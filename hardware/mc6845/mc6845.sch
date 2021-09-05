EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 6100 1100 1000 1575
U 5F3BFE79
F0 "memory" 50
F1 "memory.sch" 50
F2 "D[7..0]" B R 7100 1300 50 
F3 "LD[7..0]" O R 7100 1450 50 
F4 "MA[11..0]" I L 6100 1300 50 
F5 "A[11..0]" I L 6100 1450 50 
F6 "CCLK" I L 6100 1700 50 
F7 "~VMEM" I L 6100 1900 50 
F8 "~WR" I L 6100 2100 50 
F9 "~RD" I L 6100 2250 50 
$EndSheet
Wire Bus Line
	7100 1300 7475 1300
Wire Bus Line
	7100 1450 7475 1450
$Comp
L 28c256:AT28C16 U10
U 1 1 5F45BF7E
P 8400 2200
F 0 "U10" H 8150 3300 50  0000 C CNN
F 1 "AT28C16" H 8650 3300 50  0000 C CNN
F 2 "Package_DIP:DIP-24_W15.24mm_LongPads" H 8400 2200 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf" H 8400 2200 50  0001 C CNN
	1    8400 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 1300 7650 1300
Wire Wire Line
	8000 1400 7650 1400
Wire Wire Line
	8000 1500 7650 1500
Wire Wire Line
	8000 1600 7650 1600
Wire Wire Line
	8000 1700 7650 1700
Wire Wire Line
	8000 1800 7650 1800
Wire Wire Line
	8000 1900 7650 1900
Wire Wire Line
	8000 2000 7650 2000
Text Label 7725 1300 0    50   ~ 0
LD0
Text Label 7725 1400 0    50   ~ 0
LD1
Text Label 7725 1500 0    50   ~ 0
LD2
Text Label 7725 1600 0    50   ~ 0
LD3
Text Label 7725 1700 0    50   ~ 0
LD4
Text Label 7725 1800 0    50   ~ 0
LD5
Text Label 7725 1900 0    50   ~ 0
LD6
Text Label 7725 2000 0    50   ~ 0
RA0
Text Label 7200 1450 0    50   ~ 0
LD[7..0]
Text Label 7200 1300 0    50   ~ 0
D[7..0]
Wire Wire Line
	8000 2100 7650 2100
Wire Wire Line
	8000 2200 7650 2200
Wire Wire Line
	8000 2300 7650 2300
Text Label 7725 2100 0    50   ~ 0
RA1
Text Label 7725 2200 0    50   ~ 0
RA2
Text Label 7725 2300 0    50   ~ 0
RA3
$Comp
L 74xx:74LS165 U17
U 1 1 5F45D7A8
P 9650 1800
F 0 "U17" H 9375 2600 50  0000 C CNN
F 1 "74LS165" H 9925 2600 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket_LongPads" H 9650 1800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS165" H 9650 1800 50  0001 C CNN
	1    9650 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8800 1300 9150 1300
Wire Wire Line
	8800 1400 9150 1400
Wire Wire Line
	8800 1500 9150 1500
Wire Wire Line
	8800 1600 9150 1600
Wire Wire Line
	8800 1700 9150 1700
Wire Wire Line
	8800 1800 9150 1800
Wire Wire Line
	8800 1900 9150 1900
Wire Wire Line
	8800 2000 9150 2000
$Comp
L 74xx:74LS163 U12
U 1 1 5F3D9AD1
P 5050 4750
F 0 "U12" H 5175 5550 50  0000 C CNN
F 1 "74LS163" H 5275 5450 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket_LongPads" H 5050 4750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS163" H 5050 4750 50  0001 C CNN
	1    5050 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4550 4550 4450
Wire Wire Line
	4550 4450 4550 4350
Connection ~ 4550 4450
$Comp
L power:GND #PWR013
U 1 1 5F3DD76E
P 4400 4250
F 0 "#PWR013" H 4400 4000 50  0001 C CNN
F 1 "GND" H 4405 4077 50  0000 C CNN
F 2 "" H 4400 4250 50  0001 C CNN
F 3 "" H 4400 4250 50  0001 C CNN
	1    4400 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4950 4550 4850
Wire Wire Line
	4550 4850 4550 4750
Connection ~ 4550 4850
Connection ~ 4550 4750
$Comp
L power:+5V #PWR014
U 1 1 5F3DFDB1
P 4300 4750
F 0 "#PWR014" H 4300 4600 50  0001 C CNN
F 1 "+5V" H 4315 4923 50  0000 C CNN
F 2 "" H 4300 4750 50  0001 C CNN
F 3 "" H 4300 4750 50  0001 C CNN
	1    4300 4750
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR08
U 1 1 5F3DFE14
P 3550 4650
F 0 "#PWR08" H 3550 4500 50  0001 C CNN
F 1 "+5V" H 3565 4823 50  0000 C CNN
F 2 "" H 3550 4650 50  0001 C CNN
F 3 "" H 3550 4650 50  0001 C CNN
	1    3550 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 5F3DFE29
P 3550 5350
F 0 "#PWR09" H 3550 5100 50  0001 C CNN
F 1 "GND" H 3555 5177 50  0000 C CNN
F 2 "" H 3550 5350 50  0001 C CNN
F 3 "" H 3550 5350 50  0001 C CNN
	1    3550 5350
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR015
U 1 1 5F3DFE3E
P 5050 3950
F 0 "#PWR015" H 5050 3800 50  0001 C CNN
F 1 "+5V" H 5065 4123 50  0000 C CNN
F 2 "" H 5050 3950 50  0001 C CNN
F 3 "" H 5050 3950 50  0001 C CNN
	1    5050 3950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5F3DFE53
P 5050 5550
F 0 "#PWR016" H 5050 5300 50  0001 C CNN
F 1 "GND" H 5055 5377 50  0000 C CNN
F 2 "" H 5050 5550 50  0001 C CNN
F 3 "" H 5050 5550 50  0001 C CNN
	1    5050 5550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U13
U 1 1 5F3DFEFB
P 5125 5900
F 0 "U13" H 4875 5725 50  0000 C CNN
F 1 "74LS04" H 4800 5800 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 5125 5900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 5125 5900 50  0001 C CNN
	1    5125 5900
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5550 4550 5700 4550
Wire Wire Line
	5700 4550 5700 5100
Wire Wire Line
	5700 5900 5425 5900
Wire Wire Line
	4825 5900 4400 5900
Wire Wire Line
	4400 5250 4550 5250
Wire Wire Line
	4550 4350 4550 4250
Connection ~ 4550 4350
$Comp
L 74xx:74LS174 U16
U 1 1 5F3E2FBF
P 7350 4800
F 0 "U16" H 7450 5475 50  0000 C CNN
F 1 "74LS174" H 7550 5375 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket_LongPads" H 7350 4800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS174" H 7350 4800 50  0001 C CNN
	1    7350 4800
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS74 U15
U 1 1 5F3E428C
P 9975 4700
F 0 "U15" H 10150 5100 50  0000 C CNN
F 1 "74LS74" H 10200 5000 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9975 4700 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 9975 4700 50  0001 C CNN
	1    9975 4700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR028
U 1 1 5F3DA872
P 9650 2800
F 0 "#PWR028" H 9650 2550 50  0001 C CNN
F 1 "GND" H 9655 2627 50  0000 C CNN
F 2 "" H 9650 2800 50  0001 C CNN
F 3 "" H 9650 2800 50  0001 C CNN
	1    9650 2800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR026
U 1 1 5F3DA88D
P 8400 3300
F 0 "#PWR026" H 8400 3050 50  0001 C CNN
F 1 "GND" H 8405 3127 50  0000 C CNN
F 2 "" H 8400 3300 50  0001 C CNN
F 3 "" H 8400 3300 50  0001 C CNN
	1    8400 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6475 4400 6850 4400
Wire Wire Line
	6850 4600 6475 4600
$Comp
L power:+5V #PWR022
U 1 1 5F3DCAC1
P 7350 4100
F 0 "#PWR022" H 7350 3950 50  0001 C CNN
F 1 "+5V" H 7365 4273 50  0000 C CNN
F 2 "" H 7350 4100 50  0001 C CNN
F 3 "" H 7350 4100 50  0001 C CNN
	1    7350 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 4400 7850 3900
Wire Wire Line
	7850 3900 6800 3900
Wire Wire Line
	6800 3900 6800 4500
Wire Wire Line
	6800 4500 6850 4500
Wire Wire Line
	7850 4600 7925 4600
Wire Wire Line
	7925 4600 7925 3825
Wire Wire Line
	7925 3825 6725 3825
Wire Wire Line
	6725 3825 6725 4700
Wire Wire Line
	6725 4700 6850 4700
$Comp
L 74xx:74LS32 U11
U 1 1 5F3DF330
P 8525 4400
F 0 "U11" H 8525 4725 50  0000 C CNN
F 1 "74LS32" H 8525 4634 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 8525 4400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 8525 4400 50  0001 C CNN
	1    8525 4400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U14
U 1 1 5F3DF446
P 9125 4600
F 0 "U14" H 9125 4925 50  0000 C CNN
F 1 "74LS08" H 9125 4834 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9125 4600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 9125 4600 50  0001 C CNN
	1    9125 4600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U13
U 2 1 5F3DF562
P 9150 5125
F 0 "U13" H 9150 5442 50  0000 C CNN
F 1 "74LS04" H 9150 5351 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9150 5125 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 5125 50  0001 C CNN
	2    9150 5125
	1    0    0    -1  
$EndComp
Wire Wire Line
	8225 4500 7850 4500
Wire Wire Line
	8100 4300 8225 4300
Wire Wire Line
	8825 4400 8825 4500
Wire Wire Line
	7850 4700 8825 4700
Wire Wire Line
	9675 4600 9425 4600
Wire Wire Line
	9675 4700 9550 4700
Wire Wire Line
	9550 4700 9550 5125
Wire Wire Line
	9550 5125 9450 5125
Wire Wire Line
	5550 4450 6000 4450
Text Label 5775 4450 0    50   ~ 0
MCLK
Text Label 4150 5050 0    50   ~ 0
PCLK
Wire Wire Line
	8850 5125 8575 5125
Text Label 8650 5125 0    50   ~ 0
PCLK
$Comp
L 74xx:74LS08 U14
U 5 1 5F42F8A3
P 5125 6975
F 0 "U14" H 5355 7021 50  0000 L CNN
F 1 "74LS08" H 5355 6930 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 5125 6975 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 5125 6975 50  0001 C CNN
	5    5125 6975
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS74 U15
U 3 1 5F42F9DB
P 6125 6975
F 0 "U15" H 6325 7475 50  0000 C CNN
F 1 "74LS74" H 6400 7375 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 6125 6975 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 6125 6975 50  0001 C CNN
	3    6125 6975
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR011
U 1 1 5F42FC6C
P 4250 6475
F 0 "#PWR011" H 4250 6325 50  0001 C CNN
F 1 "+5V" H 4265 6648 50  0000 C CNN
F 2 "" H 4250 6475 50  0001 C CNN
F 3 "" H 4250 6475 50  0001 C CNN
	1    4250 6475
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR017
U 1 1 5F42FC93
P 5125 6475
F 0 "#PWR017" H 5125 6325 50  0001 C CNN
F 1 "+5V" H 5140 6648 50  0000 C CNN
F 2 "" H 5125 6475 50  0001 C CNN
F 3 "" H 5125 6475 50  0001 C CNN
	1    5125 6475
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR019
U 1 1 5F42FCBA
P 6125 6575
F 0 "#PWR019" H 6125 6425 50  0001 C CNN
F 1 "+5V" H 6140 6748 50  0000 C CNN
F 2 "" H 6125 6575 50  0001 C CNN
F 3 "" H 6125 6575 50  0001 C CNN
	1    6125 6575
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 5F42FCE1
P 7350 5600
F 0 "#PWR023" H 7350 5350 50  0001 C CNN
F 1 "GND" H 7355 5427 50  0000 C CNN
F 2 "" H 7350 5600 50  0001 C CNN
F 3 "" H 7350 5600 50  0001 C CNN
	1    7350 5600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR012
U 1 1 5F42FD08
P 4250 7475
F 0 "#PWR012" H 4250 7225 50  0001 C CNN
F 1 "GND" H 4255 7302 50  0000 C CNN
F 2 "" H 4250 7475 50  0001 C CNN
F 3 "" H 4250 7475 50  0001 C CNN
	1    4250 7475
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 5F42FD2F
P 5125 7475
F 0 "#PWR018" H 5125 7225 50  0001 C CNN
F 1 "GND" H 5130 7302 50  0000 C CNN
F 2 "" H 5125 7475 50  0001 C CNN
F 3 "" H 5125 7475 50  0001 C CNN
	1    5125 7475
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 5F42FD56
P 6125 7375
F 0 "#PWR020" H 6125 7125 50  0001 C CNN
F 1 "GND" H 6130 7202 50  0000 C CNN
F 2 "" H 6125 7375 50  0001 C CNN
F 3 "" H 6125 7375 50  0001 C CNN
	1    6125 7375
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR029
U 1 1 5F42FDFB
P 9975 4275
F 0 "#PWR029" H 9975 4125 50  0001 C CNN
F 1 "+5V" H 9990 4448 50  0000 C CNN
F 2 "" H 9975 4275 50  0001 C CNN
F 3 "" H 9975 4275 50  0001 C CNN
	1    9975 4275
	1    0    0    -1  
$EndComp
Wire Wire Line
	9975 5000 9625 5000
Wire Wire Line
	9625 5000 9625 4375
Wire Wire Line
	9625 4375 9975 4375
Wire Wire Line
	9975 4275 9975 4375
Wire Wire Line
	9975 4375 9975 4400
Connection ~ 9975 4375
Wire Wire Line
	10275 4600 10550 4600
Text Label 6475 4600 0    50   ~ 0
DE
Text Label 6475 4400 0    50   ~ 0
CURSOR
$Comp
L 74xx:74LS08 U14
U 3 1 5F441498
P 9975 6100
F 0 "U14" H 9975 6425 50  0000 C CNN
F 1 "74LS08" H 9975 6334 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9975 6100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 9975 6100 50  0001 C CNN
	3    9975 6100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U14
U 2 1 5F44168B
P 9975 5450
F 0 "U14" H 9975 5775 50  0000 C CNN
F 1 "74LS08" H 9975 5684 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9975 5450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 9975 5450 50  0001 C CNN
	2    9975 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9675 5350 9675 5450
Wire Wire Line
	9675 6000 9675 6100
Wire Wire Line
	9675 5450 9425 5450
Connection ~ 9675 5450
Wire Wire Line
	9675 5450 9675 5550
Wire Wire Line
	9675 6100 9425 6100
Connection ~ 9675 6100
Wire Wire Line
	9675 6100 9675 6200
Text Label 9475 5450 0    50   ~ 0
HS
Text Label 9475 6100 0    50   ~ 0
VS
Wire Wire Line
	10275 6100 10575 6100
Wire Wire Line
	10275 5450 10575 5450
Text Label 3300 2450 0    50   ~ 0
MCLK
Wire Wire Line
	3300 2450 3550 2450
Text Label 3300 2250 0    50   ~ 0
~RST
Text Label 3300 2150 0    50   ~ 0
~IORQ
Text Label 3300 2050 0    50   ~ 0
A0
Text Label 3300 1950 0    50   ~ 0
~CRT
Text Label 3300 1850 0    50   ~ 0
~WR
Wire Wire Line
	3550 2250 3300 2250
Wire Wire Line
	3550 2150 3300 2150
Wire Wire Line
	3550 2050 3300 2050
Wire Wire Line
	3550 1950 3300 1950
Wire Wire Line
	3550 1850 3300 1850
Text Label 3300 1650 0    50   ~ 0
D7
Text Label 3300 1550 0    50   ~ 0
D6
Wire Wire Line
	3550 1650 3300 1650
Wire Wire Line
	3550 1550 3300 1550
Text Label 3300 1450 0    50   ~ 0
D5
Text Label 3300 1350 0    50   ~ 0
D4
Wire Wire Line
	3550 1450 3300 1450
Wire Wire Line
	3550 1350 3300 1350
Text Label 3300 1250 0    50   ~ 0
D3
Text Label 3300 1150 0    50   ~ 0
D2
Wire Wire Line
	3550 1250 3300 1250
Wire Wire Line
	3550 1150 3300 1150
Text Label 3300 1050 0    50   ~ 0
D1
Text Label 3300 950  0    50   ~ 0
D0
Wire Wire Line
	3550 1050 3300 1050
Wire Wire Line
	3550 950  3300 950 
Text Label 4850 3350 0    50   ~ 0
CURSOR
Text Label 4850 3250 0    50   ~ 0
VS
Text Label 4850 3150 0    50   ~ 0
HS
Text Label 4850 3050 0    50   ~ 0
DE
Wire Wire Line
	4750 3350 5175 3350
Wire Wire Line
	4750 3250 5175 3250
Wire Wire Line
	4750 3150 5175 3150
Wire Wire Line
	4750 3050 5175 3050
Text Label 4875 2750 0    50   ~ 0
RA3
Text Label 4875 2650 0    50   ~ 0
RA2
Text Label 4875 2550 0    50   ~ 0
RA1
Text Label 4875 2450 0    50   ~ 0
RA0
Wire Wire Line
	4750 2750 5175 2750
Wire Wire Line
	4750 2650 5175 2650
Wire Wire Line
	4750 2550 5175 2550
Wire Wire Line
	4750 2450 5175 2450
Text Label 5075 2050 2    50   ~ 0
MA11
Wire Wire Line
	4750 2050 5175 2050
Text Label 5075 1950 2    50   ~ 0
MA10
Wire Wire Line
	4750 1950 5175 1950
Text Label 5075 1850 2    50   ~ 0
MA9
Wire Wire Line
	4750 1850 5175 1850
Text Label 5075 1750 2    50   ~ 0
MA8
Wire Wire Line
	4750 1750 5175 1750
Text Label 5075 1650 2    50   ~ 0
MA7
Wire Wire Line
	4750 1650 5175 1650
Text Label 5075 1550 2    50   ~ 0
MA6
Wire Wire Line
	4750 1550 5175 1550
Text Label 5075 1450 2    50   ~ 0
MA5
Wire Wire Line
	4750 1450 5175 1450
Text Label 5075 1350 2    50   ~ 0
MA4
Wire Wire Line
	4750 1350 5175 1350
Text Label 5075 1250 2    50   ~ 0
MA3
Wire Wire Line
	4750 1250 5175 1250
Text Label 5075 1150 2    50   ~ 0
MA2
Wire Wire Line
	4750 1150 5175 1150
Text Label 5075 1050 2    50   ~ 0
MA1
Wire Wire Line
	4750 1050 5175 1050
Text Label 5075 950  2    50   ~ 0
MA0
Wire Wire Line
	4750 950  5175 950 
$Comp
L GPU:MC6845 U1
U 1 1 5F3BC58A
P 4150 2150
F 0 "U1" H 4150 3728 50  0000 C CNN
F 1 "MC6845" H 4150 3637 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm" H 4200 800 50  0001 L CNN
F 3 "http://pdf.datasheetcatalog.com/datasheet_pdf/motorola/MC6845L_and_MC6845P.pdf" H 4150 2150 50  0001 C CNN
	1    4150 2150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5F520E31
P 4150 3550
F 0 "#PWR010" H 4150 3300 50  0001 C CNN
F 1 "GND" H 4155 3377 50  0000 C CNN
F 2 "" H 4150 3550 50  0001 C CNN
F 3 "" H 4150 3550 50  0001 C CNN
	1    4150 3550
	1    0    0    -1  
$EndComp
Text Notes 8075 750  0    75   ~ 0
CHAR GEN
Text Notes 6275 800  0    75   ~ 0
MEMORY
Text Notes 4450 650  0    75   ~ 0
CRTC
Text Notes 6850 3725 0    75   ~ 0
VIDEO
Text Notes 5400 3800 0    75   ~ 0
CLOCK
Text Notes 1100 700  0    75   ~ 0
CPU INTERFACE
$Comp
L power:+5V #PWR021
U 1 1 5F62BAE8
P 6650 5425
F 0 "#PWR021" H 6650 5275 50  0001 C CNN
F 1 "+5V" H 6665 5598 50  0000 C CNN
F 2 "" H 6650 5425 50  0001 C CNN
F 3 "" H 6650 5425 50  0001 C CNN
	1    6650 5425
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 5425 6850 5425
Wire Wire Line
	6850 5425 6850 5300
Wire Wire Line
	3550 4650 3550 4750
Wire Wire Line
	3550 4650 3250 4650
Wire Wire Line
	3250 4650 3250 5050
Connection ~ 3550 4650
Text Label 1650 3650 0    50   ~ 0
~RST
Text Label 1650 3550 0    50   ~ 0
~IORQ
Text Label 1650 3350 0    50   ~ 0
~CRT
Text Label 1050 2000 0    50   ~ 0
~WR
Wire Wire Line
	1900 3650 1650 3650
Wire Wire Line
	1900 3550 1650 3550
Wire Wire Line
	1900 3350 1650 3350
Wire Wire Line
	1300 2000 1050 2000
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J1
U 1 1 5F8F7D5D
P 1500 1900
F 0 "J1" H 1550 3017 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 1550 2926 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x20_P2.54mm_Vertical" H 1500 1900 50  0001 C CNN
F 3 "~" H 1500 1900 50  0001 C CNN
	1    1500 1900
	1    0    0    -1  
$EndComp
Text Label 1875 2700 0    50   ~ 0
A15
Wire Wire Line
	1800 2700 2100 2700
Text Label 1875 2600 0    50   ~ 0
A14
Wire Wire Line
	1800 2600 2100 2600
Text Label 1875 2500 0    50   ~ 0
A13
Wire Wire Line
	1800 2500 2100 2500
Text Label 1875 2400 0    50   ~ 0
A12
Wire Wire Line
	1800 2400 2100 2400
Text Label 1875 2300 0    50   ~ 0
A11
Wire Wire Line
	1800 2300 2100 2300
Text Label 1875 2200 0    50   ~ 0
A10
Wire Wire Line
	1800 2200 2100 2200
Text Label 1900 2100 0    50   ~ 0
A9
Wire Wire Line
	1800 2100 2100 2100
Text Label 1900 2000 0    50   ~ 0
A8
Wire Wire Line
	1800 2000 2100 2000
Text Label 1900 1800 0    50   ~ 0
A7
Wire Wire Line
	1800 1800 2100 1800
Text Label 1900 1700 0    50   ~ 0
A6
Wire Wire Line
	1800 1700 2100 1700
Text Label 1900 1600 0    50   ~ 0
A5
Wire Wire Line
	1800 1600 2100 1600
Text Label 1900 1500 0    50   ~ 0
A4
Wire Wire Line
	1800 1500 2100 1500
Text Label 1900 1400 0    50   ~ 0
A3
Wire Wire Line
	1800 1400 2100 1400
Text Label 1900 1300 0    50   ~ 0
A2
Wire Wire Line
	1800 1300 2100 1300
Text Label 1900 1200 0    50   ~ 0
A1
Wire Wire Line
	1800 1200 2100 1200
Text Label 1900 1100 0    50   ~ 0
A0
Wire Wire Line
	1800 1100 2100 1100
Wire Wire Line
	1300 1100 1050 1100
Wire Wire Line
	1300 1200 1050 1200
Text Label 1050 1100 0    50   ~ 0
D0
Text Label 1050 1200 0    50   ~ 0
D1
Wire Wire Line
	1300 1300 1050 1300
Wire Wire Line
	1300 1400 1050 1400
Text Label 1050 1300 0    50   ~ 0
D2
Text Label 1050 1400 0    50   ~ 0
D3
Wire Wire Line
	1300 1500 1050 1500
Wire Wire Line
	1300 1600 1050 1600
Text Label 1050 1500 0    50   ~ 0
D4
Text Label 1050 1600 0    50   ~ 0
D5
Wire Wire Line
	1300 1700 1050 1700
Wire Wire Line
	1300 1800 1050 1800
Text Label 1050 1700 0    50   ~ 0
D6
Text Label 1050 1800 0    50   ~ 0
D7
$Comp
L 74xx:74LS32 U11
U 5 1 5F42C5BC
P 4250 6975
F 0 "U11" H 4480 7021 50  0000 L CNN
F 1 "74LS32" H 4480 6930 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 4250 6975 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 4250 6975 50  0001 C CNN
	5    4250 6975
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 3450 1075 3450
Text Label 1200 3450 0    50   ~ 0
~MEM_WR
Wire Wire Line
	1500 3350 1075 3350
Text Label 1200 3350 0    50   ~ 0
~MEM_RD
Wire Wire Line
	1500 3550 1075 3550
Text Label 1200 3550 0    50   ~ 0
DIR
Text Label 1225 3650 0    50   ~ 0
~AS
Text Label 1200 3250 0    50   ~ 0
~RST
Wire Wire Line
	1500 3250 1075 3250
Wire Wire Line
	1075 3650 1500 3650
Wire Wire Line
	1300 2100 1050 2100
Text Label 1050 2100 0    50   ~ 0
~RD
Wire Wire Line
	1050 2200 1300 2200
Text Label 1050 2200 0    50   ~ 0
~IORQ
Wire Wire Line
	1300 2300 1050 2300
Text Label 1050 2300 0    50   ~ 0
~MREQ
Wire Wire Line
	1300 2400 1050 2400
Text Label 1050 2400 0    50   ~ 0
~CRTC
Wire Wire Line
	1050 2500 1300 2500
Text Label 1050 2500 0    50   ~ 0
~VMEM
Wire Wire Line
	1050 2800 1300 2800
Text Label 1050 2800 0    50   ~ 0
~RST
Wire Wire Line
	8000 3100 7850 3100
Wire Wire Line
	7850 3100 7850 3250
$Comp
L power:GND #PWR025
U 1 1 5FB6B467
P 7850 3250
F 0 "#PWR025" H 7850 3000 50  0001 C CNN
F 1 "GND" H 7855 3077 50  0000 C CNN
F 2 "" H 7850 3250 50  0001 C CNN
F 3 "" H 7850 3250 50  0001 C CNN
	1    7850 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 3100 7850 3000
Wire Wire Line
	7850 3000 8000 3000
Connection ~ 7850 3100
Wire Wire Line
	8000 2900 7850 2900
Wire Wire Line
	7850 2900 7850 2750
$Comp
L power:+5V #PWR024
U 1 1 5FB9C014
P 7850 2750
F 0 "#PWR024" H 7850 2600 50  0001 C CNN
F 1 "+5V" H 7865 2923 50  0000 C CNN
F 2 "" H 7850 2750 50  0001 C CNN
F 3 "" H 7850 2750 50  0001 C CNN
	1    7850 2750
	1    0    0    -1  
$EndComp
Text Label 4475 5900 0    50   ~ 0
CCLK
Wire Wire Line
	9150 2200 8850 2200
Text Label 8850 2200 0    50   ~ 0
CCLK
Wire Wire Line
	9150 2400 8850 2400
Text Label 8850 2400 0    50   ~ 0
PCLK
Wire Wire Line
	9150 2500 8975 2500
Wire Wire Line
	8975 2500 8975 2625
$Comp
L power:GND #PWR027
U 1 1 5FBE7CFD
P 8975 2625
F 0 "#PWR027" H 8975 2375 50  0001 C CNN
F 1 "GND" H 8980 2452 50  0000 C CNN
F 2 "" H 8975 2625 50  0001 C CNN
F 3 "" H 8975 2625 50  0001 C CNN
	1    8975 2625
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 5100 6850 5100
Connection ~ 5700 5100
Wire Wire Line
	5700 5100 5700 5900
Wire Wire Line
	1650 3250 1900 3250
Text Label 1650 3250 0    50   ~ 0
MEMCPU
Text Label 10550 4600 0    50   ~ 0
VIDEO
Text Label 10575 5450 0    50   ~ 0
HSYNC
Text Label 10575 6100 0    50   ~ 0
VSYNC
Wire Wire Line
	8100 3850 10450 3850
Wire Wire Line
	10450 3850 10450 1200
Wire Wire Line
	10150 1200 10450 1200
Wire Wire Line
	8100 3850 8100 4300
$Comp
L Oscillator:SG-8002DC X1
U 1 1 5FF4882E
P 3550 5050
F 0 "X1" H 2925 5025 50  0000 L CNN
F 1 "25.175MHz" H 2900 4925 50  0000 L CNN
F 2 "Package_DIP:DIP-8_W7.62mm_LongPads" H 4000 4700 50  0001 C CNN
F 3 "https://support.epson.biz/td/api/doc_check.php?mode=dl&lang=en&Parts=SG-8002DC" H 3450 5050 50  0001 C CNN
	1    3550 5050
	1    0    0    -1  
$EndComp
Wire Bus Line
	6100 1300 5700 1300
Text Label 5700 1300 0    50   ~ 0
MA[11..0]
Wire Bus Line
	6100 1450 5700 1450
Text Label 5700 1450 0    50   ~ 0
A[11..0]
Wire Wire Line
	6100 1700 5700 1700
Text Label 5700 1700 0    50   ~ 0
CCLK
Wire Wire Line
	6100 2100 5700 2100
Wire Wire Line
	6100 2250 5700 2250
Text Label 5700 2100 0    50   ~ 0
~WR
Text Label 5700 2250 0    50   ~ 0
~RD
Wire Wire Line
	6100 1900 5700 1900
Text Label 5700 1900 0    50   ~ 0
~VMEM
NoConn ~ 2100 2400
NoConn ~ 2100 2500
NoConn ~ 2100 2600
NoConn ~ 2100 2700
$Comp
L power:+5V #PWR?
U 1 1 616C70BA
P 8400 1100
F 0 "#PWR?" H 8400 950 50  0001 C CNN
F 1 "+5V" H 8415 1273 50  0000 C CNN
F 2 "" H 8400 1100 50  0001 C CNN
F 3 "" H 8400 1100 50  0001 C CNN
	1    8400 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 616C7808
P 9650 900
F 0 "#PWR?" H 9650 750 50  0001 C CNN
F 1 "+5V" H 9665 1073 50  0000 C CNN
F 2 "" H 9650 900 50  0001 C CNN
F 3 "" H 9650 900 50  0001 C CNN
	1    9650 900 
	1    0    0    -1  
$EndComp
Connection ~ 10450 1200
Wire Wire Line
	10450 1200 10450 1175
Wire Wire Line
	4550 4250 4400 4250
Connection ~ 4550 4250
Wire Wire Line
	4300 4750 4550 4750
Wire Wire Line
	4400 5250 4400 5900
Wire Wire Line
	3850 5050 4550 5050
$EndSCHEMATC
