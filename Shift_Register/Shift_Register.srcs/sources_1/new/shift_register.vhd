----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2018 09:31:59 PM
-- Design Name: 
-- Module Name: shift_register - main
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register is
    generic(WIDTH : natural := 8);
    port(
        clk         : in std_logic;
        load        : in std_logic;
        serial_in   : in std_logic;
        input       : in std_logic_vector(WIDTH - 1 downto 0);
        output      : out std_logic_vector(WIDTH - 1 downto 0)
    );
end shift_register;

architecture main of shift_register is

signal reg_outputs : std_logic_vector(WIDTH - 1 downto 0);

begin

output <= reg_outputs;

process(clk) begin
    if rising_edge(clk) then
        if load = '1' then
            reg_outputs <= input;
        else
            if serial_in = '1' then
                reg_outputs(0) <= input(0);
            else
                reg_outputs(0) <= '0';
            end if;
            
            reg_outputs(WIDTH - 1 downto 1) <= reg_outputs(WIDTH - 2 downto 0);
        end if;
    end if;
end process;

end main;
