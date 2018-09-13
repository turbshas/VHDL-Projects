----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2018 08:49:24 PM
-- Design Name: 
-- Module Name: barrel_shifter_tb - Behavioral
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
use IEEE.MATH_REAL.ALL;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity barrel_shifter_tb is
    generic(WIDTH : natural := 8;
            PERIOD : real := 10.0);
end barrel_shifter_tb;

architecture Behavioral of barrel_shifter_tb is

constant PERIOD_TIME : time := PERIOD * 1ns;

signal clk : std_logic;
signal shift_amount : std_logic_vector(integer(ceil(log2(real(WIDTH)))) - 1 downto 0);
signal input : std_logic_vector(WIDTH - 1 downto 0);
signal output : std_logic_vector(WIDTH - 1 downto 0);

begin

    clock : process begin
        clk <= '0';
        wait for PERIOD_TIME/2;
        loop
            wait for PERIOD_TIME/2;
            clk <= NOT clk;
        end loop;
    end process;
    
    uut : entity work.barrel_shifter(main)
        generic map(WIDTH => WIDTH)
        port map(
            clk             => clk,
            shift_amount    => shift_amount,
            input           => input,
            output          => output
        );
        
    tests : process begin
    shift_amount <= (others=>'0');
    input <= (others=>'0');
    wait until rising_edge(clk);
    wait for 2 * PERIOD_TIME;
    
    shift_amount <= "101";
    input <= "10111001";
    wait until rising_edge(clk);
    wait for 2 * PERIOD_TIME;
    
    shift_amount <= "011";
    input <= (others=>'1');
    wait until rising_edge(clk);
    wait for 2 * PERIOD_TIME;
    
    shift_amount <= "111";
    input <= "01110011";
    wait until rising_edge(clk);
    wait for 2 * PERIOD_TIME;
        
    shift_amount <= "001";
    input <= "10111001";    
    wait until rising_edge(clk);
    wait for 2 * PERIOD_TIME;
            
    shift_amount <= "010";
    input <= "10111001";    
    wait until rising_edge(clk);
    wait for 2 * PERIOD_TIME;
                
    shift_amount <= "100";
    input <= "10111001";
    wait until rising_edge(clk);
    wait for 2 * PERIOD_TIME;
        
    shift_amount <= "110";
    input <= "10111001";
    wait until rising_edge(clk);
    wait for 2 * PERIOD_TIME;
        
    shift_amount <= "000";
    input <= "10111001";
    
    wait;
    end process;

end Behavioral;
