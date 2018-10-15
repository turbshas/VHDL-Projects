-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Sun Oct 14 12:31:58 2018
-- Host        : Trevor-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               D:/Development/VHDL_Projects/Carry_Lookahead_Adder/Carry_Lookahead_Adder.sim/sim_1/synth/func/xsim/Carry_Lookahead_Adder_tb_func_synth.vhd
-- Design      : Carry_Lookahead_Adder
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a200tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Carry_Lookahead_Adder is
  port (
    a : in STD_LOGIC_VECTOR ( 15 downto 0 );
    b : in STD_LOGIC_VECTOR ( 15 downto 0 );
    cin : in STD_LOGIC;
    sum : out STD_LOGIC_VECTOR ( 15 downto 0 );
    cout : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Carry_Lookahead_Adder : entity is true;
  attribute WIDTH : integer;
  attribute WIDTH of Carry_Lookahead_Adder : entity is 16;
end Carry_Lookahead_Adder;

architecture STRUCTURE of Carry_Lookahead_Adder is
  signal a_IBUF : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal b_IBUF : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal cin_IBUF : STD_LOGIC;
  signal cout_OBUF : STD_LOGIC;
  signal cout_OBUF_inst_i_2_n_0 : STD_LOGIC;
  signal cout_OBUF_inst_i_3_n_0 : STD_LOGIC;
  signal cout_OBUF_inst_i_4_n_0 : STD_LOGIC;
  signal sum_OBUF : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \sum_OBUF[10]_inst_i_2_n_0\ : STD_LOGIC;
  signal \sum_OBUF[11]_inst_i_2_n_0\ : STD_LOGIC;
  signal \sum_OBUF[11]_inst_i_3_n_0\ : STD_LOGIC;
  signal \sum_OBUF[12]_inst_i_10_n_0\ : STD_LOGIC;
  signal \sum_OBUF[12]_inst_i_2_n_0\ : STD_LOGIC;
  signal \sum_OBUF[12]_inst_i_3_n_0\ : STD_LOGIC;
  signal \sum_OBUF[12]_inst_i_4_n_0\ : STD_LOGIC;
  signal \sum_OBUF[12]_inst_i_5_n_0\ : STD_LOGIC;
  signal \sum_OBUF[12]_inst_i_6_n_0\ : STD_LOGIC;
  signal \sum_OBUF[12]_inst_i_7_n_0\ : STD_LOGIC;
  signal \sum_OBUF[12]_inst_i_8_n_0\ : STD_LOGIC;
  signal \sum_OBUF[12]_inst_i_9_n_0\ : STD_LOGIC;
  signal \sum_OBUF[14]_inst_i_2_n_0\ : STD_LOGIC;
  signal \sum_OBUF[14]_inst_i_3_n_0\ : STD_LOGIC;
  signal \sum_OBUF[14]_inst_i_4_n_0\ : STD_LOGIC;
  signal \sum_OBUF[14]_inst_i_5_n_0\ : STD_LOGIC;
  signal \sum_OBUF[15]_inst_i_10_n_0\ : STD_LOGIC;
  signal \sum_OBUF[15]_inst_i_2_n_0\ : STD_LOGIC;
  signal \sum_OBUF[15]_inst_i_3_n_0\ : STD_LOGIC;
  signal \sum_OBUF[15]_inst_i_4_n_0\ : STD_LOGIC;
  signal \sum_OBUF[15]_inst_i_5_n_0\ : STD_LOGIC;
  signal \sum_OBUF[15]_inst_i_6_n_0\ : STD_LOGIC;
  signal \sum_OBUF[15]_inst_i_7_n_0\ : STD_LOGIC;
  signal \sum_OBUF[15]_inst_i_8_n_0\ : STD_LOGIC;
  signal \sum_OBUF[15]_inst_i_9_n_0\ : STD_LOGIC;
  signal \sum_OBUF[2]_inst_i_2_n_0\ : STD_LOGIC;
  signal \sum_OBUF[3]_inst_i_2_n_0\ : STD_LOGIC;
  signal \sum_OBUF[5]_inst_i_2_n_0\ : STD_LOGIC;
  signal \sum_OBUF[5]_inst_i_3_n_0\ : STD_LOGIC;
  signal \sum_OBUF[5]_inst_i_4_n_0\ : STD_LOGIC;
  signal \sum_OBUF[7]_inst_i_2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of cout_OBUF_inst_i_4 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \sum_OBUF[0]_inst_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \sum_OBUF[11]_inst_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \sum_OBUF[12]_inst_i_5\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \sum_OBUF[12]_inst_i_8\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \sum_OBUF[12]_inst_i_9\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \sum_OBUF[13]_inst_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \sum_OBUF[14]_inst_i_4\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \sum_OBUF[14]_inst_i_5\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \sum_OBUF[15]_inst_i_10\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \sum_OBUF[15]_inst_i_3\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \sum_OBUF[15]_inst_i_4\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \sum_OBUF[15]_inst_i_7\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \sum_OBUF[15]_inst_i_8\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \sum_OBUF[15]_inst_i_9\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \sum_OBUF[1]_inst_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \sum_OBUF[2]_inst_i_2\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \sum_OBUF[3]_inst_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \sum_OBUF[3]_inst_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \sum_OBUF[4]_inst_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \sum_OBUF[5]_inst_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \sum_OBUF[5]_inst_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \sum_OBUF[5]_inst_i_3\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \sum_OBUF[6]_inst_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \sum_OBUF[7]_inst_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \sum_OBUF[7]_inst_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \sum_OBUF[8]_inst_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \sum_OBUF[9]_inst_i_1\ : label is "soft_lutpair0";
begin
\a_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(0),
      O => a_IBUF(0)
    );
\a_IBUF[10]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(10),
      O => a_IBUF(10)
    );
\a_IBUF[11]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(11),
      O => a_IBUF(11)
    );
\a_IBUF[12]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(12),
      O => a_IBUF(12)
    );
\a_IBUF[13]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(13),
      O => a_IBUF(13)
    );
\a_IBUF[14]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(14),
      O => a_IBUF(14)
    );
\a_IBUF[15]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(15),
      O => a_IBUF(15)
    );
\a_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(1),
      O => a_IBUF(1)
    );
\a_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(2),
      O => a_IBUF(2)
    );
\a_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(3),
      O => a_IBUF(3)
    );
\a_IBUF[4]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(4),
      O => a_IBUF(4)
    );
\a_IBUF[5]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(5),
      O => a_IBUF(5)
    );
\a_IBUF[6]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(6),
      O => a_IBUF(6)
    );
\a_IBUF[7]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(7),
      O => a_IBUF(7)
    );
\a_IBUF[8]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(8),
      O => a_IBUF(8)
    );
\a_IBUF[9]_inst\: unisim.vcomponents.IBUF
     port map (
      I => a(9),
      O => a_IBUF(9)
    );
\b_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(0),
      O => b_IBUF(0)
    );
\b_IBUF[10]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(10),
      O => b_IBUF(10)
    );
\b_IBUF[11]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(11),
      O => b_IBUF(11)
    );
\b_IBUF[12]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(12),
      O => b_IBUF(12)
    );
\b_IBUF[13]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(13),
      O => b_IBUF(13)
    );
\b_IBUF[14]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(14),
      O => b_IBUF(14)
    );
\b_IBUF[15]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(15),
      O => b_IBUF(15)
    );
\b_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(1),
      O => b_IBUF(1)
    );
\b_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(2),
      O => b_IBUF(2)
    );
\b_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(3),
      O => b_IBUF(3)
    );
\b_IBUF[4]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(4),
      O => b_IBUF(4)
    );
\b_IBUF[5]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(5),
      O => b_IBUF(5)
    );
\b_IBUF[6]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(6),
      O => b_IBUF(6)
    );
\b_IBUF[7]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(7),
      O => b_IBUF(7)
    );
\b_IBUF[8]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(8),
      O => b_IBUF(8)
    );
\b_IBUF[9]_inst\: unisim.vcomponents.IBUF
     port map (
      I => b(9),
      O => b_IBUF(9)
    );
cin_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => cin,
      O => cin_IBUF
    );
cout_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => cout_OBUF,
      O => cout
    );
cout_OBUF_inst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFCFCECECC"
    )
        port map (
      I0 => \sum_OBUF[14]_inst_i_3_n_0\,
      I1 => cout_OBUF_inst_i_2_n_0,
      I2 => cout_OBUF_inst_i_3_n_0,
      I3 => a_IBUF(12),
      I4 => b_IBUF(12),
      I5 => cout_OBUF_inst_i_4_n_0,
      O => cout_OBUF
    );
cout_OBUF_inst_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000088008800000"
    )
        port map (
      I0 => b_IBUF(13),
      I1 => a_IBUF(13),
      I2 => a_IBUF(15),
      I3 => b_IBUF(15),
      I4 => a_IBUF(14),
      I5 => b_IBUF(14),
      O => cout_OBUF_inst_i_2_n_0
    );
cout_OBUF_inst_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF99FF99FFFFF"
    )
        port map (
      I0 => a_IBUF(15),
      I1 => b_IBUF(15),
      I2 => a_IBUF(14),
      I3 => b_IBUF(14),
      I4 => b_IBUF(13),
      I5 => a_IBUF(13),
      O => cout_OBUF_inst_i_3_n_0
    );
cout_OBUF_inst_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E888"
    )
        port map (
      I0 => a_IBUF(15),
      I1 => b_IBUF(15),
      I2 => a_IBUF(14),
      I3 => b_IBUF(14),
      O => cout_OBUF_inst_i_4_n_0
    );
\sum_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(0),
      O => sum(0)
    );
\sum_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => cin_IBUF,
      I1 => b_IBUF(0),
      I2 => a_IBUF(0),
      O => sum_OBUF(0)
    );
\sum_OBUF[10]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(10),
      O => sum(10)
    );
\sum_OBUF[10]_inst_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555566A566AAAAA"
    )
        port map (
      I0 => \sum_OBUF[10]_inst_i_2_n_0\,
      I1 => \sum_OBUF[12]_inst_i_4_n_0\,
      I2 => b_IBUF(8),
      I3 => a_IBUF(8),
      I4 => b_IBUF(9),
      I5 => a_IBUF(9),
      O => sum_OBUF(10)
    );
\sum_OBUF[10]_inst_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a_IBUF(10),
      I1 => b_IBUF(10),
      O => \sum_OBUF[10]_inst_i_2_n_0\
    );
\sum_OBUF[11]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(11),
      O => sum(11)
    );
\sum_OBUF[11]_inst_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"566A6A6A5656566A"
    )
        port map (
      I0 => \sum_OBUF[11]_inst_i_2_n_0\,
      I1 => a_IBUF(10),
      I2 => b_IBUF(10),
      I3 => a_IBUF(9),
      I4 => b_IBUF(9),
      I5 => \sum_OBUF[11]_inst_i_3_n_0\,
      O => sum_OBUF(11)
    );
\sum_OBUF[11]_inst_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a_IBUF(11),
      I1 => b_IBUF(11),
      O => \sum_OBUF[11]_inst_i_2_n_0\
    );
\sum_OBUF[11]_inst_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000B0BFF"
    )
        port map (
      I0 => \sum_OBUF[14]_inst_i_5_n_0\,
      I1 => \sum_OBUF[5]_inst_i_2_n_0\,
      I2 => \sum_OBUF[15]_inst_i_6_n_0\,
      I3 => b_IBUF(8),
      I4 => a_IBUF(8),
      O => \sum_OBUF[11]_inst_i_3_n_0\
    );
\sum_OBUF[12]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(12),
      O => sum(12)
    );
\sum_OBUF[12]_inst_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00AB00BFFF54FF40"
    )
        port map (
      I0 => \sum_OBUF[12]_inst_i_2_n_0\,
      I1 => a_IBUF(8),
      I2 => b_IBUF(8),
      I3 => \sum_OBUF[12]_inst_i_3_n_0\,
      I4 => \sum_OBUF[12]_inst_i_4_n_0\,
      I5 => \sum_OBUF[12]_inst_i_5_n_0\,
      O => sum_OBUF(12)
    );
\sum_OBUF[12]_inst_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b_IBUF(5),
      I1 => a_IBUF(5),
      O => \sum_OBUF[12]_inst_i_10_n_0\
    );
\sum_OBUF[12]_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF99FF99FFFFF"
    )
        port map (
      I0 => a_IBUF(9),
      I1 => b_IBUF(9),
      I2 => a_IBUF(10),
      I3 => b_IBUF(10),
      I4 => a_IBUF(11),
      I5 => b_IBUF(11),
      O => \sum_OBUF[12]_inst_i_2_n_0\
    );
\sum_OBUF[12]_inst_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF0F880F880F000"
    )
        port map (
      I0 => a_IBUF(9),
      I1 => b_IBUF(9),
      I2 => b_IBUF(11),
      I3 => a_IBUF(11),
      I4 => b_IBUF(10),
      I5 => a_IBUF(10),
      O => \sum_OBUF[12]_inst_i_3_n_0\
    );
\sum_OBUF[12]_inst_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF0F8F0F8F0F0F0"
    )
        port map (
      I0 => \sum_OBUF[12]_inst_i_6_n_0\,
      I1 => \sum_OBUF[5]_inst_i_2_n_0\,
      I2 => \sum_OBUF[12]_inst_i_7_n_0\,
      I3 => \sum_OBUF[12]_inst_i_8_n_0\,
      I4 => b_IBUF(5),
      I5 => a_IBUF(5),
      O => \sum_OBUF[12]_inst_i_4_n_0\
    );
\sum_OBUF[12]_inst_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a_IBUF(12),
      I1 => b_IBUF(12),
      O => \sum_OBUF[12]_inst_i_5_n_0\
    );
\sum_OBUF[12]_inst_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a_IBUF(4),
      I1 => b_IBUF(4),
      O => \sum_OBUF[12]_inst_i_6_n_0\
    );
\sum_OBUF[12]_inst_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFC0C000FFD4D400"
    )
        port map (
      I0 => \sum_OBUF[12]_inst_i_9_n_0\,
      I1 => a_IBUF(6),
      I2 => b_IBUF(6),
      I3 => a_IBUF(7),
      I4 => b_IBUF(7),
      I5 => \sum_OBUF[12]_inst_i_10_n_0\,
      O => \sum_OBUF[12]_inst_i_7_n_0\
    );
\sum_OBUF[12]_inst_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0660"
    )
        port map (
      I0 => b_IBUF(7),
      I1 => a_IBUF(7),
      I2 => b_IBUF(6),
      I3 => a_IBUF(6),
      O => \sum_OBUF[12]_inst_i_8_n_0\
    );
\sum_OBUF[12]_inst_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => a_IBUF(4),
      I1 => b_IBUF(4),
      O => \sum_OBUF[12]_inst_i_9_n_0\
    );
\sum_OBUF[13]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(13),
      O => sum(13)
    );
\sum_OBUF[13]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99969666"
    )
        port map (
      I0 => b_IBUF(13),
      I1 => a_IBUF(13),
      I2 => \sum_OBUF[14]_inst_i_3_n_0\,
      I3 => b_IBUF(12),
      I4 => a_IBUF(12),
      O => sum_OBUF(13)
    );
\sum_OBUF[14]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(14),
      O => sum(14)
    );
\sum_OBUF[14]_inst_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5656566A566A6A6A"
    )
        port map (
      I0 => \sum_OBUF[14]_inst_i_2_n_0\,
      I1 => a_IBUF(13),
      I2 => b_IBUF(13),
      I3 => \sum_OBUF[14]_inst_i_3_n_0\,
      I4 => b_IBUF(12),
      I5 => a_IBUF(12),
      O => sum_OBUF(14)
    );
\sum_OBUF[14]_inst_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a_IBUF(14),
      I1 => b_IBUF(14),
      O => \sum_OBUF[14]_inst_i_2_n_0\
    );
\sum_OBUF[14]_inst_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF44440400"
    )
        port map (
      I0 => \sum_OBUF[12]_inst_i_2_n_0\,
      I1 => \sum_OBUF[14]_inst_i_4_n_0\,
      I2 => \sum_OBUF[14]_inst_i_5_n_0\,
      I3 => \sum_OBUF[5]_inst_i_2_n_0\,
      I4 => \sum_OBUF[15]_inst_i_6_n_0\,
      I5 => \sum_OBUF[15]_inst_i_7_n_0\,
      O => \sum_OBUF[14]_inst_i_3_n_0\
    );
\sum_OBUF[14]_inst_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a_IBUF(8),
      I1 => b_IBUF(8),
      O => \sum_OBUF[14]_inst_i_4_n_0\
    );
\sum_OBUF[14]_inst_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFD7D7FF"
    )
        port map (
      I0 => \sum_OBUF[12]_inst_i_8_n_0\,
      I1 => a_IBUF(4),
      I2 => b_IBUF(4),
      I3 => a_IBUF(5),
      I4 => b_IBUF(5),
      O => \sum_OBUF[14]_inst_i_5_n_0\
    );
\sum_OBUF[15]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(15),
      O => sum(15)
    );
\sum_OBUF[15]_inst_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"17771117E888EEE8"
    )
        port map (
      I0 => b_IBUF(14),
      I1 => a_IBUF(14),
      I2 => a_IBUF(13),
      I3 => b_IBUF(13),
      I4 => \sum_OBUF[15]_inst_i_2_n_0\,
      I5 => \sum_OBUF[15]_inst_i_3_n_0\,
      O => sum_OBUF(15)
    );
\sum_OBUF[15]_inst_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F880"
    )
        port map (
      I0 => a_IBUF(6),
      I1 => b_IBUF(6),
      I2 => a_IBUF(7),
      I3 => b_IBUF(7),
      O => \sum_OBUF[15]_inst_i_10_n_0\
    );
\sum_OBUF[15]_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111111171717177"
    )
        port map (
      I0 => a_IBUF(12),
      I1 => b_IBUF(12),
      I2 => \sum_OBUF[15]_inst_i_4_n_0\,
      I3 => \sum_OBUF[15]_inst_i_5_n_0\,
      I4 => \sum_OBUF[15]_inst_i_6_n_0\,
      I5 => \sum_OBUF[15]_inst_i_7_n_0\,
      O => \sum_OBUF[15]_inst_i_2_n_0\
    );
\sum_OBUF[15]_inst_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a_IBUF(15),
      I1 => b_IBUF(15),
      O => \sum_OBUF[15]_inst_i_3_n_0\
    );
\sum_OBUF[15]_inst_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EB"
    )
        port map (
      I0 => \sum_OBUF[12]_inst_i_2_n_0\,
      I1 => b_IBUF(8),
      I2 => a_IBUF(8),
      O => \sum_OBUF[15]_inst_i_4_n_0\
    );
\sum_OBUF[15]_inst_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABA000000000000"
    )
        port map (
      I0 => \sum_OBUF[5]_inst_i_4_n_0\,
      I1 => \sum_OBUF[15]_inst_i_8_n_0\,
      I2 => \sum_OBUF[5]_inst_i_3_n_0\,
      I3 => \sum_OBUF[2]_inst_i_2_n_0\,
      I4 => \sum_OBUF[15]_inst_i_9_n_0\,
      I5 => \sum_OBUF[12]_inst_i_8_n_0\,
      O => \sum_OBUF[15]_inst_i_5_n_0\
    );
\sum_OBUF[15]_inst_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0808080"
    )
        port map (
      I0 => b_IBUF(5),
      I1 => a_IBUF(5),
      I2 => \sum_OBUF[12]_inst_i_8_n_0\,
      I3 => b_IBUF(4),
      I4 => a_IBUF(4),
      I5 => \sum_OBUF[15]_inst_i_10_n_0\,
      O => \sum_OBUF[15]_inst_i_6_n_0\
    );
\sum_OBUF[15]_inst_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF40"
    )
        port map (
      I0 => \sum_OBUF[12]_inst_i_2_n_0\,
      I1 => a_IBUF(8),
      I2 => b_IBUF(8),
      I3 => \sum_OBUF[12]_inst_i_3_n_0\,
      O => \sum_OBUF[15]_inst_i_7_n_0\
    );
\sum_OBUF[15]_inst_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b_IBUF(1),
      I1 => a_IBUF(1),
      O => \sum_OBUF[15]_inst_i_8_n_0\
    );
\sum_OBUF[15]_inst_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0660"
    )
        port map (
      I0 => b_IBUF(5),
      I1 => a_IBUF(5),
      I2 => b_IBUF(4),
      I3 => a_IBUF(4),
      O => \sum_OBUF[15]_inst_i_9_n_0\
    );
\sum_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(1),
      O => sum(1)
    );
\sum_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99969666"
    )
        port map (
      I0 => a_IBUF(1),
      I1 => b_IBUF(1),
      I2 => cin_IBUF,
      I3 => b_IBUF(0),
      I4 => a_IBUF(0),
      O => sum_OBUF(1)
    );
\sum_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(2),
      O => sum(2)
    );
\sum_OBUF[2]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99696966"
    )
        port map (
      I0 => a_IBUF(2),
      I1 => b_IBUF(2),
      I2 => \sum_OBUF[2]_inst_i_2_n_0\,
      I3 => b_IBUF(1),
      I4 => a_IBUF(1),
      O => sum_OBUF(2)
    );
\sum_OBUF[2]_inst_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"17"
    )
        port map (
      I0 => a_IBUF(0),
      I1 => b_IBUF(0),
      I2 => cin_IBUF,
      O => \sum_OBUF[2]_inst_i_2_n_0\
    );
\sum_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(3),
      O => sum(3)
    );
\sum_OBUF[3]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96669996"
    )
        port map (
      I0 => b_IBUF(3),
      I1 => a_IBUF(3),
      I2 => a_IBUF(2),
      I3 => b_IBUF(2),
      I4 => \sum_OBUF[3]_inst_i_2_n_0\,
      O => sum_OBUF(3)
    );
\sum_OBUF[3]_inst_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"001717FF"
    )
        port map (
      I0 => a_IBUF(0),
      I1 => b_IBUF(0),
      I2 => cin_IBUF,
      I3 => b_IBUF(1),
      I4 => a_IBUF(1),
      O => \sum_OBUF[3]_inst_i_2_n_0\
    );
\sum_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(4),
      O => sum(4)
    );
\sum_OBUF[4]_inst_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \sum_OBUF[5]_inst_i_2_n_0\,
      I1 => b_IBUF(4),
      I2 => a_IBUF(4),
      O => sum_OBUF(4)
    );
\sum_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(5),
      O => sum(5)
    );
\sum_OBUF[5]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99969666"
    )
        port map (
      I0 => a_IBUF(5),
      I1 => b_IBUF(5),
      I2 => \sum_OBUF[5]_inst_i_2_n_0\,
      I3 => b_IBUF(4),
      I4 => a_IBUF(4),
      O => sum_OBUF(5)
    );
\sum_OBUF[5]_inst_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0440"
    )
        port map (
      I0 => \sum_OBUF[2]_inst_i_2_n_0\,
      I1 => \sum_OBUF[5]_inst_i_3_n_0\,
      I2 => a_IBUF(1),
      I3 => b_IBUF(1),
      I4 => \sum_OBUF[5]_inst_i_4_n_0\,
      O => \sum_OBUF[5]_inst_i_2_n_0\
    );
\sum_OBUF[5]_inst_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0660"
    )
        port map (
      I0 => b_IBUF(3),
      I1 => a_IBUF(3),
      I2 => b_IBUF(2),
      I3 => a_IBUF(2),
      O => \sum_OBUF[5]_inst_i_3_n_0\
    );
\sum_OBUF[5]_inst_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF0F880F880F000"
    )
        port map (
      I0 => a_IBUF(1),
      I1 => b_IBUF(1),
      I2 => b_IBUF(3),
      I3 => a_IBUF(3),
      I4 => b_IBUF(2),
      I5 => a_IBUF(2),
      O => \sum_OBUF[5]_inst_i_4_n_0\
    );
\sum_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(6),
      O => sum(6)
    );
\sum_OBUF[6]_inst_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => a_IBUF(6),
      I1 => b_IBUF(6),
      I2 => \sum_OBUF[7]_inst_i_2_n_0\,
      O => sum_OBUF(6)
    );
\sum_OBUF[7]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(7),
      O => sum(7)
    );
\sum_OBUF[7]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96669996"
    )
        port map (
      I0 => b_IBUF(7),
      I1 => a_IBUF(7),
      I2 => a_IBUF(6),
      I3 => b_IBUF(6),
      I4 => \sum_OBUF[7]_inst_i_2_n_0\,
      O => sum_OBUF(7)
    );
\sum_OBUF[7]_inst_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"001717FF"
    )
        port map (
      I0 => a_IBUF(4),
      I1 => b_IBUF(4),
      I2 => \sum_OBUF[5]_inst_i_2_n_0\,
      I3 => a_IBUF(5),
      I4 => b_IBUF(5),
      O => \sum_OBUF[7]_inst_i_2_n_0\
    );
\sum_OBUF[8]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(8),
      O => sum(8)
    );
\sum_OBUF[8]_inst_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \sum_OBUF[12]_inst_i_4_n_0\,
      I1 => b_IBUF(8),
      I2 => a_IBUF(8),
      O => sum_OBUF(8)
    );
\sum_OBUF[9]_inst\: unisim.vcomponents.OBUF
     port map (
      I => sum_OBUF(9),
      O => sum(9)
    );
\sum_OBUF[9]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99969666"
    )
        port map (
      I0 => a_IBUF(9),
      I1 => b_IBUF(9),
      I2 => a_IBUF(8),
      I3 => b_IBUF(8),
      I4 => \sum_OBUF[12]_inst_i_4_n_0\,
      O => sum_OBUF(9)
    );
end STRUCTURE;
