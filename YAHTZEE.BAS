1000 '   YAHTZEE
1010 ' Original by JL Helms & MF Pezok for CCII
1020 ' Coronado, CA
1030 ' Reprogrammed to IBM PCjr by Erik Anderson
1040 ' SK High School
1050 '
1060 DEFINT A-Z
1070 DIM C(5): DIM K(18, 7): DIM F(5): DIM A$(7): DIM ER(7)
1080 DIM S(6, 5), M(13), TN(6), DU(6): KEY OFF: COLOR 15, 1, 1: WIDTH 80
1090 SCREEN 0, 1: RESTORE 1150: FOR N = 1 TO 6: READ TN(N): NEXT
1110 GOSUB 5230
1120 C1 = 39: C2 = 63: C3 = 33: C4 = 56
1130 GOSUB 4800
1140 CLS : GOSUB 4450
1150 DATA 49, 51, 53, 54, 56, 61
1160 GOSUB 6960: ' draw yahtzee board
1170 RANDOMIZE VAL(RIGHT$(TIME$, 2))
1180 LOCATE 25, 1
1190 PRINT "How many players? "; : LOCATE , , 1: GOSUB 2120
1200 GOSUB 7240: N = ASC(KB$) - 48
1210 IF N < 1 OR N > 5 THEN 1180
1220 IF N < 5 THEN GOSUB 6140
1230 IF CC = 1 THEN GOSUB 5620
1240 FOR A = 1 TO N
1250 LOCATE 25, 1: PRINT STRING$(70, " "); : LOCATE 25, 1
1260 PRINT "Player number "; A; " name please ";
1270 GOSUB 2120: LINE INPUT ; A$(A): IF A$(A) = "" THEN BEEP: GOTO 1250
1280 A$(A) = LEFT$(A$(A), 9)
1290 NEXT A
1300 IF CC = 1 THEN N = N + 1: A$(N) = "IBM PC"
1310 LOCATE 24, 1
1320 A = 0
1330 '
1340 '   Next Roll Preset
1350 '
1360 A = A + 1: IF A > N THEN A = 1
1370 H = 0: GOSUB 5480
1380 IF A = 0 THEN 4900
1390 IF K(18, A) = 2 THEN 1360
1400 LOCATE 23, 1: PRINT STRING$(60, " ");
1410 LOCATE 23, 4 * (A - 1) + 14
1420 PRINT A$(A);
1430 '
1440 '   Initial Roll
1450 '
1460 IF ER(A) = 1 THEN GOSUB 7310: GOTO 1540
1470 H = H + 1: MR = 0
1480 FOR B = 1 TO 5
1490 J = B - 1: C(B) = INT(6 * RND(1) + 1)
1500 DIE = C(B): F(B) = 0
1510 GOSUB 5390
1520 GOSUB 5670
1530 NEXT B
1540 IF A * CC = N THEN 2170
1550 '
1560 '   Player Selects Qty to Roll
1570 '
1580 GOSUB 7220
1590 IF H > 2 THEN 1970
1600 POKE 106, 0: PRINT " How many dice to roll again? "; : LOCATE , , 1: GOSUB 2110: GOSUB 7240: F$ = KB$: PRINT F$; : F = ASC(F$) - 48: LOCATE , , 0
1610 IF F = -1 THEN GOSUB 3500
1620 IF F < 0 OR F > 5 THEN 1580
1630 IF F = 0 THEN ER(A) = 0: GOTO 1970
1640 IF F = 5 THEN 1430
1650 '
1660 '   Player Selects Dice to Roll
1670 '
1680 H = H + 1
1690 GOSUB 7220
1700 FOR NN = 1 TO 4: F(NN) = 0: NEXT
1710 PRINT " Roll which "; F; "dice again   "; : LOCATE , , 1
1720 GOSUB 2120: FOR ND = 1 TO F:
1730 GOSUB 7240: F$ = KB$: F(ND) = ASC(F$) - 48: GOSUB 2150: IF F(ND) = 0 AND ND = 1 THEN ND = F: GOTO 1750
1740 IF F(ND) < 1 OR F(ND) > 5 THEN 1730
1750 PRINT F(ND); : NEXT
1760 X = 2: XF = 0
1770 FOR J = 1 TO F
1780 IF F = 1 THEN 1810
1790 IF F(J) = F(J + 1) THEN X = 1
1800 IF F(1) = 0 THEN XF = 1
1810 NEXT J: IF XF = 1 THEN H = H - 1: GOTO 1580
1820 ON X GOTO 1690, 1830
1830 '
1840 '   Player Rolls Dice Again
1850 '
1860 FOR B = 1 TO 4
1870 IF F(B) = 0 THEN 1950
1880 IF ER(A) = 2 THEN GOSUB 7450: GOTO 1910
1890 IF ER(A) = 1 THEN GOSUB 7420: GOTO 1910
1900 C(F(B)) = INT(6 * RND(1) + 1)
1910 DIE = C(F(B)): J = F(B) - 1
1920 GOSUB 5390
1930 GOSUB 5670
1940 F(B) = 0
1950 NEXT B
1960 GOTO 1550
1970 '
1980 '   Play Board Number
1990 '
2000 GOSUB 7220
2010 PRINT " Play board number?  "; : LOCATE , , 1: GOSUB 2110: GOSUB 7240
2020 I$ = KB$: I = ASC(I$) - 48: LOCATE , , 0: IF I > 9 THEN I = I - 7
2030 GOSUB 2150
2040 IF I < 1 OR I > 13 THEN 2000
2050 IF I = 12 AND K(12, A) > -1 THEN 2170
2060 IF K(I, A) = O THEN 2170
2070 LOCATE 24, 1: BEEP
2080 PRINT "NO - NO - BEAVER - - TRY AGAIN"; : FOR ND = 1 TO 1500: NEXT: LOCATE 24, 1: PRINT STRING$(60, " ");
2090 LOCATE 25, 1: PRINT STRING$(60, " "); : LOCATE 25, 1
2100 GOTO 2010
2110 REM HIGH PITCH CLICK
2120 PLAY "L64T200N70": RETURN
2130 REM GLISSANDO SOUND
2140 PLAY "L64T200N46": RETURN
2150 ' LO PITCH CLICK
2160 PLAY "L64T200N46": RETURN
2170 REM
2180 REM DICE LOGIC
2190 REM CLEAR/SET S(M,K)
2200 REM
2210 FOR M = O TO 6
2220 FOR K = O TO 5
2230 S(M, K) = 0
2240 NEXT K
2250 NEXT M
2260 FOR J = 1 TO 5
2270 X = C(J): S(X, O) = S(X, 0) + 1
2280 P = S(X, O): S(X, P) = J
2290 NEXT J
2300 REM
2310 REM SET S(O,K)=M SEQUENCE BY QTY
2320 REM
2330 X = O
2340 FOR J = 5 TO 1 STEP -1
2350 FOR M = 6 TO 1 STEP -1
2360 IF S(M, 0) <> J THEN 2380
2370 S(0, X) = M: X = X + 1
2380 NEXT M
2390 NEXT J
2400 IF A * CC = N THEN 2770
2410 IF I > 6 THEN 2490
2420 '
2430 '   Check Player Board 1-6
2440 '
2450 GOSUB 6250
2460 IF X = -1 THEN 2750
2470 K(I, A) = I * S(S(O, X), O)
2480 GOTO 4000
2490 '
2500 '   Check Player Board 7-13
2510 '
2520 ON I - 6 GOTO 2530, 2550, 2570, 2590, 2640, 2680, 2710
2530 IF S(S(0, 0), 0) < 3 THEN 2750
2540 GOSUB 6330: GOTO 4000
2550 IF S(S(O, O), 0) < 4 THEN 2750
2560 GOSUB 6330: GOTO 4000
2570 IF S(S(0, 0), 0) <> 3 OR S(S(0, 1), 0) <> 2 THEN 2750
2580 K(9, A) = 25: GOTO 4000
2590 IF S(1, 0) > O AND S(2, 0) > 0 AND S(3, 0) > 0 AND S(4, 0) > 0 THEN 2630
2600 IF S(2, 0) > O AND S(3, 0) > 0 AND S(4, 0) > 0 AND S(5, 0) > 0 THEN 2630
2610 IF S(3, 0) > O AND S(4, 0) > 0 AND S(5, 0) > 0 AND S(6, 0) > 0 THEN 2630
2620 GOTO 2750
2630 K(10, A) = 30: GOTO 4000
2640 IF S(1, 0) AND S(2, 0) AND S(3, 0) AND S(4, 0) AND S(5, 0) = 1 THEN 2670
2650 IF S(2, 0) AND S(3, 0) AND S(4, 0) AND S(5, 0) AND S(6, 0) = 1 THEN 2670
2660 GOTO 2750
2670 K(11, A) = 40: GOTO 4000
2680 IF S(S(0, 0), 0) <> 5 THEN 2750
2690 IF K(12, A) = O THEN K(12, A) = 50: GOTO 4000
2700 K(12, A) = K(12, A) + 100: GOTO 4000
2710 GOSUB 6330: GOTO 4000
2720 '
2730 '   Set Player Invalid
2740 '
2750 K(I, A) = -1
2760 GOTO 4000
2770 '
2780 '   Computer Checks
2790 '
2800 I = 12
2810 IF S(S(0, 0), 0) = 5 AND K(12, A) = 0 THEN K(12, A) = 50: GOTO 4000
2820 IF S(S(0, 0), 0) = 5 AND K(12, A) > 0 THEN K(12, A) = K(12, A) + 100: GOTO 4000
2830 I = 8
2840 IF S(S(0, 0), 0) = 4 AND K(8, A) = 0 THEN GOSUB 6330: GOTO 4000
2850 I = 9
2860 IF S(S(0, 0), 0) = 3 AND S(S(0, 1), 0) = 2 AND K(9, A) = 0 THEN K(9, A) = 25: GOTO 4000
2870 IF K(11, A) <> 0 THEN 2930
2880 I = 11
2890 IF S(1, 0) AND S(2, 0) AND S(3, 0) AND S(4, 0) AND S(5, 0) = 1 THEN 2920
2900 IF S(2, 0) AND S(3, 0) AND S(4, 0) AND S(5, 0) AND S(6, 0) = 1 THEN 2920
2910 GOTO 2930
2920 K(11, A) = 40: GOTO 4000
2930 IF K(10, A) <> 0 THEN 3000
2940 I = 10
2950 IF S(1, 0) > 0 AND S(2, 0) > 0 AND S(3, 0) > 0 AND S(4, 0) > 0 THEN 2990
2960 IF S(2, 0) > 0 AND S(3, 0) > 0 AND S(4, 0) > 0 AND S(5, 0) > 0 THEN 2990
2970 IF S(3, 0) > 0 AND S(4, 0) > 0 AND S(5, 0) > 0 AND S(6, 0) > 0 THEN 2990
2980 GOTO 3000
2990 K(10, A) = 30: GOTO 4000
3000 IF H < 3 THEN 3170
3010 I = 6
3020 IF S(6, 0) > 2 AND K(6, A) = 0 THEN K(6, A) = 6 * S(6, 0): GOTO 4000
3030 I = 5
3040 IF S(5, 0) > 2 AND K(5, A) = 0 THEN K(5, A) = 5 * S(5, 0): GOTO 4000
3050 I = 4
3060 IF S(4, 0) > 2 AND K(4, A) = 0 THEN K(4, A) = 4 * S(4, 0): GOTO 4000
3070 I = 3
3080 IF S(3, 0) > 2 AND K(3, A) = 0 THEN K(3, A) = 3 * S(3, 0): GOTO 4000
3090 I = 7
3100 IF S(S(0, 0), 0) > 2 AND K(7, A) = 0 THEN GOSUB 6330: GOTO 4000
3110 I = 2
3120 IF S(2, 0) > 2 AND K(2, A) = 0 THEN K(2, A) = 2 * S(2, 0): GOTO 4000
3130 I = 1
3140 IF S(1, 0) > 2 AND K(1, A) = 0 THEN K(1, A) = 1 * S(1, 0): GOTO 4000
3150 I = 13: IF K(13, A) <> 0 THEN 3170
3160 IF C(1) + C(2) + C(3) + C(4) + C(5) > 19 THEN GOSUB 6330: GOTO 4000
3170 '
3180 '   Clear Dice Number F(B)
3190 '   Computer
3200 '
3210 FOR B = 1 TO 5
3220 F(B) = 0
3230 NEXT B
3240 '
3250 '   Clear Dice Control
3260 '   Computer
3270 '
3280 H = H + 1: IF H > 3 THEN 3860
3290 I = M(MR): IF I <> 0 THEN 3320
3300 MR = MR + 1: IF MR > 13 THEN MR = 1
3310 GOTO 3290
3320 IF I = 12 AND K(12, A) > -1 THEN 3360
3330 IF K(I, A) <> 0 THEN 3300
3340 IF I = 9 THEN 3470
3350 IF I = 10 OR I = 11 THEN 3580
3360 '
3370 '   Get Dice 1,2,3,4
3380 '   Computer
3390 '
3400 M = 0: J = 1
3410 M = M + 1: IF M > 4 THEN 3740
3420 K = S(O, M): IF K = 0 THEN 3740
3430 FOR L = 1 TO S(K, O)
3440 F(J) = S(K, L): J = J + 1
3450 NEXT L
3460 GOTO 3410
3470 '
3480 '   Get Dice FH
3490 '   Computer
3500 '
3510 M = 0: J = 1
3520 M = M + 1: IF M > 4 THEN 3740
3530 K = S(O, M): IF K = 0 THEN 3740
3540 FOR L = 1 TO S(K, O)
3550 F(J) = S(K, L): J = J + 1
3560 NEXT L
3570 GOTO 3520
3580 '
3590 '   Get Dice LG/SM ST
3600 '   Computer
3610 '
3620 M = 0: J = 1
3630 M = M + 1: IF M > 4 THEN 3700
3640 K = S(O, M): IF K = 0 THEN 3700
3650 IF S(K, 0) = 1 THEN 3630
3660 FOR L = 1 TO S(K, O)
3670 F(J) = S(K, L): J = J + 1
3680 NEXT L
3690 GOTO 3630
3700 IF F(1) < 0 THEN 3740
3710 L = INT(2 * RND(1) + 1)
3720 F(1) = 5
3730 IF L = 1 THEN F(1) = 1
3740 '
3750 '   Computer Roll Again
3760 '
3770 FOR B = 1 TO 4
3780 IF F(B) < 1 THEN 3830
3790 C(F(B)) = INT(6 * RND(1) + 1)
3800 DIE = C(F(B)): J = F(B) - 1
3810 GOSUB 5390
3820 GOSUB 5670
3830 F(B) = 0
3840 NEXT B
3850 GOTO 2170
3860 '
3870 '   Computer Must Score
3880 '
3890 MR = MR + 1: IF MR > 13 THEN MR = 1
3900 I = M(MR): IF I = 0 THEN 3890
3910 IF K(I, A) <> 0 THEN 3980
3920 IF I > 6 THEN 3980
3930 GOSUB 6250
3940 IF X = -1 THEN 3990
3950 IF K(I, A) <> 0 THEN 3870
3960 K(I, A) = S(I, 0) * I
3970 IF K(I, A) <> O THEN 4000
3980 IF I = 13 AND K(13, A) = 0 THEN GOSUB 6330
3990 IF K(I, A) = 0 THEN K(I, A) = -1
4000 '
4010 '   Get Scoreboard Totals
4020 '
4030 FOR J = 14 TO 17
4040 K(J, A) = 0
4050 NEXT J
4060 FOR J = 1 TO 6
4070 IF K(J, A) < 0 THEN 4090
4080 K(15, A) = K(15, A) + K(J, A)
4090 NEXT J
4100 IF K(15, A) > 62 THEN K(14, A) = 35
4110 FOR J = 7 TO 13
4120 IF K(J, A) < 0 THEN 4140
4130 K(16, A) = K(16, A) + K(J, A)
4140 NEXT J
4150 K(17, A) = K(14, A) + K(15, A) + K(16, A)
4160 '
4170 '   Print Score
4180 '
4190 GOSUB 2140
4200 COLOR 15, 1
4210 FOR J = 1 TO 6
4220 IF K(J, A) < 0 THEN LOCATE J + 1, 4 * (A - 1) + 15: PRINT "  0"; : GOTO 4250
4230 IF K(J, A) < 1 THEN 4250
4240 LOCATE J + 1, 4 * (A - 1) + 15: PRINT USING "###"; K(J, A);
4250 NEXT J
4260 FOR J = 7 TO 13
4270 IF K(J, A) < 0 THEN LOCATE J + 4, 4 * (A - 1) + 15: PRINT "  0"; : GOTO 4300
4280 IF K(J, A) < 1 THEN 4300
4290 LOCATE J + 4, 4 * (A - 1) + 15: PRINT USING "###"; K(J, A);
4300 NEXT J
4310 LOCATE 9, 4 * (A - 1) + 15: PRINT USING "###"; K(15, A)
4320 LOCATE 19, 4 * (A - 1) + 15: PRINT USING "###"; K(16, A)
4330 LOCATE 20, 4 * (A - 1) + 15: PRINT USING "###"; K(14, A)
4340 LOCATE 21, 4 * (A - 1) + 15: PRINT USING "###"; K(17, A)
4350 COLOR 15, 1, 1
4360 IF A * CC <> N THEN 1330
4370 '
4380 '   Reset M(I) Computer Priorities
4390 '
4400 FOR B = 1 TO 13
4410 IF M(B) = 12 THEN 4430
4420 IF M(B) = I THEN M(B) = 0
4430 NEXT B
4440 GOTO 1330
4450 '
4460 '   Instructions
4470 '
4480 PRINT "            Y A H T Z E E "
4490 PRINT "This is the Game of Yahtzee - "
4500 PRINT "From 1 to 5 players may play at the same time"
4510 PRINT "with each players current status shown on the "
4520 PRINT "playing board, including total scores."
4530 PRINT
4540 PRINT "The only difference between this game and the "
4550 PRINT "popular home game is that you may get multiple"
4560 PRINT "yahtzees here.....the first yahtzee scores"
4570 PRINT "50 points, and each additional one will yield"
4580 PRINT "a bonus of 100 points (If the yahtzee is put"
4590 PRINT "into the yahtzee block)...in addition you"
4600 PRINT "will be given an extra turn at the end of "
4610 PRINT "game.": PRINT
4620 PRINT "The winner will be announced at the end of"
4630 PRINT "the game.": PRINT : PRINT
4640 PRINT "To be last....well, we won't say anything about it."
4650 PRINT : PRINT
4780 GOSUB 2120: INPUT "Hit <RETURN> to continue  "; Y$: BEEP
4790 RETURN
4800 RETURN
4810 LOCATE 10, 10: PRINT "Yahtzee.BAS     Ver 3.2"
4820 LOCATE 12, 10: PRINT "31 June 85"
4830 LOCATE 14, 10: PRINT "Developed by "
4840 LOCATE 15, 13: PRINT "J.L. Helms  &  M.F. Peziok"
4850 LOCATE 16, 13: PRINT "1009 Leyte Rd / 1321 Saipan Rd"
4860 LOCATE 17, 17: PRINT "Coronado, CA.    92118"
4870 LOCATE 18, 15: PRINT "(714) 435-6992 / 437-4659"
4880 PRINT CHR$(11)
4890 RETURN
4900 '
4910 '   End - Sort Winner
4920 '
4930 X = 2: IF N = 1 THEN 5010
4940 FOR J = 1 TO N - 1
4950 IF K(17, J) > K(17, J + 1) THEN 4990
4960  K = K(17, J): K(17, J) = K(17, J + 1): K(17, J + 1) = K
4970 A$ = A$(J): A$(J) = A$(J + 1): A$(J + 1) = A$
4980 X = 1
4990 NEXT J
5000 ON X GOTO 4900, 5010
5010 '
5020 '   Print Winners Standings
5030 '
5040 RESTORE 5340
5050 FOR J = 1 TO N
5060 LOCATE 25, 1: PRINT STRING$(60, " ");
5070 IF J > 1 AND J = N THEN RESTORE 5380
5080 LOCATE 25, 1: READ A$
5090 PRINT A$; "    "; A$(J); " ";
5100 TT = 500 * (N - J + 1): IF TT < 1500 THEN TT = 1500
5110 FOR T = 1 TO TT: NEXT T
5120 NEXT J
5130 LOCATE 25, 1: PRINT STRING$(60, " ");
5140 LOCATE 24, 1: PRINT "+++   End of Game   +++";
5150 FOR T = 1 TO 2000: NEXT T
5160 '
5170 GOSUB 2120: LOCATE 25, 1: INPUT "Play Again?  Y/N  "; Y$
5180 IF LEFT$(Y$, 1) = "Y" THEN GOSUB 5230: GOTO 1110
5190 IF LEFT$(Y$, 1) = CHR$(27) THEN BEEP: GOTO 5220
5200 IF LEFT$(Y$, 1) <> "N" THEN BEEP: GOTO 5170
5220 END
5230 '
5240 '   Clear Matrices
5250 '
5260 FOR K = 1 TO 7
5270 FOR J = 1 TO 18
5280 K(J, K) = 0
5290 NEXT J
5300 A$(K) = ""
5310 NEXT K
5320 CLS
5330 RETURN
5340 DATA "+++   The Winner   +++"
5350 DATA " Second Place", " Third Place "
5360 DATA " Fourth Place ", " Fifth Place "
5370 DATA " Sixth Place "
5380 DATA " Dead Last "
5390 '
5400 '   Erase Die
5410 '
5420 COLOR 15, 4: PRINT ""; :
5430 LOCATE 4 * J + 1, 50: PRINT "      ";
5440 LOCATE 4 * J + 2, 50: PRINT "      ";
5450 LOCATE 4 * J + 3, 50: PRINT "      ";
5460 COLOR 15, 1
5470 RETURN
5480 '
5490 '   Check If Done
5500 '
5510 X = 0
5520 FOR J = 1 TO N
5530 Y = 2
5540 FOR K = 1 TO 13
5550 IF K(K, J) = 0 THEN Y = 1
5560 NEXT K
5570 K(18, J) = Y
5580 IF Y = 2 THEN X = X + 1
5590 NEXT J
5600 IF X >= N THEN A = 0
5610 RETURN
5620 '
5630 '   Computer Priorities Info
5640 '
5650 GOSUB 6920
5660 RETURN
5670 '
5680 '   Print Die
5690 '
5700 COLOR 15, 4: LOCATE , , 0
5710 '
5730 ON DIE GOTO 6070, 6010, 5950, 5890, 5830, 5770
5740 '
5750 '   Six
5760 '
5770 LOCATE 4 * J + 1, 50: PRINT " "; CHR$(2); " "; CHR$(2); " "; CHR$(2); " ";
5780 LOCATE 4 * J + 2, 50: PRINT "       ";
5790 LOCATE 4 * J + 3, 50: PRINT " "; CHR$(2); " "; CHR$(2); " "; CHR$(2); " ": GOTO 6100
5800 '
5810 '   Five
5820 '
5830 LOCATE 4 * J + 1, 50: PRINT " "; CHR$(2); "   "; CHR$(2); " ";
5840 LOCATE 4 * J + 2, 50: PRINT "   "; CHR$(2); "   ";
5850 LOCATE 4 * J + 3, 50: PRINT " "; CHR$(2); "   "; CHR$(2); " ": GOTO 6100
5860 '
5870 '   Four
5880 '
5890 LOCATE 4 * J + 1, 50: PRINT " "; CHR$(2); "   "; CHR$(2); " ";
5900 LOCATE 4 * J + 2, 50: PRINT "       ";
5910 LOCATE 4 * J + 3, 50: PRINT " "; CHR$(2); "   "; CHR$(2); " ": GOTO 6100
5920 '
5930 '   Three
5940 '
5950 LOCATE 4 * J + 1, 50: PRINT " "; CHR$(2); "     ";
5960 LOCATE 4 * J + 2, 50: PRINT "   "; CHR$(2); "   ";
5970 LOCATE 4 * J + 3, 50: PRINT "     "; CHR$(2); " ": GOTO 6100
5980 '
5990 '   Two
6000 '
6010 LOCATE 4 * J + 1, 50: PRINT " "; CHR$(2); "     ";
6020 LOCATE 4 * J + 2, 50: PRINT "       ";
6030 LOCATE 4 * J + 3, 50: PRINT "     "; CHR$(2); " ": GOTO 6100
6040 '
6050 '   One
6060 '
6070 LOCATE 4 * J + 1, 50: PRINT "       ";
6080 LOCATE 4 * J + 2, 50: PRINT "   "; CHR$(2); "   ";
6090 LOCATE 4 * J + 3, 50: PRINT "       ": GOTO 6100
6100 '   Get Out
6110 COLOR 15, 1
6120 LOCATE 1, 1
6130 RETURN
6140 '
6150 '   Computer Option
6160 '
6170 CC = 0
6180 LOCATE 25, 1
6190 PRINT "Do you wish to play against me?  Y/N  "; : GOSUB 2120
6200 Y$ = INKEY$: IF Y$ = "" THEN 6200 ELSE BEEP
6210 IF Y$ = "N" THEN RETURN
6220 IF Y$ <> "Y" THEN 6180
6230 CC = 1
6240 RETURN
6250 '
6260 '   Check For aces-Sixes Any Position
6270 '
6280 X = -1
6290 FOR J = 0 TO 4
6300  IF S(O, J) = I THEN X = J
6310 NEXT J
6320 RETURN
6330 '
6340 '   Total Dice Value
6350 '
6360 FOR J = 1 TO 5
6370 K(I, A) = K(I, A) + C(J)
6380 NEXT J
6390 RETURN
6400 '
6410 '   Matrix Information
6420 '
6430 '   c(5)     Current Dice
6440 '   K(18,7)  Scoreboard
6450 '            Columns 1-13 Board Number
6460 '            Columns   14 Bonus Upper
6470 '            Column    15 Total Upper
6480 '            Column    16 Total Lower
6490 '            Column    17 Grand Total
6500 '            Column    18 Done/Not Done Status
6510 '            Row     1- 7 Players Score
6520 '            Row        N Computers Score (<7 Players)
6530 '
6540 '   F(5)     Dice Number to Roll Again
6550 '   A$(7)    Players Names
6560 '   S(6,5)   Computers Dice Logic
6570 '            Column     0 Dice Number by Qty Sequence
6580 '            Column     1 Qty/Position for Aces
6590 '            Column     2 Qty/Position for Twos
6600 '            Column     3 Qty/Position for Threes
6610 '            Column     4 Qty/Position for Fours
6620 '            Column     5 Qty/Position for Fives
6630 '            Column     6 Qty/Position for Sixes
6640 '            Row        0 Quantity of Dice
6650 '            Row     1- 5 Position of Dice in C(5)
6660 '
6670 '  Sample S(Y,X)  for Dice of 5,2,4,6,4
6680 '
6690 '  Y/X  0  1  2  3  4  5
6700 '  0    4  6  5  2            In qty/value sequence
6710 '  1                          NO DIE =1
6720 '  2    1  2                  1 Two Position 2
6730 '  3                          NO DIE =3
6740 '  4    2  3  5               2 Fours Position 3 and 5
6750 '  5    1  1                  1 Five Position 1
6760 '  6    1  4                  1 Six Position 4
6770 '          +           +
6780 '  +    +  ++++++++++++++++++ Section for Position Data
6790 '  +    + ------------------- Column Indicates Qty
6800 '  +------------------------- Index Equates to Dice Value
6810 '
6820 '  M(13)    Priority numbers for must score where value
6830 '           refers to play board number
6840 '
6850 '  To run internal checks - enter A -1 for
6860 '  playing board number or qty of dice to roll
6870 '  again - - Data will not be lost and screen
6880 '  will be reset with current dice shown - -
6890 '  players / computers score will not show until
6900 '  after their turn
6910 '
6920 '  Computer Priorities
6930 RESTORE 6940
6940 DATA 11, 9, 12, 8, 1, 2, 3, 4, 5, 6, 10, 7, 13
6950 FOR Y = 1 TO 13: READ M(Y): NEXT Y: RETURN: RETURN
6960 '   Player's Board
6970 CLS
6980 PRINT "             ÚÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄ¿"
6990 PRINT "ONES........1³...³...³...³...³...³...³1"
7000 PRINT "TWOS........2³...³...³...³...³...³...³2"
7010 PRINT "THREES......3³...³...³...³...³...³...³3"
7020 PRINT "FOURS.......4³...³...³...³...³...³...³4"
7030 PRINT "FIVES.......5³...³...³...³...³...³...³5"
7040 PRINT "SIXES.......6³...³...³...³...³...³...³6"
7050 PRINT "             ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´"
7060 PRINT "TOTAL UPPER..³...³...³...³...³...³...³"
7070 PRINT "             ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´"
7080 PRINT "3 OF A KIND.7³...³...³...³...³...³...³7"
7090 PRINT "4 OF A KIND.8³...³...³...³...³...³...³8"
7100 PRINT "FULL HOUSE..9³...³...³...³...³...³...³9"
7110 PRINT "SM STRAIGHT.A³...³...³...³...³...³...³A"
7120 PRINT "LG STRAIGHT.B³...³...³...³...³...³...³B"
7130 PRINT "YAHTZEE.....C³...³...³...³...³...³...³C"
7140 PRINT "CHANCE......D³...³...³...³...³...³...³D"
7150 PRINT "             ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´"
7160 PRINT "TOTAL LOWER..³...³...³...³...³...³...³"
7170 PRINT "TOP BONUS....³...³...³...³...³...³...³"
7180 PRINT "GRAND TOTAL..³...³...³...³...³...³...³"
7190 PRINT "             ÀÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÙ"
7200 PRINT "               1   2   3   4   5"
7210 RETURN
7220 LOCATE 25, 1: PRINT STRING$(70, " "); : LOCATE 25, 1: RETURN
7230 ' KB Input and Escape
7240 KB$ = "": WHILE KB$ = "": KB$ = INKEY$: WEND
7250 IF KB$ = CHR$(27) THEN 5220
7260 IF KB$ = CHR$(81) OR KB$ = CHR$(89) OR KB$ = CHR$(70) THEN ER(A) = 1
7270 IF KB$ = CHR$(87) OR KB$ = CHR$(69) OR KB$ = CHR$(82) THEN ER(A) = 1
7280 IF KB$ = CHR$(84) OR KB$ = CHR$(79) OR KB$ = CHR$(85) THEN ER(A) = 1
7290 IF KB$ = CHR$(73) THEN ER(A) = 1
7300 RETURN
7310 ' Secret
7320 H = H + 1: MR = 0
7330 ER = INT(6 * RND(1) + 1)
7340 C(1) = ER: C(3) = ER: C(5) = ER
7350 C(2) = INT(6 * RND(1) + 1): C(4) = INT(6 * RND(1) + 1)
7360 FOR B = 1 TO 5
7370 J = B - 1: DIE = C(B): F(B) = 0
7380 GOSUB 5390
7390 GOSUB 5670
7400 NEXT B
7410 RETURN
7420 C(2) = ER: C(4) = INT(6 * RND(1) + 1)
7430 IF C(4) = ER THEN C(4) = ER - 2
7440 ER(A) = 2: RETURN
7450 C(4) = ER: ER(A) = 0: RETURN

