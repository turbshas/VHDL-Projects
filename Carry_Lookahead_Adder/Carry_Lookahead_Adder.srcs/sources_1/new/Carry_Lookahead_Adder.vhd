----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2018 10:37:19 PM
-- Design Name: 
-- Module Name: Carry_Lookahead_Adder - Behavioral
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Carry_Lookahead_Adder is
    generic(
        WIDTH : positive := 43
    );
    port(
        a : in std_logic_vector(WIDTH - 1 downto 0);
        b : in std_logic_vector(WIDTH - 1 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(WIDTH - 1 downto 0);
        cout : out std_logic
    );
end Carry_Lookahead_Adder;

architecture Behavioral of Carry_Lookahead_Adder is

constant NUM_GROUPS_4         : natural := natural(FLOOR( real(WIDTH) / real(4) ));  -- Number of complete groups of 4 bits
constant NUM_GROUPS_16        : natural := natural(FLOOR( real(WIDTH) / real(16) )); -- Number of complete groups of 16 bits
constant LEFTOVER_BITS        : natural := WIDTH - (NUM_GROUPS_4 * 4);               -- Number of bits that don't belong to a complete group of 4
constant LEFTOVER_GROUPS_4    : natural := NUM_GROUPS_4 - (NUM_GROUPS_16 * 4); -- Number of complete groups of 4 that don't belong to a complete group of 16 bits
constant LEFTOVER_BITS_MOD_16 : natural := WIDTH - NUM_GROUPS_16 * 16;               -- Number of bits that don't belong to a complete group of 16
constant EXTRA_LAU_4          : natural := natural(CEIL(real(LEFTOVER_BITS) / real(4))); -- Whether there are leftover bits that will need a LAU

-- Carries, propagates, and generates of each full adder
signal cins         : std_logic_vector(WIDTH - 1 downto 0); -- Each bit is the input to the cin port of each full adder
signal couts_lau_4  : std_logic_vector(WIDTH downto 1); -- Carry outputs from each lookahead unit belonging to a group of 4 full adders
signal couts_lau_16 : std_logic_vector(NUM_GROUPS_4 + EXTRA_LAU_4 downto 0); -- Carry outputs from each lookahead unit belonging to a group of 16 full adders
signal props        : std_logic_vector(WIDTH - 1 downto 0);
signal gens         : std_logic_vector(WIDTH - 1 downto 0);

-- Group propagates and generates for each of the groups of 4 full adders
signal prop_gs : std_logic_vector(NUM_GROUPS_4 + EXTRA_LAU_4 - 1 downto 0);
signal gen_gs  : std_logic_vector(NUM_GROUPS_4 + EXTRA_LAU_4 - 1 downto 0);

begin

    couts_lau_16(0) <= cin;
    cout <= couts_lau_16(couts_lau_16'length - 1);

-- Most common use is in multiples of 16 bits. This loop generates the section of the adder that is a multiple of 16
-- e.g. bits 0 to 31 in a 43-bit adder
groups_16 : for i in 0 to NUM_GROUPS_16 - 1 generate
    fblus : for j in 0 to 3 generate -- There are 4 4-bit groups in each 16-bit group
        cins(i * 16 + j * 4) <= couts_lau_16(i * 4 + j);
        cins(i * 16 + j * 4 + 3 downto i * 16 + j * 4 + 1) <= couts_lau_4(i * 16 + j * 4 + 3 downto i * 16 + j * 4 + 1);
        faus : for k in 0 to 3 generate -- Generate the 4 full adders
            fau : entity work.Full_Adder_Unit port map(
                a    =>     a((i * 16) + (j * 4) + k),
                b    =>     b((i * 16) + (j * 4) + k),
                cin  =>  cins((i * 16) + (j * 4) + k),
                sum  =>   sum((i * 16) + (j * 4) + k),
                prop => props((i * 16) + (j * 4) + k),
                gen  =>  gens((i * 16) + (j * 4) + k));
        end generate;
        
        -- Lookahead unit fora group of 4 full adders
        lau_4 : entity work.Lookahead_Unit
        generic map(WIDTH => 4) 
        port map(
            props  =>       props((i * 16) + (j * 4) + 3 downto (i * 16) + (j * 4)),
            gens   =>        gens((i * 16) + (j * 4) + 3 downto (i * 16) + (j * 4)),
            cin    =>        cins((i * 16) + (j * 4)),
            prop_g =>     prop_gs((i * 4) + j),
            gen_g  =>      gen_gs((i * 4) + j),
            couts  => couts_lau_4((i * 16) + (j * 4) + 4 downto (i * 16) + (j * 4) + 1));
    end generate;
    
    -- Lookahead unit for 4 4-bit lookahead units
    lau_16 : entity work.Lookahead_Unit
    generic map(WIDTH => 4)
    port map(
        props   => prop_gs(i * 4 + 3 downto i * 4),
        gens    =>  gen_gs(i * 4 + 3 downto i * 4),
        cin     =>    cins(i * 16),
        prop_g  => open,  -- not used
        gen_g   => open,  -- not used
        couts   => couts_lau_16(i * 4 + 4 downto i * 4 + 1));
end generate;

-- This loop generates the section of the adder that is a multiple of 4 bits after the section that is a multiple of 16 bits
-- e.g. bits 32 to 39 in a 43-bit adder
groups_4 : for i in 0 to LEFTOVER_GROUPS_4 - 1 generate
    cins(i * 4 + NUM_GROUPS_16 * 16) <= couts_lau_16(i + NUM_GROUPS_16 * 4);
    cins(i * 4 + 3 + NUM_GROUPS_16 * 16 downto i * 4 + 1 + NUM_GROUPS_16 * 16) <= couts_lau_4(i * 4 + 3 + NUM_GROUPS_16 * 16 downto i * 4 + 1 + NUM_GROUPS_16 * 16);
    faus : for j in 0 to 3 generate -- Generate the 4 full adders
        fau : entity work.Full_Adder_Unit port map(
            a    =>     a((i * 4) + j + NUM_GROUPS_16 * 16),
            b    =>     b((i * 4) + j + NUM_GROUPS_16 * 16),
            cin  =>  cins((i * 4) + j + NUM_GROUPS_16 * 16),
            sum  =>   sum((i * 4) + j + NUM_GROUPS_16 * 16),
            prop => props((i * 4) + j + NUM_GROUPS_16 * 16),
            gen  =>  gens((i * 4) + j + NUM_GROUPS_16 * 16));
    end generate;
        
    -- Lookahead unit fora group of 4 full adders
    lau_4 : entity work.Lookahead_Unit
    generic map(WIDTH => 4) 
    port map(
        props  =>       props((i * 4) + 3 + NUM_GROUPS_16 * 16 downto (i * 4) + NUM_GROUPS_16 * 16),
        gens   =>        gens((i * 4) + 3 + NUM_GROUPS_16 * 16 downto (i * 4) + NUM_GROUPS_16 * 16),
        cin    =>        cins((i * 4) + NUM_GROUPS_16 * 16),
        prop_g =>     prop_gs(i + NUM_GROUPS_16 * 4),
        gen_g  =>      gen_gs(i + NUM_GROUPS_16 * 4),
        couts  => couts_lau_4((i * 4) + 4 + NUM_GROUPS_16 * 16 downto (i * 4) + 1 + NUM_GROUPS_16 * 16));
end generate;

-- This loop generates that last leftover bits of the adder that isn't a multiple of 4 or 16
-- e.g. bits 40 to 42 in a 43-bit adder
leftover_bits_fa : for i in 0 to LEFTOVER_BITS - 1 generate
    fau : entity work.Full_Adder_Unit port map(
        a    =>     a(NUM_GROUPS_4 * 4 + i),
        b    =>     b(NUM_GROUPS_4 * 4 + i),
        cin  =>  cins(NUM_GROUPS_4 * 4 + i),
        sum  =>   sum(NUM_GROUPS_4 * 4 + i),
        prop => props(NUM_GROUPS_4 * 4 + i),
        gen  =>  gens(NUM_GROUPS_4 * 4 + i));
end generate;

leftover_bits_lau : if LEFTOVER_BITS > 0 generate
    cins(NUM_GROUPS_4 * 4) <= couts_lau_16(NUM_GROUPS_4);
    cins(NUM_GROUPS_4 * 4  + LEFTOVER_BITS - 1 downto NUM_GROUPS_4 * 4 + 1) <= couts_lau_4(NUM_GROUPS_4 * 4  + LEFTOVER_BITS - 1 downto NUM_GROUPS_4 * 4 + 1);
    lau_4 : entity work.Lookahead_Unit
    generic map(WIDTH => LEFTOVER_BITS)
    port map(
        props   =>       props(NUM_GROUPS_4 * 4 + LEFTOVER_BITS - 1 downto NUM_GROUPS_4 * 4),
        gens    =>        gens(NUM_GROUPS_4 * 4 + LEFTOVER_BITS - 1 downto NUM_GROUPS_4 * 4),
        cin     =>        cins(NUM_GROUPS_4 * 4),
        prop_g  =>     prop_gs(NUM_GROUPS_4),
        gen_g   =>      gen_gs(NUM_GROUPS_4),
        couts   => couts_lau_4(NUM_GROUPS_4 * 4 + LEFTOVER_BITS downto NUM_GROUPS_4 * 4 + 1));
end generate;

-- Last lookahead unit to cover the section of the adder that isn't a multiple of 16
-- e.g. bits 32 to 42 in a 43-bit adder
leftover_lau_16 : if LEFTOVER_BITS_MOD_16 > 0 generate
    lau_16 : entity work.Lookahead_Unit
    generic map(WIDTH => LEFTOVER_GROUPS_4 + EXTRA_LAU_4)
    port map(
        props   =>      prop_gs(NUM_GROUPS_4 + EXTRA_LAU_4 - 1 downto NUM_GROUPS_4 + EXTRA_LAU_4 - (LEFTOVER_GROUPS_4 + EXTRA_LAU_4)),
        gens    =>       gen_gs(NUM_GROUPS_4 + EXTRA_LAU_4 - 1 downto NUM_GROUPS_4 + EXTRA_LAU_4 - (LEFTOVER_GROUPS_4 + EXTRA_LAU_4)),
        cin     =>         cins(NUM_GROUPS_16 * 16),
        prop_g  =>         open,  -- not used
        gen_g   =>         open,  -- not used
        couts   => couts_lau_16(NUM_GROUPS_4 + EXTRA_LAU_4 downto NUM_GROUPS_4 + EXTRA_LAU_4 - (LEFTOVER_GROUPS_4 + EXTRA_LAU_4) + 1));
end generate;

end Behavioral;
