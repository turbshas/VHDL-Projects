----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2018 11:00:16 PM
-- Design Name: 
-- Module Name: shift_register_tb - main
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

entity shift_register_tb is
generic(WIDTH : natural := 8;
        PERIOD : real := 10.0);
end shift_register_tb;

architecture Behavioral of shift_register_tb is

constant PERIOD_TIME : time := PERIOD * 1ns;

signal clk, load, serial_in : std_logic;
signal input, output : std_logic_vector(WIDTH - 1 downto 0);

begin

    clock : process begin
        clk <= '0';
        wait for PERIOD_TIME/2;
        loop
            wait for PERIOD_TIME/2;
            clk <= NOT clk;
        end loop;
    end process;

    uut : entity work.shift_register(main)
        generic map(WIDTH => WIDTH)
        port map(
            clk         => clk,
            load        => load,
            serial_in   => serial_in,
            input       => input,
            output      => output
        );
        
        tests : process begin
            load <='0';
            serial_in <= '0';
            input <= (others=>'0');
            wait until rising_edge(clk);
            wait for 2 * PERIOD_TIME;
            
            load <= '1';
            input <= "10011011";
            wait for PERIOD_TIME;
            load <= '0';
            wait for 8 * PERIOD_TIME;
            
            serial_in <= '1';
            input(0) <= '1';
            wait for PERIOD_TIME;
            input(0) <= '1';
            wait for PERIOD_TIME;
            input(0) <= '0';
            wait for PERIOD_TIME;
            input(0) <= '1';
            wait for PERIOD_TIME;
            input(0) <= '0';
            wait for PERIOD_TIME;
            input(0) <= '1';
            wait for PERIOD_TIME;
            input(0) <= '0';
            wait for PERIOD_TIME;
            input(0) <= '0';
            wait for PERIOD_TIME;
            input(0) <= '1';
            wait for PERIOD_TIME;
            
            wait;
        end process;

end Behavioral;
