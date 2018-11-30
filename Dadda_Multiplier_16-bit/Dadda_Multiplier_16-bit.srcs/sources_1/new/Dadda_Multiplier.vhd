----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2018 10:17:59 AM
-- Design Name: 
-- Module Name: Dadda_Multiplier - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Dadda_Multiplier is
    port(
        a       : in std_logic_vector(15 downto 0);
        b       : in std_logic_vector(15 downto 0);
        result  : out std_logic_vector(31 downto 0)
    );
end Dadda_Multiplier;

architecture Behavioral of Dadda_Multiplier is

constant MAX_CARRY      : natural := 4;
constant NUM_STEPS      : natural := 6;
constant NUM_WEIGHTS    : natural := 31;
constant WIDTH          : natural := 16;

type CARRIES_T is array (NUM_WEIGHTS - 1 downto 0) of std_logic_vector(MAX_CARRY - 1 downto 0);
type CARRIES_ARR_T is array (NUM_STEPS downto 0) of CARRIES_T;
type WEIGHTS_T is array (NUM_WEIGHTS - 1 downto 0) of std_logic_vector(WIDTH - 1 downto 0);
type WEIGHTS_ARR_T is array (NUM_STEPS downto 0) of WEIGHTS_T;

signal carries : CARRIES_ARR_T;
signal weights : WEIGHTS_ARR_T;

signal temp_add_a   : std_logic_vector(NUM_WEIGHTS - 2 downto 0);
signal temp_add_b   : std_logic_vector(NUM_WEIGHTS - 2 downto 0);
signal temp_output  : std_logic_vector(NUM_WEIGHTS downto 0);
signal temp_weights : WEIGHTS_T;

begin

-- Initialize first set of values
init : for i in 0 to WIDTH - 1 generate
    inner : for j in 0 to WIDTH - 1 generate
        temp_weights(i + j)(i) <= a(i) AND b(j);
    end generate;
end generate;

weights(0)(15 downto 0) <= temp_weights(15 downto 0);
mapping_loop : for i in 16 to NUM_WEIGHTS - 1 generate
    weights(0)(i)((30 - i) downto 0) <= temp_weights(i)(15 downto (i - 15));
end generate;

-- Sum of adder goes to bottom of the same weight
-- Carry of adder goes to top of the next weight (the carries signal)

-- **************** Step 1 **************** --

-- Weights 0 - 12 pass through
weights(1)(12 downto 0) <= weights(0)(12 downto 0);

-- Weight 13
s0_0 : entity work.Half_Adder port map(a => weights(0)(13)(0), b => weights(0)(13)(1),                         sum => weights(1)(13)(12), carry => carries(0)(14)(0));
weights(1)(13)(11 downto 0) <= weights(0)(13)(13 downto 2);
    
-- Weight 14
s0_1 : entity work.Full_Adder port map(a => carries(0)(14)(0), b => weights(0)(14)(0), c => weights(0)(14)(1), sum => weights(1)(14)(11), carry => carries(0)(15)(0));
s0_2 : entity work.Half_Adder port map(a => weights(0)(14)(2), b => weights(0)(14)(3),                         sum => weights(1)(14)(12), carry => carries(0)(15)(1));
weights(1)(14)(10 downto 0) <= weights(0)(14)(14 downto 4);

-- Weight 15
s0_3 : entity work.Full_Adder port map(a => carries(0)(15)(0), b => carries(0)(15)(1), c => weights(0)(15)(0), sum => weights(1)(15)(10), carry => carries(0)(16)(0));
s0_4 : entity work.Full_Adder port map(a => weights(0)(15)(1), b => weights(0)(15)(2), c => weights(0)(15)(3), sum => weights(1)(15)(11), carry => carries(0)(16)(1));
s0_5 : entity work.Half_Adder port map(a => weights(0)(15)(4), b => weights(0)(15)(5),                         sum => weights(1)(15)(12), carry => carries(0)(16)(2));
weights(1)(15)(9 downto 0) <= weights(0)(15)(15 downto 6);
    
-- Weight 16
s0_6 : entity work.Full_Adder port map(a => carries(0)(16)(0), b => carries(0)(16)(1), c => carries(0)(16)(2), sum => weights(1)(16)(10), carry => carries(0)(17)(0));
s0_7 : entity work.Full_Adder port map(a => weights(0)(16)(0), b => weights(0)(16)(1), c => weights(0)(16)(2), sum => weights(1)(16)(11), carry => carries(0)(17)(1));
s0_8 : entity work.Half_Adder port map(a => weights(0)(16)(3), b => weights(0)(16)(4),                         sum => weights(1)(16)(12), carry => carries(0)(17)(2));
weights(1)(16)(9 downto 0) <= weights(0)(16)(14 downto 5);

-- Weight 17
s0_9  : entity work.Full_Adder port map(a => carries(0)(17)(0), b => carries(0)(17)(1), c => carries(0)(17)(2), sum => weights(1)(17)(11), carry => carries(0)(18)(0));
s0_10 : entity work.Full_Adder port map(a => weights(0)(17)(0), b => weights(0)(17)(1), c => weights(0)(17)(2), sum => weights(1)(17)(12), carry => carries(0)(18)(1));
weights(1)(17)(10 downto 0) <= weights(0)(17)(13 downto 3);

-- Weight 18
-- This is the last adder for this step, so the carry goes to the weights signal instead
s0_11 : entity work.Full_Adder port map(a => carries(0)(18)(0), b => carries(0)(18)(1), c => weights(0)(18)(0), sum => weights(1)(18)(12), carry => weights(1)(19)(0));
weights(1)(18)(11 downto 0) <= weights(0)(18)(12 downto 1);

-- Weight 19
weights(1)(19)(12 downto 1) <= weights(0)(19)(11 downto 0);

-- Everything else is passed through
weights(1)(NUM_WEIGHTS - 1 downto 20) <= weights(0)(NUM_WEIGHTS - 1 downto 20);

-- **************** Step 2 **************** --
weights(2)(8 downto 0) <= weights(1)(8 downto 0);

-- Weight 9
s1_0 : entity work.Half_Adder port map(a => weights(1)(9)(0), b => weights(1)(9)(1),                           sum => weights(2)(9)(8), carry => carries(1)(10)(0));
weights(2)(9)(7 downto 0) <= weights(1)(9)(9 downto 2);

-- Weight 10
s1_1 : entity work.Full_Adder port map(a => carries(1)(10)(0), b => weights(1)(10)(0), c => weights(1)(10)(1), sum => weights(2)(10)(7), carry => carries(1)(11)(0));
s1_2 : entity work.Half_Adder port map(a => weights(1)(10)(2), b => weights(1)(10)(3),                         sum => weights(2)(10)(8), carry => carries(1)(11)(1));
weights(2)(10)(6 downto 0) <= weights(1)(10)(10 downto 4);

-- Weight 11
s1_3 : entity work.Full_Adder port map(a => carries(1)(11)(0), b => carries(1)(11)(1), c => weights(1)(11)(0), sum => weights(2)(11)(6), carry => carries(1)(12)(0));
s1_4 : entity work.Full_Adder port map(a => weights(1)(11)(1), b => weights(1)(11)(2), c => weights(1)(11)(3), sum => weights(2)(11)(7), carry => carries(1)(12)(1));
s1_5 : entity work.Half_Adder port map(a => weights(1)(11)(4), b => weights(1)(11)(5),                         sum => weights(2)(11)(8), carry => carries(1)(12)(2));
weights(2)(11)(5 downto 0) <= weights(1)(11)(11 downto 6);

-- Weight 12
s1_6 : entity work.Full_Adder port map(a => carries(1)(12)(0), b => carries(1)(12)(1), c => carries(1)(12)(2), sum => weights(2)(12)(5), carry => carries(1)(13)(0));
s1_7 : entity work.Full_Adder port map(a => weights(1)(12)(0), b => weights(1)(12)(1), c => weights(1)(12)(2), sum => weights(2)(12)(6), carry => carries(1)(13)(1));
s1_8 : entity work.Full_Adder port map(a => weights(1)(12)(3), b => weights(1)(12)(4), c => weights(1)(12)(5), sum => weights(2)(12)(7), carry => carries(1)(13)(2));
s1_9 : entity work.Half_Adder port map(a => weights(1)(12)(6), b => weights(1)(12)(7),                         sum => weights(2)(12)(8), carry => carries(1)(13)(3));
weights(2)(12)(4 downto 0) <= weights(1)(12)(12 downto 8);

-- Weight 13 to 19
s1_loop : for i in 13 to 19 generate
    fa0 : entity work.Full_Adder port map(a => carries(1)(i)(0), b => carries(1)(i)(1), c => carries(1)(i)(2), sum => weights(2)(i)(5), carry => carries(1)(i + 1)(0));
    fa1 : entity work.Full_Adder port map(a => carries(1)(i)(3), b => weights(1)(i)(0), c => weights(1)(i)(1), sum => weights(2)(i)(6), carry => carries(1)(i + 1)(1));
    fa2 : entity work.Full_Adder port map(a => weights(1)(i)(2), b => weights(1)(i)(3), c => weights(1)(i)(4), sum => weights(2)(i)(7), carry => carries(1)(i + 1)(2));
    fa3 : entity work.Full_Adder port map(a => weights(1)(i)(5), b => weights(1)(i)(6), c => weights(1)(i)(7), sum => weights(2)(i)(8), carry => carries(1)(i + 1)(3));
    weights(2)(i)(4 downto 0) <= weights(1)(i)(12 downto 8);
end generate;

-- Weight 20
s1_10 : entity work.Full_Adder port map(a => carries(1)(20)(0), b => carries(1)(20)(1), c => carries(1)(20)(2), sum => weights(2)(20)(6), carry => carries(1)(21)(0));
s1_11 : entity work.Full_Adder port map(a => carries(1)(20)(3), b => weights(1)(20)(0), c => weights(1)(20)(1), sum => weights(2)(20)(7), carry => carries(1)(21)(1));
s1_12 : entity work.Full_Adder port map(a => weights(1)(20)(2), b => weights(1)(20)(3), c => weights(1)(20)(4), sum => weights(2)(20)(8), carry => carries(1)(21)(2));
weights(2)(20)(5 downto 0) <= weights(1)(20)(10 downto 5);

-- Weight 21
s1_13 : entity work.Full_Adder port map(a => carries(1)(21)(0), b => carries(1)(21)(1), c => carries(1)(21)(2), sum => weights(2)(21)(7), carry => carries(1)(22)(0));
s1_14 : entity work.Full_Adder port map(a => weights(1)(21)(0), b => weights(0)(21)(1), c => weights(0)(21)(2), sum => weights(2)(21)(8), carry => carries(1)(22)(1));
weights(2)(21)(6 downto 0) <= weights(1)(21)(9 downto 3);

-- Weight 22
-- This is the last adder for this step, so the carry goes to the weights signal instead
s1_15 : entity work.Full_Adder port map(a => carries(1)(22)(0), b => carries(1)(22)(1), c => weights(1)(22)(0), sum => weights(2)(22)(8), carry => weights(2)(23)(0));
weights(2)(22)(7 downto 0) <= weights(1)(22)(8 downto 1);

-- Weight 23
weights(2)(23)(8 downto 1) <= weights(1)(23)(7 downto 0);

-- Everything else passes through
weights(2)(NUM_WEIGHTS - 1 downto 24) <= weights(1)(NUM_WEIGHTS - 1 downto 24);

-- **************** Step 3 **************** --
weights(3)(5 downto 0) <= weights(2)(5 downto 0);

-- Weight 6
s2_0 : entity work.Half_Adder port map(a => weights(2)(6)(0), b => weights(2)(6)(1),                         sum => weights(3)(6)(5), carry => carries(2)(7)(0));
weights(3)(6)(4 downto 0) <= weights(2)(6)(6 downto 2);

-- Weight 7
s2_1 : entity work.Full_Adder port map(a => carries(2)(7)(0), b => weights(2)(7)(0), c => weights(2)(7)(1), sum => weights(3)(7)(4), carry => carries(2)(8)(0));
s2_2 : entity work.Half_Adder port map(a => weights(2)(7)(2), b => weights(2)(7)(3),                        sum => weights(3)(7)(5), carry => carries(2)(8)(1));
weights(3)(7)(3 downto 0) <= weights(2)(7)(7 downto 4);

-- Weight 8
s2_3 : entity work.Full_Adder port map(a => carries(2)(8)(0), b => carries(2)(8)(1), c => weights(2)(8)(0), sum => weights(3)(8)(3), carry => carries(2)(9)(0));
s2_4 : entity work.Full_Adder port map(a => weights(2)(8)(1), b => weights(2)(8)(2), c => weights(2)(8)(3), sum => weights(3)(8)(4), carry => carries(2)(9)(1));
s2_5 : entity work.Half_Adder port map(a => weights(2)(8)(4), b => weights(2)(8)(5),                        sum => weights(3)(8)(5), carry => carries(2)(9)(2));
weights(3)(8)(2 downto 0) <= weights(2)(8)(8 downto 6);

-- Weight 9 to 23
s2_loop : for i in 9 to 23 generate
    fa0 : entity work.Full_Adder port map(a => carries(2)(i)(0), b => carries(2)(i)(1), c => carries(2)(i)(2), sum => weights(3)(i)(3), carry => carries(2)(i + 1)(0));
    fa1 : entity work.Full_Adder port map(a => weights(2)(i)(0), b => weights(2)(i)(1), c => weights(2)(i)(2), sum => weights(3)(i)(4), carry => carries(2)(i + 1)(1));
    fa2 : entity work.Full_Adder port map(a => weights(2)(i)(3), b => weights(2)(i)(4), c => weights(2)(i)(5), sum => weights(3)(i)(5), carry => carries(2)(i + 1)(2));
    weights(3)(i)(2 downto 0) <= weights(2)(i)(8 downto 6);    
end generate;

-- Weight 24
s2_6 : entity work.Full_Adder port map(a => carries(2)(24)(0), b => carries(2)(24)(1), c => carries(2)(24)(2), sum => weights(3)(24)(4), carry => carries(2)(25)(0));
s2_7 : entity work.Full_Adder port map(a => weights(2)(24)(0), b => weights(2)(24)(1), c => weights(2)(24)(2), sum => weights(3)(24)(5), carry => carries(2)(25)(1));
weights(3)(24)(3 downto 0) <= weights(2)(24)(6 downto 3);

-- Weight 25
-- This is the last adder for this step, so the carry goes to the weights signal instead
s2_8 : entity work.Full_Adder port map(a => carries(2)(25)(0), b => carries(2)(25)(1), c => weights(2)(25)(0), sum => weights(3)(25)(5), carry => weights(3)(26)(0));
weights(3)(25)(4 downto 0) <= weights(2)(25)(5 downto 1);

-- Weight 26
weights(3)(26)(5 downto 1) <= weights(2)(26)(4 downto 0);

-- Everything else passes through
weights(3)(NUM_WEIGHTS - 1 downto 27) <= weights(2)(NUM_WEIGHTS - 1 downto 27);

-- **************** Step 4 **************** --
weights(4)(3 downto 0) <= weights(3)(3 downto 0);

-- Weight 4
s3_0 : entity work.Half_Adder port map(a => weights(3)(4)(0), b => weights(3)(4)(1),                         sum => weights(4)(4)(3), carry => carries(3)(5)(0));
weights(4)(4)(2 downto 0) <= weights(3)(4)(4 downto 2);

-- Weight 5
s3_1 : entity work.Full_Adder port map(a => carries(3)(5)(0), b => weights(3)(5)(0), c => weights(3)(5)(1), sum => weights(4)(5)(2), carry => carries(3)(6)(0));
s3_2 : entity work.Half_Adder port map(a => weights(3)(5)(2), b => weights(3)(5)(3),                        sum => weights(4)(5)(3), carry => carries(3)(6)(1));
weights(4)(5)(1 downto 0) <= weights(3)(5)(5 downto 4);

-- Weights 6 to 26
s3_loop : for i in 6 to 26 generate
    fa0 : entity work.Full_Adder port map(a => carries(3)(i)(0), b => carries(3)(i)(1), c => weights(3)(i)(0), sum => weights(4)(i)(2), carry => carries(3)(i + 1)(0));
    fa1 : entity work.Full_Adder port map(a => weights(3)(i)(1), b => weights(3)(i)(2), c => weights(3)(i)(3), sum => weights(4)(i)(3), carry => carries(3)(i + 1)(1));
    weights(4)(i)(1 downto 0) <= weights(3)(i)(5 downto 4);    
end generate;

-- Weight 27
-- This is the last adder for this step, so the carry goes to the weights signal instead
s3_3 : entity work.Full_Adder port map(a => carries(3)(27)(0), b => carries(3)(27)(1), c => weights(3)(27)(0), sum => weights(4)(27)(3), carry => weights(4)(28)(0));
weights(4)(27)(2 downto 0) <= weights(3)(27)(3 downto 1);

-- Weight 28
weights(4)(28)(3 downto 1) <= weights(3)(28)(2 downto 0);

-- Everything else passes through
weights(4)(NUM_WEIGHTS - 1 downto 29) <= weights(3)(NUM_WEIGHTS - 1 downto 29);

-- **************** Step 5 **************** --
weights(5)(2 downto 0) <= weights(4)(2 downto 0);

-- Weight 3
s4_0 : entity work.Half_Adder port map(a => weights(4)(3)(0), b => weights(4)(3)(1),                         sum => weights(5)(3)(2), carry => carries(4)(4)(0));
weights(5)(3)(1 downto 0) <= weights(4)(3)(3 downto 2);

-- Weight 4 to 27
s4_loop : for i in 4 to 27 generate
    fa0 : entity work.Full_Adder port map(a => carries(4)(i)(0), b => weights(4)(i)(0), c => weights(4)(i)(1), sum => weights(5)(i)(2), carry => carries(4)(i + 1)(0));
    weights(5)(i)(1 downto 0) <= weights(4)(i)(3 downto 2);
end generate;

-- Weight 28
-- This is the last adder for this step, so the carry goes to the weights signal instead
s4_1 : entity work.Full_Adder port map(a => carries(4)(28)(0), b => weights(4)(28)(0), c => weights(4)(28)(1), sum => weights(5)(28)(2), carry => weights(5)(29)(0));
weights(5)(28)(1 downto 0) <= weights(4)(28)(3 downto 2);

-- Weight 29
weights(5)(29)(2 downto 1) <= weights(4)(29)(1 downto 0);

-- Everything else passes through
weights(5)(NUM_WEIGHTS - 1 downto 30) <= weights(3)(NUM_WEIGHTS - 1 downto 30);

-- **************** Step 6 **************** --
weights(6)(1 downto 0) <= weights(5)(1 downto 0);

-- Weight 2
s5_0 : entity work.Half_Adder port map(a => weights(5)(2)(0), b => weights(5)(2)(1),                         sum => weights(6)(2)(1), carry => carries(5)(3)(0));
weights(6)(2)(0 downto 0) <= weights(5)(2)(2 downto 2);

-- Weight 3 to 28
s5_loop : for i in 3 to 28 generate
    fa0 : entity work.Full_Adder port map(a => carries(5)(i)(0), b => weights(5)(i)(0), c => weights(5)(i)(1), sum => weights(6)(i)(1), carry => carries(5)(i + 1)(0));
    weights(6)(i)(0 downto 0) <= weights(5)(i)(2 downto 2);
end generate;

-- Weight 29
-- This is the last adder for this step, so the carry goes to the weights signal instead
s5_1 : entity work.Full_Adder port map(a => carries(5)(29)(0), b => weights(5)(29)(0), c => weights(5)(29)(1), sum => weights(6)(29)(1), carry => weights(6)(30)(0));
weights(6)(29)(0 downto 0) <= weights(5)(29)(2 downto 2);

-- Weight 30
weights(6)(30)(1 downto 1) <= weights(5)(30)(0 downto 0);

-- **************** Step 7 **************** --
-- Convert to std_logic_vector
convert_loop : for i in 0 to NUM_WEIGHTS - 2 generate
    temp_add_a(i) <= weights(6)(i + 1)(1);
    temp_add_b(i) <= weights(6)(i + 1)(0);
end generate;
-- Do the final add
temp_output(0) <= weights(6)(0)(0);
temp_output(NUM_WEIGHTS downto 1) <= std_logic_vector(("0" & unsigned(temp_add_a)) + ("0" & unsigned(temp_add_b)));

result <= temp_output;

end Behavioral;
