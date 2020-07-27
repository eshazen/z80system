------------------------------------------------------------
-- Copyright Mentor Graphic Corporation 1991. 
-- All rights reserved.  
------------------------------------------------------------
--
--  Model Title:  TTL Library ( part 4 )
--  Date Created: 94/10/26 (Wed)
--  Author:       T.Ohtsuka ( tootsuka@ss.titech.ac.jp )
--
------------------------------------------------------------
-- Model Description: 
--
-----------------------------------------------------------
--
----- ls151 -----
-- 8 to 1 data selector --
--------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls151 IS
  PORT (
       w        : OUT   STD_ULOGIC ;
       y        : OUT   STD_ULOGIC ;
       d_in     : IN    STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
       a        : IN    STD_ULOGIC ;
       b        : IN    STD_ULOGIC ;
       c        : IN    STD_ULOGIC ;
       strobe   : IN    STD_ULOGIC
       ) ;
END ls151 ;

ARCHITECTURE struct1 OF ls151 IS
  SIGNAL d_bar,d_sel : STD_ULOGIC_VECTOR(2 DOWNTO 0) ;
  SIGNAL wa0,wa1,wa2,wa3,wa4,wa5,wa6,wa7,w0,str : STD_ULOGIC ;
BEGIN
  d_bar(0) <= NOT a AFTER 5 NS ;
  d_bar(1) <= NOT b AFTER 5 NS ;
  d_bar(2) <= NOT c AFTER 5 NS ;
  d_sel(0) <= NOT d_bar(0) AFTER 5 NS ;
  d_sel(1) <= NOT d_bar(1) AFTER 5 NS ;
  d_sel(2) <= NOT d_bar(2) AFTER 5 NS ;
  y   <= NOT w0 AFTER 5 NS ;
  str <= NOT strobe AFTER 5 NS ;
  wa0 <= d_in(0) AND d_bar(2) AND d_bar(1) AND d_bar(0) AND str AFTER 5 NS ;
  wa1 <= d_in(1) AND d_bar(2) AND d_bar(1) AND d_sel(0) AND str AFTER 5 NS ;
  wa2 <= d_in(2) AND d_bar(2) AND d_sel(1) AND d_bar(0) AND str AFTER 5 NS ;
  wa3 <= d_in(3) AND d_bar(2) AND d_sel(1) AND d_sel(0) AND str AFTER 5 NS ;
  wa4 <= d_in(4) AND d_sel(2) AND d_bar(1) AND d_bar(0) AND str AFTER 5 NS ;
  wa5 <= d_in(5) AND d_sel(2) AND d_bar(1) AND d_sel(0) AND str AFTER 5 NS ;
  wa6 <= d_in(6) AND d_sel(2) AND d_sel(1) AND d_bar(0) AND str AFTER 5 NS ;
  wa7 <= d_in(7) AND d_sel(2) AND d_sel(1) AND d_sel(0) AND str AFTER 5 NS ;
  w0 <= NOT ( wa0 OR wa1 OR wa2 OR wa3 OR wa4 OR wa5 OR wa6 OR wa7 ) AFTER 5 NS ;
  w <= w0 ;
END struct1 ;

----- ls377 -----
-- 8 bit d-ffs --
-----------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls377 IS
  PORT (
       out0     : OUT    STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
       in0      : IN     STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
       clock    : IN     STD_ULOGIC ;
       enable_g : IN     STD_ULOGIC
       ) ;
END ls377 ;

ARCHITECTURE struct1 OF ls377 IS
  COMPONENT dff
    PORT (
         q      : OUT   STD_ULOGIC ;
         qb     : OUT   STD_ULOGIC ;
         d      : IN    STD_ULOGIC ;
         clock  : IN    STD_ULOGIC ;
         preset : IN    STD_ULOGIC ;
         clear  : IN    STD_ULOGIC
         ) ;
  END COMPONENT ;
  FOR ff7 : dff USE ENTITY WORK.dff ;
  FOR ff6 : dff USE ENTITY WORK.dff ;
  FOR ff5 : dff USE ENTITY WORK.dff ;
  FOR ff4 : dff USE ENTITY WORK.dff ;
  FOR ff3 : dff USE ENTITY WORK.dff ;
  FOR ff2 : dff USE ENTITY WORK.dff ;
  FOR ff1 : dff USE ENTITY WORK.dff ;
  FOR ff0 : dff USE ENTITY WORK.dff ;
  SIGNAL   clk,cl,wn0,wn1,c,high : STD_ULOGIC ;
  SIGNAL   qb                     : STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
  CONSTANT H : STD_ULOGIC :='1' ;

BEGIN
  high <= H ;
  clk <= NOT clock AFTER 5 NS ;
  cl  <= NOT clk ;
  wn0 <= wn1 NOR clk AFTER 5 NS ;
  wn1 <= wn0 NOR enable_g AFTER 5 NS ;
  c   <= wn1 AND cl AFTER 5 NS ;
  ff7 : dff PORT MAP (out0(7),qb(7),in0(7),c,high,high) ;
  ff6 : dff PORT MAP (out0(6),qb(6),in0(6),c,high,high) ;
  ff5 : dff PORT MAP (out0(5),qb(5),in0(5),c,high,high) ;
  ff4 : dff PORT MAP (out0(4),qb(4),in0(4),c,high,high) ;
  ff3 : dff PORT MAP (out0(3),qb(3),in0(3),c,high,high) ;
  ff2 : dff PORT MAP (out0(2),qb(2),in0(2),c,high,high) ;
  ff1 : dff PORT MAP (out0(1),qb(1),in0(1),c,high,high) ;
  ff0 : dff PORT MAP (out0(0),qb(0),in0(0),c,high,high) ;
END struct1 ;

----- ls540 -----
-- octal 3 state buffer ( inverted ) --
---------------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls540 IS
  PORT (
       out0     : OUT   STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
       in0      : IN    STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
       strobe1  : IN    STD_ULOGIC ;
       strobe2  : IN    STD_ULOGIC
       ) ;
END ls540 ;

ARCHITECTURE struct1 OF ls540 IS
  COMPONENT notif0_5
    PORT (
         o1     : OUT   STD_ULOGIC ;
         i1     : IN    STD_ULOGIC ;
         c1     : IN    STD_ULOGIC
         ) ;
  END COMPONENT ;
  FOR g0 : notif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g1 : notif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g2 : notif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g3 : notif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g4 : notif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g5 : notif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g6 : notif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g7 : notif0_5 USE ENTITY WORK.notif0_5 ;
  SIGNAL oebar : STD_ULOGIC ;
BEGIN
  oebar <= strobe1 OR strobe2 AFTER 5 NS ;
  g0 : notif0_5 PORT MAP (out0(0),in0(0),oebar) ;
  g1 : notif0_5 PORT MAP (out0(1),in0(1),oebar) ;
  g2 : notif0_5 PORT MAP (out0(2),in0(2),oebar) ;
  g3 : notif0_5 PORT MAP (out0(3),in0(3),oebar) ;
  g4 : notif0_5 PORT MAP (out0(4),in0(4),oebar) ;
  g5 : notif0_5 PORT MAP (out0(5),in0(5),oebar) ;
  g6 : notif0_5 PORT MAP (out0(6),in0(6),oebar) ;
  g7 : notif0_5 PORT MAP (out0(7),in0(7),oebar) ;
END struct1 ;

----- ls541 -----
-- octal 3 state buffer --
--------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls541 IS
  PORT (
       out0     : OUT   STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
       in0      : IN    STD_ULOGIC_VECTOR(7 DOWNTO 0) ;
       strobe1  : IN    STD_ULOGIC ;
       strobe2  : IN    STD_ULOGIC
       ) ;
END ls541 ;

ARCHITECTURE struct1 OF ls541 IS
  COMPONENT bufif0_5
    PORT (
         o1     : OUT   STD_ULOGIC ;
         i1     : IN    STD_ULOGIC ;
         c1     : IN    STD_ULOGIC
         ) ;
  END COMPONENT ;
  FOR g0 : bufif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g1 : bufif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g2 : bufif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g3 : bufif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g4 : bufif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g5 : bufif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g6 : bufif0_5 USE ENTITY WORK.notif0_5 ;
  FOR g7 : bufif0_5 USE ENTITY WORK.notif0_5 ;
  SIGNAL oebar : STD_ULOGIC ;
BEGIN
  oebar <= strobe1 OR strobe2 AFTER 5 NS ;
  g0 : bufif0_5 PORT MAP (out0(0),in0(0),oebar) ;
  g1 : bufif0_5 PORT MAP (out0(1),in0(1),oebar) ;
  g2 : bufif0_5 PORT MAP (out0(2),in0(2),oebar) ;
  g3 : bufif0_5 PORT MAP (out0(3),in0(3),oebar) ;
  g4 : bufif0_5 PORT MAP (out0(4),in0(4),oebar) ;
  g5 : bufif0_5 PORT MAP (out0(5),in0(5),oebar) ;
  g6 : bufif0_5 PORT MAP (out0(6),in0(6),oebar) ;
  g7 : bufif0_5 PORT MAP (out0(7),in0(7),oebar) ;
END struct1 ;

----- ls157 -----
-- quad 2 to 1 data selector --
-------------------------------
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls157 IS
  PORT (
       y      : OUT    STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       a      : IN     STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       b      : IN     STD_ULOGIC_VECTOR(3 DOWNTO 0) ;
       sel    : IN     STD_ULOGIC ;
       strobe : IN     STD_ULOGIC
       ) ;
END ls157 ;

ARCHITECTURE struct1 OF ls157 IS
  SIGNAL select_b,select2,A_select,B_select,strobe_b,
         l1,l2,l3,l4,l5,l6,l7,l8
         : STD_ULOGIC ;
BEGIN
  select_b <= NOT sel AFTER 5 NS ;
  strobe_b <= NOT strobe AFTER 5 NS ;
  select2 <= sel AFTER 5 NS ;
  A_select <= strobe_b AND select_b AFTER 5 NS ;
  B_select <= strobe_b AND select2 AFTER 5 NS ;
  l1 <= a(0) AND A_select AFTER 5 NS ;
  l2 <= a(1) AND A_select AFTER 5 NS ;
  l3 <= a(2) AND A_select AFTER 5 NS ;
  l4 <= a(3) AND A_select AFTER 5 NS ;
  l5 <= b(0) AND B_select AFTER 5 NS ;
  l6 <= b(1) AND B_select AFTER 5 NS ;
  l7 <= b(2) AND B_select AFTER 5 NS ;
  l8 <= b(3) AND B_select AFTER 5 NS ;
  y(0) <= l1 OR l5 AFTER 5 NS ;
  y(1) <= l2 OR l6 AFTER 5 NS ;
  y(2) <= l3 OR l7 AFTER 5 NS ;
  y(3) <= l4 OR l8 AFTER 5 NS ;
END struct1 ;

----- rsff -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY rsff IS
  PORT (
       q     : OUT    STD_ULOGIC ;
       s     : IN     STD_ULOGIC ;
       r     : IN     STD_ULOGIC
       ) ;
END rsff ;

ARCHITECTURE struct1 OF rsff IS
  SIGNAL l1,l2 : STD_ULOGIC ;
BEGIN
  l1 <= l2 NAND r AFTER 5 NS ;
  l2 <= s NAND l1 AFTER 5 NS ;
  q <= l2 ;
END struct1 ;

----- inverter -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls04 IS
  PORT (
       o1     : OUT     STD_ULOGIC ;
       i1     : IN      STD_ULOGIC
       ) ;
END ls04 ;

ARCHITECTURE struct1 OF ls04 IS
BEGIN
  o1 <= NOT i1 AFTER 10 NS ;
END struct1 ;

----- 2 input nand -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls00 IS

  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC
       ) ;
END ls00 ;

ARCHITECTURE struct1 OF ls00 IS
BEGIN
  o1 <= i1 NAND i2 AFTER 10 NS ;
END struct1 ;
----- 2 input nor -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls02 IS

  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC
       ) ;
END ls02 ;

ARCHITECTURE struct1 OF ls02 IS
BEGIN
  o1 <= i1 NOR i2 AFTER 10 NS ;
END struct1 ;
----- 2 input and -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls08 IS

  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC
       ) ;
END ls08 ;

ARCHITECTURE struct1 OF ls08 IS
BEGIN
  o1 <= i1 AND i2 AFTER 10 NS ;
END struct1 ;
----- 2 input or -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls32 IS

  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC
       ) ;
END ls32 ;

ARCHITECTURE struct1 OF ls32 IS
BEGIN
  o1 <= i1 OR i2 AFTER 10 NS ;
END struct1 ;
----- 3 input nand -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls10 IS

  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC ;
       i3      : IN      STD_ULOGIC
       ) ;
END ls10 ;

ARCHITECTURE struct1 OF ls10 IS
BEGIN
  o1 <= NOT ( i1 AND i2 AND i3 ) AFTER 10 NS ;
END struct1 ;
----- 3 input and -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls11 IS

  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC ;
       i3      : IN      STD_ULOGIC
       ) ;
END ls11 ;

ARCHITECTURE struct1 OF ls11 IS
BEGIN
  o1 <= i1 AND i2 AND i3 AFTER 10 NS ;
END struct1 ;
----- 3 input nor -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls27 IS

  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC ;
       i3      : IN      STD_ULOGIC
       ) ;
END ls27 ;

ARCHITECTURE struct1 OF ls27 IS
BEGIN
  o1 <= NOT ( i1 OR i2 OR i3 ) AFTER 10 NS ;
END struct1 ;
----- 4 input nand -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls20 IS
  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC ;
       i3      : IN      STD_ULOGIC ;
       i4      : IN      STD_ULOGIC
       ) ;
END ls20 ;

ARCHITECTURE struct1 OF ls20 IS
BEGIN
  o1 <= NOT ( i1 AND i2 AND i3 AND i4 ) AFTER 10 NS ;
END struct1 ;
----- 4 input and -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls21 IS
  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC ;
       i3      : IN      STD_ULOGIC ;
       i4      : IN      STD_ULOGIC
       ) ;
END ls21 ;

ARCHITECTURE struct1 OF ls21 IS
BEGIN
  o1 <= i1 AND i2 AND i3 AND i4 AFTER 10 NS ;
END struct1 ;
----- 8 input nand -----
LIBRARY IEEE ;

USE IEEE.STD_LOGIC_1164.ALL ;
-- USE IEEE.STD_LOGIC_1164_EXTENSIONS.ALL ;

ENTITY ls30 IS
  PORT (
       o1      : OUT     STD_ULOGIC ;
       i1      : IN      STD_ULOGIC ;
       i2      : IN      STD_ULOGIC ;
       i3      : IN      STD_ULOGIC ;
       i4      : IN      STD_ULOGIC ;
       i5      : IN      STD_ULOGIC ;
       i6      : IN      STD_ULOGIC ;
       i7      : IN      STD_ULOGIC ;
       i8      : IN      STD_ULOGIC
       ) ;
END ls30 ;

ARCHITECTURE struct1 OF ls30 IS
BEGIN
  o1 <= NOT ( i1 AND i2 AND i3 AND i4 AND i5 AND i6 AND i7 AND i8 ) AFTER 10 NS ;
END struct1 ;
