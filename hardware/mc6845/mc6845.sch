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
F2 "MA[15..0]" I L 6100 1300 50 
F3 "A[15..0]" I L 6100 1450 50 
F4 "D[7..0]" B R 7100 1300 50 
F5 "LD[7..0]" O R 7100 1450 50 
F6 "MMUX" I L 6100 1600 50 
F7 "nOE" I L 6100 1850 50 
F8 "nWE" I L 6100 1975 50 
F9 "DIR" I L 6100 2100 50 
F10 "nBE" I L 6100 2250 50 
F11 "CCLK" I L 6100 2400 50 
F12 "PAGE[0..2]" I L 6100 2550 50 
$EndSheet
Wire Bus Line
	6100 1300 5675 1300
Wire Bus Line
	6100 1450 5675 1450
Wire Bus Line
	7100 1300 7475 1300
Text Label 6000 1300 2    50   ~ 0
MA[15..0]
Wire Bus Line
	7100 1450 7475 1450
$Comp
L 28c256:AT28C16 U10
U 1 1 5F45BF7E
P 8400 2200
F 0 "U10" H 8400 3478 50  0000 C CNN
F 1 "AT28C16" H 8400 3387 50  0000 C CNN
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
Text Label 5700 1450 0    50   ~ 0
A[15..0]
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
P 9625 1800
F 0 "U17" H 9625 2878 50  0000 C CNN
F 1 "74LS165" H 9625 2787 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket_LongPads" H 9625 1800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS165" H 9625 1800 50  0001 C CNN
	1    9625 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8800 1300 9125 1300
Wire Wire Line
	8800 1400 9125 1400
Wire Wire Line
	8800 1500 9125 1500
Wire Wire Line
	8800 1600 9125 1600
Wire Wire Line
	8800 1700 9125 1700
Wire Wire Line
	8800 1800 9125 1800
Wire Wire Line
	8800 1900 9125 1900
Wire Wire Line
	8800 2000 9125 2000
$Comp
L 74xx:74LS163 U12
U 1 1 5F3D9AD1
P 5050 4775
F 0 "U12" H 5175 5575 50  0000 C CNN
F 1 "74LS163" H 5275 5475 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket_LongPads" H 5050 4775 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS163" H 5050 4775 50  0001 C CNN
	1    5050 4775
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4575 4550 4475
Wire Wire Line
	4550 4475 4550 4375
Connection ~ 4550 4475
Wire Wire Line
	4550 4275 4375 4275
$Comp
L power:GND #PWR013
U 1 1 5F3DD76E
P 4375 4275
F 0 "#PWR013" H 4375 4025 50  0001 C CNN
F 1 "GND" H 4380 4102 50  0000 C CNN
F 2 "" H 4375 4275 50  0001 C CNN
F 3 "" H 4375 4275 50  0001 C CNN
	1    4375 4275
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4975 4550 4875
Wire Wire Line
	4550 4875 4550 4775
Connection ~ 4550 4875
Wire Wire Line
	4550 4775 4375 4775
Connection ~ 4550 4775
$Comp
L power:+5V #PWR014
U 1 1 5F3DFDB1
P 4375 4775
F 0 "#PWR014" H 4375 4625 50  0001 C CNN
F 1 "+5V" H 4390 4948 50  0000 C CNN
F 2 "" H 4375 4775 50  0001 C CNN
F 3 "" H 4375 4775 50  0001 C CNN
	1    4375 4775
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR08
U 1 1 5F3DFE14
P 3850 4000
F 0 "#PWR08" H 3850 3850 50  0001 C CNN
F 1 "+5V" H 3865 4173 50  0000 C CNN
F 2 "" H 3850 4000 50  0001 C CNN
F 3 "" H 3850 4000 50  0001 C CNN
	1    3850 4000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 5F3DFE29
P 3850 4700
F 0 "#PWR09" H 3850 4450 50  0001 C CNN
F 1 "GND" H 3855 4527 50  0000 C CNN
F 2 "" H 3850 4700 50  0001 C CNN
F 3 "" H 3850 4700 50  0001 C CNN
	1    3850 4700
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR015
U 1 1 5F3DFE3E
P 5050 3975
F 0 "#PWR015" H 5050 3825 50  0001 C CNN
F 1 "+5V" H 5065 4148 50  0000 C CNN
F 2 "" H 5050 3975 50  0001 C CNN
F 3 "" H 5050 3975 50  0001 C CNN
	1    5050 3975
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5F3DFE53
P 5050 5575
F 0 "#PWR016" H 5050 5325 50  0001 C CNN
F 1 "GND" H 5055 5402 50  0000 C CNN
F 2 "" H 5050 5575 50  0001 C CNN
F 3 "" H 5050 5575 50  0001 C CNN
	1    5050 5575
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U13
U 1 1 5F3DFEFB
P 5125 5925
F 0 "U13" H 4875 5750 50  0000 C CNN
F 1 "74LS04" H 4800 5825 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 5125 5925 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 5125 5925 50  0001 C CNN
	1    5125 5925
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5550 4575 5700 4575
Wire Wire Line
	5700 4575 5700 5125
Wire Wire Line
	5700 5925 5425 5925
Wire Wire Line
	4825 5925 4400 5925
Wire Wire Line
	4400 5925 4400 5275
Wire Wire Line
	4400 5275 4550 5275
Wire Wire Line
	4550 4375 4550 4275
Connection ~ 4550 4375
Connection ~ 4550 4275
$Comp
L 74xx:74LS174 U16
U 1 1 5F3E2FBF
P 7350 4825
F 0 "U16" H 7450 5500 50  0000 C CNN
F 1 "74LS174" H 7550 5400 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket_LongPads" H 7350 4825 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS174" H 7350 4825 50  0001 C CNN
	1    7350 4825
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS74 U15
U 1 1 5F3E428C
P 9975 4725
F 0 "U15" H 10150 5125 50  0000 C CNN
F 1 "74LS74" H 10200 5025 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9975 4725 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 9975 4725 50  0001 C CNN
	1    9975 4725
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR028
U 1 1 5F3DA872
P 9625 2800
F 0 "#PWR028" H 9625 2550 50  0001 C CNN
F 1 "GND" H 9630 2627 50  0000 C CNN
F 2 "" H 9625 2800 50  0001 C CNN
F 3 "" H 9625 2800 50  0001 C CNN
	1    9625 2800
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
	6475 4425 6850 4425
Wire Wire Line
	6850 4625 6475 4625
$Comp
L power:+5V #PWR022
U 1 1 5F3DCAC1
P 7350 4125
F 0 "#PWR022" H 7350 3975 50  0001 C CNN
F 1 "+5V" H 7365 4298 50  0000 C CNN
F 2 "" H 7350 4125 50  0001 C CNN
F 3 "" H 7350 4125 50  0001 C CNN
	1    7350 4125
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 4425 7850 3925
Wire Wire Line
	7850 3925 6800 3925
Wire Wire Line
	6800 3925 6800 4525
Wire Wire Line
	6800 4525 6850 4525
Wire Wire Line
	7850 4625 7925 4625
Wire Wire Line
	7925 4625 7925 3850
Wire Wire Line
	7925 3850 6725 3850
Wire Wire Line
	6725 3850 6725 4725
Wire Wire Line
	6725 4725 6850 4725
$Comp
L 74xx:74LS32 U11
U 1 1 5F3DF330
P 8525 4425
F 0 "U11" H 8525 4750 50  0000 C CNN
F 1 "74LS32" H 8525 4659 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 8525 4425 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 8525 4425 50  0001 C CNN
	1    8525 4425
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U14
U 1 1 5F3DF446
P 9125 4625
F 0 "U14" H 9125 4950 50  0000 C CNN
F 1 "74LS08" H 9125 4859 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9125 4625 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 9125 4625 50  0001 C CNN
	1    9125 4625
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U13
U 2 1 5F3DF562
P 9150 5150
F 0 "U13" H 9150 5467 50  0000 C CNN
F 1 "74LS04" H 9150 5376 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9150 5150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9150 5150 50  0001 C CNN
	2    9150 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8225 4525 7850 4525
Wire Wire Line
	8100 4325 8225 4325
Wire Wire Line
	8825 4425 8825 4525
Wire Wire Line
	7850 4725 8825 4725
Wire Wire Line
	9675 4625 9425 4625
Wire Wire Line
	9675 4725 9550 4725
Wire Wire Line
	9550 4725 9550 5150
Wire Wire Line
	9550 5150 9450 5150
Wire Wire Line
	5550 4475 6000 4475
Text Label 5775 4475 0    50   ~ 0
MCLK
Text Label 4300 5075 0    50   ~ 0
PCLK
Wire Wire Line
	8850 5150 8575 5150
Text Label 8650 5150 0    50   ~ 0
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
P 7350 5625
F 0 "#PWR023" H 7350 5375 50  0001 C CNN
F 1 "GND" H 7355 5452 50  0000 C CNN
F 2 "" H 7350 5625 50  0001 C CNN
F 3 "" H 7350 5625 50  0001 C CNN
	1    7350 5625
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
P 9975 4300
F 0 "#PWR029" H 9975 4150 50  0001 C CNN
F 1 "+5V" H 9990 4473 50  0000 C CNN
F 2 "" H 9975 4300 50  0001 C CNN
F 3 "" H 9975 4300 50  0001 C CNN
	1    9975 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9975 5025 9625 5025
Wire Wire Line
	9625 5025 9625 4400
Wire Wire Line
	9625 4400 9975 4400
Wire Wire Line
	9975 4300 9975 4400
Wire Wire Line
	9975 4400 9975 4425
Connection ~ 9975 4400
Wire Wire Line
	10275 4625 10550 4625
Text Label 6475 4625 0    50   ~ 0
DE
Text Label 6475 4425 0    50   ~ 0
CURSOR
$Comp
L 74xx:74LS08 U14
U 3 1 5F441498
P 9975 6125
F 0 "U14" H 9975 6450 50  0000 C CNN
F 1 "74LS08" H 9975 6359 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9975 6125 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 9975 6125 50  0001 C CNN
	3    9975 6125
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS08 U14
U 2 1 5F44168B
P 9975 5475
F 0 "U14" H 9975 5800 50  0000 C CNN
F 1 "74LS08" H 9975 5709 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_Socket_LongPads" H 9975 5475 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 9975 5475 50  0001 C CNN
	2    9975 5475
	1    0    0    -1  
$EndComp
Wire Wire Line
	9675 5375 9675 5475
Wire Wire Line
	9675 6025 9675 6125
Wire Wire Line
	9675 5475 9425 5475
Connection ~ 9675 5475
Wire Wire Line
	9675 5475 9675 5575
Wire Wire Line
	9675 6125 9425 6125
Connection ~ 9675 6125
Wire Wire Line
	9675 6125 9675 6225
Text Label 9475 5475 0    50   ~ 0
HS
Text Label 9475 6125 0    50   ~ 0
VS
Wire Wire Line
	10275 6125 10575 6125
Wire Wire Line
	10275 5475 10575 5475
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
Text Notes 5400 3825 0    75   ~ 0
CLOCK
Text Notes 1100 700  0    75   ~ 0
CPU INTERFACE
Wire Wire Line
	6100 2400 5675 2400
Text Label 5675 2400 0    50   ~ 0
CCLK
Wire Wire Line
	6100 1975 5675 1975
Text Label 5675 1975 0    50   ~ 0
~MEM_WR
Wire Wire Line
	6100 1850 5675 1850
Text Label 5675 1850 0    50   ~ 0
~MEM_RD
Wire Wire Line
	6100 2100 5675 2100
Text Label 5675 2100 0    50   ~ 0
DIR
$Comp
L power:+5V #PWR021
U 1 1 5F62BAE8
P 6650 5450
F 0 "#PWR021" H 6650 5300 50  0001 C CNN
F 1 "+5V" H 6665 5623 50  0000 C CNN
F 2 "" H 6650 5450 50  0001 C CNN
F 3 "" H 6650 5450 50  0001 C CNN
	1    6650 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 5450 6850 5450
Wire Wire Line
	6850 5450 6850 5325
Wire Wire Line
	3850 4000 3850 4100
Wire Wire Line
	3850 4000 3550 4000
Wire Wire Line
	3550 4000 3550 4400
Connection ~ 3850 4000
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
Wire Wire Line
	4150 5075 4150 4400
Wire Wire Line
	4150 5075 4550 5075
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
Text Label 1900 2700 0    50   ~ 0
A15
Wire Wire Line
	1800 2700 2125 2700
Text Label 1900 2600 0    50   ~ 0
A14
Wire Wire Line
	1800 2600 2125 2600
Text Label 1900 2500 0    50   ~ 0
A13
Wire Wire Line
	1800 2500 2125 2500
Text Label 1900 2400 0    50   ~ 0
A12
Wire Wire Line
	1800 2400 2125 2400
Text Label 1900 2300 0    50   ~ 0
A11
Wire Wire Line
	1800 2300 2125 2300
Text Label 1900 2200 0    50   ~ 0
A10
Wire Wire Line
	1800 2200 2125 2200
Text Label 1900 2100 0    50   ~ 0
A9
Wire Wire Line
	1800 2100 2125 2100
Text Label 1900 2000 0    50   ~ 0
A8
Wire Wire Line
	1800 2000 2125 2000
Text Label 1900 1800 0    50   ~ 0
A7
Wire Wire Line
	1800 1800 2125 1800
Text Label 1900 1700 0    50   ~ 0
A6
Wire Wire Line
	1800 1700 2125 1700
Text Label 1900 1600 0    50   ~ 0
A5
Wire Wire Line
	1800 1600 2125 1600
Text Label 1900 1500 0    50   ~ 0
A4
Wire Wire Line
	1800 1500 2125 1500
Text Label 1900 1400 0    50   ~ 0
A3
Wire Wire Line
	1800 1400 2125 1400
Text Label 1900 1300 0    50   ~ 0
A2
Wire Wire Line
	1800 1300 2125 1300
Text Label 1900 1200 0    50   ~ 0
A1
Wire Wire Line
	1800 1200 2125 1200
Text Label 1900 1100 0    50   ~ 0
A0
Wire Wire Line
	1800 1100 2125 1100
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
~DS0
Wire Wire Line
	1050 2500 1300 2500
Text Label 1050 2500 0    50   ~ 0
~DS1
Text Label 1050 2600 0    50   ~ 0
~DS2
Wire Wire Line
	1050 2600 1300 2600
Text Label 1050 2700 0    50   ~ 0
~DS3
Wire Wire Line
	1050 2700 1300 2700
Wire Wire Line
	1050 2800 1300 2800
Text Label 1050 2800 0    50   ~ 0
~RST
Wire Wire Line
	6100 1600 5675 1600
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
Text Label 4475 5925 0    50   ~ 0
CCLK
Wire Wire Line
	9125 2200 8850 2200
Text Label 8850 2200 0    50   ~ 0
CCLK
Wire Wire Line
	9125 2400 8850 2400
Text Label 8850 2400 0    50   ~ 0
PCLK
Wire Wire Line
	9125 2500 8975 2500
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
	5700 5125 6850 5125
Connection ~ 5700 5125
Wire Wire Line
	5700 5125 5700 5925
Text Label 5675 1600 0    50   ~ 0
MEMCPU
Wire Wire Line
	1650 3250 1900 3250
Text Label 1650 3250 0    50   ~ 0
MEMCPU
Text Label 10550 4625 0    50   ~ 0
VIDEO
Text Label 10575 5475 0    50   ~ 0
HSYNC
Text Label 10575 6125 0    50   ~ 0
VSYNC
Wire Wire Line
	8100 3875 10450 3875
Wire Wire Line
	10450 3875 10450 1200
Wire Wire Line
	10125 1200 10450 1200
Wire Wire Line
	8100 3875 8100 4325
Text Notes 5450 2975 0    75   ~ 0
MA[15..12] to mux (RA, latch)
$Comp
L Oscillator:SG-8002DC X1
U 1 1 5FF4882E
P 3850 4400
F 0 "X1" H 3225 4375 50  0000 L CNN
F 1 "25.175MHz" H 3200 4275 50  0000 L CNN
F 2 "Package_DIP:DIP-8_W7.62mm_LongPads" H 4300 4050 50  0001 C CNN
F 3 "https://support.epson.biz/td/api/doc_check.php?mode=dl&lang=en&Parts=SG-8002DC" H 3750 4400 50  0001 C CNN
	1    3850 4400
	1    0    0    -1  
$EndComp
Text Label 5675 2250 0    50   ~ 0
~MEM_RD
Wire Wire Line
	6100 2250 5675 2250
$Comp
L 74xx:74LS157 U?
U 1 1 61360719
P 3000 6100
F 0 "U?" H 3000 7181 50  0000 C CNN
F 1 "74LS157" H 3000 7090 50  0000 C CNN
F 2 "" H 3000 6100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 3000 6100 50  0001 C CNN
	1    3000 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 5500 3850 5500
Wire Wire Line
	3500 5800 3850 5800
Wire Wire Line
	3500 6100 3850 6100
Wire Wire Line
	3500 6400 3850 6400
Text Label 3550 5500 0    50   ~ 0
MA12
Text Label 3550 5800 0    50   ~ 0
MA13
Text Label 3550 6100 0    50   ~ 0
MA14
Text Label 3550 6400 0    50   ~ 0
MA15
Wire Wire Line
	2500 5500 2250 5500
Wire Wire Line
	2500 5800 2250 5800
Wire Wire Line
	2500 6100 2250 6100
Wire Wire Line
	2500 6400 2250 6400
Text Label 2250 5500 0    50   ~ 0
RA0
Text Label 2250 5800 0    50   ~ 0
RA1
Text Label 2250 6100 0    50   ~ 0
RA2
Text Label 2250 6400 0    50   ~ 0
RA3
$Comp
L 74xx:74LS374 U?
U 1 1 61469559
P 1250 6100
F 0 "U?" H 1250 7081 50  0000 C CNN
F 1 "74LS374" H 1250 6990 50  0000 C CNN
F 2 "" H 1250 6100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS374" H 1250 6100 50  0001 C CNN
	1    1250 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 5600 2500 5600
Wire Wire Line
	1750 5700 2200 5700
Wire Wire Line
	2200 5700 2200 5900
Wire Wire Line
	2200 5900 2500 5900
Wire Wire Line
	1750 5800 2150 5800
Wire Wire Line
	2150 5800 2150 6200
Wire Wire Line
	2150 6200 2500 6200
Wire Wire Line
	750  5600 550  5600
Wire Wire Line
	750  5700 550  5700
Wire Wire Line
	750  5800 550  5800
Wire Wire Line
	750  5900 550  5900
Wire Wire Line
	750  6000 550  6000
Wire Wire Line
	750  6100 550  6100
Wire Wire Line
	750  6200 550  6200
Wire Wire Line
	750  6300 550  6300
Text Label 550  5600 0    50   ~ 0
D0
Text Label 550  5700 0    50   ~ 0
D1
Text Label 550  5800 0    50   ~ 0
D2
Text Label 550  5900 0    50   ~ 0
D3
Text Label 550  6000 0    50   ~ 0
D4
Text Label 550  6100 0    50   ~ 0
D5
Text Label 550  6200 0    50   ~ 0
D6
Text Label 550  6300 0    50   ~ 0
D7
Wire Wire Line
	1750 5900 2100 5900
Wire Wire Line
	2100 5900 2100 6500
Wire Wire Line
	2100 6500 2500 6500
Text Label 5600 2550 0    50   ~ 0
PAGE[0..2]
Wire Bus Line
	5550 2550 6100 2550
Wire Wire Line
	1750 6000 2050 6000
Wire Wire Line
	1750 6100 2050 6100
Wire Wire Line
	1750 6200 2050 6200
Text Label 1800 6000 0    50   ~ 0
PAGE0
Text Label 1800 6100 0    50   ~ 0
PAGE1
Text Label 1800 6200 0    50   ~ 0
PAGE2
$EndSCHEMATC
