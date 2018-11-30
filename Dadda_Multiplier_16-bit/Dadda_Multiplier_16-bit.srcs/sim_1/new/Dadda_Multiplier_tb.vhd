----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2018 10:47:24 AM
-- Design Name: 
-- Module Name: Dadda_Multiplier_tb - Behavioral
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

entity Dadda_Multiplier_tb is
end Dadda_Multiplier_tb;

architecture Behavioral of Dadda_Multiplier_tb is

signal a : std_logic_vector(15 downto 0);
signal b : std_logic_vector(15 downto 0);
signal result : std_logic_vector(31 downto 0);

begin

uut : entity work.Dadda_Multiplier
port map(
    a => a,
    b => b,
    result => result
);

process begin
    a <= (others=>'0');
    b <= (others=>'0');
    wait for 5ns;
    
    a <= x"0032";
    b <= x"000A";
    wait for 5ns;
    
    a <= x"4000";
    b <= x"0028";
    wait for 5ns;
    
    a <= x"5678";
    b <= x"1234";
    wait for 5ns;

    wait;
end process;

end Behavioral;
