//
// display fake CP/M text
//
strings = [
"A>stat a:*.*",
"     ",
" Recs  Bytes  Ext Acc",
"   64     8k    1 R/W A:ASM.COM",
"    2     1k    1 R/W A:BYE.COM",
"    1     1k    1 R/W A:CLS.COM",
"   32     4k    1 R/W A:CREF80.COM",
"   38     5k    1 R/W A:DDT.COM",
"   79    10k    1 R/W A:DDTZ.COM",
"    3     1k    1 R/W A:DUMP.COM",
"   52     7k    1 R/W A:ED.COM",
"    1     1k    1 R/W A:HELLO.ASM",
"    1     1k    1 R/W A:HELLO.COM",
"   10     2k    1 R/W A:HIST.UTL",
"   84    11k    1 R/W A:L80.COM",
"   37     5k    1 R/W A:LIB80.COM",
"   14     2k    1 R/W A:LOAD.COM",
"    1     1k    1 R/W A:M.SUB",
"  157    20k    2 R/W A:M80.COM",
"   92    12k    1 R/W A:MAC.COM",
"   76    10k    1 R/W A:MOVCPM.COM",
"   58     8k    1 R/W A:PIP.COM",
"    1     1k    1 R/W A:REW.ASM",
"    1     1k    1 R/W A:REW.COM",
"  106    14k    1 R/W A:RMAC.COM",
"  119    15k    1 R/W A:SDIR.COM",
"   61     8k    1 R/W A:SID.COM",
"   40     5k    1 R/W A:STAT.COM",
"   10     2k    1 R/W A:SUBMIT.COM",
"    8     1k    1 R/W A:SYSGEN.COM",
"    9     2k    1 R/W A:TRACE.UTL",
"   82    11k    1 R/W A:WM.COM",
"   23     3k    1 R/W A:WM.HLP",
"    6     1k    1 R/W A:XSUB.COM",
"   80    10k    1 R/W A:ZSID.COM" ];

module show_text( strs, hgt) {
     color("white")
  	  linear_extrude( 0.015)
	  for( i = [0 : len(strs) ]) {
	       translate( [0, -i*hgt, 0])
		    text( strs[i], font="Courier 10 Pitch", valign="top", size=0.6*hgt);
	  }
}
