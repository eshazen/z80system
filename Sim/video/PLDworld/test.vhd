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
