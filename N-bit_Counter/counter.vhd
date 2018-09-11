library ieee;
use ieee.std_logic_1164.all;

entity counter is 
	generic(
		WIDTH : natural := 8
	       );
	port(
		clk       : in std_logic; 
		reset     : in std_logic;
	    i_enable  : in std_logic;
		o_count   : out std_logic_vector(WIDTH - 1 downto 0)
	    );
end entity;

architecture main of counter is

signal prev_reg : std_logic_vector(WIDTH - 2 downto 0);
signal reg_en : std_logic_vector(WIDTH - 1 downto 0);	
signal count : std_logic_vector(WIDTH - 1 downto 0);

begin
    o_count <= count;
	
	reg_enables : process(i_enable, count, prev_reg) begin
		reg_en(0) <= i_enable;
		prev_reg(0) <= count(0);

		for i in 1 to WIDTH - 2 loop
			prev_reg(i) <= prev_reg(i - 1) AND count(i);
			reg_en(i) <= prev_reg(i - 1) AND i_enable;
		end loop;
		
        reg_en(WIDTH - 1) <= prev_reg(WIDTH - 2) AND i_enable;
	end process;

    process(clk, reset, reg_en) begin
        if rising_edge(clk) then
            if reset = '1' then
                count <= (others=>'0');
            else
                for i in 0 to WIDTH - 1 loop
                    if reg_en(i) = '1' then                
                        count(i) <= NOT count(i);
                    end if;
                end loop;
            end if;                
        end if;
    end process;

end architecture;
