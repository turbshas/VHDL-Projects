----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2018 10:37:19 PM
-- Design Name: 
-- Module Name: Full_Adder_Unit - Behavioral
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

entity Full_Adder_Unit is
    port(
        a    : in std_logic;
        b    : in std_logic;
        cin  : in std_logic;
        sum  : out std_logic;
        prop : out std_logic;
        gen  : out std_logic
    );
end Full_Adder_Unit;

architecture Behavioral of Full_Adder_Unit is
begin

sum <= a XOR b XOR cin;
prop <= a XOR b;
gen <= a AND b;

end Behavioral;
