EESchema Schematic File Version 4
LIBS:6303-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_01x40 J1
U 1 1 5D4D81A3
P 750 2750
F 0 "J1" H 668 4867 50  0000 C CNN
F 1 "Conn_01x40" H 668 4776 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x40_P2.54mm_Horizontal" H 750 2750 50  0001 C CNN
F 3 "~" H 750 2750 50  0001 C CNN
	1    750  2750
	-1   0    0    -1  
$EndComp
Text GLabel 950  850  2    50   Input ~ 0
A15
Text GLabel 950  950  2    50   Input ~ 0
A14
Text GLabel 950  1050 2    50   Input ~ 0
A13
Text GLabel 950  1150 2    50   Input ~ 0
A12
Text GLabel 950  1250 2    50   Input ~ 0
A11
Text GLabel 950  1350 2    50   Input ~ 0
A10
Text GLabel 950  1450 2    50   Input ~ 0
A9
Text GLabel 950  1550 2    50   Input ~ 0
A8
Text GLabel 950  1650 2    50   Input ~ 0
A7
Text GLabel 950  1750 2    50   Input ~ 0
A6
Text GLabel 950  1850 2    50   Input ~ 0
A5
Text GLabel 950  1950 2    50   Input ~ 0
A4
Text GLabel 950  2050 2    50   Input ~ 0
A3
Text GLabel 950  2150 2    50   Input ~ 0
A2
Text GLabel 950  2250 2    50   Input ~ 0
A1
Text GLabel 950  2350 2    50   Input ~ 0
A0
Text GLabel 950  2450 2    50   Output ~ 0
GND
Text GLabel 950  2550 2    50   Output ~ 0
VCC
Text GLabel 950  2750 2    50   3State ~ 0
RESET
Text GLabel 950  2850 2    50   Output ~ 0
CLK
Text GLabel 950  2950 2    50   Output ~ 0
INT
Text GLabel 950  3050 2    50   Input ~ 0
MREQ
Text GLabel 950  3150 2    50   Input ~ 0
WR
Text GLabel 950  3250 2    50   Input ~ 0
RD
Text GLabel 950  3350 2    50   Input ~ 0
IORQ
Text GLabel 950  3450 2    50   3State ~ 0
D0
Text GLabel 950  3550 2    50   3State ~ 0
D1
Text GLabel 950  3650 2    50   3State ~ 0
D2
Text GLabel 950  3750 2    50   3State ~ 0
D3
Text GLabel 950  3850 2    50   3State ~ 0
D4
Text GLabel 950  3950 2    50   3State ~ 0
D5
Text GLabel 950  4050 2    50   3State ~ 0
D6
Text GLabel 950  4150 2    50   3State ~ 0
D7
Text GLabel 950  4250 2    50   Input ~ 0
TX
Text GLabel 950  4350 2    50   Output ~ 0
RX
$Comp
L Alan:6303RP-DIP40 U1
U 1 1 5D733D5E
P 5100 3400
F 0 "U1" H 5450 4800 50  0000 C CNN
F 1 "6303RP-DIP40" H 5500 4700 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm" H 5200 3400 50  0001 C CNN
F 3 "" H 5200 3400 50  0001 C CNN
	1    5100 3400
	1    0    0    -1  
$EndComp
Text GLabel 4550 2400 0    50   Input ~ 0
CLK
Text GLabel 4550 2700 0    50   Input ~ 0
RESET
NoConn ~ 4550 2300
Text GLabel 3000 2600 0    50   Input ~ 0
INT
Text GLabel 6900 2300 2    50   Output ~ 0
E
Text GLabel 5600 3600 2    50   Output ~ 0
UA8
Text GLabel 5600 3700 2    50   Output ~ 0
UA9
Text GLabel 5600 3800 2    50   Output ~ 0
UA10
Text GLabel 5600 3900 2    50   Output ~ 0
UA11
Text GLabel 5600 4000 2    50   Output ~ 0
UA12
Text GLabel 5600 4100 2    50   Output ~ 0
UA13
Text GLabel 5600 4200 2    50   Output ~ 0
UA14
Text GLabel 5600 4300 2    50   Output ~ 0
UA15
Text GLabel 4550 4200 0    50   Input ~ 0
RX
Text GLabel 4550 4300 0    50   Output ~ 0
TX
$Comp
L power:GND #PWR0101
U 1 1 5D72CAA8
P 5100 4450
F 0 "#PWR0101" H 5100 4200 50  0001 C CNN
F 1 "GND" H 5105 4277 50  0000 C CNN
F 2 "" H 5100 4450 50  0001 C CNN
F 3 "" H 5100 4450 50  0001 C CNN
	1    5100 4450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0102
U 1 1 5D72CE02
P 5100 2150
F 0 "#PWR0102" H 5100 2000 50  0001 C CNN
F 1 "VCC" H 5117 2323 50  0000 C CNN
F 2 "" H 5100 2150 50  0001 C CNN
F 3 "" H 5100 2150 50  0001 C CNN
	1    5100 2150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5D73258C
P 3200 1950
F 0 "R2" H 3270 1996 50  0000 L CNN
F 1 "4K7" H 3270 1905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3130 1950 50  0001 C CNN
F 3 "~" H 3200 1950 50  0001 C CNN
	1    3200 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5D7329BF
P 3450 4400
F 0 "R6" H 3520 4446 50  0000 L CNN
F 1 "4K7" H 3520 4355 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3380 4400 50  0001 C CNN
F 3 "~" H 3450 4400 50  0001 C CNN
	1    3450 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5D732C8D
P 3700 1950
F 0 "R4" H 3770 1996 50  0000 L CNN
F 1 "4K7" H 3770 1905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3630 1950 50  0001 C CNN
F 3 "~" H 3700 1950 50  0001 C CNN
	1    3700 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5D732F58
P 3950 1950
F 0 "R5" H 4020 1996 50  0000 L CNN
F 1 "4K7" H 4020 1905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3880 1950 50  0001 C CNN
F 3 "~" H 3950 1950 50  0001 C CNN
	1    3950 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5D73326E
P 3950 4400
F 0 "R7" H 4020 4446 50  0000 L CNN
F 1 "4K7" H 4020 4355 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3880 4400 50  0001 C CNN
F 3 "~" H 3950 4400 50  0001 C CNN
	1    3950 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 2500 3950 2100
Wire Wire Line
	4550 2800 3700 2800
Wire Wire Line
	3700 2800 3700 2100
Wire Wire Line
	3450 3900 4550 3900
Wire Wire Line
	3200 4000 3200 2100
Wire Wire Line
	3200 4000 4550 4000
Wire Wire Line
	5600 2400 6850 2400
Wire Wire Line
	6850 3600 6950 3600
Wire Wire Line
	6850 2400 6850 3600
Text GLabel 7950 3400 2    50   Output ~ 0
A7
Text GLabel 7950 3300 2    50   Output ~ 0
A6
Text GLabel 7950 3200 2    50   Output ~ 0
A5
Text GLabel 7950 3100 2    50   Output ~ 0
A4
Text GLabel 7950 3000 2    50   Output ~ 0
A3
Text GLabel 7950 2900 2    50   Output ~ 0
A2
Text GLabel 7950 2800 2    50   Output ~ 0
A1
Text GLabel 7950 2700 2    50   Output ~ 0
A0
$Comp
L power:VCC #PWR0103
U 1 1 5D72E9C4
P 7450 2400
F 0 "#PWR0103" H 7450 2250 50  0001 C CNN
F 1 "VCC" H 7467 2573 50  0000 C CNN
F 2 "" H 7450 2400 50  0001 C CNN
F 3 "" H 7450 2400 50  0001 C CNN
	1    7450 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 5D72C727
P 7450 4000
F 0 "#PWR0104" H 7450 3750 50  0001 C CNN
F 1 "GND" H 7455 3827 50  0000 C CNN
F 2 "" H 7450 4000 50  0001 C CNN
F 3 "" H 7450 4000 50  0001 C CNN
	1    7450 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 4000 7450 4000
Wire Wire Line
	6950 3700 6950 4000
Wire Wire Line
	5600 3400 6750 3400
Wire Wire Line
	5600 3300 6650 3300
Wire Wire Line
	6950 3200 6550 3200
Wire Wire Line
	5600 3100 6450 3100
Wire Wire Line
	5600 2900 6250 2900
Wire Wire Line
	6950 3000 6350 3000
Wire Wire Line
	5600 2800 6150 2800
Wire Wire Line
	5600 2700 6050 2700
Connection ~ 7450 4000
$Comp
L 74xx:74LS573 U2
U 1 1 5D73983B
P 7450 3200
F 0 "U2" H 7700 4100 50  0000 C CNN
F 1 "74HC573" H 7700 4000 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm" H 7450 3200 50  0001 C CNN
F 3 "74xx/74hc573.pdf" H 7450 3200 50  0001 C CNN
	1    7450 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 1800 3450 1800
Connection ~ 3450 1800
Wire Wire Line
	3700 1800 3950 1800
Connection ~ 3700 1800
$Comp
L power:VCC #PWR0105
U 1 1 5D738B7B
P 3450 1800
F 0 "#PWR0105" H 3450 1650 50  0001 C CNN
F 1 "VCC" H 3467 1973 50  0000 C CNN
F 2 "" H 3450 1800 50  0001 C CNN
F 3 "" H 3450 1800 50  0001 C CNN
	1    3450 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 4550 3700 4550
Wire Wire Line
	3450 3900 3450 4250
$Comp
L power:GND #PWR0106
U 1 1 5D74DCB4
P 3700 4550
F 0 "#PWR0106" H 3700 4300 50  0001 C CNN
F 1 "GND" H 3705 4377 50  0000 C CNN
F 2 "" H 3700 4550 50  0001 C CNN
F 3 "" H 3700 4550 50  0001 C CNN
	1    3700 4550
	1    0    0    -1  
$EndComp
Connection ~ 3700 4550
Wire Wire Line
	3700 4550 3950 4550
Wire Wire Line
	3950 4100 4550 4100
Wire Wire Line
	3950 4100 3950 4250
$Comp
L 74xx:74HC00 U3
U 1 1 5D75BDF6
P 6700 1200
F 0 "U3" H 6700 1525 50  0000 C CNN
F 1 "74HC00" H 6700 1434 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 6700 1200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 6700 1200 50  0001 C CNN
	1    6700 1200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC00 U3
U 2 1 5D75D884
P 7700 1300
F 0 "U3" H 7700 1625 50  0000 C CNN
F 1 "74HC00" H 7700 1534 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 7700 1300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 7700 1300 50  0001 C CNN
	2    7700 1300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC00 U3
U 3 1 5D760D9C
P 7700 1850
F 0 "U3" H 7700 2175 50  0000 C CNN
F 1 "74HC00" H 7700 2084 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 7700 1850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 7700 1850 50  0001 C CNN
	3    7700 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 2500 6400 2500
Connection ~ 6400 1300
Wire Wire Line
	6400 1300 6400 1100
Wire Wire Line
	7400 1950 6400 1950
$Comp
L Jumper:Jumper_2_Open JP1
U 1 1 5D763796
P 1600 4550
F 0 "JP1" H 1600 4785 50  0000 C CNN
F 1 "Jumper_2_Open" H 1600 4694 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1600 4550 50  0001 C CNN
F 3 "~" H 1600 4550 50  0001 C CNN
	1    1600 4550
	1    0    0    -1  
$EndComp
Text GLabel 1800 4550 2    50   Input ~ 0
E
Wire Wire Line
	1400 4550 950  4550
Wire Wire Line
	6900 2300 6750 2300
Wire Wire Line
	6750 2300 6750 1750
Wire Wire Line
	6750 1750 7400 1750
Connection ~ 6750 2300
Wire Wire Line
	6750 2300 5600 2300
Wire Wire Line
	7400 1750 7400 1400
Connection ~ 7400 1750
Wire Wire Line
	6400 1300 6400 1950
Connection ~ 6400 1950
Wire Wire Line
	6400 1950 6400 2500
Wire Wire Line
	7000 1200 7400 1200
Text GLabel 8000 1300 2    50   Output ~ 0
WR
Text GLabel 8000 1850 2    50   Output ~ 0
RD
Text GLabel 6750 4700 3    50   Output ~ 0
D7
Text GLabel 6650 4700 3    50   Output ~ 0
D6
Text GLabel 6550 4700 3    50   Output ~ 0
D5
Text GLabel 6450 4700 3    50   Output ~ 0
D4
Text GLabel 6350 4700 3    50   Output ~ 0
D3
Text GLabel 6250 4700 3    50   Output ~ 0
D2
Text GLabel 6150 4700 3    50   Output ~ 0
D1
Text GLabel 6050 4700 3    50   Output ~ 0
D0
Wire Wire Line
	6050 4700 6050 2700
Connection ~ 6050 2700
Wire Wire Line
	6050 2700 6950 2700
Wire Wire Line
	6150 4700 6150 2800
Connection ~ 6150 2800
Wire Wire Line
	6150 2800 6950 2800
Connection ~ 6250 2900
Wire Wire Line
	6250 2900 6950 2900
Wire Wire Line
	6250 2900 6250 4700
Wire Wire Line
	6350 4700 6350 3000
Connection ~ 6350 3000
Wire Wire Line
	6350 3000 5600 3000
Wire Wire Line
	6450 4700 6450 3100
Connection ~ 6450 3100
Wire Wire Line
	6450 3100 6950 3100
Wire Wire Line
	6550 4700 6550 3200
Connection ~ 6550 3200
Wire Wire Line
	6550 3200 5600 3200
Connection ~ 6650 3300
Wire Wire Line
	6650 3300 6950 3300
Wire Wire Line
	6650 3300 6650 4700
Wire Wire Line
	6750 4700 6750 3400
Connection ~ 6750 3400
Wire Wire Line
	6750 3400 6950 3400
$Comp
L 74xx:74HC00 U3
U 4 1 5D79212F
P 7350 5450
F 0 "U3" H 7350 5775 50  0000 C CNN
F 1 "74HC00" H 7350 5684 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 7350 5450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 7350 5450 50  0001 C CNN
	4    7350 5450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC00 U3
U 5 1 5D792FFA
P 1000 6800
F 0 "U3" H 1230 6846 50  0000 L CNN
F 1 "74HC00" H 1230 6755 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 1000 6800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74hc00" H 1000 6800 50  0001 C CNN
	5    1000 6800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 5D7959FF
P 1000 7300
F 0 "#PWR0107" H 1000 7050 50  0001 C CNN
F 1 "GND" H 1005 7127 50  0000 C CNN
F 2 "" H 1000 7300 50  0001 C CNN
F 3 "" H 1000 7300 50  0001 C CNN
	1    1000 7300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0108
U 1 1 5D7963F4
P 1000 6300
F 0 "#PWR0108" H 1000 6150 50  0001 C CNN
F 1 "VCC" H 1017 6473 50  0000 C CNN
F 2 "" H 1000 6300 50  0001 C CNN
F 3 "" H 1000 6300 50  0001 C CNN
	1    1000 6300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5D796D91
P 2200 6850
F 0 "C1" H 2315 6896 50  0000 L CNN
F 1 "0.1uF" H 2315 6805 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 2238 6700 50  0001 C CNN
F 3 "~" H 2200 6850 50  0001 C CNN
	1    2200 6850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5D79C1E9
P 2750 6850
F 0 "C2" H 2865 6896 50  0000 L CNN
F 1 "0.1uF" H 2865 6805 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 2788 6700 50  0001 C CNN
F 3 "~" H 2750 6850 50  0001 C CNN
	1    2750 6850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5D7A60A9
P 3250 6850
F 0 "C3" H 3365 6896 50  0000 L CNN
F 1 "0.1uF" H 3365 6805 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 3288 6700 50  0001 C CNN
F 3 "~" H 3250 6850 50  0001 C CNN
	1    3250 6850
	1    0    0    -1  
$EndComp
Text GLabel 1900 6700 0    50   Input ~ 0
VCC
Text GLabel 1900 7000 0    50   Input ~ 0
GND
Wire Wire Line
	1900 6700 2200 6700
Connection ~ 2200 6700
Wire Wire Line
	2200 6700 2750 6700
Connection ~ 2750 6700
Wire Wire Line
	2750 6700 3250 6700
Wire Wire Line
	1900 7000 2200 7000
Connection ~ 2200 7000
Wire Wire Line
	2200 7000 2750 7000
Connection ~ 2750 7000
Wire Wire Line
	2750 7000 3250 7000
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5D7B805C
P 2750 6700
F 0 "#FLG0101" H 2750 6775 50  0001 C CNN
F 1 "PWR_FLAG" H 2750 6873 50  0000 C CNN
F 2 "" H 2750 6700 50  0001 C CNN
F 3 "~" H 2750 6700 50  0001 C CNN
	1    2750 6700
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5D7B8ABA
P 2750 7000
F 0 "#FLG0102" H 2750 7075 50  0001 C CNN
F 1 "PWR_FLAG" H 2750 7173 50  0000 C CNN
F 2 "" H 2750 7000 50  0001 C CNN
F 3 "~" H 2750 7000 50  0001 C CNN
	1    2750 7000
	-1   0    0    1   
$EndComp
$Comp
L 74xx:74LS688 U4
U 1 1 5D7C2D6D
P 6450 6350
F 0 "U4" H 6994 6396 50  0000 L CNN
F 1 "74HC688" H 6994 6305 50  0000 L CNN
F 2 "Package_DIP:DIP-20_W7.62mm" H 6450 6350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS688" H 6450 6350 50  0001 C CNN
	1    6450 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 6050 5950 5950
Wire Wire Line
	5950 5150 6450 5150
Connection ~ 5950 5450
Wire Wire Line
	5950 5450 5950 5150
Connection ~ 5950 5550
Wire Wire Line
	5950 5550 5950 5450
Connection ~ 5950 5650
Wire Wire Line
	5950 5650 5950 5550
Connection ~ 5950 5750
Wire Wire Line
	5950 5750 5950 5650
Connection ~ 5950 5850
Wire Wire Line
	5950 5850 5950 5750
Connection ~ 5950 5950
Wire Wire Line
	5950 5950 5950 5850
Wire Wire Line
	5950 6150 5450 6150
Wire Wire Line
	5450 6150 5450 7550
Wire Wire Line
	5450 7550 5950 7550
$Comp
L power:GND #PWR0109
U 1 1 5D8121EB
P 6450 7550
F 0 "#PWR0109" H 6450 7300 50  0001 C CNN
F 1 "GND" H 6455 7377 50  0000 C CNN
F 2 "" H 6450 7550 50  0001 C CNN
F 3 "" H 6450 7550 50  0001 C CNN
	1    6450 7550
	1    0    0    -1  
$EndComp
Connection ~ 6450 7550
$Comp
L power:VCC #PWR0110
U 1 1 5D81295C
P 6450 5150
F 0 "#PWR0110" H 6450 5000 50  0001 C CNN
F 1 "VCC" H 6467 5323 50  0000 C CNN
F 2 "" H 6450 5150 50  0001 C CNN
F 3 "" H 6450 5150 50  0001 C CNN
	1    6450 5150
	1    0    0    -1  
$EndComp
Connection ~ 6450 5150
Text GLabel 5950 6350 0    50   Input ~ 0
A15
Text GLabel 5950 6450 0    50   Input ~ 0
A14
Text GLabel 5950 6550 0    50   Input ~ 0
A13
Text GLabel 5950 6650 0    50   Input ~ 0
A12
Text GLabel 5950 6750 0    50   Input ~ 0
A11
Text GLabel 5950 6850 0    50   Input ~ 0
A10
Text GLabel 5950 6950 0    50   Input ~ 0
A9
Text GLabel 5950 7050 0    50   Input ~ 0
A8
Wire Wire Line
	7050 5350 7050 5450
Wire Wire Line
	6950 5450 7050 5450
Connection ~ 7050 5450
Wire Wire Line
	7050 5450 7050 5550
Text GLabel 7650 5450 2    50   Output ~ 0
MREQ
Text GLabel 7650 5800 2    50   Output ~ 0
IORQ
Wire Wire Line
	7050 5800 7650 5800
Connection ~ 7050 5550
Wire Wire Line
	7050 5550 7050 5800
$Comp
L Device:C C4
U 1 1 5D82C90E
P 3800 6850
F 0 "C4" H 3915 6896 50  0000 L CNN
F 1 "0.1uF" H 3915 6805 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 3838 6700 50  0001 C CNN
F 3 "~" H 3800 6850 50  0001 C CNN
	1    3800 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 6700 3800 6700
Connection ~ 3250 6700
Connection ~ 3250 7000
NoConn ~ 950  4450
NoConn ~ 950  4750
Wire Wire Line
	3950 2500 4550 2500
$Comp
L Device:R R1
U 1 1 5D843054
P 2350 1950
F 0 "R1" H 2420 1996 50  0000 L CNN
F 1 "10K" H 2420 1905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 2280 1950 50  0001 C CNN
F 3 "~" H 2350 1950 50  0001 C CNN
	1    2350 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 1800 2350 1800
Connection ~ 3200 1800
Wire Wire Line
	950  2650 2350 2650
Wire Wire Line
	2350 2650 2350 2100
Wire Wire Line
	5950 7250 5950 7550
Connection ~ 5950 7550
Wire Wire Line
	5950 7550 6450 7550
$Comp
L 74xx:74LS573 U5
U 1 1 5D86B383
P 9400 3200
F 0 "U5" H 9650 4100 50  0000 C CNN
F 1 "74HC573" H 9650 4000 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm" H 9400 3200 50  0001 C CNN
F 3 "74xx/74hc573.pdf" H 9400 3200 50  0001 C CNN
	1    9400 3200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 5D86FE7C
P 9400 4000
F 0 "#PWR0111" H 9400 3750 50  0001 C CNN
F 1 "GND" H 9405 3827 50  0000 C CNN
F 2 "" H 9400 4000 50  0001 C CNN
F 3 "" H 9400 4000 50  0001 C CNN
	1    9400 4000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0112
U 1 1 5D8708B7
P 9400 2400
F 0 "#PWR0112" H 9400 2250 50  0001 C CNN
F 1 "VCC" H 9417 2573 50  0000 C CNN
F 2 "" H 9400 2400 50  0001 C CNN
F 3 "" H 9400 2400 50  0001 C CNN
	1    9400 2400
	1    0    0    -1  
$EndComp
Text GLabel 8900 2700 0    50   Input ~ 0
UA8
Text GLabel 8900 2800 0    50   Input ~ 0
UA9
Text GLabel 8900 2900 0    50   Input ~ 0
UA10
Text GLabel 8900 3000 0    50   Input ~ 0
UA11
Text GLabel 8900 3100 0    50   Input ~ 0
UA12
Text GLabel 8900 3200 0    50   Input ~ 0
UA13
Text GLabel 8900 3300 0    50   Input ~ 0
UA14
Text GLabel 8900 3400 0    50   Input ~ 0
UA15
Wire Wire Line
	6850 3600 6850 4350
Wire Wire Line
	6850 4350 8700 4350
Wire Wire Line
	8700 4350 8700 3600
Wire Wire Line
	8700 3600 8900 3600
Connection ~ 6850 3600
Wire Wire Line
	8900 3700 8900 4000
Wire Wire Line
	8900 4000 9400 4000
Connection ~ 9400 4000
Text GLabel 9900 2700 2    50   Output ~ 0
A8
Text GLabel 9900 2800 2    50   Output ~ 0
A9
Text GLabel 9900 2900 2    50   Output ~ 0
A10
Text GLabel 9900 3000 2    50   Output ~ 0
A11
Text GLabel 9900 3100 2    50   Output ~ 0
A12
Text GLabel 9900 3200 2    50   Output ~ 0
A13
Text GLabel 9900 3300 2    50   Output ~ 0
A14
Text GLabel 9900 3400 2    50   Output ~ 0
A15
Text Notes 11000 4400 2    50   ~ 0
Buffer A8-A15 for transient spikes (see CPU handbook)\n
Wire Wire Line
	3000 2600 3450 2600
$Comp
L Device:R R3
U 1 1 5D8B5BA0
P 3450 1950
F 0 "R3" H 3520 1996 50  0000 L CNN
F 1 "4K7" H 3520 1905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3380 1950 50  0001 C CNN
F 3 "~" H 3450 1950 50  0001 C CNN
	1    3450 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 2100 3450 2600
Wire Wire Line
	3450 1800 3700 1800
Connection ~ 3450 2600
Wire Wire Line
	3450 2600 4550 2600
$Comp
L Device:C C5
U 1 1 5D8CDB09
P 4300 6850
F 0 "C5" H 4415 6896 50  0000 L CNN
F 1 "0.1uF" H 4415 6805 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 4338 6700 50  0001 C CNN
F 3 "~" H 4300 6850 50  0001 C CNN
	1    4300 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 6700 3800 6700
Connection ~ 3800 6700
Wire Wire Line
	3250 7000 3800 7000
Connection ~ 3800 7000
Wire Wire Line
	3800 7000 4300 7000
$Comp
L Device:R R8
U 1 1 5D8EFF7E
P 9450 1000
F 0 "R8" H 9300 1050 50  0000 L CNN
F 1 "1K" H 9250 950 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 9380 1000 50  0001 C CNN
F 3 "~" H 9450 1000 50  0001 C CNN
	1    9450 1000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 5D8F083F
P 9550 1000
F 0 "R9" H 9700 1050 50  0000 L CNN
F 1 "1K" H 9700 950 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 9480 1000 50  0001 C CNN
F 3 "~" H 9550 1000 50  0001 C CNN
	1    9550 1000
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Male J2
U 1 1 5D8F15C0
P 9550 650
F 0 "J2" V 9612 794 50  0000 L CNN
F 1 "Conn_01x03_Male" V 9703 794 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Horizontal" H 9550 650 50  0001 C CNN
F 3 "~" H 9550 650 50  0001 C CNN
	1    9550 650 
	0    1    1    0   
$EndComp
Text GLabel 9450 1150 3    50   Input ~ 0
TX
Text GLabel 9550 1150 3    50   Output ~ 0
RX
Text GLabel 9650 1150 3    50   Input ~ 0
GND
Wire Wire Line
	9650 850  9650 1150
$Comp
L Connector_Generic:Conn_01x10 J3
U 1 1 5D90C3D5
P 3700 3400
F 0 "J3" H 3618 2675 50  0000 C CNN
F 1 "Conn_01x10" H 3618 2766 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x10_P2.54mm_Vertical" H 3700 3400 50  0001 C CNN
F 3 "~" H 3700 3400 50  0001 C CNN
	1    3700 3400
	-1   0    0    1   
$EndComp
Text GLabel 3900 3800 2    50   Input ~ 0
GND
Wire Wire Line
	4550 3700 3900 3700
Wire Wire Line
	3900 3600 4550 3600
Wire Wire Line
	3900 3100 4550 3100
Wire Wire Line
	3900 3000 4550 3000
Wire Wire Line
	4550 3200 3900 3200
Wire Wire Line
	4550 3300 3900 3300
Wire Wire Line
	4550 3500 3900 3500
Wire Wire Line
	3900 3400 4550 3400
Text GLabel 3900 2900 2    50   Input ~ 0
VCC
$Comp
L Jumper:Jumper_2_Open JP2
U 1 1 5DABECBD
P 1600 4650
F 0 "JP2" H 1600 4885 50  0000 C CNN
F 1 "Jumper_2_Open" H 1600 4794 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1600 4650 50  0001 C CNN
F 3 "~" H 1600 4650 50  0001 C CNN
	1    1600 4650
	1    0    0    1   
$EndComp
Text GLabel 1800 4650 2    50   Input ~ 0
RW
Wire Wire Line
	1400 4650 950  4650
Text GLabel 6600 2500 2    50   Output ~ 0
RW
Wire Wire Line
	6600 2500 6400 2500
Connection ~ 6400 2500
$EndSCHEMATC
