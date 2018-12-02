entity Single_Cycle_Divisor is
	generic(WIDTH : natural := 16);
	port(
		n : in std_logic_vector(WIDTH - 1 downto 0);
		d : in std_logic_vector(WIDTH - 1 downto 0);
		q : out std_logic_vector(WIDTH - 1 downto 0);
		r : out std_logic_vector(WIDTH - 1 downto 0);
	);
end entity;

architecture Behavioral of Single_Cycle_Divisor is

constant TWO_WIDTH : natural := 2 * WIDTH;

-- Upper half of R will be the remainder, lower half is quotient
signal R : array(WIDTH downto 0) of unsigned(TWO_WIDTH - 1 downto 0);
signal R_adjusted : unsigned(WIDTH - 1 downto 0);
signal Q : std_logic_vector(WIDTH - 1 downto 0);
signal Q_std_form : unsigned(WIDTH - 1 downto 0);

signal D : unsigned(WIDTH - 1 downto 0);
signal minus_D : unsigned(WIDTH - 1 downto 0);

signal change_amount : array(WIDTH - 1 downto 0) of unsigned(WIDTH - 1 downto 0);
signal result_negative : std_logic;

begin

-- Simple non-restoring division

-- Setup initial values
R(WIDTH)(TWO_WIDTH - 1 downto WIDTH) <= (others=>'0');
R(WIDTH)(WIDTH - 1 downto 0) <= n;

D(TWO_WIDTH - 1 downto WIDTH) <= d;
D(WIDTH - 1 downto 0) <= (others=>'0');
minus_D <= NOT(D) + 1;

-- Actual dividing loop
divide_loop : for i in WIDTH - 1 downto 0 generate
	Q(i) <= '1' when R(i + 1) >= 0 else '0';
	change_amount(i) <= minus_D when Q(i) = '1' else D;
	
	-- Shift r, do addition with D or -D
	R(i)(TWO_WIDTH - 1 downto WIDTH) <= R(i + 1)(TWO_WIDTH - 2 downto WIDTH - 1) + change_amount(i);
	-- Shift q
	R(i)(WIDTH - 1 downto 1) <= R(i + 1)(WIDTH - 2 downto 0);
	-- Set lower bit of q
	R(i)(0) <= Q(i);
end generate;

-- Convert to standard form
Q_std_form <= R(0)(WIDTH - 1 downto 0) - NOT(R(0)(WIDTH - 1 downto 0));

-- Adjust if negative and connect to output
result_negative <= R(0)(TWO_WIDTH - 1);
q <= std_logic_vector(Q_std_form - 1) when result_negative = '1' else std_logic_vector(Q_std_form);
R_adjusted <= R(0)(TWO_WIDTH - 1 downto WIDTH) + D when result_negative = '1' else R(0)(TWO_WIDTH - 1 downto WIDTH);
r <= std_logic_vector(R_adjusted);

end architecture;