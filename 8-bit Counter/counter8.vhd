library ieee;
use ieee.std_logic_1164.all;

entity counter_8b is 
	generic(
		WIDTH : natural := 8
	       );
	port(
		clk, 
		reset,
	    i_enable : in std_logic;
		o_count : out std_logic_vector(WIDTH - 1 downto 0)
	    );
end entity;

architecture main of counter_8b is

signal clk_en : std_logic;
signal prev_reg : std_logic_vector(WIDTH - 1 downto 0);
signal reg_en : std_logic_vector(WIDTH - 1 downto 0);	
signal count : std_logic_vector(WIDTH - 1 downto 0);

begin
    o_count <= count;
	clk_en <= clk AND i_enable;
	
	reg_enables : process(clk_en, count, prev_reg) begin
		reg_en(0) <= clk_en;
		prev_reg(0) <= count(0);

		for i in 1 to WIDTH - 1 loop
			prev_reg(i) <= prev_reg(i - 1) AND count(i);
			reg_en(i) <= prev_reg(i - 1) AND clk_en;
		end loop;
	end process;
    
    generate_regs: for i in 0 to WIDTH - 1 generate
        process(reg_en, reset) begin
--            if reset = '1' then
--                count(i) <= '0';
--            els
            if rising_edge(reg_en(i)) then
                count(i) <= NOT count(i);
            end if;
        end process;
    end generate;

end architecture;
