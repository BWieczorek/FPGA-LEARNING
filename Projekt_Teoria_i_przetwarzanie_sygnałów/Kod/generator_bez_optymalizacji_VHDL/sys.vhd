-- -------------------------------------------------------------
-- 
-- File Name: hdlsrcx/lookupTable/sys.vhd
-- Created: 2020-01-07 22:53:34
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: sys
-- Source Path: lookupTable/sys
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY sys IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In1                               :   IN    std_logic_vector(31 DOWNTO 0);  -- single
        Out1                              :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
        );
END sys;


ARCHITECTURE rtl OF sys IS

  -- Component Declarations
  COMPONENT lookupFun
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          counter                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          y                               :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : lookupFun
    USE ENTITY work.lookupFun(rtl);

  -- Signals
  SIGNAL y                                : std_logic_vector(31 DOWNTO 0);  -- ufix32

BEGIN
  u_lookupFun : lookupFun
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              counter => In1,  -- single
              y => y  -- single
              );

  Out1 <= y;

END rtl;

