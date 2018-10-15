----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2018 11:27:51 PM
-- Design Name: 
-- Module Name: Lookahead_Unit - Behavioral
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
use IEEE.STD_LOGIC_MISC.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Lookahead_Unit is
    generic(WIDTH : positive := 4);
    port(
        props   : in std_logic_vector(WIDTH - 1 downto 0);
        gens    : in std_logic_vector(WIDTH - 1 downto 0);
        cin     : in std_logic;
        prop_g  : out std_logic;
        gen_g   : out std_logic;
        couts   : out std_logic_vector(WIDTH - 1 downto 0)
    );
end Lookahead_Unit;

architecture Behavioral of Lookahead_Unit is

signal gen_g_terms : std_logic_vector(WIDTH - 1 downto 0);

-- Signals so prop_g and gen_g can be read from
signal prop_g_sig  : std_logic;
signal gen_g_sig   : std_logic;

-- Signal so carry outputs can be read from
signal couts_sig   : std_logic_vector(WIDTH - 1 downto 0);

begin
    -- Group propagate and generate
    prop_g     <= prop_g_sig;
    gen_g      <= gen_g_sig;
    prop_g_sig <= and_reduce(props);
    gen_g_sig  <= or_reduce(gen_g_terms);
    
    -- Each of the minterms for the group generate expression
    gen_g_terms(WIDTH - 1) <= gens(WIDTH - 1);
    terms : for i in WIDTH - 2 downto 0 generate
        gen_g_terms(i) <= gens(i) AND and_reduce(props(WIDTH - 1 downto (i + 1)));
    end generate;
    
    -- Each of the carry outputs
    couts <= couts_sig(WIDTH - 1 downto 0);
    couts_sig(0) <= gens(0) OR (props(0) AND cin);
    carry_outs : for i in 1 to WIDTH - 1 generate
        couts_sig(i) <= gens(i) OR (props(i) AND couts_sig(i - 1));
    end generate;

end Behavioral;
