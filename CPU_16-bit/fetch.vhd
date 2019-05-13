library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fetch is
    port(
        clock : in std_logic,
        reset : in std_logic,
        instr : out std_logic_vector(15 downto 0)
        );
end entity;

architecture main of fetch is

signal pc : std_logic_vector(15 downto 0);

begin

main_mem : entity work.mem
    port map(
        clk => clock,
        addr => pc,
        data_in => open,
        data_out => instr,
        read_write => '1',
        enable => '1');

process(clock, reset) begin
    if rising_edge(clock) then
        if reset then
            pc <= (others=>'0');
            instr <= (others=>'0');
        else
            pc <= std_logic_vector(unsigned(pc) + 2);
        end if;
    end if;
end process;

end architecture;

