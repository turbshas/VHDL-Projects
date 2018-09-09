----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2018 05:11:25 PM
-- Design Name: 
-- Module Name: counter8_tb - Behavioral
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

entity counter8_tb is
    generic(PERIOD : real := 10.0;
            WIDTH : natural := 8 );
end counter8_tb;

architecture Behavioral of counter8_tb is

constant PERIOD_TIME : time := PERIOD * 1ns;

signal clk : std_logic;
signal reset : std_logic;
signal i_enable : std_logic;
signal count : std_logic_vector(7 downto 0);

begin

    clock : process begin
        clk <= '0';
        wait for PERIOD_TIME/2;
        loop
            wait for PERIOD_TIME/2;
            clk <= NOT clk;
        end loop;
    end process;
    
    rest_proc : process begin
        reset <= '0';
        wait for 2*PERIOD_TIME;
        reset <= '1';
        wait for 6*PERIOD_TIME;
        reset <= '0';
        wait; 
    end process;
    
    uut : entity work.counter_8b(main)
        port map (
            clk        => clk,
            reset       => reset,
            i_enable    => i_enable,
            o_count       => count
        );
        
    test : process begin
        i_enable <= '1';
        wait until falling_edge(reset);
        wait until rising_edge(clk);
        
        wait for 11*PERIOD_TIME;
        
        i_enable <= '0';
        wait for 5*PERIOD_TIME;
        i_enable <= '1';
        
        wait for 2*PERIOD_TIME;
        reset <= '1';
        wait for 4*PERIOD_TIME;
        reset <= '0';
        wait until rising_edge(clk);
        
        wait for 260*PERIOD_TIME;
        
        wait;
    end process;

end Behavioral;
