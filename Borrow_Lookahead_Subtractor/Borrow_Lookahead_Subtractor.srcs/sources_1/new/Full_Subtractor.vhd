----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/14/2018 11:34:21 PM
-- Design Name: 
-- Module Name: Full_Subtractor - Behavioral
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

entity Full_Subtractor is
    port(
        a    : in std_logic;
        b    : in std_logic;
        bin  : in std_logic;
        sub  : out std_logic;
        prop : out std_logic;
        gen  : out std_logic 
    );
end Full_Subtractor;

architecture Behavioral of Full_Subtractor is

begin

sub <= a XOR b XOR bin;
prop <= a XNOR b;
gen <= (NOT a) AND b;

end Behavioral;
