# RC2014 doco
## Memory Map

Address | Board | Function | Notes
------- | ----- | -------- | -----
$80-$83 | SIO2  | Z80 SIO ports | A4=0, A4..A6 decoded, A0..A1 local
$10-$17 | CF    | Compact Flash | A6=0, A3..A5 decoded, A0..A2 local
$30, $38 | ROM  | Paged Rom | A6=0, A3..A5 decoded.  Use only $30, $38

Notes:
* SIO2: pretty normal
* CF: 8 ports decoded at $10
* ROM:  Wierd.  $30 resets page register, $38 toggles it!

