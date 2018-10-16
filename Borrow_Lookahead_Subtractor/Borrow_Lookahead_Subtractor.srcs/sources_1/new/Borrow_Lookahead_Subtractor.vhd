----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2018 09:51:48 PM
-- Design Name: 
-- Module Name: Borrow_Lookahead_Subtractor - Behavioral
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

entity Borrow_Lookahead_Subtractor is
    generic(
        WIDTH : positive := 16
    );
    port(
        a : in std_logic_vector(WIDTH - 1 downto 0);
        b : in std_logic_vector(WIDTH - 1 downto 0);
        bin : in std_logic;
        sub : out std_logic_vector(WIDTH - 1 downto 0);
        bout : out std_logic
    );
end Borrow_Lookahead_Subtractor;

architecture Behavioral of Borrow_Lookahead_Subtractor is

constant NUM_GROUPS_4         : natural := natural(FLOOR( real(WIDTH) / real(4) ));  -- Number of complete groups of 4 bits
constant NUM_GROUPS_16        : natural := natural(FLOOR( real(WIDTH) / real(16) )); -- Number of complete groups of 16 bits
constant LEFTOVER_BITS        : natural := WIDTH - (NUM_GROUPS_4 * 4);               -- Number of bits that don't belong to a complete group of 4
constant LEFTOVER_GROUPS_4    : natural := NUM_GROUPS_4 - (NUM_GROUPS_16 * 4); -- Number of complete groups of 4 that don't belong to a complete group of 16 bits
constant LEFTOVER_BITS_MOD_16 : natural := WIDTH - NUM_GROUPS_16 * 16;               -- Number of bits that don't belong to a complete group of 16
constant EXTRA_LAU_4          : natural := natural(CEIL(real(LEFTOVER_BITS) / real(4))); -- Whether there are leftover bits that will need a LAU

-- Borrows, propagates, and generates of each full subtractor
signal bins         : std_logic_vector(WIDTH - 1 downto 0); -- Each bit is the input to the bin port of each full subtractor
signal bouts_lau_4  : std_logic_vector(WIDTH downto 1); -- Borrow outputs from each lookahead unit belonging to a group of 4 full subtractor
signal bouts_lau_16 : std_logic_vector(NUM_GROUPS_4 + EXTRA_LAU_4 downto 0); -- Borrow outputs from each lookahead unit belonging to a group of 16 full subtractor
signal props        : std_logic_vector(WIDTH - 1 downto 0);
signal gens         : std_logic_vector(WIDTH - 1 downto 0);

-- Group propagates and generates for each of the groups of 4 full subtractors
signal prop_gs : std_logic_vector(NUM_GROUPS_4 + EXTRA_LAU_4 - 1 downto 0);
signal gen_gs  : std_logic_vector(NUM_GROUPS_4 + EXTRA_LAU_4 - 1 downto 0);

begin

    bouts_lau_16(0) <= bin;
    bout <= bouts_lau_16(bouts_lau_16'length - 1);

-- Most common use is in multiples of 16 bits. This loop generates the section of the subtractor that is a multiple of 16
-- e.g. bits 0 to 31 in a 43-bit subtractor
groups_16 : for i in 0 to NUM_GROUPS_16 - 1 generate
    fblus : for j in 0 to 3 generate -- There are 4 4-bit groups in each 16-bit group
        bins(i * 16 + j * 4) <= bouts_lau_16(i * 4 + j);
        bins(i * 16 + j * 4 + 3 downto i * 16 + j * 4 + 1) <= bouts_lau_4(i * 16 + j * 4 + 3 downto i * 16 + j * 4 + 1);
        fsus : for k in 0 to 3 generate -- Generate the 4 full subtractor
            fsu : entity work.Full_Subtractor port map(
                a    =>     a((i * 16) + (j * 4) + k),
                b    =>     b((i * 16) + (j * 4) + k),
                bin  =>  bins((i * 16) + (j * 4) + k),
                sub  =>   sub((i * 16) + (j * 4) + k),
                prop => props((i * 16) + (j * 4) + k),
                gen  =>  gens((i * 16) + (j * 4) + k));
        end generate;
        
        -- Lookahead unit fora group of 4 full subtractor
        lau_4 : entity work.Lookahead_Unit
        generic map(WIDTH => 4) 
        port map(
            props  =>       props((i * 16) + (j * 4) + 3 downto (i * 16) + (j * 4)),
            gens   =>        gens((i * 16) + (j * 4) + 3 downto (i * 16) + (j * 4)),
            bin    =>        bins((i * 16) + (j * 4)),
            prop_g =>     prop_gs((i * 4) + j),
            gen_g  =>      gen_gs((i * 4) + j),
            bouts  => bouts_lau_4((i * 16) + (j * 4) + 4 downto (i * 16) + (j * 4) + 1));
    end generate;
    
    -- Lookahead unit for 4 4-bit lookahead units
    lau_16 : entity work.Lookahead_Unit
    generic map(WIDTH => 4)
    port map(
        props   => prop_gs(i * 4 + 3 downto i * 4),
        gens    =>  gen_gs(i * 4 + 3 downto i * 4),
        bin     =>    bins(i * 16),
        prop_g  => open,  -- not used
        gen_g   => open,  -- not used
        bouts   => bouts_lau_16(i * 4 + 4 downto i * 4 + 1));
end generate;

-- This loop generates the section of the subtractor that is a multiple of 4 bits after the section that is a multiple of 16 bits
-- e.g. bits 32 to 39 in a 43-bit subtractor
groups_4 : for i in 0 to LEFTOVER_GROUPS_4 - 1 generate
    bins(i * 4 + NUM_GROUPS_16 * 16) <= bouts_lau_16(i + NUM_GROUPS_16 * 4);
    bins(i * 4 + 3 + NUM_GROUPS_16 * 16 downto i * 4 + 1 + NUM_GROUPS_16 * 16) <= bouts_lau_4(i * 4 + 3 + NUM_GROUPS_16 * 16 downto i * 4 + 1 + NUM_GROUPS_16 * 16);
    fss : for j in 0 to 3 generate -- Generate the 4 full subtractor
        fs : entity work.Full_Subtractor port map(
            a    =>     a((i * 4) + j + NUM_GROUPS_16 * 16),
            b    =>     b((i * 4) + j + NUM_GROUPS_16 * 16),
            bin  =>  bins((i * 4) + j + NUM_GROUPS_16 * 16),
            sub  =>   sub((i * 4) + j + NUM_GROUPS_16 * 16),
            prop => props((i * 4) + j + NUM_GROUPS_16 * 16),
            gen  =>  gens((i * 4) + j + NUM_GROUPS_16 * 16));
    end generate;
        
    -- Lookahead unit fora group of 4 full subtractor
    lau_4 : entity work.Lookahead_Unit
    generic map(WIDTH => 4) 
    port map(
        props  =>       props((i * 4) + 3 + NUM_GROUPS_16 * 16 downto (i * 4) + NUM_GROUPS_16 * 16),
        gens   =>        gens((i * 4) + 3 + NUM_GROUPS_16 * 16 downto (i * 4) + NUM_GROUPS_16 * 16),
        bin    =>        bins((i * 4) + NUM_GROUPS_16 * 16),
        prop_g =>     prop_gs(i + NUM_GROUPS_16 * 4),
        gen_g  =>      gen_gs(i + NUM_GROUPS_16 * 4),
        bouts  => bouts_lau_4((i * 4) + 4 + NUM_GROUPS_16 * 16 downto (i * 4) + 1 + NUM_GROUPS_16 * 16));
end generate;

-- This loop generates that last leftover bits of the subtractor that isn't a multiple of 4 or 16
-- e.g. bits 40 to 42 in a 43-bit subtractor
leftover_bits_fb : for i in 0 to LEFTOVER_BITS - 1 generate
    fb : entity work.Full_Subtractor port map(
        a    =>     a(NUM_GROUPS_4 * 4 + i),
        b    =>     b(NUM_GROUPS_4 * 4 + i),
        bin  =>  bins(NUM_GROUPS_4 * 4 + i),
        sub  =>   sub(NUM_GROUPS_4 * 4 + i),
        prop => props(NUM_GROUPS_4 * 4 + i),
        gen  =>  gens(NUM_GROUPS_4 * 4 + i));
end generate;

leftover_bits_lau : if LEFTOVER_BITS > 0 generate
    bins(NUM_GROUPS_4 * 4) <= bouts_lau_16(NUM_GROUPS_4);
    bins(NUM_GROUPS_4 * 4  + LEFTOVER_BITS - 1 downto NUM_GROUPS_4 * 4 + 1) <= bouts_lau_4(NUM_GROUPS_4 * 4  + LEFTOVER_BITS - 1 downto NUM_GROUPS_4 * 4 + 1);
    lau_4 : entity work.Lookahead_Unit
    generic map(WIDTH => LEFTOVER_BITS)
    port map(
        props   =>       props(NUM_GROUPS_4 * 4 + LEFTOVER_BITS - 1 downto NUM_GROUPS_4 * 4),
        gens    =>        gens(NUM_GROUPS_4 * 4 + LEFTOVER_BITS - 1 downto NUM_GROUPS_4 * 4),
        bin     =>        bins(NUM_GROUPS_4 * 4),
        prop_g  =>     prop_gs(NUM_GROUPS_4),
        gen_g   =>      gen_gs(NUM_GROUPS_4),
        bouts   => bouts_lau_4(NUM_GROUPS_4 * 4 + LEFTOVER_BITS downto NUM_GROUPS_4 * 4 + 1));
end generate;

-- Last lookahead unit to cover the section of the subtractor that isn't a multiple of 16
-- e.g. bits 32 to 42 in a 43-bit subtractor
leftover_lau_16 : if LEFTOVER_BITS_MOD_16 > 0 generate
    lau_16 : entity work.Lookahead_Unit
    generic map(WIDTH => LEFTOVER_GROUPS_4 + EXTRA_LAU_4)
    port map(
        props   =>      prop_gs(NUM_GROUPS_4 + EXTRA_LAU_4 - 1 downto NUM_GROUPS_4 + EXTRA_LAU_4 - (LEFTOVER_GROUPS_4 + EXTRA_LAU_4)),
        gens    =>       gen_gs(NUM_GROUPS_4 + EXTRA_LAU_4 - 1 downto NUM_GROUPS_4 + EXTRA_LAU_4 - (LEFTOVER_GROUPS_4 + EXTRA_LAU_4)),
        bin     =>         bins(NUM_GROUPS_16 * 16),
        prop_g  =>         open,  -- not used
        gen_g   =>         open,  -- not used
        bouts   => bouts_lau_16(NUM_GROUPS_4 + EXTRA_LAU_4 downto NUM_GROUPS_4 + EXTRA_LAU_4 - (LEFTOVER_GROUPS_4 + EXTRA_LAU_4) + 1));
end generate;

end Behavioral;
