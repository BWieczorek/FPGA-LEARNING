-- -------------------------------------------------------------
-- 
-- File Name: hdlsrcx/lookupTable/nfp_ceil_single.vhd
-- Created: 2020-01-07 22:53:34
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: nfp_ceil_single
-- Source Path: lookupTable/sys/lookupFun/nfp_ceil_single
-- Hierarchy Level: 3
-- 
-- {Latency Strategy = "Max"}
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.lookupTable_pkg.ALL;

ENTITY nfp_ceil_single IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        nfp_in                            :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        nfp_out                           :   OUT   std_logic_vector(31 DOWNTO 0)  -- ufix32
        );
END nfp_ceil_single;


ARCHITECTURE rtl OF nfp_ceil_single IS

  -- Signals
  SIGNAL Constant8_out1                   : std_logic;  -- ufix1
  SIGNAL Constant7_out1                   : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL Delay4_out1                      : std_logic;  -- ufix1
  SIGNAL Logical_Operator_out1            : std_logic;  -- ufix1
  SIGNAL Data_Type_Conversion_out1        : std_logic;  -- ufix1
  SIGNAL Add_out1                         : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Delay3_out1                      : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Add_add_cast                     : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Delay1_out1                      : std_logic;  -- ufix1
  SIGNAL nfp_in_unsigned                  : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL aSign                            : std_logic;  -- ufix1
  SIGNAL aExponent                        : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL aMantissa                        : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL Delay_PS_1_2_reg                 : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Delay_PS_1_2_reg_next            : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Delay_PS_1_2_out1                : std_logic;  -- ufix1
  SIGNAL Delay_PS_3_out1                  : std_logic;  -- ufix1
  SIGNAL Delay14_PS_4_out1                : std_logic;  -- ufix1
  SIGNAL Constant1_out1                   : std_logic;  -- ufix1
  SIGNAL Switch1_out1                     : std_logic;  -- ufix1
  SIGNAL Delay3_PS_5_out1                 : std_logic;  -- ufix1
  SIGNAL Delay2_PS_1_out1                 : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL isExponentZero_out1              : std_logic;  -- ufix1
  SIGNAL Delay3_PS_1_out1                 : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL isExponentGt150_out1             : std_logic;  -- ufix1
  SIGNAL isMantissaZero_out1              : std_logic;  -- ufix1
  SIGNAL isInputZero_out1                 : std_logic;  -- ufix1
  SIGNAL isInputInteger_out1              : std_logic;  -- ufix1
  SIGNAL Delay4_PS_2_4_reg                : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL Delay4_PS_2_4_reg_next           : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL Delay4_PS_2_4_out1               : std_logic;  -- ufix1
  SIGNAL Delay2_PS_2_3_reg                : vector_of_unsigned8(0 TO 1);  -- ufix8 [2]
  SIGNAL Delay2_PS_2_3_reg_next           : vector_of_unsigned8(0 TO 1);  -- ufix8 [2]
  SIGNAL Delay2_PS_2_3_out1               : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Delay10_PS_4_out1                : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL isExponentLt127_out1             : std_logic;  -- ufix1
  SIGNAL isInputPositive_out1             : std_logic;  -- ufix1
  SIGNAL Constant77_out1                  : std_logic;  -- ufix1
  SIGNAL normalizedMantissa_out1          : unsigned(23 DOWNTO 0);  -- ufix24
  SIGNAL Bit_Slice8_out1                  : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Bit_Slice16_out1                 : std_logic;  -- ufix1
  SIGNAL Bit_Slice15_out1                 : std_logic;  -- ufix1
  SIGNAL Logical_Operator5_out1           : std_logic;  -- ufix1
  SIGNAL Bit_Slice14_out1                 : std_logic;  -- ufix1
  SIGNAL Bit_Slice13_out1                 : std_logic;  -- ufix1
  SIGNAL Logical_Operator7_out1           : std_logic;  -- ufix1
  SIGNAL Logical_Operator6_out1           : std_logic;  -- ufix1
  SIGNAL Bit_Slice12_out1                 : std_logic;  -- ufix1
  SIGNAL Bit_Slice11_out1                 : std_logic;  -- ufix1
  SIGNAL Logical_Operator4_out1           : std_logic;  -- ufix1
  SIGNAL Bit_Slice10_out1                 : std_logic;  -- ufix1
  SIGNAL Bit_Slice9_out1                  : std_logic;  -- ufix1
  SIGNAL Logical_Operator14_out1          : std_logic;  -- ufix1
  SIGNAL Logical_Operator13_out1          : std_logic;  -- ufix1
  SIGNAL Bit_Slice9_out1_1                : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Bit_Slice16_out1_1               : std_logic;  -- ufix1
  SIGNAL Bit_Slice15_out1_1               : std_logic;  -- ufix1
  SIGNAL Logical_Operator5_out1_1         : std_logic;  -- ufix1
  SIGNAL Bit_Slice14_out1_1               : std_logic;  -- ufix1
  SIGNAL Bit_Slice13_out1_1               : std_logic;  -- ufix1
  SIGNAL Logical_Operator7_out1_1         : std_logic;  -- ufix1
  SIGNAL Logical_Operator6_out1_1         : std_logic;  -- ufix1
  SIGNAL Bit_Slice12_out1_1               : std_logic;  -- ufix1
  SIGNAL Bit_Slice11_out1_1               : std_logic;  -- ufix1
  SIGNAL Logical_Operator4_out1_1         : std_logic;  -- ufix1
  SIGNAL Bit_Slice10_out1_1               : std_logic;  -- ufix1
  SIGNAL Bit_Slice9_out1_2                : std_logic;  -- ufix1
  SIGNAL Logical_Operator14_out1_1        : std_logic;  -- ufix1
  SIGNAL Logical_Operator13_out1_1        : std_logic;  -- ufix1
  SIGNAL Bit_Slice2_out1                  : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Bit_Slice8_out1_1                : std_logic;  -- ufix1
  SIGNAL Bit_Slice7_out1                  : std_logic;  -- ufix1
  SIGNAL Logical_Operator1_out1           : std_logic;  -- ufix1
  SIGNAL Bit_Slice6_out1                  : std_logic;  -- ufix1
  SIGNAL Bit_Slice5_out1                  : std_logic;  -- ufix1
  SIGNAL Logical_Operator3_out1           : std_logic;  -- ufix1
  SIGNAL Bit_Slice3_out1                  : std_logic;  -- ufix1
  SIGNAL Bit_Slice2_out1_1                : std_logic;  -- ufix1
  SIGNAL Bit_Slice4_out1                  : std_logic;  -- ufix1
  SIGNAL Constant_out1                    : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Bit_Slice1_out1                  : std_logic;  -- ufix1
  SIGNAL Constant1_out1_1                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch2_out1                     : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Logical_Operator_out1_1          : std_logic;  -- ufix1
  SIGNAL Constant2_out1                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch1_out1_1                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant3_out1                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant4_out1                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Logical_Operator2_out1           : std_logic;  -- ufix1
  SIGNAL Switch3_out1                     : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch4_out1                     : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant5_out1                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant6_out1                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch6_out1                     : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant7_out1_1                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant8_out1_1                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch8_out1                     : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Logical_Operator12_out1          : std_logic;  -- ufix1
  SIGNAL Switch9_out1                     : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch10_out1                    : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant9_out1                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant10_out1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch12_out1                    : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant11_out1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant12_out1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch15_out1                    : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch16_out1                    : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant13_out1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant14_out1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch18_out1                    : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant15_out1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant16_out1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch20_out1                    : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch21_out1                    : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Logical_Operator12_out1_1        : std_logic;  -- ufix1
  SIGNAL Switch13_out1                    : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch_out1                      : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant9_out1_1                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant10_out1_1                : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch12_out1_1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant11_out1_1                : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant12_out1_1                : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch15_out1_1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch16_out1_1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant13_out1_1                : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant14_out1_1                : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch18_out1_1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant15_out1_1                : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant16_out1_1                : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch20_out1_1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch21_out1_1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch13_out1_1                  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Switch1_out1_2                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Delay4_PS_2_out1                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL mantissaFractionlength_out1      : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL ExponentBias_out1                : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL TrueExponent_sub_cast            : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL TrueExponent_sub_cast_1          : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL TrueExponent_sub_temp            : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL TrueExponent_out1                : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL shiftlength_sub_cast             : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL shiftlength_sub_cast_1           : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL shiftlength_sub_temp             : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL shiftlength_out1                 : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL Delay5_PS_2_out1                 : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL isPosLtShiftlength_relop1        : std_logic;
  SIGNAL Delay5_PS_3_out1                 : std_logic;  -- ufix1
  SIGNAL Logical_Operator_out1_2          : std_logic;  -- ufix1
  SIGNAL Delay12_PS_4_out1                : std_logic;  -- ufix1
  SIGNAL Delay8_PS_2_3_reg                : vector_of_unsigned23(0 TO 1);  -- ufix23 [2]
  SIGNAL Delay8_PS_2_3_reg_next           : vector_of_unsigned23(0 TO 1);  -- ufix23 [2]
  SIGNAL Delay8_PS_2_3_out1               : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL initialBinaryPointPos_out1       : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL ShiftBinaryPoint_out1            : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL Delay7_PS_3_out1                 : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL constant_out1_1                  : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL ConcatExpandMant_out1            : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL Add_sub_cast                     : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL Add_sub_cast_1                   : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL Add_sub_temp                     : signed(31 DOWNTO 0);  -- sfix32
  SIGNAL Add_out1_1                       : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Bit_Slice3_out1_1                : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL Mask_out1                        : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL tempExpAnd_Mant_out1             : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL Delay11_PS_4_out1                : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL Delay6_PS_4_out1                 : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL tempExpAndMantInc_out1           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Bit_Slice4_out1_1                : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL Switch1_out1_3                   : unsigned(30 DOWNTO 0);  -- ufix31
  SIGNAL Bit_Slice2_out1_2                : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL isSignedness_out1                : std_logic;  -- ufix1
  SIGNAL Exponent127_out1                 : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Exponent0_out1                   : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Switch_out1_1                    : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Delay3_PS_3_4_reg                : vector_of_unsigned8(0 TO 1);  -- ufix8 [2]
  SIGNAL Delay3_PS_3_4_reg_next           : vector_of_unsigned8(0 TO 1);  -- ufix8 [2]
  SIGNAL Delay3_PS_3_4_out1               : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Switch5_out1                     : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Switch4_out1_1                   : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Constant3_out1_1                 : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Switch6_out1_1                   : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Delay4_PS_5_out1                 : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL Bit_Slice1_out1_1                : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL Constant136_out1                 : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL Switch2_out1_1                   : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL Delay13_PS_4_out1                : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL Switch3_out1_1                   : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL Constant2_out1_1                 : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL Switch5_out1_1                   : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL Delay5_PS_5_out1                 : unsigned(22 DOWNTO 0);  -- ufix23
  SIGNAL nfp_out_pack                     : unsigned(31 DOWNTO 0);  -- ufix32

BEGIN
  Constant8_out1 <= '1';

  Constant7_out1 <= to_unsigned(16#3#, 3);

  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_out1 <= '1';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_out1 <= Relational_Operator_relop1;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  Logical_Operator_out1 <= Constant8_out1 AND Delay4_out1;

  Data_Type_Conversion_out1 <= Logical_Operator_out1;

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= to_unsigned(16#0#, 3);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_out1 <= Add_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  Add_add_cast <= '0' & '0' & Data_Type_Conversion_out1;
  Add_out1 <= Delay3_out1 + Add_add_cast;

  
  Relational_Operator_relop1 <= '1' WHEN Add_out1 <= Constant7_out1 ELSE
      '0';

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= '1';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= Relational_Operator_relop1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  nfp_in_unsigned <= unsigned(nfp_in);

  -- Split 32 bit word into FP sign, exponent, mantissa
  aSign <= nfp_in_unsigned(31);
  aExponent <= nfp_in_unsigned(30 DOWNTO 23);
  aMantissa <= nfp_in_unsigned(22 DOWNTO 0);

  Delay_PS_1_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_PS_1_2_reg(0) <= '0';
      Delay_PS_1_2_reg(1) <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_PS_1_2_reg(0) <= Delay_PS_1_2_reg_next(0);
        Delay_PS_1_2_reg(1) <= Delay_PS_1_2_reg_next(1);
      END IF;
    END IF;
  END PROCESS Delay_PS_1_2_process;

  Delay_PS_1_2_out1 <= Delay_PS_1_2_reg(1);
  Delay_PS_1_2_reg_next(0) <= aSign;
  Delay_PS_1_2_reg_next(1) <= Delay_PS_1_2_reg(0);

  Delay_PS_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_PS_3_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_PS_3_out1 <= Delay_PS_1_2_out1;
      END IF;
    END IF;
  END PROCESS Delay_PS_3_process;


  Delay14_PS_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay14_PS_4_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay14_PS_4_out1 <= Delay_PS_3_out1;
      END IF;
    END IF;
  END PROCESS Delay14_PS_4_process;


  Constant1_out1 <= '0';

  
  Switch1_out1 <= Delay14_PS_4_out1 WHEN Delay1_out1 = '0' ELSE
      Constant1_out1;

  Delay3_PS_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_PS_5_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_PS_5_out1 <= Switch1_out1;
      END IF;
    END IF;
  END PROCESS Delay3_PS_5_process;


  Delay2_PS_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_PS_1_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_PS_1_out1 <= aExponent;
      END IF;
    END IF;
  END PROCESS Delay2_PS_1_process;


  
  isExponentZero_out1 <= '1' WHEN Delay2_PS_1_out1 = to_unsigned(16#00#, 8) ELSE
      '0';

  Delay3_PS_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_PS_1_out1 <= to_unsigned(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_PS_1_out1 <= aMantissa;
      END IF;
    END IF;
  END PROCESS Delay3_PS_1_process;


  
  isExponentGt150_out1 <= '1' WHEN Delay2_PS_1_out1 >= to_unsigned(16#96#, 8) ELSE
      '0';

  
  isMantissaZero_out1 <= '1' WHEN Delay3_PS_1_out1 = to_unsigned(16#000000#, 23) ELSE
      '0';

  isInputZero_out1 <= isExponentZero_out1 AND isMantissaZero_out1;

  isInputInteger_out1 <= isExponentGt150_out1 OR isInputZero_out1;

  Delay4_PS_2_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_PS_2_4_reg(0) <= '0';
      Delay4_PS_2_4_reg(1) <= '0';
      Delay4_PS_2_4_reg(2) <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_PS_2_4_reg(0) <= Delay4_PS_2_4_reg_next(0);
        Delay4_PS_2_4_reg(1) <= Delay4_PS_2_4_reg_next(1);
        Delay4_PS_2_4_reg(2) <= Delay4_PS_2_4_reg_next(2);
      END IF;
    END IF;
  END PROCESS Delay4_PS_2_4_process;

  Delay4_PS_2_4_out1 <= Delay4_PS_2_4_reg(2);
  Delay4_PS_2_4_reg_next(0) <= isInputInteger_out1;
  Delay4_PS_2_4_reg_next(1) <= Delay4_PS_2_4_reg(0);
  Delay4_PS_2_4_reg_next(2) <= Delay4_PS_2_4_reg(1);

  Delay2_PS_2_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_PS_2_3_reg(0) <= to_unsigned(16#00#, 8);
      Delay2_PS_2_3_reg(1) <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_PS_2_3_reg(0) <= Delay2_PS_2_3_reg_next(0);
        Delay2_PS_2_3_reg(1) <= Delay2_PS_2_3_reg_next(1);
      END IF;
    END IF;
  END PROCESS Delay2_PS_2_3_process;

  Delay2_PS_2_3_out1 <= Delay2_PS_2_3_reg(1);
  Delay2_PS_2_3_reg_next(0) <= Delay2_PS_1_out1;
  Delay2_PS_2_3_reg_next(1) <= Delay2_PS_2_3_reg(0);

  Delay10_PS_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay10_PS_4_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay10_PS_4_out1 <= Delay2_PS_2_3_out1;
      END IF;
    END IF;
  END PROCESS Delay10_PS_4_process;


  
  isExponentLt127_out1 <= '1' WHEN Delay10_PS_4_out1 < to_unsigned(16#7F#, 8) ELSE
      '0';

  
  isInputPositive_out1 <= '1' WHEN Delay_PS_3_out1 = '0' ELSE
      '0';

  Constant77_out1 <= '1';

  normalizedMantissa_out1 <= Constant77_out1 & Delay3_PS_1_out1;

  Bit_Slice8_out1 <= normalizedMantissa_out1(7 DOWNTO 0);

  Bit_Slice16_out1 <= Bit_Slice8_out1(0);

  Bit_Slice15_out1 <= Bit_Slice8_out1(1);

  Logical_Operator5_out1 <= Bit_Slice16_out1 OR Bit_Slice15_out1;

  Bit_Slice14_out1 <= Bit_Slice8_out1(2);

  Bit_Slice13_out1 <= Bit_Slice8_out1(3);

  Logical_Operator7_out1 <= Bit_Slice14_out1 OR Bit_Slice13_out1;

  Logical_Operator6_out1 <= Logical_Operator5_out1 OR Logical_Operator7_out1;

  Bit_Slice12_out1 <= Bit_Slice8_out1(4);

  Bit_Slice11_out1 <= Bit_Slice8_out1(5);

  Logical_Operator4_out1 <= Bit_Slice12_out1 OR Bit_Slice11_out1;

  Bit_Slice10_out1 <= Bit_Slice8_out1(6);

  Bit_Slice9_out1 <= Bit_Slice8_out1(7);

  Logical_Operator14_out1 <= Bit_Slice10_out1 OR Bit_Slice9_out1;

  Logical_Operator13_out1 <= Logical_Operator4_out1 OR Logical_Operator14_out1;

  Bit_Slice9_out1_1 <= normalizedMantissa_out1(15 DOWNTO 8);

  Bit_Slice16_out1_1 <= Bit_Slice9_out1_1(0);

  Bit_Slice15_out1_1 <= Bit_Slice9_out1_1(1);

  Logical_Operator5_out1_1 <= Bit_Slice16_out1_1 OR Bit_Slice15_out1_1;

  Bit_Slice14_out1_1 <= Bit_Slice9_out1_1(2);

  Bit_Slice13_out1_1 <= Bit_Slice9_out1_1(3);

  Logical_Operator7_out1_1 <= Bit_Slice14_out1_1 OR Bit_Slice13_out1_1;

  Logical_Operator6_out1_1 <= Logical_Operator5_out1_1 OR Logical_Operator7_out1_1;

  Bit_Slice12_out1_1 <= Bit_Slice9_out1_1(4);

  Bit_Slice11_out1_1 <= Bit_Slice9_out1_1(5);

  Logical_Operator4_out1_1 <= Bit_Slice12_out1_1 OR Bit_Slice11_out1_1;

  Bit_Slice10_out1_1 <= Bit_Slice9_out1_1(6);

  Bit_Slice9_out1_2 <= Bit_Slice9_out1_1(7);

  Logical_Operator14_out1_1 <= Bit_Slice10_out1_1 OR Bit_Slice9_out1_2;

  Logical_Operator13_out1_1 <= Logical_Operator4_out1_1 OR Logical_Operator14_out1_1;

  Bit_Slice2_out1 <= normalizedMantissa_out1(23 DOWNTO 16);

  Bit_Slice8_out1_1 <= Bit_Slice2_out1(0);

  Bit_Slice7_out1 <= Bit_Slice2_out1(1);

  Logical_Operator1_out1 <= Bit_Slice8_out1_1 OR Bit_Slice7_out1;

  Bit_Slice6_out1 <= Bit_Slice2_out1(2);

  Bit_Slice5_out1 <= Bit_Slice2_out1(3);

  Logical_Operator3_out1 <= Bit_Slice6_out1 OR Bit_Slice5_out1;

  Bit_Slice3_out1 <= Bit_Slice2_out1(4);

  Bit_Slice2_out1_1 <= Bit_Slice2_out1(5);

  Bit_Slice4_out1 <= Bit_Slice2_out1(7);

  Constant_out1 <= to_unsigned(16#00#, 6);

  Bit_Slice1_out1 <= Bit_Slice2_out1(6);

  Constant1_out1_1 <= to_unsigned(16#18#, 6);

  
  Switch2_out1 <= Constant_out1 WHEN Bit_Slice4_out1 = '0' ELSE
      Constant1_out1_1;

  Logical_Operator_out1_1 <= Bit_Slice3_out1 OR Bit_Slice2_out1_1;

  Constant2_out1 <= to_unsigned(16#17#, 6);

  
  Switch1_out1_1 <= Switch2_out1 WHEN Bit_Slice1_out1 = '0' ELSE
      Constant2_out1;

  Constant3_out1 <= to_unsigned(16#16#, 6);

  Constant4_out1 <= to_unsigned(16#15#, 6);

  Logical_Operator2_out1 <= Logical_Operator1_out1 OR Logical_Operator3_out1;

  
  Switch3_out1 <= Constant3_out1 WHEN Bit_Slice3_out1 = '0' ELSE
      Constant4_out1;

  
  Switch4_out1 <= Switch1_out1_1 WHEN Logical_Operator_out1_1 = '0' ELSE
      Switch3_out1;

  Constant5_out1 <= to_unsigned(16#14#, 6);

  Constant6_out1 <= to_unsigned(16#13#, 6);

  
  Switch6_out1 <= Constant5_out1 WHEN Bit_Slice6_out1 = '0' ELSE
      Constant6_out1;

  Constant7_out1_1 <= to_unsigned(16#12#, 6);

  Constant8_out1_1 <= to_unsigned(16#11#, 6);

  
  Switch8_out1 <= Constant7_out1_1 WHEN Bit_Slice8_out1_1 = '0' ELSE
      Constant8_out1_1;

  Logical_Operator12_out1 <= Logical_Operator6_out1_1 OR Logical_Operator13_out1_1;

  
  Switch9_out1 <= Switch6_out1 WHEN Logical_Operator1_out1 = '0' ELSE
      Switch8_out1;

  
  Switch10_out1 <= Switch4_out1 WHEN Logical_Operator2_out1 = '0' ELSE
      Switch9_out1;

  Constant9_out1 <= to_unsigned(16#10#, 6);

  Constant10_out1 <= to_unsigned(16#0F#, 6);

  
  Switch12_out1 <= Constant9_out1 WHEN Bit_Slice10_out1_1 = '0' ELSE
      Constant10_out1;

  Constant11_out1 <= to_unsigned(16#0E#, 6);

  Constant12_out1 <= to_unsigned(16#0D#, 6);

  
  Switch15_out1 <= Constant11_out1 WHEN Bit_Slice12_out1_1 = '0' ELSE
      Constant12_out1;

  
  Switch16_out1 <= Switch12_out1 WHEN Logical_Operator4_out1_1 = '0' ELSE
      Switch15_out1;

  Constant13_out1 <= to_unsigned(16#0C#, 6);

  Constant14_out1 <= to_unsigned(16#0B#, 6);

  
  Switch18_out1 <= Constant13_out1 WHEN Bit_Slice14_out1_1 = '0' ELSE
      Constant14_out1;

  Constant15_out1 <= to_unsigned(16#0A#, 6);

  Constant16_out1 <= to_unsigned(16#09#, 6);

  
  Switch20_out1 <= Constant15_out1 WHEN Bit_Slice16_out1_1 = '0' ELSE
      Constant16_out1;

  
  Switch21_out1 <= Switch18_out1 WHEN Logical_Operator5_out1_1 = '0' ELSE
      Switch20_out1;

  Logical_Operator12_out1_1 <= Logical_Operator6_out1 OR Logical_Operator13_out1;

  
  Switch13_out1 <= Switch16_out1 WHEN Logical_Operator6_out1_1 = '0' ELSE
      Switch21_out1;

  
  Switch_out1 <= Switch10_out1 WHEN Logical_Operator12_out1 = '0' ELSE
      Switch13_out1;

  Constant9_out1_1 <= to_unsigned(16#08#, 6);

  Constant10_out1_1 <= to_unsigned(16#07#, 6);

  
  Switch12_out1_1 <= Constant9_out1_1 WHEN Bit_Slice10_out1 = '0' ELSE
      Constant10_out1_1;

  Constant11_out1_1 <= to_unsigned(16#06#, 6);

  Constant12_out1_1 <= to_unsigned(16#05#, 6);

  
  Switch15_out1_1 <= Constant11_out1_1 WHEN Bit_Slice12_out1 = '0' ELSE
      Constant12_out1_1;

  
  Switch16_out1_1 <= Switch12_out1_1 WHEN Logical_Operator4_out1 = '0' ELSE
      Switch15_out1_1;

  Constant13_out1_1 <= to_unsigned(16#04#, 6);

  Constant14_out1_1 <= to_unsigned(16#03#, 6);

  
  Switch18_out1_1 <= Constant13_out1_1 WHEN Bit_Slice14_out1 = '0' ELSE
      Constant14_out1_1;

  Constant15_out1_1 <= to_unsigned(16#02#, 6);

  Constant16_out1_1 <= to_unsigned(16#01#, 6);

  
  Switch20_out1_1 <= Constant15_out1_1 WHEN Bit_Slice16_out1 = '0' ELSE
      Constant16_out1_1;

  
  Switch21_out1_1 <= Switch18_out1_1 WHEN Logical_Operator5_out1 = '0' ELSE
      Switch20_out1_1;

  
  Switch13_out1_1 <= Switch16_out1_1 WHEN Logical_Operator6_out1 = '0' ELSE
      Switch21_out1_1;

  
  Switch1_out1_2 <= Switch_out1 WHEN Logical_Operator12_out1_1 = '0' ELSE
      Switch13_out1_1;

  Delay4_PS_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_PS_2_out1 <= to_unsigned(16#00#, 6);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_PS_2_out1 <= Switch1_out1_2;
      END IF;
    END IF;
  END PROCESS Delay4_PS_2_process;


  mantissaFractionlength_out1 <= to_unsigned(16#17#, 8);

  ExponentBias_out1 <= to_unsigned(16#7F#, 8);

  TrueExponent_sub_cast <= signed(resize(Delay2_PS_1_out1, 32));
  TrueExponent_sub_cast_1 <= signed(resize(ExponentBias_out1, 32));
  TrueExponent_sub_temp <= TrueExponent_sub_cast - TrueExponent_sub_cast_1;
  TrueExponent_out1 <= unsigned(TrueExponent_sub_temp(8 DOWNTO 0));

  shiftlength_sub_cast <= signed(resize(mantissaFractionlength_out1, 32));
  shiftlength_sub_cast_1 <= signed(resize(TrueExponent_out1, 32));
  shiftlength_sub_temp <= shiftlength_sub_cast - shiftlength_sub_cast_1;
  shiftlength_out1 <= unsigned(shiftlength_sub_temp(9 DOWNTO 0));

  Delay5_PS_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_PS_2_out1 <= to_unsigned(16#000#, 10);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_PS_2_out1 <= shiftlength_out1;
      END IF;
    END IF;
  END PROCESS Delay5_PS_2_process;


  
  isPosLtShiftlength_relop1 <= '1' WHEN resize(Delay4_PS_2_out1, 10) <= Delay5_PS_2_out1 ELSE
      '0';

  Delay5_PS_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_PS_3_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_PS_3_out1 <= isPosLtShiftlength_relop1;
      END IF;
    END IF;
  END PROCESS Delay5_PS_3_process;


  Logical_Operator_out1_2 <= isInputPositive_out1 AND Delay5_PS_3_out1;

  Delay12_PS_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay12_PS_4_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay12_PS_4_out1 <= Logical_Operator_out1_2;
      END IF;
    END IF;
  END PROCESS Delay12_PS_4_process;


  Delay8_PS_2_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay8_PS_2_3_reg(0) <= to_unsigned(16#000000#, 23);
      Delay8_PS_2_3_reg(1) <= to_unsigned(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay8_PS_2_3_reg(0) <= Delay8_PS_2_3_reg_next(0);
        Delay8_PS_2_3_reg(1) <= Delay8_PS_2_3_reg_next(1);
      END IF;
    END IF;
  END PROCESS Delay8_PS_2_3_process;

  Delay8_PS_2_3_out1 <= Delay8_PS_2_3_reg(1);
  Delay8_PS_2_3_reg_next(0) <= Delay3_PS_1_out1;
  Delay8_PS_2_3_reg_next(1) <= Delay8_PS_2_3_reg(0);

  initialBinaryPointPos_out1 <= to_unsigned(16#00000001#, 31);

  ShiftBinaryPoint_out1 <= initialBinaryPointPos_out1 sll to_integer(Delay5_PS_2_out1);

  Delay7_PS_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay7_PS_3_out1 <= to_unsigned(16#00000000#, 31);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay7_PS_3_out1 <= ShiftBinaryPoint_out1;
      END IF;
    END IF;
  END PROCESS Delay7_PS_3_process;


  constant_out1_1 <= to_unsigned(16#00000001#, 31);

  ConcatExpandMant_out1 <= Delay2_PS_2_3_out1 & Delay8_PS_2_3_out1;

  Add_sub_cast <= signed(resize(Delay7_PS_3_out1, 32));
  Add_sub_cast_1 <= signed(resize(constant_out1_1, 32));
  Add_sub_temp <= Add_sub_cast - Add_sub_cast_1;
  Add_out1_1 <= unsigned(Add_sub_temp);

  Bit_Slice3_out1_1 <= Add_out1_1(30 DOWNTO 0);

  Mask_out1 <=  NOT Bit_Slice3_out1_1;

  tempExpAnd_Mant_out1 <= ConcatExpandMant_out1 AND Mask_out1;

  Delay11_PS_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay11_PS_4_out1 <= to_unsigned(16#00000000#, 31);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay11_PS_4_out1 <= tempExpAnd_Mant_out1;
      END IF;
    END IF;
  END PROCESS Delay11_PS_4_process;


  Delay6_PS_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay6_PS_4_out1 <= to_unsigned(16#00000000#, 31);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay6_PS_4_out1 <= Delay7_PS_3_out1;
      END IF;
    END IF;
  END PROCESS Delay6_PS_4_process;


  tempExpAndMantInc_out1 <= resize(Delay6_PS_4_out1, 32) + resize(Delay11_PS_4_out1, 32);

  Bit_Slice4_out1_1 <= tempExpAndMantInc_out1(30 DOWNTO 0);

  
  Switch1_out1_3 <= Delay11_PS_4_out1 WHEN Delay12_PS_4_out1 = '0' ELSE
      Bit_Slice4_out1_1;

  Bit_Slice2_out1_2 <= Switch1_out1_3(30 DOWNTO 23);

  
  isSignedness_out1 <= '1' WHEN Delay_PS_1_2_out1 = '1' ELSE
      '0';

  Exponent127_out1 <= to_unsigned(16#7F#, 8);

  Exponent0_out1 <= to_unsigned(16#00#, 8);

  
  Switch_out1_1 <= Exponent127_out1 WHEN isSignedness_out1 = '0' ELSE
      Exponent0_out1;

  Delay3_PS_3_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_PS_3_4_reg(0) <= to_unsigned(16#00#, 8);
      Delay3_PS_3_4_reg(1) <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_PS_3_4_reg(0) <= Delay3_PS_3_4_reg_next(0);
        Delay3_PS_3_4_reg(1) <= Delay3_PS_3_4_reg_next(1);
      END IF;
    END IF;
  END PROCESS Delay3_PS_3_4_process;

  Delay3_PS_3_4_out1 <= Delay3_PS_3_4_reg(1);
  Delay3_PS_3_4_reg_next(0) <= Switch_out1_1;
  Delay3_PS_3_4_reg_next(1) <= Delay3_PS_3_4_reg(0);

  
  Switch5_out1 <= Bit_Slice2_out1_2 WHEN isExponentLt127_out1 = '0' ELSE
      Delay3_PS_3_4_out1;

  
  Switch4_out1_1 <= Switch5_out1 WHEN Delay4_PS_2_4_out1 = '0' ELSE
      Delay10_PS_4_out1;

  Constant3_out1_1 <= to_unsigned(16#00#, 8);

  
  Switch6_out1_1 <= Switch4_out1_1 WHEN Delay1_out1 = '0' ELSE
      Constant3_out1_1;

  Delay4_PS_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_PS_5_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_PS_5_out1 <= Switch6_out1_1;
      END IF;
    END IF;
  END PROCESS Delay4_PS_5_process;


  Bit_Slice1_out1_1 <= Switch1_out1_3(22 DOWNTO 0);

  Constant136_out1 <= to_unsigned(16#000000#, 23);

  
  Switch2_out1_1 <= Bit_Slice1_out1_1 WHEN isExponentLt127_out1 = '0' ELSE
      Constant136_out1;

  Delay13_PS_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay13_PS_4_out1 <= to_unsigned(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay13_PS_4_out1 <= Delay8_PS_2_3_out1;
      END IF;
    END IF;
  END PROCESS Delay13_PS_4_process;


  
  Switch3_out1_1 <= Switch2_out1_1 WHEN Delay4_PS_2_4_out1 = '0' ELSE
      Delay13_PS_4_out1;

  Constant2_out1_1 <= to_unsigned(16#000000#, 23);

  
  Switch5_out1_1 <= Switch3_out1_1 WHEN Delay1_out1 = '0' ELSE
      Constant2_out1_1;

  Delay5_PS_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_PS_5_out1 <= to_unsigned(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_PS_5_out1 <= Switch5_out1_1;
      END IF;
    END IF;
  END PROCESS Delay5_PS_5_process;


  -- Combine FP sign, exponent, mantissa into 32 bit word
  nfp_out_pack <= Delay3_PS_5_out1 & Delay4_PS_5_out1 & Delay5_PS_5_out1;

  nfp_out <= std_logic_vector(nfp_out_pack);

END rtl;

