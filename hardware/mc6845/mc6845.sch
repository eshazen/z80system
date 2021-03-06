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
S 6075 1100 1000 1575
U 5F3BFE79
F0 "memory" 50
F1 "memory.sch" 50
F2 "MA[15..0]" I L 6075 1300 50 
F3 "A[15..0]" I L 6075 1450 50 
F4 "D[7..0]" B R 7075 1300 50 
F5 "LD[7..0]" O R 7075 1450 50 
F6 "MMUX" I L 6075 1600 50 
F7 "nOE" I L 6075 1850 50 
F8 "nWE" I L 6075 1975 50 
F9 "DIR" I L 6075 2100 50 
F10 "nBE" I L 6075 2225 50 
F11 "CCLK" I L 6075 2350 50 
F12 "MA[15..0]" I L 6075 2500 50 
$EndSheet
Wire Bus Line
	6075 1300 5650 1300
Wire Bus Line
	6075 1450 5650 1450
Wire Bus Line
	7075 1300 7450 1300
Text Label 5975 1300 2    50   ~ 0
MA[15..0]
Wire Bus Line
	7075 1450 7450 1450
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
Text Label 7175 1450 0    50   ~ 0
LD[7..0]
Text Label 7175 1300 0    50   ~ 0
D[7..0]
Text Label 5675 1450 0    50   ~ 0
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
Text Label 3325 2475 0    50   ~ 0
MCLK
Wire Wire Line
	3325 2475 3575 2475
Text Label 3325 2275 0    50   ~ 0
~RST
Text Label 3325 2175 0    50   ~ 0
~IORQ
Text Label 3325 2075 0    50   ~ 0
A0
Text Label 3325 1975 0    50   ~ 0
~CRT
Text Label 3325 1875 0    50   ~ 0
~WR
Wire Wire Line
	3575 2275 3325 2275
Wire Wire Line
	3575 2175 3325 2175
Wire Wire Line
	3575 2075 3325 2075
Wire Wire Line
	3575 1975 3325 1975
Wire Wire Line
	3575 1875 3325 1875
Text Label 3325 1675 0    50   ~ 0
D7
Text Label 3325 1575 0    50   ~ 0
D6
Wire Wire Line
	3575 1675 3325 1675
Wire Wire Line
	3575 1575 3325 1575
Text Label 3325 1475 0    50   ~ 0
D5
Text Label 3325 1375 0    50   ~ 0
D4
Wire Wire Line
	3575 1475 3325 1475
Wire Wire Line
	3575 1375 3325 1375
Text Label 3325 1275 0    50   ~ 0
D3
Text Label 3325 1175 0    50   ~ 0
D2
Wire Wire Line
	3575 1275 3325 1275
Wire Wire Line
	3575 1175 3325 1175
Text Label 3325 1075 0    50   ~ 0
D1
Text Label 3325 975  0    50   ~ 0
D0
Wire Wire Line
	3575 1075 3325 1075
Wire Wire Line
	3575 975  3325 975 
Text Label 4875 3375 0    50   ~ 0
CURSOR
Text Label 4875 3275 0    50   ~ 0
VS
Text Label 4875 3175 0    50   ~ 0
HS
Text Label 4875 3075 0    50   ~ 0
DE
Wire Wire Line
	4775 3375 5200 3375
Wire Wire Line
	4775 3275 5200 3275
Wire Wire Line
	4775 3175 5200 3175
Wire Wire Line
	4775 3075 5200 3075
Text Label 4900 2775 0    50   ~ 0
RA3
Text Label 4900 2675 0    50   ~ 0
RA2
Text Label 4900 2575 0    50   ~ 0
RA1
Text Label 4900 2475 0    50   ~ 0
RA0
Wire Wire Line
	4775 2775 5200 2775
Wire Wire Line
	4775 2675 5200 2675
Wire Wire Line
	4775 2575 5200 2575
Wire Wire Line
	4775 2475 5200 2475
Text Label 5100 2075 2    50   ~ 0
MA11
Wire Wire Line
	4775 2075 5200 2075
Text Label 5100 1975 2    50   ~ 0
MA10
Wire Wire Line
	4775 1975 5200 1975
Text Label 5100 1875 2    50   ~ 0
MA9
Wire Wire Line
	4775 1875 5200 1875
Text Label 5100 1775 2    50   ~ 0
MA8
Wire Wire Line
	4775 1775 5200 1775
Text Label 5100 1675 2    50   ~ 0
MA7
Wire Wire Line
	4775 1675 5200 1675
Text Label 5100 1575 2    50   ~ 0
MA6
Wire Wire Line
	4775 1575 5200 1575
Text Label 5100 1475 2    50   ~ 0
MA5
Wire Wire Line
	4775 1475 5200 1475
Text Label 5100 1375 2    50   ~ 0
MA4
Wire Wire Line
	4775 1375 5200 1375
Text Label 5100 1275 2    50   ~ 0
MA3
Wire Wire Line
	4775 1275 5200 1275
Text Label 5100 1175 2    50   ~ 0
MA2
Wire Wire Line
	4775 1175 5200 1175
Text Label 5100 1075 2    50   ~ 0
MA1
Wire Wire Line
	4775 1075 5200 1075
Text Label 5100 975  2    50   ~ 0
MA0
Wire Wire Line
	4775 975  5200 975 
$Comp
L GPU:MC6845 U1
U 1 1 5F3BC58A
P 4175 2175
F 0 "U1" H 4175 3753 50  0000 C CNN
F 1 "MC6845" H 4175 3662 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm" H 4225 825 50  0001 L CNN
F 3 "http://pdf.datasheetcatalog.com/datasheet_pdf/motorola/MC6845L_and_MC6845P.pdf" H 4175 2175 50  0001 C CNN
	1    4175 2175
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5F520E31
P 4175 3575
F 0 "#PWR010" H 4175 3325 50  0001 C CNN
F 1 "GND" H 4180 3402 50  0000 C CNN
F 2 "" H 4175 3575 50  0001 C CNN
F 3 "" H 4175 3575 50  0001 C CNN
	1    4175 3575
	1    0    0    -1  
$EndComp
Text Notes 8075 750  0    75   ~ 0
CHAR GEN
Text Notes 6225 700  0    75   ~ 0
MEMORY
Text Notes 4475 675  0    75   ~ 0
CRTC
Text Notes 6850 3725 0    75   ~ 0
VIDEO
Text Notes 5400 3825 0    75   ~ 0
CLOCK
Text Notes 2600 4875 0    75   ~ 0
CPU INTERFACE
Wire Wire Line
	6075 2350 5650 2350
Text Label 5650 2350 0    50   ~ 0
CCLK
Wire Wire Line
	6075 1975 5650 1975
Text Label 5650 1975 0    50   ~ 0
~MEM_WR
Wire Wire Line
	6075 1850 5650 1850
Text Label 5650 1850 0    50   ~ 0
~MEM_RD
Wire Wire Line
	6075 2225 5650 2225
Text Label 5650 2225 0    50   ~ 0
~MEM_RD
Wire Wire Line
	6075 2100 5650 2100
Text Label 5650 2100 0    50   ~ 0
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
Text Label 1750 6250 0    50   ~ 0
~RST
Text Label 1750 6150 0    50   ~ 0
~IORQ
Text Label 1750 5950 0    50   ~ 0
~CRT
Text Label 2600 6300 0    50   ~ 0
~WR
Wire Wire Line
	2000 6250 1750 6250
Wire Wire Line
	2000 6150 1750 6150
Wire Wire Line
	2000 5950 1750 5950
Wire Wire Line
	2850 6300 2600 6300
Wire Wire Line
	4150 5075 4150 4400
Wire Wire Line
	4150 5075 4550 5075
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J1
U 1 1 5F8F7D5D
P 3050 6200
F 0 "J1" H 3100 7317 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 3100 7226 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x20_P2.54mm_Vertical" H 3050 6200 50  0001 C CNN
F 3 "~" H 3050 6200 50  0001 C CNN
	1    3050 6200
	1    0    0    -1  
$EndComp
Text Label 3450 7000 0    50   ~ 0
A15
Wire Wire Line
	3350 7000 3675 7000
Text Label 3450 6900 0    50   ~ 0
A14
Wire Wire Line
	3350 6900 3675 6900
Text Label 3450 6800 0    50   ~ 0
A13
Wire Wire Line
	3350 6800 3675 6800
Text Label 3450 6700 0    50   ~ 0
A12
Wire Wire Line
	3350 6700 3675 6700
Text Label 3450 6600 0    50   ~ 0
A11
Wire Wire Line
	3350 6600 3675 6600
Text Label 3450 6500 0    50   ~ 0
A10
Wire Wire Line
	3350 6500 3675 6500
Text Label 3450 6400 0    50   ~ 0
A9
Wire Wire Line
	3350 6400 3675 6400
Text Label 3450 6300 0    50   ~ 0
A8
Wire Wire Line
	3350 6300 3675 6300
Text Label 3450 6100 0    50   ~ 0
A7
Wire Wire Line
	3350 6100 3675 6100
Text Label 3450 6000 0    50   ~ 0
A6
Wire Wire Line
	3350 6000 3675 6000
Text Label 3450 5900 0    50   ~ 0
A5
Wire Wire Line
	3350 5900 3675 5900
Text Label 3450 5800 0    50   ~ 0
A4
Wire Wire Line
	3350 5800 3675 5800
Text Label 3450 5700 0    50   ~ 0
A3
Wire Wire Line
	3350 5700 3675 5700
Text Label 3450 5600 0    50   ~ 0
A2
Wire Wire Line
	3350 5600 3675 5600
Text Label 3450 5500 0    50   ~ 0
A1
Wire Wire Line
	3350 5500 3675 5500
Text Label 3450 5400 0    50   ~ 0
A0
Wire Wire Line
	3350 5400 3675 5400
Wire Wire Line
	2850 5400 2600 5400
Wire Wire Line
	2850 5500 2600 5500
Text Label 2600 5400 0    50   ~ 0
D0
Text Label 2600 5500 0    50   ~ 0
D1
Wire Wire Line
	2850 5600 2600 5600
Wire Wire Line
	2850 5700 2600 5700
Text Label 2600 5600 0    50   ~ 0
D2
Text Label 2600 5700 0    50   ~ 0
D3
Wire Wire Line
	2850 5800 2600 5800
Wire Wire Line
	2850 5900 2600 5900
Text Label 2600 5800 0    50   ~ 0
D4
Text Label 2600 5900 0    50   ~ 0
D5
Wire Wire Line
	2850 6000 2600 6000
Wire Wire Line
	2850 6100 2600 6100
Text Label 2600 6000 0    50   ~ 0
D6
Text Label 2600 6100 0    50   ~ 0
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
	1600 6050 1175 6050
Text Label 1300 6050 0    50   ~ 0
~MEM_WR
Wire Wire Line
	1600 5950 1175 5950
Text Label 1300 5950 0    50   ~ 0
~MEM_RD
Wire Wire Line
	1600 6150 1175 6150
Text Label 1300 6150 0    50   ~ 0
DIR
Text Label 1325 6250 0    50   ~ 0
~AS
Text Label 1300 5850 0    50   ~ 0
~RST
Wire Wire Line
	1600 5850 1175 5850
Wire Wire Line
	1175 6250 1600 6250
Wire Wire Line
	2850 6400 2600 6400
Text Label 2600 6400 0    50   ~ 0
~RD
Wire Wire Line
	2600 6500 2850 6500
Text Label 2600 6500 0    50   ~ 0
~IORQ
Wire Wire Line
	2850 6600 2600 6600
Text Label 2600 6600 0    50   ~ 0
~MREQ
Wire Wire Line
	2850 6700 2600 6700
Text Label 2600 6700 0    50   ~ 0
~DS0
Wire Wire Line
	2600 6800 2850 6800
Text Label 2600 6800 0    50   ~ 0
~DS1
Text Label 2600 6900 0    50   ~ 0
~DS2
Wire Wire Line
	2600 6900 2850 6900
Text Label 2600 7000 0    50   ~ 0
~DS3
Wire Wire Line
	2600 7000 2850 7000
Wire Wire Line
	2600 7100 2850 7100
Text Label 2600 7100 0    50   ~ 0
~RST
Text Notes 2050 850  0    75   ~ 0
ARDUINO\nINTERFACE
Wire Wire Line
	6075 1600 5650 1600
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
Text Label 5650 1600 0    50   ~ 0
MEMCPU
Wire Wire Line
	1750 5850 2000 5850
Text Label 1750 5850 0    50   ~ 0
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
Wire Bus Line
	6075 2500 5650 2500
Text Label 5650 2500 0    50   ~ 0
PAGE[2..0]
Text Notes 5425 2975 0    75   ~ 0
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
$EndSCHEMATC
