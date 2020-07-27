------------------------------------------------------------
-- Copyright Mentor Graphic Corporation 1991. 
-- All rights reserved.  
------------------------------------------------------------
--
--  Model Title:  TTL library PART I
--  Date Created: 94/10/13 (THU)
--  Author:       T. Ohtsuka ( tootsuka@ss.titech.ac.jp )
--
------------------------------------------------------------
-- Model Description: 
--
-----------------------------------------------------------
-- WORK is "/home/deneb/tootsuka/work/syuse3/ttl_library".
-- See "Set Compiler Option".

LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

----- clock generator -----
ENTITY ckgen IS
   PORT (
			ck	: OUT   STD_ULOGIC
         ) ;
END ckgen ;

ARCHITECTURE struct1 OF ckgen IS
  SIGNAL clk : STD_ULOGIC := '0' ;
BEGIN
  clk <= NOT clk AFTER 500 NS ;
  ck  <= clk ;
END struct1 ;

----- d flip flop -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY dff IS
   PORT (
        q      : OUT STD_ULOGIC ;
        qb     : OUT STD_ULOGIC ;
        d      : IN  STD_ULOGIC ;
        clock  : IN  STD_ULOGIC ;
        preset : IN  STD_ULOGIC ;
        clear  : IN  STD_ULOGIC
        ) ;
END dff ;

ARCHITECTURE struct1 OF dff IS
  SIGNAL l1,l2,l3,l4,lq,lqb : STD_ULOGIC ;
BEGIN
  l1 <= NOT ( preset AND l4 AND l2 ) AFTER 5 NS ;
  l2 <= NOT ( l1 AND clear AND clock ) AFTER 5 NS ;
  l3 <= NOT ( l2 AND clock AND l4 )  AFTER 5 NS ;
  l4 <= NOT ( l3 AND clear AND d ) AFTER 5 NS ;
  lq  <= NOT ( preset AND l2 AND lqb ) AFTER 5 NS ;
  lqb <= NOT ( lq AND clear AND l3 ) AFTER 5 NS ;
  q <= lq ;
  qb <= lqb ;
END struct1 ;
----- ls138 -----
-- 3 to 8 demultiplexer --
--------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls138 IS
   PORT (
        y     : OUT STD_ULOGIC_vector(7 DOWNTO 0) ;
        mode  : IN  STD_ULOGIC_vector(2 DOWNTO 0) ;
        g1    : IN  STD_ULOGIC ;
        g2a   : IN  STD_ULOGIC ;
        g2b   : IN  STD_ULOGIC
        ) ;
END ls138 ;

ARCHITECTURE struct1 OF ls138 IS
  SIGNAL l1,l2,l3,l4,l5,l6,l7,l8 : STD_ULOGIC ;
BEGIN
  l1 <= NOT g1 AFTER 5 NS ;
  l3 <= NOT mode(0) AFTER 5 NS ;
  l4 <= NOT mode(1) AFTER 5 NS ;
  l5 <= NOT mode(2) AFTER 5 NS ;
  l6 <= NOT l3 AFTER 5 NS ;
  l7 <= NOT l4 AFTER 5 NS ;
  l8 <= NOT l5 AFTER 5 NS ;
  l2 <= NOT ( l1 OR g2a OR g2b ) AFTER 5 NS ;
  y(0) <= NOT ( l3 AND l4 AND l5 AND l2 ) AFTER 5 NS ;
  y(1) <= NOT ( l6 AND l4 AND l5 AND l2 ) AFTER 5 NS ;
  y(2) <= NOT ( l3 AND l7 AND l5 AND l2 ) AFTER 5 NS ;
  y(3) <= NOT ( l6 AND l7 AND l5 AND l2 ) AFTER 5 NS ;
  y(4) <= NOT ( l3 AND l4 AND l8 AND l2 ) AFTER 5 NS ;
  y(5) <= NOT ( l6 AND l4 AND l8 AND l2 ) AFTER 5 NS ;
  y(6) <= NOT ( l3 AND l7 AND l8 AND l2 ) AFTER 5 NS ;
  y(7) <= NOT ( l6 AND l7 AND l8 AND l2 ) AFTER 5 NS ;
END struct1 ;

----- ls139 -----
-- dual 2 to 4 demultiplexer --
-------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls139 IS
  PORT (
       y      : OUT   STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       g      : IN    STD_ULOGIC ;
       a      : IN    STD_ULOGIC ;
       b      : IN    STD_ULOGIC
       ) ;
END ls139 ;

ARCHITECTURE struct1 OF ls139 IS
  SIGNAL l1,l2,l3,l4,l5 : STD_ULOGIC ;
BEGIN
  l1 <= NOT g AFTER 5 NS ;
  l2 <= NOT a AFTER 5 NS ;
  l3 <= NOT b AFTER 5 NS ;
  l4 <= NOT l2 AFTER 5 NS ;
  l5 <= NOT l3 AFTER 5 NS ;
  y(0) <= NOT ( l1 AND l2 AND l3 ) AFTER 5 NS ;
  y(1) <= NOT ( l1 AND l3 AND l4 ) AFTER 5 NS ;
  y(2) <= NOT ( l1 AND l2 AND l5 ) AFTER 5 NS ;
  y(3) <= NOT ( l1 AND l4 AND l5 ) AFTER 5 NS ;
END struct1 ;

----- ls153 -----
-- dual 4 to 1 data selector --
-------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls153 IS
  PORT (
       out1   : OUT     STD_ULOGIC ;
       out2   : OUT     STD_ULOGIC ;
       data1  : IN      STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       data2  : IN      STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       select_a : IN    STD_ULOGIC ;
       select_b : IN    STD_ULOGIC ;
       strobe1  : IN    STD_ULOGIC ;
       strobe2  : IN    STD_ULOGIC
       ) ;
END ls153 ;

ARCHITECTURE struct1 OF ls153 IS
  SIGNAL s1b,s2b,sbbar,sabar,sa,sb,
         d1_0,d1_1,d1_2,d1_3,d2_0,d2_1,d2_2,d2_3
         : STD_ULOGIC ;
BEGIN
  s1b <= NOT strobe1 AFTER 5 NS ;
  s2b <= NOT strobe2 AFTER 5 NS ;
  sbbar <= NOT select_b AFTER 5 NS ;
  sabar <= NOT select_a AFTER 5 NS ;
  sb <= NOT sbbar AFTER 5 NS ;
  sa <= NOT sabar AFTER 5 NS ;
  d1_0 <= s1b AND data1(0) AND sbbar AND sabar AFTER 5 NS ;
  d1_1 <= s1b AND data1(1) AND sbbar AND sa    AFTER 5 NS ;
  d1_2 <= s1b AND data1(2) AND sb    AND sabar AFTER 5 NS ;
  d1_3 <= s1b AND data1(3) AND sb    AND sa    AFTER 5 NS ;
  d2_0 <= s2b AND data2(0) AND sbbar AND sabar AFTER 5 NS ;
  d2_1 <= s2b AND data2(1) AND sbbar AND sa    AFTER 5 NS ;
  d2_2 <= s2b AND data2(2) AND sb    AND sabar AFTER 5 NS ;
  d2_3 <= s2b AND data2(3) AND sb    AND sa    AFTER 5 NS ;
  out1 <= d1_0 OR d1_1 OR d1_2 OR d1_3 AFTER 5 NS ;
  out2 <= d2_0 OR d2_1 OR d2_2 OR d2_3 AFTER 5 NS ;
END struct1 ;

----- ls163 -----
-- syncronous 4 bit counter --
------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls163 IS
  PORT (
       out1    : OUT  STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       rc      : OUT  STD_ULOGIC ;
       data    : IN   STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       clock   : IN   STD_ULOGIC ;
       load    : IN   STD_ULOGIC ;
       clear   : IN   STD_ULOGIC ;
       p       : IN   STD_ULOGIC ;
       t       : IN   STD_ULOGIC
       ) ;
END  ls163 ;

ARCHITECTURE struct1 OF ls163 IS
  COMPONENT dff
   PORT (
        q      : OUT STD_ULOGIC ;
        qb     : OUT STD_ULOGIC ;
        d      : IN  STD_ULOGIC ;
        clock  : IN  STD_ULOGIC ;
        preset : IN  STD_ULOGIC ;
        clear  : IN  STD_ULOGIC
        ) ;
  END COMPONENT ;
  FOR f1 : dff USE ENTITY WORK.dff ;
  FOR f2 : dff USE ENTITY WORK.dff ;
  FOR f3 : dff USE ENTITY WORK.dff ;
  FOR f4 : dff USE ENTITY WORK.dff ;
  SIGNAL l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,
         l12,l13,l14,l15,l16,l17,l18,l19,l20,
         l21,l22,l23,l24,l25,l26,l27,l28,l29,
         lf1bar,lf2bar,lf3bar,lf4bar --,
--         high
         : STD_ULOGIC ;
  SIGNAL high : STD_ULOGIC :='1' ;
  SIGNAL out0 : STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
  CONSTANT H : STD_ULOGIC :='1' ;
BEGIN
--  high <= H ;
  l1 <= clock AFTER 5 NS ;
  l2 <= NOT clear AFTER 5 NS ;
  l10 <= NOT l4 AFTER 5 NS ;
  l11 <= NOT lf1bar AFTER 5 NS ;
  l12 <= NOT lf2bar AFTER 5 NS ;
  l24 <= NOT lf3bar AFTER 5 NS ;
  l29 <= NOT lf4bar AFTER 5 NS ;
  l3  <= NOT ( l2 OR load ) AFTER 5 NS ;
  l9  <= NOT ( l2 OR l3 )   AFTER 5 NS ;
  l4  <= t AND clear AND load AND p AFTER 5 NS ;
  l5  <= l3 AND data(0) AFTER 5 NS ;
  l6  <= l3 AND data(1) AFTER 5 NS ;
  l7  <= l3 AND data(2) AFTER 5 NS ;
  l8  <= l3 AND data(3) AFTER 5 NS ;
  l13 <= l9 AND out0(0) AND l10 AFTER 5 NS ;
  l14 <= l4 AND lf1bar AFTER 5 NS ;
  l17 <= l9 AND out0(1) AND l16 AFTER 5 NS ;
  l18 <= l11 AND l4 AND lf2bar AFTER 5 NS ;
  l21 <= l9 AND out0(2) AND l20 AFTER 5 NS ;
  l22 <= l12 AND l11 AND l4 AND lf3bar AFTER 5 NS ;
  l26 <= l9 AND out0(3) AND l25 AFTER 5 NS ;
  l27 <= l24 AND l12 AND l11 AND l4 AND lf4bar AFTER 5 NS ;
  rc  <= l29 AND l24 AND l12 AND l11 AND t AFTER 5 NS ;
  l15 <= l13 OR l14 OR l5 AFTER 5 NS ;
  l19 <= l17 OR l18 OR l6 AFTER 5 NS ;
  l23 <= l21 OR l22 OR l7 AFTER 5 NS ;
  l28 <= l26 OR l27 OR l8 AFTER 5 NS ;
  l16 <= NOT ( l11 AND l4 ) AFTER 5 NS ;
  l20 <= NOT ( l12 AND l11 AND l4 ) AFTER 5 NS ;
  l25 <= NOT ( l24 AND l12 AND l11 AND l4 ) AFTER 5 NS ;
  f1 : dff
    PORT MAP ( out0(0), lf1bar, l15, l1, high, high ) ;
  f2 : dff
    PORT MAP ( out0(1), lf2bar, l19, l1, high, high ) ;
  f3 : dff
    PORT MAP ( out0(2), lf3bar, l23, l1, high, high ) ;
  f4 : dff
    PORT MAP ( out0(3), lf4bar, l28, l1, high, high ) ;
  out1 <= out0 ;
END struct1 ;

----- ls169 -----
-- syncronous up/down counter --
--------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls169 IS
  PORT (
       out1  :  OUT   STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       rc    :  OUT   STD_ULOGIC ;
       data  :  IN    STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       clock :  IN    STD_ULOGIC ;
       load  :  IN    STD_ULOGIC ;
       ud    :  IN    STD_ULOGIC ;
       pbar  :  IN    STD_ULOGIC ;
       tbar  :  IN    STD_ULOGIC
       ) ;
END ls169 ;

ARCHITECTURE struct1 OF ls169 IS
  COMPONENT dff
   PORT (
        q      : OUT STD_ULOGIC ;
        qb     : OUT STD_ULOGIC ;
        d      : IN  STD_ULOGIC ;
        clock  : IN  STD_ULOGIC ;
        preset : IN  STD_ULOGIC ;
        clear  : IN  STD_ULOGIC
        ) ;
  END COMPONENT ;
  FOR f1 : dff USE ENTITY WORK.dff ;
  FOR f2 : dff USE ENTITY WORK.dff ;
  FOR f3 : dff USE ENTITY WORK.dff ;
  FOR f4 : dff USE ENTITY WORK.dff ;
  SIGNAL l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,
         l12,l13,l14,l15,l16,l17,l18,l19,l20,
         l21,l22,l23,l24,l25,l26,l27,l28,l29,
         l30,l31,l32,l33,l34,l35,l36,l37,l38,
         l39,l40,l41,l42,t,
         lf1bar,lf2bar,lf3bar,lf4bar--,
--         high
         : STD_ULOGIC ;
  SIGNAL high : STD_ULOGIC := '1' ;
  CONSTANT H : STD_ULOGIC :='1' ;
  
  BEGIN
--    high <= H ;
    l1 <= clock AFTER 5 NS ;
    l2 <= load AFTER 5 NS ;
    t  <= NOT tbar ;
    l3 <= NOT load AFTER 5 NS ;
    l4 <= NOT ud AFTER 5 NS ;
    l6 <= NOT l4 AFTER 5 NS ;
    l7 <= NOT lf4bar AFTER 5 NS ;
    l8 <= NOT ( lf4bar AND lf3bar ) AFTER 5 NS ;
    l9 <= NOT ( lf4bar AND lf3bar AND lf2bar ) AFTER 5 NS ;
    l5 <= NOT ( pbar OR tbar ) AFTER 5 NS ;
    l19 <= NOT ( l10 OR l11 ) AFTER 5 NS ;
    l20 <= NOT ( l12 OR l13 OR l14 ) AFTER 5 NS ;
    l21 <= NOT ( l15 OR l16 OR l17 OR l18 ) AFTER 5 NS ;
    l41 <= NOT ( lf1bar OR lf2bar OR lf3bar OR lf4bar OR l4 OR tbar ) 
           AFTER 5 NS ;
    rc <= NOT ( l41 OR l42 ) AFTER 5 NS ;
    l10 <= l4 AND l7 AFTER 5 NS ;
    l11 <= l6 AND lf4bar AFTER 5 NS ;
    l12 <= l4 AND l8 AFTER 5 NS ;
    l13 <= l6 AND lf3bar AFTER 5 NS ;
    l14 <= l6 AND lf4bar AFTER 5 NS ;
    l15 <= l4 AND l9 AFTER 5 NS ;
    l16 <= l6 AND lf2bar AFTER 5 NS ;
    l17 <= l6 AND lf3bar AFTER 5 NS ;
    l18 <= l6 AND lf4bar AFTER 5 NS ;
    l22 <= l19 AND l5 AFTER 5 NS ;
    l23 <= l20 AND l5 AFTER 5 NS ;
    l24 <= l21 AND l5 AFTER 5 NS ;
    l29 <= data(0) AND l3 AFTER 5 NS ;
    l30 <= l2 AND l25 AFTER 5 NS ;
    l31 <= data(1) AND l3 AFTER 5 NS ;
    l32 <= l2 AND l26 AFTER 5 NS ;
    l33 <= data(2) AND l3 AFTER 5 NS ;
    l34 <= l2 AND l27 AFTER 5 NS ;
    l35 <= data(3) AND l3 AFTER 5 NS ;
    l36 <= l2 AND l28 AFTER 5 NS ;
    l42 <= t AND lf1bar AND lf2bar AND lf3bar AND lf4bar AND l4 AFTER 5 NS ;
    l37 <= l29 OR l30 AFTER 5 NS ;
    l38 <= l31 OR l32 AFTER 5 NS ;
    l39 <= l33 OR l34 AFTER 5 NS ;
    l40 <= l35 OR l36 AFTER 5 NS ;
    l25 <= NOT ( l5  XOR lf4bar ) AFTER 5 NS ;
    l26 <= NOT ( l22 XOR lf3bar ) AFTER 5 NS ;
    l27 <= NOT ( l23 XOR lf2bar ) AFTER 5 NS ;
    l28 <= NOT ( l24 XOR lf1bar ) AFTER 5 NS ;
    f1 : dff
         PORT MAP ( out1(3),lf1bar,l40,l1,high,high ) ;
    f2 : dff
         PORT MAP ( out1(2),lf2bar,l39,l1,high,high ) ;
    f3 : dff
         PORT MAP ( out1(1),lf3bar,l38,l1,high,high ) ;
    f4 : dff
         PORT MAP ( out1(0),lf4bar,l37,l1,high,high ) ;
END struct1 ;
----- ls175 -----
-- quad d-ffs --
----------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls175 IS
  PORT (
       q     : OUT STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       qbar  : OUT STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       d     : IN  STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       clock : IN  STD_ULOGIC ;
       clear : IN STD_ULOGIC
       ) ;
END ls175 ;

ARCHITECTURE struct1 OF ls175 IS
  COMPONENT dff
   PORT (
        q      : OUT STD_ULOGIC ;
        qb     : OUT STD_ULOGIC ;
        d      : IN  STD_ULOGIC ;
        clock  : IN  STD_ULOGIC ;
        preset : IN  STD_ULOGIC ;
        clear  : IN  STD_ULOGIC
        ) ;
  END COMPONENT ;
  FOR f1 : dff USE ENTITY WORK.dff ;
  FOR f2 : dff USE ENTITY WORK.dff ;
  FOR f3 : dff USE ENTITY WORK.dff ;
  FOR f4 : dff USE ENTITY WORK.dff ;
  SIGNAL clr,clrb,clkb,clk --,high
         : STD_ULOGIC ;
  SIGNAL high : STD_ULOGIC := '1' ;
--  CONSTANT H : STD_ULOGIC :='1' ;
BEGIN
--  high <= H ;
  clkb <= NOT clock AFTER 5 NS ;
  clrb <= NOT clear AFTER 5 NS ;
  clk  <= NOT clkb ;
  clr  <= NOT clrb ;
  f1 : dff
       PORT MAP ( q(0),qbar(0),d(0),clk,high,clr) ;
  f2 : dff
       PORT MAP ( q(1),qbar(1),d(1),clk,high,clr) ;
  f3 : dff
       PORT MAP ( q(2),qbar(2),d(2),clk,high,clr) ;
  f4 : dff
       PORT MAP ( q(3),qbar(3),d(3),clk,high,clr) ;
END struct1 ;
----- ls181 -----
-- arithmatic logic unit --
---------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls181 IS
  PORT (
       f0     : OUT STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       cn4bar : OUT STD_ULOGIC ;
       l_y    : OUT STD_ULOGIC ;
       l_x    : OUT STD_ULOGIC ;
       aeqb   : OUT STD_ULOGIC ;
       a      : IN  STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       b      : IN  STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       s      : IN  STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       m      : IN  STD_ULOGIC ;
       cnbar  : IN  STD_ULOGIC
       ) ;
END ls181 ;

ARCHITECTURE struct1 OF ls181 IS
  SIGNAL l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,
         l12,l13,l14,l15,l16,l17,l18,l19,l20,
         l21,l22,l23,l24,l25,l26,l27,l28,l29,
         l30,l31,l32,l33,l34,l35,l36,l37,l38,
         l39,l40,l41,l42,l43,l44,l45,l46,l47,
         l48,l49,l50,l51,l52,l53,l54,l55,l56,
         l57,l58,l59,l60,l61,ly
         : STD_ULOGIC ;
  SIGNAL f : STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
BEGIN
  l1  <= NOT b(3) AFTER 5 NS ;
  l9  <= NOT b(2) AFTER 5 NS ;
  l17 <= NOT b(1) AFTER 5 NS ;
  l25 <= NOT b(0) AFTER 5 NS ;
  l33 <= NOT m    AFTER 5 NS ;
  l2  <= b(3) AND s(3) AND a(3) AFTER 5 NS ;
  l3  <= l1 AND s(2) AND a(3) AFTER 5 NS ;
  l4  <= l1 AND s(1) AFTER 5 NS ;
  l5  <= b(3) AND s(0) AFTER 5 NS ;
  l10 <= b(2) AND s(3) AND a(2) AFTER 5 NS ;
  l11 <= l9 AND s(2) AND a(2) AFTER 5 NS ;
  l12 <= l9 AND s(1) AFTER 5 NS ;
  l13 <= b(2) AND s(0) AFTER 5 NS ;
  l18 <= b(1) AND s(3) AND a(1) AFTER 5 NS ;
  l19 <= l17 AND s(2) AND a(1) AFTER 5 NS ;
  l20 <= l17 AND s(1) AFTER 5 NS ;
  l21 <= b(1) AND s(0) AFTER 5 NS ;
  l26 <= b(0) AND s(3) AND a(0) AFTER 5 NS ;
  l27 <= l25 AND s(2) AND a(0) AFTER 5 NS ;
  l28 <= l25 AND s(1) AFTER 5 NS ;
  l29 <= b(0) AND s(0) AFTER 5 NS ;
  l35 <= l7 AND l16 AFTER 5 NS ;
  l36 <= l7 AND l15 AND l24 AFTER 5 NS ;
  l37 <= l7 AND l15 AND l23 AND l32 AFTER 5 NS ;
  l43 <= cnbar AND l31 AND l23 AND l15 AND l33 AFTER 5 NS ;
  l44 <= l23 AND l15 AND l32 AND l33 AFTER 5 NS ;
  l45 <= l15 AND l24 AND l33 AFTER 5 NS ;
  l46 <= l16 AND l33 AFTER 5 NS ;
  l50 <= cnbar AND l31 AND l23 AND l33 AFTER 5 NS ;
  l51 <= l23 AND l32 AND l33 AFTER 5 NS ;
  l52 <= l24 AND l33 AFTER 5 NS ;
  l56 <= cnbar AND l31 AND l33 AFTER 5 NS ;
  l57 <= l32 AND l33 AFTER 5 NS ;
  aeqb <= f(3) AND f(2) AND f(1) AND f(0) AFTER 5 NS ;
  l6 <= a(3) AFTER 5 NS ;
  l14 <= a(2) AFTER 5 NS ;
  l22 <= a(1) AFTER 5 NS ;
  l30 <= a(0) AFTER 5 NS ;
  l34 <= l8 AFTER 5 NS ;
  l7  <= l2 NOR l3 AFTER 5 NS ;
  l8  <= NOT ( l4 OR l5 OR l6 ) AFTER 5 NS ;
  l15 <= l10 NOR l11  AFTER 5 NS ;
  l16 <= NOT ( l12 OR l13 OR l14 ) AFTER 5 NS ;
  l23 <= l18 NOR l19 AFTER 5 NS ;
  l24 <= NOT ( l20 OR l21 OR l22 ) AFTER 5 NS ;
  l31 <= l26 NOR l27 AFTER 5 NS ;
  l32 <= NOT ( l28 OR l29 OR l30 ) AFTER 5 NS ;
  ly  <= NOT ( l34 OR l35 OR l36 OR l37 ) AFTER 5 NS ;
  l47 <= NOT ( l43 OR l44 OR l45 OR l46 ) AFTER 5 NS ;
  l53 <= NOT ( l50 OR l51 OR l52 ) AFTER 5 NS ;
  l58 <= l56 NOR l57 AFTER 5 NS ;
  l38 <= NOT ( l7 AND l15 AND l23 AND l31 AND cnbar ) AFTER 5 NS ;
  l_x <= NOT ( l7 AND l15 AND l23 AND l31 ) AFTER 5 NS ;
  cn4bar <= ly NAND l38 AFTER 5 NS ;
  l61 <= l33 NAND cnbar AFTER 5 NS ;
  l42 <= l7  XOR l8 AFTER 5 NS ;
  f(3)<= l42 XOR l47 AFTER 5 NS ;
  l49 <= l15 XOR l16 AFTER 5 NS ;
  f(2)<= l49 XOR l53 AFTER 5 NS ;
  l55 <= l23 XOR l24 AFTER 5 NS ;
  f(1)<= l55 XOR l58 AFTER 5 NS ;
  l60 <= l31 XOR l32 AFTER 5 NS ;
  f(0)<= l60 XOR l61 AFTER 5 NS ;
  l_y <= ly ;
  f0 <= f ;
END struct1 ;
