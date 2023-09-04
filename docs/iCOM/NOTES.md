# Looking at the iCOM box

Drives are FD 511

So:  AC motor.  Single/double density.  "Basic" interface (50 pins)

See https://github.com/dhansel/ArduinoFDC for an inspiring Arduino test setup.
Not for 8 inch drives, but maybe we could adapt...

Power supply is at least 45 years old.  Needs re-capping at a minimum!

    Ref  Value     Volts   Dia   pitch
	C1   47uF      50V     0.4   0.25                   Mouser 710-860010675020   $0.15
	C2   8,000     50V     2.0   0.86   large screws!   Mouser 539-CGS802U050V2C $36.85
                                        Alt. snap-in    Mouser 5985-85-50V8200    $4.16
	C3   (film)
	C4   470uF     35V     0.64  0.35                   Mouser 667-EEU-TA1V471S   $1.75
	C5   470uF     16V     0.5   0.3                    Mouser 647-UES1C471MHM1TO $1.05
	C6   10,000uF  16V     1.0   2.0    axial           Mouser 594-2222-021-15103 $6.03
	C7   10,000uF  16V     1.0   2.0    axial           Mouser 594-2222-021-15103 $6.03
	C8   470uF     16V     0.52  0.25                   Mouser 647-UES1C471MHM1TO $1.05
	C9   ??
	C10  2200uF    35V     0.875 1.575  axial           Mouser 598-228TTA035M     $4.56
	C11  22uF      16V     0.5   0.2                    Mouser 710-860010372002   $0.10
	C12  (film)
	
Outputs:

	24V  @ 4A    100W
	5V   @ 6A     30W
	-12V @ 1A     12W
		TOTAL    142W
		
E.G.

	Mean Well LRS-150-24   24V @ 6.5A    $23
	Mean Well LRS-50-5      5V @ 10A     $18
	Mean Well RS-15-12     12V @ 1.3A    $17

