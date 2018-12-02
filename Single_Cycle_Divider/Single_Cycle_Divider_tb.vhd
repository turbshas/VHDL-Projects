entity Singe_Cycle_Divider_tb is
	port();
end entity;

architecture Behavioral of Singe_Cycle_Divider_tb is

constant WIDTH : natural := 8;

signal n, d, q, r : std_logic_vector(WIDTH - 1 downto 0);

begin

uut : entity work.Singe_Cycle_Divider
	generic map(WIDTH => WIDTH);
	port map(n => n, d => d, q => q, r => r);
	
process begin
	n <= (others=>'0');
	d <= (others=>'1');
	
	wait for 5ns;
	
	n <= "01101011"; -- 107
	d <= "00001101"; -- 13
	
	wait for 5ns;
	
	n <= "11100111"; -- 231
	d <= "01100100"; -- 100
	
	wait for 5ns;
	
	n <= "10001000"; -- -120
	d <= "00001111"; -- 15
	
	wait for 5ns;
	
	n <= "01000001"; -- 65
	d <= "11111001"; -- -7
	
	wait for 5ns;
	
	n <= "00000001";
	d <= "00000000";
	
	wait;
end process;

end architecture;