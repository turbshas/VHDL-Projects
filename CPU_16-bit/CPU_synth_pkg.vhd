package CPU_synth_pkg is

-- 5 bits for opcode
-- 2 bits for each register
-- 4 bits for condition code
-- 1 bit left over
-- For now:
--       15  14   13  12   11  10   9  8    5  4      0
--  |------||-------||-------||------||------||--------|
--  | RSVD ||  RS2  ||  RS1  ||  RD  || COND || OPCODE |
--
--
--   15                    11  10   9  8    5  4      0
--  |------------------------||------||------||--------|
--  |        IMMEDIATE       ||  RD  || COND || OPCODE |

-- types ----------------------------------------
type OP_CODE is std_logic_vector(4 downto 0);
type EX_COND is std_logic_vector(3 downto 0);

-- OP Codes -------------------------------------
constant OC_NOP  : OP_CODE := "00000";
constant OC_LDH  : OP_CODE := "00001"; -- Load half-word(2B)
constant OC_LDB  : OP_CODE := "00010"; -- Load byte
constant OC_LDSB : OP_CODE := "00011"; -- Load signed byte
constant OC_LDI  : OP_CODE := "00100"; -- Load immediate
constant OC_STRH : OP_CODE := "00101"; -- Store half-word (2B)
constant OC_STRB : OP_CODE := "00110"; -- Store byte
constant OC_B    : OP_CODE := "00111"; -- Branch
constant OC_BX   : OP_CODE := "01000"; -- Branch to address in a register
constant OC_CMP  : OP_CODE := "01001"; -- Compare
constant OC_TST  : OP_CODE := "01010"; -- Test

constant OC_BFC  : OP_CODE := "01011"; -- Bit field clear
constant OC_NOT  : OP_CODE := "01100"; -- Bitwise not
constant OC_AND  : OP_CODE := "01101"; -- Bitwise and
constant OC_ORR  : OP_CODE := "01110"; -- Bitwise or
constant OC_XOR  : OP_CODE := "01111"; -- Bitwise xor
constant OC_LSL  : OP_CODE := "10000"; -- Logical shift left
constant OC_LSR  : OP_CODE := "10001"; -- Logical shift right
constant OC_ASR  : OP_CODE := "10010"; -- Arithmetic shift right

constant OC_ADD  : OP_CODE := "10011"; -- Integer add
constant OC_SUB  : OP_CODE := "10100"; -- Integer subtract
constant OC_MUL  : OP_CODE := "10101"; -- Integer multiply
constant OC_DIV  : OP_CODE := "10110"; -- Integer divide
constant OC_NEG  : OP_CODE := "10111"; -- Negation

constant OC_RSV0 : OP_CODE := "11000";
constant OC_RSV1 : OP_CODE := "11001";
constant OC_RSV2 : OP_CODE := "11010";
constant OC_RSV3 : OP_CODE := "11011";
constant OC_RSV4 : OP_CODE := "11100";
constant OC_RSV5 : OP_CODE := "11101";
constant OC_RSV6 : OP_CODE := "11110";
constant OC_RSV7 : OP_CODE := "11111";

-- Execution conditions--------------------------
constant EC_AL : EX_COND := "0000";

constant EC_EQ : EX_COND := "0001";
constant EC_NE : EX_COND := "0010";
constant EC_CS : EX_COND := "0011";
constant EC_CC : EX_COND := "0100";
constant EC_PV : EX_COND := "0101";
constant EC_NV : EX_COND := "0110";
constant EC_VS : EX_COND := "0111";
constant EC_VC : EX_COND := "1000";

constant EC_HI : EX_COND := "1001";
constant EC_LS : EX_COND := "1010";
constant EC_GT : EX_COND := "1011";
constant EC_GE : EX_COND := "1100";
constant EC_LT : EX_COND := "1101";
constant EC_LE : EX_COND := "1110";

constant EC_RSV : EX_COND := "1111";

end package;
