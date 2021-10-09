# RC2014 doco
## Memory Map

Address | Board | Function | Notes
------- | ----- | -------- | -----
$80-$83 | SIO2  | Z80 SIO ports | A4=0, A4..A6 decoded, A0..A1 local
$10-$17 | CF    | Compact Flash | A6=0, A3..A5 decoded, A0..A2 local
$30, $38 | ROM  | Paged Rom | A6=0, A3..A5 decoded.  Use only $30, $38
$70-$77 | 512K  | ROM/RAM  | $70-$73 set 16K page# MA14-MA21

Notes:
* SIO2: pretty normal
* CF: 8 ports decoded at $10
* Paged ROM:  Wierd.  $30 resets page register, $38 toggles it!

### 512K ROM/RAM observations from examining schem:

Page# is MA14-MA21 which in principle supports 4M but only 1M is used

MA14-MA18 got to two 512K devices.  MA19 selects the device.
MA20, MA21 aren't used.

So one could expand using the same paging scheme up to total 4M.

It seems also that writing to the ROM is perfectly feasible.  Personally,
I would add a hardware "write protect" switch.
