package CPU_synth_pkg is

-- types ----------------------------------------
type OP_CODE is std_logic_vector( downto 0);

-- OP Codes -------------------------------------
constant OC_NOP  : OP_CODE := "00000";
constant OC_LDR  : OP_CODE := "00001";
constant OC_LDB  : OP_CODE := "00010";
constant OC_LDSB : OP_CODE := "";
constant OC_STR  : OP_CODE := "00011";
constant OC_MOV  : OP_CODE := "00100";
constant OC_B    : OP_CODE := "00101";
constant OC_CMP  : OP_CODE := "";
constant OC_TST  : OP_CODE := "";

constant OC_BFC  : OP_CODE := "";
constant OC_NOT  : OP_CODE := "00101";
constant OC_AND  : OP_CODE := "00110";
constant OC_ORR  : OP_CODE := "00111";
constant OC_XOR  : OP_CODE := "01000";
constant OC_LSL  : OP_CODE := "01001";
constant OC_LSR  : OP_CODE := "01010";
constant OC_ASR  : OP_CODE := "01011";

constant OC_ADD  : OP_CODE := "01100";
constant OC_SUB  : OP_CODE := "01101";
constant OC_MUL  : OP_CODE := "01110";
constant OC_DIV  : OP_CODE := "01111";
constant OC_NEG  : OP_CODE := "10000";

constant OC_FADD : OP_CODE := "10001";
constant OC_FSUB : OP_CODE := "10010";
constant OC_FMUL : OP_CODE := "10011";
constant OC_FDIV : OP_CODE := "10100";
constant OC_FNEG : OP_CODE := "10101";


end package;