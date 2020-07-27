------------------------------------------------------------
-- Copyright Mentor Graphic Corporation 1991. 
-- All rights reserved.  
------------------------------------------------------------
--
--  Model Title:  TTL library PART II
--  Date Created: 94/10/20 (THU)
--  Author:       T. Ohtsuka ( tootsuka@ss.titech.ac.jp )
--
------------------------------------------------------------
-- Model Description: 
--
-----------------------------------------------------------
--
----- bufif1_0 -----
-- 3 state bufif1 with no delay --
----------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY bufif1_0  IS
  PORT (
       o1     : OUT   STD_ULOGIC ;
       i1     : IN    STD_ULOGIC ;
       c1     : IN    STD_ULOGIC 
       ) ;
END bufif1_0  ;

ARCHITECTURE behav1 OF bufif1_0  IS
BEGIN
  bufif : PROCESS(i1,c1)
  BEGIN
    IF ( c1 = '1' ) THEN 
      o1 <= i1 ;
    ELSE
      o1 <= 'Z' ;
    END IF ;
  END PROCESS bufif ;
END behav1 ;
----- bufif1_5 -----
-- 3 states bufif1 with 5 ns delay --
-------------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY bufif1_5 IS
  PORT (
       o1     : OUT   STD_ULOGIC ;
       i1     : IN    STD_ULOGIC ;
       c1     : IN    STD_ULOGIC
       ) ;
END bufif1_5 ;

ARCHITECTURE behav1 OF bufif1_5 IS
BEGIN
  bufif : PROCESS(i1,c1)
  BEGIN
    IF ( c1 = '1' ) THEN 
      o1 <= i1 AFTER 5 NS ;
    ELSE
      o1 <= 'Z' AFTER 5 NS ;
    END IF ;
  END PROCESS bufif ;
END behav1 ;
----- bufif0_0 -----
-- 3 state bufif0 with no delay --
----------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY bufif0_0 IS
  PORT (
       o1     : OUT   STD_ULOGIC ;
       i1     : IN    STD_ULOGIC ;
       c1     : IN    STD_ULOGIC
       ) ;
END bufif0_0 ;

ARCHITECTURE behav1 OF bufif0_0 IS
BEGIN
  bufif : PROCESS(i1,c1)
  BEGIN
    IF ( c1 = '0' ) THEN 
      o1 <= i1 ;
    ELSE
      o1 <= 'Z' ;
    END IF ;
  END PROCESS bufif ;
END behav1 ;
----- bufif0_5 -----
-- 3 states bufif0 with 5 ns delay --
-------------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY bufif0_5 IS
  PORT (
       o1     : OUT   STD_ULOGIC ;
       i1     : IN    STD_ULOGIC ;
       c1     : IN    STD_ULOGIC
       ) ;
END bufif0_5 ;

ARCHITECTURE behav1 OF bufif0_5 IS
BEGIN
  bufif : PROCESS(i1,c1)
  BEGIN
    IF ( c1 = '0' ) THEN 
      o1 <= i1 AFTER 5 NS ;
    ELSE
      o1 <= 'Z' AFTER 5 NS ;
    END IF ;
  END PROCESS bufif ;
END behav1 ;
----- notif1_0 -----
-- 3 state inverter if 1 with no delay --
-----------------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY notif1_0 IS
  PORT (
       o1     : OUT   STD_ULOGIC ;
       i1     : IN    STD_ULOGIC ;
       c1     : IN    STD_ULOGIC
       ) ;
END notif1_0 ;

ARCHITECTURE behav1 OF notif1_0 IS
BEGIN
  notif : PROCESS(i1,c1)
  BEGIN
    IF ( c1 = '1' ) THEN 
      o1 <= NOT i1 ;
    ELSE
      o1 <= 'Z' ;
    END IF ;
  END PROCESS notif ;
END behav1 ;
----- notif1_5 -----
-- 3 states inverter_if1 with 5 ns delay --
-------------------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY notif1_5 IS
  PORT (
       o1     : OUT   STD_ULOGIC ;
       i1     : IN    STD_ULOGIC ;
       c1     : IN    STD_ULOGIC
       ) ;
END notif1_5 ;

ARCHITECTURE behav1 OF notif1_5 IS
BEGIN
  notif : PROCESS(i1,c1)
  BEGIN
    IF ( c1 = '1' ) THEN 
      o1 <= NOT i1 AFTER 5 NS ;
    ELSE
      o1 <= 'Z' AFTER 5 NS ;
    END IF ;
  END PROCESS notif ;
END behav1 ;
----- notif0_0 -----
-- 3 states inverter if 0 with no delay --
------------------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY notif0_0 IS
  PORT (
       o1     : OUT   STD_ULOGIC ;
       i1     : IN    STD_ULOGIC ;
       c1     : IN    STD_ULOGIC
       ) ;
END notif0_0 ;

ARCHITECTURE behav1 OF notif0_0 IS
BEGIN
  notif : PROCESS(i1,c1)
  BEGIN
    IF ( c1 = '0' ) THEN 
      o1 <= NOT i1 ;
    ELSE
      o1 <= 'Z' ;
    END IF ;
  END PROCESS notif ;
END behav1 ;
----- notif0_5 -----
-- 3 states inverter if 0 with 5 ns delay --
--------------------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY notif0_5 IS
  PORT (
       o1     : OUT   STD_ULOGIC ;
       i1     : IN    STD_ULOGIC ;
       c1     : IN    STD_ULOGIC
       ) ;
END notif0_5 ;

ARCHITECTURE behav1 OF notif0_5 IS
BEGIN
  notif : PROCESS(i1,c1)
  BEGIN
    IF ( c1 = '0' ) THEN 
      o1 <= NOT i1 AFTER 5 NS ;
    ELSE
      o1 <= 'Z' AFTER 5 NS ;
    END IF ;
  END PROCESS notif ;
END behav1 ;

----- ls194 -----
-- 4 bits shift register --
---------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls194 IS
  PORT (
       q0     : OUT    STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       pin    : IN     STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       s1     : IN     STD_ULOGIC ;
       s0     : IN     STD_ULOGIC ;
       rin    : IN     STD_ULOGIC ;
       lin    : IN     STD_ULOGIC ;
       clock  : IN     STD_ULOGIC ;
       clear  : IN     STD_ULOGIC
       ) ;
END ls194 ;

ARCHITECTURE struct1 OF ls194 IS
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
-- WORK is "/home/deneb/tootsuka/work/syuse3/ttl_library" see "set compiler option".
  SIGNAL l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,
         l12,l13,l14,l15,l16,l17,l18,l19,l20,
         l21,l22,l23,l24,l25,
         high
         : STD_ULOGIC ;
  SIGNAL q,qb : STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
  CONSTANT H : STD_ULOGIC :='1' ;
BEGIN
  high <= H ;
  l1  <= NOT s1 AFTER 5 NS ;
  l2  <= NOT l1 AFTER 5 NS ;
  l3  <= NOT s0 AFTER 5 NS ;
  l4  <= NOT l3 AFTER 5 NS ;
  l25 <= clear  AFTER 5 NS ;
  l5  <= rin AND l1 AND l4 AFTER 5 NS ;
  l6  <= l4 AND l2 AND pin(3) AFTER 5 NS ;
  l7  <= l3 AND l2 AND q(2) AFTER 5 NS ;
  l8  <= l3 AND l1 AND q(3) AFTER 5 NS ;
  l9  <= q(3) AND l1 AND l4 AFTER 5 NS ;
  l10 <= l4 AND l2 AND pin(2) AFTER 5 NS ;
  l11 <= l3 AND l2 AND q(1) AFTER 5 NS ;
  l12 <= l3 AND l1 AND q(2) AFTER 5 NS ;
  l13 <= q(2) AND l1 AND l4 AFTER 5 NS ;
  l14 <= l4 AND l2 AND pin(1) AFTER 5 NS ;
  l15 <= l3 AND l2 AND q(0) AFTER 5 NS ;
  l16 <= l3 AND l1 AND q(1) AFTER 5 NS ;
  l17 <= q(1) AND l1 AND l4 AFTER 5 NS ;
  l18 <= l4 AND l2 AND pin(0) AFTER 5 NS ;
  l19 <= l3 AND l2 AND lin AFTER 5 NS ;
  l20 <= l3 AND l1 AND q(0) AFTER 5 NS ;
  l21 <= l5 OR l6 OR l7 OR l8 AFTER 5 NS ;
  l22 <= l9 OR l10 OR l11 OR l12 AFTER 5 NS ;
  l23 <= l13 OR l14 OR l15 OR l16 AFTER 5 NS ;
  l24 <= l17 OR l18 OR l19 OR l20 AFTER 5 NS ;
  f1 : dff
       PORT MAP ( q(3),qb(3),l21,clock,high,l25) ;
  f2 : dff
       PORT MAP ( q(2),qb(2),l22,clock,high,l25) ;
  f3 : dff
       PORT MAP ( q(1),qb(1),l23,clock,high,l25) ;
  f4 : dff
       PORT MAP ( q(0),qb(0),l24,clock,high,l25) ;
  q0 <= q ;
END struct1 ;
----- ls257 -----
-- quadruple 2 line to 1 line data selector/multiplexers --
-- with 3 state outputs                                  --
-----------------------------------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls257 IS
   PORT (
        y      : OUT   STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
        a      : IN    STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
        b      : IN    STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
        sel    : IN    STD_ULOGIC ;
        o_ctrl : IN    STD_ULOGIC
        ) ;
END ls257 ;

ARCHITECTURE struct1 OF ls257 IS
  COMPONENT bufif1_0 
    PORT ( 
         o1    : OUT  STD_ULOGIC ;
         i1    : IN   STD_ULOGIC ;
         c1    : IN   STD_ULOGIC
         ) ;
  END COMPONENT ;
  FOR g16 : bufif1_0 USE ENTITY WORK.bufif1_0 ;
  FOR g17 : bufif1_0 USE ENTITY WORK.bufif1_0  ;
  FOR g18 : bufif1_0 USE ENTITY WORK.bufif1_0  ;
  FOR g19 : bufif1_0 USE ENTITY WORK.bufif1_0  ;
  SIGNAL l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,
         l12,l13,l14,l15
         : STD_ULOGIC ;
BEGIN
  l1  <= NOT sel AFTER 5 NS ;
  l2  <= NOT l1 AFTER 5 NS ;
  l3  <= NOT o_ctrl AFTER 5 NS ;
  l4  <= a(0) AND l1 AFTER 5 NS ;
  l5  <= b(0) AND l2 AFTER 5 NS ;
  l6  <= a(1) AND l1 AFTER 5 NS ;
  l7  <= b(1) AND l2 AFTER 5 NS ;
  l8  <= a(2) AND l1 AFTER 5 NS ;
  l9  <= b(2) AND l2 AFTER 5 NS ;
  l10 <= a(3) AND l1 AFTER 5 NS ;
  l11 <= b(3) AND l2 AFTER 5 NS ;
  l12 <= l4 OR l5 AFTER 5 NS ;
  l13 <= l6 OR l7 AFTER 5 NS ;
  l14 <= l8 OR l9 AFTER 5 NS ;
  l15 <= l10 OR l11 AFTER 5 NS ;
  g16 : bufif1_0
    PORT MAP ( y(0),l12,l3) ;
  g17 : bufif1_0
    PORT MAP ( y(1),l13,l3) ;
  g18 : bufif1_0
    PORT MAP ( y(2),l14,l3) ;
  g19 : bufif1_0
    PORT MAP ( y(3),l15,l3) ;
END struct1 ;

----- ls374 -----
-- octal 3 state d-ffs --
-------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls374 IS
  PORT (
       out0     : OUT  STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
       in0      : IN   STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
       clock    : IN   STD_ULOGIC ;
       oc       : IN   STD_ULOGIC
       ) ;
END ls374 ;

ARCHITECTURE struct1 OF ls374 IS
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
  COMPONENT notif1_5
    PORT ( 
         o1    : OUT  STD_ULOGIC ;
         i1    : IN   STD_ULOGIC ;
         c1    : IN   STD_ULOGIC
         ) ;
  END COMPONENT ;
  FOR f0  : dff USE ENTITY WORK.dff ;
  FOR f1  : dff USE ENTITY WORK.dff ;
  FOR f2  : dff USE ENTITY WORK.dff ;
  FOR f3  : dff USE ENTITY WORK.dff ;
  FOR f4  : dff USE ENTITY WORK.dff ;
  FOR f5  : dff USE ENTITY WORK.dff ;
  FOR f6  : dff USE ENTITY WORK.dff ;
  FOR f7  : dff USE ENTITY WORK.dff ;
  FOR g3  : notif1_5 USE ENTITY WORK.notif1_5 ;
  FOR g4  : notif1_5 USE ENTITY WORK.notif1_5 ;
  FOR g5  : notif1_5 USE ENTITY WORK.notif1_5 ;
  FOR g6  : notif1_5 USE ENTITY WORK.notif1_5 ;
  FOR g7  : notif1_5 USE ENTITY WORK.notif1_5 ;
  FOR g8  : notif1_5 USE ENTITY WORK.notif1_5 ;
  FOR g9  : notif1_5 USE ENTITY WORK.notif1_5 ;
  FOR g10 : notif1_5 USE ENTITY WORK.notif1_5 ;
  SIGNAL q0,q1,q2,q3,q4,q5,q6,q7,
         lf0,lf1,lf2,lf3,lf4,lf5,lf6,lf7,
         l1,l2,high
         : STD_ULOGIC ;
  CONSTANT H : STD_ULOGIC := '1' ;
BEGIN
  high <= H ;
  l1  <= NOT oc AFTER 5 NS ;
  l2  <= clock AFTER 5 NS ;
  f0  : dff PORT MAP(q0,lf0,in0(0),l2,high,high) ;
  f1  : dff PORT MAP(q1,lf1,in0(1),l2,high,high) ;
  f2  : dff PORT MAP(q2,lf2,in0(2),l2,high,high) ;
  f3  : dff PORT MAP(q3,lf3,in0(3),l2,high,high) ;
  f4  : dff PORT MAP(q4,lf4,in0(4),l2,high,high) ;
  f5  : dff PORT MAP(q5,lf5,in0(5),l2,high,high) ;
  f6  : dff PORT MAP(q6,lf6,in0(6),l2,high,high) ;
  f7  : dff PORT MAP(q7,lf7,in0(7),l2,high,high) ;
  g3  : notif1_5 PORT MAP(out0(0),lf0,l1) ;
  g4  : notif1_5 PORT MAP(out0(1),lf1,l1) ;
  g5  : notif1_5 PORT MAP(out0(2),lf2,l1) ;
  g6  : notif1_5 PORT MAP(out0(3),lf3,l1) ;
  g7  : notif1_5 PORT MAP(out0(4),lf4,l1) ;
  g8  : notif1_5 PORT MAP(out0(5),lf5,l1) ;
  g9  : notif1_5 PORT MAP(out0(6),lf6,l1) ;
  g10 : notif1_5 PORT MAP(out0(7),lf7,l1) ;
END struct1 ;
