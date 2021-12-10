EESchema Schematic File Version 4
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
L Connector_Generic:Conn_01x33 J5
U 1 1 5FCA4B81
P 10775 3500
F 0 "J5" H 10300 5450 50  0000 L CNN
F 1 "Conn_01x33" H 10275 5350 50  0000 L CNN
F 2 "lcd_adapter:FH12-33S-0.5" H 10775 3500 50  0001 C CNN
F 3 "~" H 10775 3500 50  0001 C CNN
F 4 "FH12-33S-0.5SH(55)" H 10675 5250 50  0000 C CNN "MfgNo"
F 5 "798-FH12-33S-0.5SH55" H 10775 3500 50  0001 C CNN "CatNo"
F 6 "Mouser" H 10775 3500 50  0001 C CNN "Supplier"
	1    10775 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	10575 1900 10450 1900
Wire Wire Line
	10450 1900 10450 2300
Wire Wire Line
	10450 2300 10575 2300
Wire Wire Line
	10450 2300 10450 3000
Wire Wire Line
	10450 3000 10575 3000
Connection ~ 10450 2300
Wire Wire Line
	10450 3000 10450 3700
Wire Wire Line
	10450 3700 10575 3700
Connection ~ 10450 3000
Wire Wire Line
	10450 3700 10450 4400
Wire Wire Line
	10450 4400 10575 4400
Connection ~ 10450 3700
Wire Wire Line
	10450 4400 10450 4900
Connection ~ 10450 4400
Wire Wire Line
	10575 2000 9800 2000
Text Label 9800 2000 0    50   ~ 0
LCD_CLK
Wire Wire Line
	10575 2100 9800 2100
Text Label 9800 2100 0    50   ~ 0
LCD_HS
Wire Wire Line
	10575 2200 9800 2200
Text Label 9800 2200 0    50   ~ 0
LCD_VS
Wire Wire Line
	10575 2400 9800 2400
Wire Wire Line
	10575 2500 9800 2500
Wire Wire Line
	10575 2600 9800 2600
Wire Wire Line
	10575 2700 9800 2700
Wire Wire Line
	10575 2800 9800 2800
Wire Wire Line
	10575 2900 9800 2900
Text Label 9800 2400 0    50   ~ 0
LCD_R0
Text Label 9800 2500 0    50   ~ 0
LCD_R1
Wire Wire Line
	10575 3100 9800 3100
Wire Wire Line
	10575 3200 9800 3200
Wire Wire Line
	10575 3300 9800 3300
Wire Wire Line
	10575 3400 9800 3400
Wire Wire Line
	10575 3500 9800 3500
Wire Wire Line
	10575 3600 9800 3600
Wire Wire Line
	10575 3800 9800 3800
Wire Wire Line
	10575 3900 9800 3900
Wire Wire Line
	10575 4000 9800 4000
Wire Wire Line
	10575 4100 9800 4100
Wire Wire Line
	10575 4200 9800 4200
Wire Wire Line
	10575 4300 9800 4300
Text Label 9800 2600 0    50   ~ 0
LCD_R2
Text Label 9800 2700 0    50   ~ 0
LCD_R3
Text Label 9800 2800 0    50   ~ 0
LCD_R4
Text Label 9800 2900 0    50   ~ 0
LCD_R5
Text Label 9800 3100 0    50   ~ 0
LCD_G0
Text Label 9800 3200 0    50   ~ 0
LCD_G1
Text Label 9800 3300 0    50   ~ 0
LCD_G2
Text Label 9800 3400 0    50   ~ 0
LCD_G3
Text Label 9800 3500 0    50   ~ 0
LCD_G4
Text Label 9800 3600 0    50   ~ 0
LCD_G5
Text Label 9800 3800 0    50   ~ 0
LCD_B0
Text Label 9800 3900 0    50   ~ 0
LCD_B1
Text Label 9800 4000 0    50   ~ 0
LCD_B2
Text Label 9800 4100 0    50   ~ 0
LCD_B3
Text Label 9800 4200 0    50   ~ 0
LCD_B4
Text Label 9800 4300 0    50   ~ 0
LCD_B5
Wire Wire Line
	10575 4500 9800 4500
Wire Wire Line
	10575 4600 10325 4600
Wire Wire Line
	10325 4600 10325 4700
Wire Wire Line
	10325 4700 10575 4700
Wire Wire Line
	10575 4800 9800 4800
Text Label 9800 4500 0    50   ~ 0
LCD_DEN
Text Label 9800 4800 0    50   ~ 0
LCD_REV
Wire Wire Line
	10575 4900 10450 4900
Connection ~ 10450 4900
Wire Wire Line
	10450 4900 10450 5100
Wire Wire Line
	10575 5100 10450 5100
Connection ~ 10450 5100
Wire Wire Line
	10450 5100 10450 5350
Wire Wire Line
	10575 5000 9800 5000
Text Label 9800 5000 0    50   ~ 0
LCD_DISP
Wire Wire Line
	10325 4700 10175 4700
Connection ~ 10325 4700
$Comp
L power:+3.3V #PWR0102
U 1 1 5FCAF977
P 10175 4700
F 0 "#PWR0102" H 10175 4550 50  0001 C CNN
F 1 "+3.3V" H 9975 4775 50  0000 C CNN
F 2 "" H 10175 4700 50  0001 C CNN
F 3 "" H 10175 4700 50  0001 C CNN
	1    10175 4700
	1    0    0    -1  
$EndComp
$Comp
L Connector:DB15_Female J4
U 1 1 5FCB0467
P 9075 5000
F 0 "J4" H 8900 6000 50  0000 L CNN
F 1 "DB15_Female" H 8875 5900 50  0000 L CNN
F 2 "Connector_Dsub:DSUB-15-HD_Female_Horizontal_P2.29x1.98mm_EdgePinOffset9.40mm" H 9075 5000 50  0001 C CNN
F 3 " ~" H 9075 5000 50  0001 C CNN
	1    9075 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:R_US R1
U 1 1 5FCB5487
P 7625 3525
F 0 "R1" V 7575 3650 50  0000 C CNN
F 1 "4k" V 7575 3325 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 3515 50  0001 C CNN
F 3 "~" H 7625 3525 50  0001 C CNN
	1    7625 3525
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R2
U 1 1 5FCB5E72
P 7625 3675
F 0 "R2" V 7575 3800 50  0000 C CNN
F 1 "2k" V 7575 3475 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 3665 50  0001 C CNN
F 3 "~" H 7625 3675 50  0001 C CNN
	1    7625 3675
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R3
U 1 1 5FCB6817
P 7625 3825
F 0 "R3" V 7575 3950 50  0000 C CNN
F 1 "1k" V 7575 3625 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 3815 50  0001 C CNN
F 3 "~" H 7625 3825 50  0001 C CNN
	1    7625 3825
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R4
U 1 1 5FCB6BF9
P 7625 3975
F 0 "R4" V 7575 4100 50  0000 C CNN
F 1 "510" V 7575 3775 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 3965 50  0001 C CNN
F 3 "~" H 7625 3975 50  0001 C CNN
	1    7625 3975
	0    1    1    0   
$EndComp
Wire Wire Line
	7775 3525 7875 3525
Wire Wire Line
	7875 3525 7875 3675
Wire Wire Line
	7875 3675 7775 3675
Wire Wire Line
	7875 3675 7875 3825
Wire Wire Line
	7875 3825 7775 3825
Connection ~ 7875 3675
Wire Wire Line
	7875 3825 7875 3975
Wire Wire Line
	7875 3975 7775 3975
Connection ~ 7875 3825
$Comp
L Device:R_US R5
U 1 1 5FCBF8DD
P 7625 4175
F 0 "R5" V 7575 4300 50  0000 C CNN
F 1 "4k" V 7575 3975 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 4165 50  0001 C CNN
F 3 "~" H 7625 4175 50  0001 C CNN
	1    7625 4175
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R6
U 1 1 5FCBFA6F
P 7625 4325
F 0 "R6" V 7575 4450 50  0000 C CNN
F 1 "2k" V 7575 4125 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 4315 50  0001 C CNN
F 3 "~" H 7625 4325 50  0001 C CNN
	1    7625 4325
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R7
U 1 1 5FCBFA79
P 7625 4475
F 0 "R7" V 7575 4600 50  0000 C CNN
F 1 "1k" V 7575 4275 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 4465 50  0001 C CNN
F 3 "~" H 7625 4475 50  0001 C CNN
	1    7625 4475
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R8
U 1 1 5FCBFA83
P 7625 4625
F 0 "R8" V 7575 4750 50  0000 C CNN
F 1 "510" V 7575 4425 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 4615 50  0001 C CNN
F 3 "~" H 7625 4625 50  0001 C CNN
	1    7625 4625
	0    1    1    0   
$EndComp
Wire Wire Line
	7775 4175 7875 4175
Wire Wire Line
	7875 4175 7875 4325
Wire Wire Line
	7875 4325 7775 4325
Wire Wire Line
	7875 4325 7875 4475
Wire Wire Line
	7875 4475 7775 4475
Connection ~ 7875 4325
Wire Wire Line
	7875 4475 7875 4625
Wire Wire Line
	7875 4625 7775 4625
Connection ~ 7875 4475
$Comp
L Device:R_US R9
U 1 1 5FCC31CE
P 7625 4800
F 0 "R9" V 7575 4925 50  0000 C CNN
F 1 "4k" V 7575 4600 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 4790 50  0001 C CNN
F 3 "~" H 7625 4800 50  0001 C CNN
	1    7625 4800
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R10
U 1 1 5FCC33C0
P 7625 4950
F 0 "R10" V 7575 5075 50  0000 C CNN
F 1 "2k" V 7575 4750 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 4940 50  0001 C CNN
F 3 "~" H 7625 4950 50  0001 C CNN
	1    7625 4950
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R11
U 1 1 5FCC33CA
P 7625 5100
F 0 "R11" V 7575 5225 50  0000 C CNN
F 1 "1k" V 7575 4900 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 5090 50  0001 C CNN
F 3 "~" H 7625 5100 50  0001 C CNN
	1    7625 5100
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R12
U 1 1 5FCC33D4
P 7625 5250
F 0 "R12" V 7575 5375 50  0000 C CNN
F 1 "510" V 7575 5050 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 5240 50  0001 C CNN
F 3 "~" H 7625 5250 50  0001 C CNN
	1    7625 5250
	0    1    1    0   
$EndComp
Wire Wire Line
	7775 4800 7875 4800
Wire Wire Line
	7875 4800 7875 4950
Wire Wire Line
	7875 4950 7775 4950
Wire Wire Line
	7875 4950 7875 5100
Wire Wire Line
	7875 5100 7775 5100
Connection ~ 7875 4950
Wire Wire Line
	7875 5100 7875 5250
Wire Wire Line
	7875 5250 7775 5250
Connection ~ 7875 5100
Wire Wire Line
	7475 5250 6900 5250
Wire Wire Line
	8775 4300 8775 3975
Wire Wire Line
	8775 3975 7875 3975
Connection ~ 7875 3975
Wire Wire Line
	8775 4500 7975 4500
Wire Wire Line
	7975 4500 7975 4625
Wire Wire Line
	7975 4625 7875 4625
Connection ~ 7875 4625
Wire Wire Line
	8775 4700 8050 4700
Wire Wire Line
	8050 4700 8050 4800
Wire Wire Line
	8050 4800 7875 4800
Connection ~ 7875 4800
$Comp
L Device:R_US R13
U 1 1 5FCD08EB
P 7625 5525
F 0 "R13" V 7575 5650 50  0000 C CNN
F 1 "100" V 7575 5325 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 5515 50  0001 C CNN
F 3 "~" H 7625 5525 50  0001 C CNN
	1    7625 5525
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R14
U 1 1 5FCD0D60
P 7625 5725
F 0 "R14" V 7575 5850 50  0000 C CNN
F 1 "100" V 7575 5525 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7665 5715 50  0001 C CNN
F 3 "~" H 7625 5725 50  0001 C CNN
	1    7625 5725
	0    1    1    0   
$EndComp
Wire Wire Line
	7775 5525 8125 5525
Wire Wire Line
	8125 5525 8125 5200
Wire Wire Line
	8125 5200 8775 5200
Wire Wire Line
	7775 5725 8275 5725
Wire Wire Line
	8275 5725 8275 5400
Wire Wire Line
	8275 5400 8775 5400
Wire Wire Line
	7475 5525 6900 5525
Wire Wire Line
	7475 5725 6900 5725
Wire Wire Line
	8775 5100 8600 5100
Wire Wire Line
	8600 5100 8600 5300
Wire Wire Line
	8600 5300 8775 5300
Wire Wire Line
	8600 5300 8600 5500
Wire Wire Line
	8600 5500 8775 5500
Connection ~ 8600 5300
Wire Wire Line
	8600 5500 8600 5700
Wire Wire Line
	8600 5700 8775 5700
Connection ~ 8600 5500
$Comp
L power:GND #PWR0103
U 1 1 5FCE8453
P 8600 5700
F 0 "#PWR0103" H 8600 5450 50  0001 C CNN
F 1 "GND" H 8605 5527 50  0000 C CNN
F 2 "" H 8600 5700 50  0001 C CNN
F 3 "" H 8600 5700 50  0001 C CNN
	1    8600 5700
	1    0    0    -1  
$EndComp
Connection ~ 8600 5700
Wire Wire Line
	8775 4600 8600 4600
Wire Wire Line
	8600 4600 8600 5100
Connection ~ 8600 5100
Text Label 6900 3525 0    50   ~ 0
LCD_R0
Text Label 6900 3675 0    50   ~ 0
LCD_R1
Text Label 6900 3825 0    50   ~ 0
LCD_R2
Text Label 6900 3975 0    50   ~ 0
LCD_R3
Text Label 6900 4175 0    50   ~ 0
LCD_G0
Text Label 6900 4325 0    50   ~ 0
LCD_G1
Text Label 6900 4475 0    50   ~ 0
LCD_G2
Text Label 6900 4625 0    50   ~ 0
LCD_G3
Text Label 6900 4800 0    50   ~ 0
LCD_B0
Text Label 6900 4950 0    50   ~ 0
LCD_B1
Text Label 6900 5100 0    50   ~ 0
LCD_B2
Text Label 6900 5250 0    50   ~ 0
LCD_B3
Text Label 6900 5525 0    50   ~ 0
LCD_HS
Text Label 6900 5725 0    50   ~ 0
LCD_VS
$Comp
L Connector_Generic:Conn_02x24_Counter_Clockwise J1
U 1 1 5FCFE959
P 5150 3300
F 0 "J1" H 5200 4617 50  0000 C CNN
F 1 "CMOD-A7" H 5200 4526 50  0000 C CNN
F 2 "Package_DIP:DIP-48_W15.24mm_Socket_LongPads" H 5150 3300 50  0001 C CNN
F 3 "~" H 5150 3300 50  0001 C CNN
	1    5150 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 4500 5650 4500
Wire Wire Line
	5650 4500 5650 4650
$Comp
L power:GND #PWR0104
U 1 1 5FD04DE5
P 5650 4650
F 0 "#PWR0104" H 5650 4400 50  0001 C CNN
F 1 "GND" H 5655 4477 50  0000 C CNN
F 2 "" H 5650 4650 50  0001 C CNN
F 3 "" H 5650 4650 50  0001 C CNN
	1    5650 4650
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J2
U 1 1 5FD05A8B
P 5225 1350
F 0 "J2" V 5287 1394 50  0000 L CNN
F 1 "Conn_01x02_Male" V 5378 1394 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x01_P2.54mm_Vertical" H 5225 1350 50  0001 C CNN
F 3 "~" H 5225 1350 50  0001 C CNN
	1    5225 1350
	0    1    1    0   
$EndComp
Wire Wire Line
	5125 1550 5125 1675
Wire Wire Line
	5125 1675 5175 1675
Wire Wire Line
	5225 1675 5225 1550
$Comp
L power:GND #PWR0105
U 1 1 5FD0A306
P 5175 1675
F 0 "#PWR0105" H 5175 1425 50  0001 C CNN
F 1 "GND" H 5325 1650 50  0000 C CNN
F 2 "" H 5175 1675 50  0001 C CNN
F 3 "" H 5175 1675 50  0001 C CNN
	1    5175 1675
	1    0    0    -1  
$EndComp
Connection ~ 5175 1675
Wire Wire Line
	5175 1675 5225 1675
Text Notes 5000 1250 0    50   ~ 0
PMOD GND\n(to improve signal integrity)
Wire Wire Line
	7475 5100 6900 5100
Wire Wire Line
	7475 4950 6900 4950
Wire Wire Line
	7475 4800 6900 4800
Wire Wire Line
	7475 4625 6900 4625
Wire Wire Line
	7475 4475 6900 4475
Wire Wire Line
	7475 4325 6900 4325
Wire Wire Line
	7475 4175 6900 4175
Wire Wire Line
	7475 3975 6900 3975
Wire Wire Line
	7475 3825 6900 3825
Wire Wire Line
	7475 3675 6900 3675
Wire Wire Line
	7475 3525 6900 3525
Wire Wire Line
	6225 4400 5450 4400
Text Label 5825 4400 0    50   ~ 0
LCD_CLK
Wire Wire Line
	6225 4300 5450 4300
Text Label 5825 4300 0    50   ~ 0
LCD_HS
Wire Wire Line
	6225 4200 5450 4200
Text Label 5825 4200 0    50   ~ 0
LCD_VS
Wire Wire Line
	6225 4100 5450 4100
Wire Wire Line
	6225 4000 5450 4000
Wire Wire Line
	6225 3900 5450 3900
Wire Wire Line
	6225 3800 5450 3800
Wire Wire Line
	6225 3700 5450 3700
Wire Wire Line
	6225 3600 5450 3600
Text Label 5825 4100 0    50   ~ 0
LCD_R0
Text Label 5825 4000 0    50   ~ 0
LCD_R1
Wire Wire Line
	6225 3500 5450 3500
Wire Wire Line
	6225 3400 5450 3400
Wire Wire Line
	6225 3300 5450 3300
Wire Wire Line
	6225 3200 5450 3200
Wire Wire Line
	6225 3100 5450 3100
Wire Wire Line
	6225 3000 5450 3000
Wire Wire Line
	6225 2900 5450 2900
Wire Wire Line
	6225 2800 5450 2800
Wire Wire Line
	6225 2700 5450 2700
Wire Wire Line
	6225 2600 5450 2600
Wire Wire Line
	6225 2500 5450 2500
Wire Wire Line
	6225 2400 5450 2400
Text Label 5825 3900 0    50   ~ 0
LCD_R2
Text Label 5825 3800 0    50   ~ 0
LCD_R3
Text Label 5825 3700 0    50   ~ 0
LCD_R4
Text Label 5825 3600 0    50   ~ 0
LCD_R5
Text Label 5825 3500 0    50   ~ 0
LCD_G0
Text Label 5825 3400 0    50   ~ 0
LCD_G1
Text Label 5825 3300 0    50   ~ 0
LCD_G2
Text Label 5825 3200 0    50   ~ 0
LCD_G3
Text Label 5825 3100 0    50   ~ 0
LCD_G4
Text Label 5825 3000 0    50   ~ 0
LCD_G5
Text Label 5825 2900 0    50   ~ 0
LCD_B0
Text Label 5825 2800 0    50   ~ 0
LCD_B1
Text Label 5825 2700 0    50   ~ 0
LCD_B2
Text Label 5825 2600 0    50   ~ 0
LCD_B3
Text Label 5825 2500 0    50   ~ 0
LCD_B4
Text Label 5825 2400 0    50   ~ 0
LCD_B5
Wire Wire Line
	6225 2300 5450 2300
Text Label 5825 2300 0    50   ~ 0
LCD_DEN
Text Label 5675 7175 0    50   ~ 0
LCD_REV
Text Label 5700 6850 0    50   ~ 0
LCD_DISP
$Comp
L power:+3.3V #PWR0106
U 1 1 5FE1ED01
P 5100 6775
F 0 "#PWR0106" H 5100 6625 50  0001 C CNN
F 1 "+3.3V" H 5100 6950 50  0000 C CNN
F 2 "" H 5100 6775 50  0001 C CNN
F 3 "" H 5100 6775 50  0001 C CNN
	1    5100 6775
	1    0    0    -1  
$EndComp
$Comp
L Jumper:Jumper_3_Open JP1
U 1 1 5FE20151
P 4850 6950
F 0 "JP1" H 4850 7174 50  0000 C CNN
F 1 "JPR3" H 4850 7083 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 4850 6950 50  0001 C CNN
F 3 "~" H 4850 6950 50  0001 C CNN
	1    4850 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 7100 4850 7175
$Comp
L power:GND #PWR0107
U 1 1 5FE305A7
P 4600 7175
F 0 "#PWR0107" H 4600 6925 50  0001 C CNN
F 1 "GND" H 4605 7002 50  0000 C CNN
F 2 "" H 4600 7175 50  0001 C CNN
F 3 "" H 4600 7175 50  0001 C CNN
	1    4600 7175
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 7175 4600 6950
Wire Wire Line
	4850 7175 6075 7175
Text Notes 10350 1400 0    50   ~ 0
LCD Panel
Text Notes 9275 5000 0    50   ~ 0
VGA
$Comp
L power:+3.3V #PWR0108
U 1 1 5FF325D2
P 5125 4825
F 0 "#PWR0108" H 5125 4675 50  0001 C CNN
F 1 "+3.3V" H 5125 5000 50  0000 C CNN
F 2 "" H 5125 4825 50  0001 C CNN
F 3 "" H 5125 4825 50  0001 C CNN
	1    5125 4825
	1    0    0    -1  
$EndComp
Wire Wire Line
	5125 4825 4950 4825
Text Notes 7075 6850 0    175  ~ 0
UPCO Graphics Systems
Text Notes 7525 7525 0    100  ~ 0
CMOD S7 LCD/VGA Adapter
Text Notes 10750 7650 0    100  ~ 0
A
Text Notes 725  7675 0    100  ~ 0
TODO:\n*  Redo level shifters with 74HC\n*  Change all to TH\n*  12V for backlight (dimmer)?\n
Wire Wire Line
	4950 4825 4950 4500
Text Notes 4400 900  0    100  ~ 0
CMOD A7 FPGA Module
$Comp
L Connector:Conn_01x06_Male J7
U 1 1 61BE2437
P 2600 4250
F 0 "J7" H 2600 4550 50  0000 C CNN
F 1 "Conn_01x06_Male" H 2600 3850 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 2600 4250 50  0001 C CNN
F 3 "~" H 2600 4250 50  0001 C CNN
	1    2600 4250
	1    0    0    -1  
$EndComp
Text Notes 2300 3850 0    100  ~ 0
Serial keyboard
$Comp
L Connector:Mini-DIN-6 J8
U 1 1 61BFA3C2
P 3050 5900
F 0 "J8" H 3050 6150 50  0000 C CNN
F 1 "Mini-DIN-6" H 3050 5650 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x03_P2.54mm_Vertical" H 3050 5900 50  0001 C CNN
F 3 "http://service.powerdynamics.com/ec/Catalog17/Section%2011.pdf" H 3050 5900 50  0001 C CNN
	1    3050 5900
	1    0    0    -1  
$EndComp
Text Notes 2500 5500 0    100  ~ 0
PS/2 Keyboard
Wire Wire Line
	3350 5900 3550 5900
Wire Wire Line
	3550 5900 3550 6250
Wire Wire Line
	2750 5900 2250 5900
Wire Wire Line
	2250 5900 2250 5550
Wire Wire Line
	3350 5800 4200 5800
$Comp
L power:+5V #PWR05
U 1 1 61C3BD70
P 2250 5550
F 0 "#PWR05" H 2250 5400 50  0001 C CNN
F 1 "+5V" H 2250 5690 50  0000 C CNN
F 2 "" H 2250 5550 50  0001 C CNN
F 3 "" H 2250 5550 50  0001 C CNN
	1    2250 5550
	1    0    0    -1  
$EndComp
Text Label 3750 5800 0    50   ~ 0
PS2-CLK
Text Label 3750 6000 0    50   ~ 0
PS2-DATA
$Comp
L power:GND #PWR011
U 1 1 61C3EA75
P 3550 6250
F 0 "#PWR011" H 3550 6000 50  0001 C CNN
F 1 "GND" H 3555 6077 50  0000 C CNN
F 2 "" H 3550 6250 50  0001 C CNN
F 3 "" H 3550 6250 50  0001 C CNN
	1    3550 6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 4050 3300 4050
$Comp
L power:GND #PWR08
U 1 1 61C4FD6C
P 3300 4800
F 0 "#PWR08" H 3300 4550 50  0001 C CNN
F 1 "GND" H 3305 4627 50  0000 C CNN
F 2 "" H 3300 4800 50  0001 C CNN
F 3 "" H 3300 4800 50  0001 C CNN
	1    3300 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 4050 3300 4150
$Comp
L power:+5V #PWR012
U 1 1 61C6B945
P 3600 4050
F 0 "#PWR012" H 3600 3900 50  0001 C CNN
F 1 "+5V" H 3600 4190 50  0000 C CNN
F 2 "" H 3600 4050 50  0001 C CNN
F 3 "" H 3600 4050 50  0001 C CNN
	1    3600 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 4250 2800 4250
Wire Wire Line
	3600 4050 3600 4250
Wire Wire Line
	2800 4450 3700 4450
$Comp
L myRC2014:RC2014_BUS J6
U 1 1 61B378B7
P 1800 1050
F 0 "J6" H 1608 1315 50  0000 C CNN
F 1 "RC2014_BUS" H 1608 1224 50  0000 C CNN
F 2 "myRC2014_footprints:RC2014_Header" H 1800 1050 50  0001 C CNN
F 3 "" H 1800 1050 50  0001 C CNN
	1    1800 1050
	1    0    0    -1  
$EndComp
$Comp
L myRC2014:RC2014_BUS J6
U 2 1 61B392BD
P 1100 3800
F 0 "J6" H 883 4065 50  0000 C CNN
F 1 "RC2014_BUS" H 883 3974 50  0000 C CNN
F 2 "myRC2014_footprints:RC2014_Header" H 1100 3800 50  0001 C CNN
F 3 "" H 1100 3800 50  0001 C CNN
	2    1100 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 5350 4200 5350
$Comp
L power:GND #PWR014
U 1 1 61B8CFCA
P 4700 5650
F 0 "#PWR014" H 4700 5400 50  0001 C CNN
F 1 "GND" H 4500 5600 50  0000 C CNN
F 2 "" H 4700 5650 50  0001 C CNN
F 3 "" H 4700 5650 50  0001 C CNN
	1    4700 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 6000 3700 6000
Wire Wire Line
	4700 5350 5150 5350
Text Label 4850 5350 0    50   ~ 0
KB_CLOCK
Wire Wire Line
	3700 6000 3700 4450
Connection ~ 3700 6000
Wire Wire Line
	3700 6000 4400 6000
Wire Wire Line
	2800 4150 3300 4150
Connection ~ 3300 4150
Wire Wire Line
	3400 1150 4450 1150
Wire Wire Line
	4450 1150 4450 2200
Wire Wire Line
	4300 1900 4300 2300
Wire Wire Line
	4950 2200 4450 2200
Wire Wire Line
	4300 2300 4950 2300
$Comp
L Jumper:Jumper_3_Bridged12 JP3
U 1 1 61C741D9
P 3050 1900
F 0 "JP3" V 3096 1967 50  0000 L CNN
F 1 "Jumper_3_Bridged12" V 3005 1967 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x03_P2.54mm_Vertical" H 3050 1900 50  0001 C CNN
F 3 "~" H 3050 1900 50  0001 C CNN
	1    3050 1900
	0    -1   -1   0   
$EndComp
$Comp
L Jumper:Jumper_3_Bridged12 JP2
U 1 1 61C752EF
P 2650 1150
F 0 "JP2" V 2696 1217 50  0000 L CNN
F 1 "Jumper_3_Bridged12" V 2605 1217 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x03_P2.54mm_Vertical" H 2650 1150 50  0001 C CNN
F 3 "~" H 2650 1150 50  0001 C CNN
	1    2650 1150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2650 1400 2350 1400
Wire Wire Line
	2650 900  2350 900 
Wire Wire Line
	3050 2150 2350 2150
Wire Wire Line
	2350 1650 3050 1650
Text Label 2350 900  0    50   ~ 0
RXA
Text Label 2350 1400 0    50   ~ 0
RXB
Text Label 2350 1650 0    50   ~ 0
TXA
Text Label 2350 2150 0    50   ~ 0
TXB
Wire Wire Line
	1800 5050 2150 5050
Wire Wire Line
	1800 5150 2150 5150
Text Label 1950 5150 0    50   ~ 0
RXA
Text Label 1950 5050 0    50   ~ 0
TXA
Wire Wire Line
	1100 6000 1550 6000
Wire Wire Line
	1100 6100 1550 6100
Text Label 1350 6100 0    50   ~ 0
RXB
Text Label 1350 6000 0    50   ~ 0
TXB
$Comp
L power:GND #PWR02
U 1 1 61D2114F
P 1250 3800
F 0 "#PWR02" H 1250 3550 50  0001 C CNN
F 1 "GND" H 1255 3627 50  0000 C CNN
F 2 "" H 1250 3800 50  0001 C CNN
F 3 "" H 1250 3800 50  0001 C CNN
	1    1250 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 3800 1100 3800
Wire Wire Line
	1100 4000 1150 4000
Wire Wire Line
	1150 4000 1150 3450
$Comp
L power:+5V #PWR01
U 1 1 61D448F3
P 1150 3450
F 0 "#PWR01" H 1150 3300 50  0001 C CNN
F 1 "+5V" H 1150 3590 50  0000 C CNN
F 2 "" H 1150 3450 50  0001 C CNN
F 3 "" H 1150 3450 50  0001 C CNN
	1    1150 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 2850 2200 2850
Wire Wire Line
	2200 2850 2200 3050
Wire Wire Line
	1800 3050 2050 3050
Wire Wire Line
	2050 3050 2050 2750
$Comp
L power:+5V #PWR03
U 1 1 61D69397
P 2050 2750
F 0 "#PWR03" H 2050 2600 50  0001 C CNN
F 1 "+5V" H 2050 2890 50  0000 C CNN
F 2 "" H 2050 2750 50  0001 C CNN
F 3 "" H 2050 2750 50  0001 C CNN
	1    2050 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C1
U 1 1 61DEBB00
P 2650 2700
F 0 "C1" H 2742 2746 50  0000 L CNN
F 1 "0.1uF" H 2742 2655 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 2650 2700 50  0001 C CNN
F 3 "~" H 2650 2700 50  0001 C CNN
	1    2650 2700
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR017
U 1 1 61DEC108
P 2650 2600
F 0 "#PWR017" H 2650 2450 50  0001 C CNN
F 1 "+3.3V" H 2650 2800 50  0000 C CNN
F 2 "" H 2650 2600 50  0001 C CNN
F 3 "" H 2650 2600 50  0001 C CNN
	1    2650 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C2
U 1 1 61E00B31
P 3050 2700
F 0 "C2" H 3142 2746 50  0000 L CNN
F 1 "0.1uF" H 3142 2655 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 3050 2700 50  0001 C CNN
F 3 "~" H 3050 2700 50  0001 C CNN
	1    3050 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 2600 2650 2600
Connection ~ 2650 2600
Wire Wire Line
	3050 2800 2650 2800
Wire Wire Line
	3300 4150 3300 4800
$Comp
L Device:C_Small C3
U 1 1 61E4D104
P 4050 2700
F 0 "C3" H 4142 2746 50  0000 L CNN
F 1 "0.1uF" H 4142 2655 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 4050 2700 50  0001 C CNN
F 3 "~" H 4050 2700 50  0001 C CNN
	1    4050 2700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 61E4D89E
P 4050 2800
F 0 "#PWR020" H 4050 2550 50  0001 C CNN
F 1 "GND" H 4050 2600 50  0000 C CNN
F 2 "" H 4050 2800 50  0001 C CNN
F 3 "" H 4050 2800 50  0001 C CNN
	1    4050 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 61E4D8A8
P 4450 2700
F 0 "C4" H 4542 2746 50  0000 L CNN
F 1 "0.1uF" H 4542 2655 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 4450 2700 50  0001 C CNN
F 3 "~" H 4450 2700 50  0001 C CNN
	1    4450 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 2600 4050 2600
Wire Wire Line
	4450 2800 4050 2800
Connection ~ 4050 2800
$Comp
L power:+5V #PWR019
U 1 1 61E611F2
P 4050 2600
F 0 "#PWR019" H 4050 2450 50  0001 C CNN
F 1 "+5V" H 4050 2740 50  0000 C CNN
F 2 "" H 4050 2600 50  0001 C CNN
F 3 "" H 4050 2600 50  0001 C CNN
	1    4050 2600
	1    0    0    -1  
$EndComp
Connection ~ 4050 2600
Wire Wire Line
	4950 4300 4300 4300
Wire Wire Line
	4950 4400 4300 4400
Text Label 4300 4300 0    50   ~ 0
KB_CLOCK
Text Label 4300 4400 0    50   ~ 0
KB_DATA
Wire Wire Line
	4950 3300 4350 3300
Wire Wire Line
	4350 3700 4350 3300
$Comp
L power:GND #PWR022
U 1 1 61EB382E
P 4050 4000
F 0 "#PWR022" H 4050 3750 50  0001 C CNN
F 1 "GND" H 4050 3800 50  0000 C CNN
F 2 "" H 4050 4000 50  0001 C CNN
F 3 "" H 4050 4000 50  0001 C CNN
	1    4050 4000
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR021
U 1 1 61ECAA85
P 4050 3400
F 0 "#PWR021" H 4050 3250 50  0001 C CNN
F 1 "+3.3V" H 4050 3600 50  0000 C CNN
F 2 "" H 4050 3400 50  0001 C CNN
F 3 "" H 4050 3400 50  0001 C CNN
	1    4050 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C5
U 1 1 61EF3587
P 3450 2700
F 0 "C5" H 3542 2746 50  0000 L CNN
F 1 "0.1uF" H 3542 2655 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 3450 2700 50  0001 C CNN
F 3 "~" H 3450 2700 50  0001 C CNN
	1    3450 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 2600 3050 2600
Connection ~ 3050 2600
Connection ~ 3050 2800
Wire Wire Line
	3050 2800 3450 2800
$Comp
L Device:C_Small C8
U 1 1 61BC592F
P 8600 1950
F 0 "C8" H 8692 1996 50  0000 L CNN
F 1 "10uF" H 8692 1905 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 8600 1950 50  0001 C CNN
F 3 "~" H 8600 1950 50  0001 C CNN
	1    8600 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 1600 8600 1850
$Comp
L power:+3.3V #PWR025
U 1 1 61BE5536
P 8600 1600
F 0 "#PWR025" H 8600 1450 50  0001 C CNN
F 1 "+3.3V" H 8600 1800 50  0000 C CNN
F 2 "" H 8600 1600 50  0001 C CNN
F 3 "" H 8600 1600 50  0001 C CNN
	1    8600 1600
	1    0    0    -1  
$EndComp
Connection ~ 8600 1600
$Comp
L Device:C_Small C6
U 1 1 61BF57A3
P 7050 1950
F 0 "C6" H 7142 1996 50  0000 L CNN
F 1 "0.1uF" H 7142 1905 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 7050 1950 50  0001 C CNN
F 3 "~" H 7050 1950 50  0001 C CNN
	1    7050 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 1600 7050 1850
Connection ~ 7750 2050
$Comp
L power:+5V #PWR023
U 1 1 61C468DD
P 7050 1600
F 0 "#PWR023" H 7050 1450 50  0001 C CNN
F 1 "+5V" H 7050 1740 50  0000 C CNN
F 2 "" H 7050 1600 50  0001 C CNN
F 3 "" H 7050 1600 50  0001 C CNN
	1    7050 1600
	1    0    0    -1  
$EndComp
Connection ~ 7050 1600
Wire Wire Line
	7050 2050 7750 2050
$Comp
L Device:R_US R18
U 1 1 61B5379A
P 4550 5350
F 0 "R18" V 4450 5250 50  0000 C CNN
F 1 "2k" V 4450 5500 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4590 5340 50  0001 C CNN
F 3 "~" H 4550 5350 50  0001 C CNN
	1    4550 5350
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R20
U 1 1 61B72B4A
P 4700 5500
F 0 "R20" H 4600 5450 50  0000 C CNN
F 1 "3k" H 4550 5550 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4740 5490 50  0001 C CNN
F 3 "~" H 4700 5500 50  0001 C CNN
	1    4700 5500
	-1   0    0    1   
$EndComp
Connection ~ 4700 5350
Wire Wire Line
	4200 5350 4200 5800
$Comp
L power:GND #PWR09
U 1 1 61BC6D38
P 4700 6300
F 0 "#PWR09" H 4700 6050 50  0001 C CNN
F 1 "GND" H 4500 6250 50  0000 C CNN
F 2 "" H 4700 6300 50  0001 C CNN
F 3 "" H 4700 6300 50  0001 C CNN
	1    4700 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 6000 5150 6000
Text Label 4850 6000 0    50   ~ 0
KB_DATA
$Comp
L Device:R_US R19
U 1 1 61BC722C
P 4550 6000
F 0 "R19" V 4450 5900 50  0000 C CNN
F 1 "2k" V 4450 6150 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4590 5990 50  0001 C CNN
F 3 "~" H 4550 6000 50  0001 C CNN
	1    4550 6000
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R21
U 1 1 61BC7236
P 4700 6150
F 0 "R21" H 4600 6100 50  0000 C CNN
F 1 "3k" H 4550 6200 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4740 6140 50  0001 C CNN
F 3 "~" H 4700 6150 50  0001 C CNN
	1    4700 6150
	-1   0    0    1   
$EndComp
Connection ~ 4700 6000
$Comp
L power:GND #PWR07
U 1 1 61C0DBC7
P 3850 2200
F 0 "#PWR07" H 3850 1950 50  0001 C CNN
F 1 "GND" H 3650 2150 50  0000 C CNN
F 2 "" H 3850 2200 50  0001 C CNN
F 3 "" H 3850 2200 50  0001 C CNN
	1    3850 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 1900 4300 1900
$Comp
L Device:R_US R16
U 1 1 61C0DBD2
P 3700 1900
F 0 "R16" V 3600 1800 50  0000 C CNN
F 1 "2k" V 3600 2050 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 3740 1890 50  0001 C CNN
F 3 "~" H 3700 1900 50  0001 C CNN
	1    3700 1900
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R17
U 1 1 61C0DBDC
P 3850 2050
F 0 "R17" H 3750 2000 50  0000 C CNN
F 1 "3k" H 3700 2100 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 3890 2040 50  0001 C CNN
F 3 "~" H 3850 2050 50  0001 C CNN
	1    3850 2050
	-1   0    0    1   
$EndComp
Connection ~ 3850 1900
Wire Wire Line
	3200 1900 3550 1900
$Comp
L Device:R_US R15
U 1 1 61C6F09A
P 3250 1150
F 0 "R15" V 3150 1050 50  0000 C CNN
F 1 "2k" V 3150 1300 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 3290 1140 50  0001 C CNN
F 3 "~" H 3250 1150 50  0001 C CNN
	1    3250 1150
	0    1    1    0   
$EndComp
Wire Wire Line
	3100 1150 2800 1150
Text Notes 5400 5750 0    100  ~ 0
Level shifter\n"bricolage"
$Comp
L Device:R_US R22
U 1 1 61C8BA25
P 5400 6850
F 0 "R22" V 5300 6750 50  0000 C CNN
F 1 "2k" V 5300 7000 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 5440 6840 50  0001 C CNN
F 3 "~" H 5400 6850 50  0001 C CNN
	1    5400 6850
	0    1    1    0   
$EndComp
Wire Wire Line
	5100 6775 5100 6850
Wire Wire Line
	5250 6850 5100 6850
Connection ~ 5100 6850
Wire Wire Line
	5100 6850 5100 6950
Wire Wire Line
	5550 6850 5700 6850
$Comp
L power:GND #PWR06
U 1 1 61CE708E
P 2650 2800
F 0 "#PWR06" H 2650 2550 50  0001 C CNN
F 1 "GND" H 2650 2600 50  0000 C CNN
F 2 "" H 2650 2800 50  0001 C CNN
F 3 "" H 2650 2800 50  0001 C CNN
	1    2650 2800
	1    0    0    -1  
$EndComp
Connection ~ 2650 2800
$Comp
L power:GND #PWR04
U 1 1 61CE7888
P 2200 3050
F 0 "#PWR04" H 2200 2800 50  0001 C CNN
F 1 "GND" H 2200 2850 50  0000 C CNN
F 2 "" H 2200 3050 50  0001 C CNN
F 3 "" H 2200 3050 50  0001 C CNN
	1    2200 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 61CED7B0
P 10450 5350
F 0 "#PWR013" H 10450 5100 50  0001 C CNN
F 1 "GND" H 10455 5177 50  0000 C CNN
F 2 "" H 10450 5350 50  0001 C CNN
F 3 "" H 10450 5350 50  0001 C CNN
	1    10450 5350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 61CF1E69
P 7050 2050
F 0 "#PWR010" H 7050 1800 50  0001 C CNN
F 1 "GND" H 7050 1900 50  0000 C CNN
F 2 "" H 7050 2050 50  0001 C CNN
F 3 "" H 7050 2050 50  0001 C CNN
	1    7050 2050
	1    0    0    -1  
$EndComp
Connection ~ 7050 2050
$Comp
L Oscillator:CXO_DIP8 X1
U 1 1 61CFC106
P 4050 3700
F 0 "X1" H 3850 3950 50  0000 L CNN
F 1 "CXO_DIP8" H 4100 3450 50  0000 L CNN
F 2 "Oscillator:Oscillator_DIP-8" H 4500 3350 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/OSZI.pdf" H 3950 3700 50  0001 C CNN
	1    4050 3700
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:LM2937xT VR1
U 1 1 61D4849B
P 7750 1600
F 0 "VR1" H 7600 1725 50  0000 C CNN
F 1 "LM2937xT" H 7750 1725 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 7750 1825 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm2937.pdf" H 7750 1550 50  0001 C CNN
	1    7750 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 1900 7750 2050
Wire Wire Line
	8050 1600 8600 1600
Wire Wire Line
	7750 2050 8600 2050
Wire Wire Line
	7050 1600 7450 1600
$EndSCHEMATC
