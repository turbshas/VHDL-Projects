----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/14/2018 12:58:18 AM
-- Design Name: 
-- Module Name: Carry_Lookahead_Adder_tb - Behavioral
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

entity Carry_Lookahead_Adder_tb is
end Carry_Lookahead_Adder_tb;

architecture Behavioral of Carry_Lookahead_Adder_tb is

constant WIDTH : positive := 16;

signal a_8 : std_logic_vector(7 downto 0);
signal b_8 : std_logic_vector(7 downto 0);
signal cin_8 : std_logic;
signal sum_8 : std_logic_vector(7 downto 0);
signal cout_8 : std_logic;

signal a_16 : std_logic_vector(15 downto 0);
signal b_16 : std_logic_vector(15 downto 0);
signal cin_16 : std_logic;
signal sum_16 : std_logic_vector(15 downto 0);
signal cout_16 : std_logic;

signal a_43 : std_logic_vector(42 downto 0);
signal b_43 : std_logic_vector(42 downto 0);
signal cin_43 : std_logic;
signal sum_43 : std_logic_vector(42 downto 0);
signal cout_43 : std_logic;

begin

uut_16 : entity work.Carry_Lookahead_Adder
    generic map(WIDTH => 16)
    port map (a => a_16, b => b_16, cin => cin_16, sum => sum_16, cout => cout_16);
    
    width_16 : process
    begin
        a_16 <= (others=>'0');
        b_16 <= (others=>'0');
        cin_16 <= '0';
        
        wait for 5ns;
        
        a_16 <= "1010101010101010";
        b_16 <= "0101010101010101";
        cin_16 <= '0';
        
        wait for 5ns;
        
        a_16 <= "0010101010101010";
        b_16 <= "0101010101010101";
        cin_16 <= '1';
        
        wait for 5ns;
                
        a_16 <= "1010101010101010";
        b_16 <= "0101010101010101";
        cin_16 <= '1';
        
        wait for 5ns;
                                    
        a_16 <= "0111011101110111";
        b_16 <= "0001000100010001";
        cin_16 <= '1';
    
        wait;
    end process;

uut_8 : entity work.Carry_Lookahead_Adder
    generic map(WIDTH => 8)
    port map (a => a_8, b => b_8, cin => cin_8, sum => sum_8, cout => cout_8);
        
    width_8 : process
    begin
        a_8 <= (others=>'0');
        b_8 <= (others=>'0');
        cin_8 <= '0';
            
        wait for 5ns;
            
        a_8 <= "10101010";
        b_8 <= "01010101";
        cin_8 <= '0';
            
        wait for 5ns;
            
        a_8 <= "00101010";
        b_8 <= "01010101";
        cin_8 <= '1';
            
        wait for 5ns;
                    
        a_8 <= "10101010";
        b_8 <= "01010101";
        cin_8 <= '1';
        
        wait for 5ns;
                            
        a_8 <= "01110111";
        b_8 <= "00010001";
        cin_8 <= '1';
        
        wait;
    end process;
    
uut_43 : entity work.Carry_Lookahead_Adder
    generic map(WIDTH => 43)
    port map (a => a_43, b => b_43, cin => cin_43, sum => sum_43, cout => cout_43);
    
    width_43 : process
    begin
        a_43 <= (others=>'0');
        b_43 <= (others=>'0');
        cin_43 <= '0';
            
        wait for 5ns;
            
        a_43 <= "0101010101010101010101010101010101010101010";
        b_43 <= "1010101010101010101010101010101010101010101";
        cin_43 <= '0';
            
        wait for 5ns;
            
        a_43 <= "0101010101010101010101010101010101010101010";
        b_43 <= "0010101010101010101010101010101010101010101";
        cin_43 <= '1';
        
        wait for 5ns;
        
        a_43 <= "0101010101010101010101010101010101010101010";
        b_43 <= "1010101010101010101010101010101010101010101";
        cin_43 <= '1';
            
        wait for 5ns;
                                
        a_43 <= "0110111011101110111011101110111011101110111";
        b_43 <= "0010001000100010001000100010001000100010001";
        cin_43 <= '1';
            
        wait;
        end process;

end Behavioral;
