library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mem is
    generic(SIZE : natural := 1024*1024);
    port(
        clk         : in std_logic,
        addr        : in std_logic_vector(15 downto 0),
        data_in     : in std_logic_vector(15 downto 0),
        data_out    : out std_logic_vector(15 downto 0),
        read_write  : in std_logic,
        enable      : in std_logic
        );
end entity;

architecture main of mem is

type DATA_T is array (SIZE - 1 downto 0) of std_logic_vector(7 downto 0);
signal data : DATA_T;

begin

reads: process(enable, read_write, addr) begin
    if enable AND read_write then
        data_out(7 downto 0) <= data(addr);
        data_out(15 downto 8) <= data(addr + 1);
    end if;
end process;

writes: process(clk, enable, read_write, addr, data_in) begin
    if rising_edge(clk) then
        if enable AND (NOT read_write) then
            data(addr) <= data_in(7 downto 0);
            data(addr + 1) <= data_in(15 downto 8);
        end if;
    end if;
end process;

end architecture;

