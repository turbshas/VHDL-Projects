----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2018 09:59:54 PM
-- Design Name: 
-- Module Name: Borrow_Lookahead_Subtractor_tb - Behavioral
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

entity Borrow_Lookahead_Subtractor_tb is
--  Port ( );
end Borrow_Lookahead_Subtractor_tb;

architecture Behavioral of Borrow_Lookahead_Subtractor_tb is

signal a_8 : std_logic_vector(7 downto 0);
signal b_8 : std_logic_vector(7 downto 0);
signal bin_8 : std_logic;
signal sub_8 : std_logic_vector(7 downto 0);
signal bout_8 : std_logic;

signal a_16 : std_logic_vector(15 downto 0);
signal b_16 : std_logic_vector(15 downto 0);
signal bin_16 : std_logic;
signal sub_16 : std_logic_vector(15 downto 0);
signal bout_16 : std_logic;

signal a_43 : std_logic_vector(42 downto 0);
signal b_43 : std_logic_vector(42 downto 0);
signal bin_43 : std_logic;
signal sub_43 : std_logic_vector(42 downto 0);
signal bout_43 : std_logic;

begin

uut_16 : entity work.Borrow_Lookahead_Subtractor
    generic map(WIDTH => 16)
    port map (a => a_16, b => b_16, bin => bin_16, sub => sub_16, bout => bout_16);
    
    width_16 : process
    begin
        a_16 <= (others=>'0');
        b_16 <= (others=>'0');
        bin_16 <= '0';
        
        wait for 5ns;
        
        a_16 <= "1010101010101010";
        b_16 <= "0101010101010101";
        bin_16 <= '0';
        
        wait for 5ns;
        
        a_16 <= "0010101010101010";
        b_16 <= "0101010101010101";
        bin_16 <= '1';
        
        wait for 5ns;
                
        a_16 <= "1111111111111111";
        b_16 <= "1111111111111111";
        bin_16 <= '1';
        
        wait for 5ns;
                                    
        a_16 <= "1000100010001000";
        b_16 <= "0001000100010001";
        bin_16 <= '1';
    
        wait;
    end process;

uut_8 : entity work.Borrow_Lookahead_Subtractor
    generic map(WIDTH => 8)
    port map (a => a_8, b => b_8, bin => bin_8, sub => sub_8, bout => bout_8);
        
    width_8 : process
    begin
        a_8 <= (others=>'0');
        b_8 <= (others=>'0');
        bin_8 <= '0';
            
        wait for 5ns;
            
        a_8 <= "10101010";
        b_8 <= "01010101";
        bin_8 <= '0';
        
        wait for 5ns;
        
        a_8 <= "00101010";
        b_8 <= "01010101";
        bin_8 <= '1';
        
        wait for 5ns;
                
        a_8 <= "11111111";
        b_8 <= "11111111";
        bin_8 <= '1';
        
        wait for 5ns;
                                    
        a_8 <= "10001000";
        b_8 <= "00010001";
        bin_8 <= '1';
        
        wait;
    end process;
    
uut_43 : entity work.Borrow_Lookahead_Subtractor
    generic map(WIDTH => 43)
    port map (a => a_43, b => b_43, bin => bin_43, sub => sub_43, bout => bout_43);
    
    width_43 : process
    begin
        a_43 <= (others=>'0');
        b_43 <= (others=>'0');
        bin_43 <= '0';
            
        wait for 5ns;
            
        a_43 <= "0101010101010101010101010101010101010101010";
        b_43 <= "1010101010101010101010101010101010101010101";
        bin_43 <= '0';
        
        wait for 5ns;
        
        a_43 <= "0001010101010101010101010101010101010101010";
        b_43 <= "0010101010101010101010101010101010101010101";
        bin_43 <= '1';
        
        wait for 5ns;
                
        a_43 <= "1111111111111111111111111111111111111111111";
        b_43 <= "1111111111111111111111111111111111111111111";
        bin_43 <= '1';
        
        wait for 5ns;
                                    
        a_43 <= "0001000100010001000100010001000100010001000";
        b_43 <= "0010001000100010001000100010001000100010001";
        bin_43 <= '1';
            
        wait;
        end process;

end Behavioral;
