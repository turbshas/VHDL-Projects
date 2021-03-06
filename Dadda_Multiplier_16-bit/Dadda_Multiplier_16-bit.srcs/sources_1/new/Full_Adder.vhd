----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2018 10:17:59 AM
-- Design Name: 
-- Module Name: Full_Adder - Behavioral
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

entity Full_Adder is
    port(
        a       : in std_logic;
        b       : in std_logic;
        c       : in std_logic;
        sum     : out std_logic;
        carry   : out std_logic
    );
end Full_Adder;

architecture Behavioral of Full_Adder is
begin

    sum <= a XOR b XOR c;
    carry <= (a AND b) OR (a AND c) OR (b AND c);

end Behavioral;
