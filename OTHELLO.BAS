1000 '  Othello  -- Pet Version -- Modified by Erik Anderson
1030 SCREEN 0,0: COLOR 7,0,0:WIDTH 80:KEY OFF
1040 E$="":FOR I= 1 TO 39:E$= E$+ " ":NEXT
1050 D$= CHR$(11)
1060 FOR I= 1 TO 20:D$=D$ + CHR$(10):NEXT
1070 XL= 3:XH= 6:YL= 3:YH= 6
1080 DIM A(9,9), I4(7), J4(7), SC(2), D$(2), P$(2), N$(2):ZO= 0
1090 CLS:LOCATE 1,20:PRINT"Greetings from Othello"
1100 PRINT:PRINT"Othello  is played on an 8 x 8 board, rows numbered"
1110 PRINT"1 to 8  and columns A to H.   The initial configuration is"
1120 PRINT"all blank except for the center four squares. Try to place"
1130 PRINT"your piece so that it  outflanks your  opponent,  creating"
1140 PRINT"horizontal,  vertical, or diagonal run of opposing pieces,"
1150 PRINT"turning them into yours."
1160 PRINT
1170 PRINT:PRINT
1180 PRINT"Example:  Red outflanks Blue,  capturing four Blue pieces."
1190 PRINT"2 make your move,  enter a number for the row and a letter"
1200 PRINT"for the column."
1210 PRINT"Note:  You must  capture at  least one of  your opponent's"
1220 PRINT"pieces in this way if it is possible.  If it is not possi-"
1230 PRINT"ble, you forfeit your move by entering 0 A for your move."
1240 PRINT:PRINT"How many players (1 or 2)? ";:GOSUB 3220:IF VAL (X$)= 0 OR VAL (X$)> 2 THEN 1240
1250 PRINT X$:NP= VAL (X$):PRINT
1260 IF NP=2 THEN PRINT "player #1 goes first when the play starts"
1270 SOUND 3000,2:INPUT  "Enter player 1's name! ";P$(1):P$(1)=P$(1)+ " "+ CHR$(2)
1280 SOUND 3000,2:IF NP= 2 THEN INPUT "Enter Player 2's name! ";P$(2):P$(2)=P$(2) + " " + CHR$(1)
1290 IF NP=2 THEN 1350
1300 PRINT:PRINT"Should I play my best? ";
1310 S2= 0:S4= 0:S5= 0:P$(2)= "IBM PC"
1320 GOSUB 3220:IF X$= "N" THEN PRINT "NO":GOTO 1350
1330 PRINT"YES"
1340 S2= 2:S4= 1:S5= -2
1350 B= -1:W= 1:PT= 0
1360 D$(O+1)= "BLANK"
1370 D$(B+1)= "RED ":N$(B+1)= "RED "
1380 D$(W+1)= "BLUE":N$(W+1)= "BLUE"
1390 FOR K= 0  TO 7
1400 READ I4(K),J4(K)
1410 NEXT
1420 FOR I= 0 TO 9:FOR J= 0 TO 9
1430 A(I,J)= 0
1440 NEXT J,I
1450 A(4,4)= W:A(5,5)= W
1460 A(4,5)= B:A(5,4)= B
1470 SC(1)= 2:SC(2)= 2:N1= 4:Z= 0
1480 C= B:H= W
1490 FOR NN= 1 TO 3000:NEXT:CLS
1500 GOSUB 3300
1510 IF NP= 2 THEN 2020
1520 PRINT D$"Do you want to go first ? ";
1530 PT= 1:GOSUB 3220:IF X$= "Y" THEN PRINT "YES":PT= 0:GOTO 2020
1540 PT= 1:PRINT "NO":PRINT D$E$D$"OK, I AM THINKING!"
1550 '   Computer's Move
1560 IF NP= 1 THEN TIME$="0:0:0":GOTO 1600
1570 IF PT= 2 THEN B1= -1:I3= 0:J3= 0:T1= C:T2= H
1580 IF PT= 1 THEN B1= -1:I3= 0:J3= 0:T1= H:T2= C
1590 GOTO 2030
1600 PT= PT+ 1:IF PT> 2 THEN PT= 1
1610 B1= -1:I3= 0:J3= 0:T1= C:T2= H
1620 FOR I= YL TO YH:FOR J= XL TO XH
1630 IF A(I,J) <> 0 THEN 1790
1640 GOSUB 2740
1650 IF F1= ZO THEN 1790
1660 U= -1
1670 GOSUB 2780
1680 IF S1= ZO THEN 1790
1690 IF (I=1) OR (I=8)THEN S1= S1+ S2
1700 IF (J=1) OR (J=8)THEN S1= S1+ S2
1710 IF (I=2) OR (I=7) THEN S1=S1+ S5
1720 IF (J=2) OR (J=7) THEN S1=S1+ S5
1730 IF (I=3) OR (I=6) THEN S1=S1+ S4
1740 IF (J=3) OR (J=6) THEN S1=S1+ S4
1750 IF S1 < B1 THEN 1790
1760 IF S1> B1 THEN 1780
1770 IF RND(1) > .5 THEN 1790
1780 B1= S1:I3= I:J3= J
1790 NEXT J,I
1800 IF B1 > 0 THEN 1880
1810 IF S5= 0 THEN 1840
1820 IF NP= 1 THEN S5= 0:GOTO 1610
1830 S5= 0:GOTO 1550
1840 S5= 0:PRINT D$E$D$ "I have to forfeit my move!"
1850 IF Z=1 THEN 2430
1860 Z= 1
1870 GOTO 2020
1880 Z= 0
1890 PRINT D$E$D$"I will move to "RIGHT$ (STR$ (I3),1)" "CHR$(J3+ 64)
1900 GOSUB 3090: '  5
1910 I= I3:J= J3:U= 1
1920 GOSUB 2780
1930 SC(PT)= SC(PT)+ S1+ 1
1940 OP= PT+ 1:IF OP= 3 THEN OP= 1
1950 SC(OP)= SC(OP)- S1
1960 N1=N1+ 1
1970 PRINT D$E$D$"That gives me";
1980 PRINT S1;
1990 PRINT "of your pieces."
2000 GOSUB 3390
2010 IF SC(OP)= 0 OR N1= 64 THEN 2430
2020 T1= H:T2= C
2030 PT=PT +1:IF PT> 2 THEN PT= 1
2040 IF PT= 2 THEN B1= -1:I3= 0:J3= 0:T1= C:T2= H
2050 IF PT= 1 THEN B1= -1:I3= 0:J3= 0:T1= H:T2= C
2060 BEEP
2070 TIME$="0:0:0":PRINT D$E$D$P$(PT)", input your move ! ";:GOSUB 3020
2080 IF (I < 0) OR (J < 0) OR (J > 8) OR (I >8) THEN 2040
2090 IF I < > 0 THEN 2160
2100 PRINT D$E$D$; "Are you forfeiting your turn ? ";
2110 GOSUB 3220: IF X$< > "Y" THEN PRINT "NO":GOTO 2040
2120 PRINT "YES"
2130 IF Z=1 THEN 2430
2140 Z1= 1
2150 GOTO 1550
2160 IF A(I,J)= 0 THEN 2190
2170 PRINT D$"Sorry, square occupied; try again"
2180 GOTO 2270
2190 GOSUB 2740
2200 IF F1= 1 THEN 2230
2210 PRINT D$""E$D$"Sorry, not next to my pieces; try again"
2220 GOTO 2270
2230 U= -1
2240 GOSUB 2780
2250 IF S1> 0 THEN 2290
2260 PRINT D$""E$D$"Sorry, doesn't flank a row; try again"
2270 PRINT E$D$:BEEP:FOR N=1 TO 2000:NEXT
2280 GOTO 2040
2290 Z= 0:GOSUB 3150
2300 PRINT D$""E$D$""P$(PY)" That gives you";
2310 PRINT S1;
2320 PRINT "piece";:IF S1> 1 THEN PRINT "s";
2330 PRINT:PRINT E$D$
2340 U= 1
2350 GOSUB 2780
2360 SC(PT)= SC(PT)+ S1+ 1
2370 OP= PT+ 1:IF OP=3 THEN OP= 1
2380 SC(OP)= SC(OP)- S1
2390 N1= N1+ 1
2400 GOSUB 3390
2410 IF SC(OP)= 0 OR N1= 64 THEN 2430
2420 GOTO 1550
2430 PRINT D$E$:PRINT E$:PRINT E$
2440 PRINT D$E$D$P$(1)"  has "SC(1)"pieces    ";
2450 PRINT P$(2)" has "SC(2)" pieces"
2460 IF SC(1)= SC(2) THEN 2150
2470 IF NP= 2 THEN 2540
2480 IF SC(1)> SC(2) THEN 2530
2490 PRINT"Sorry, I won that one.";
2500 GOTO 2540
2510 PRINT "It's a tie !!";
2520 GOTO  2680
2530 PRINT"You won !!!!!!";
2540 C1= SC(1)- SC(2)
2550 IF C1> 0 THEN 2570
2560 C1= - C1
2570 C1= (64* C1)/N1
2580 PRINT "That was a ";
2590 IF C1 < 11 THEN 2670
2600 IF C1 < 25 THEN 2660
2610 IF C1 < 39 THEN 2650
2620 IF C1 < 53 THEN 2640
2630 PRINT "perfect game":GOTO 2680
2640 PRINT "walkaway    ":GOTO 2680
2650 PRINT "fight       ":GOTO 2680
2660 PRINT "hot game    ":GOTO 2680
2670 PRINT "squeaker    "
2680 PRINT
2690 PRINT "Do you want to play another game ? ";:BEEP
2700 GOSUB 3220:IF X$= "Y" THEN PRINT "YES";: RUN 1040
2710 PRINT "NO"
2720 PRINT "Thanks for playing."
2730 CLS: END
2740 F1= ZO: FOR I1 = -1 TO 1:FOR J1= -1 TO 1:IF A(I+ I1,J+  J1)= T2 THEN 2760
2750 NEXT J1, I1:RETURN
2760 F1= 1:RETURN
2770 '   Check for count & flanking pieces
2780 S1= ZO:FOR K= 0 TO 7
2790 S3= ZO:I5= I4(K):J5= J4(K):I6= I+ I5:J6= J+ J5
2800 IF A(I6,J6) < > T2 THEN 2910
2810 S3= S3+ 1:I6= I6+ I5:J6= J6+ J5
2820 IF A(I6,J6)= T1 THEN 2850
2830 IF A(I6,J6)= ZO THEN 2910
2840 GOTO 2810
2850 S1=S1+ S3
2860 IF U< > 1 THEN 2910
2870 I6= I:J6= J
2880 FOR K1= 0 TO S3
2890 A(I6,J6)= T1:I6= I6+ I5:J6= J6+ J5
2900 NEXT K1
2910 NEXT K
2920 RETURN
2930 '    3Set search limits for computer moves
2940 IF I=YL THEN YL=YL- 1:IF YL< 1 THEN YL= 1
2950 IF I=YH THEN YH=YH+ 1:IF YH> 8 THEN YH= 8
2960 IF J=XL THEN XL=XL- 1:IF XL< 1 THEN XL= 1
2970 IF J=XH THEN XH=XH+ 1:IF XH> 8 THEN XH= 8
2980 LOCATE 1,1:PRINT TI$;"  "
2990 RETURN
3000 ' Input Subroutine5
3010 PRINT D$E$"Bad move; Try again."
3020 I= -1:J= -1
3030 FOR K= 1 TO 2
3040 GOSUB 3220
3050 G= ASC (X$)
3060 IF 47 < G AND G < 58 THEN I=G- 48:PRINT ""X$"  ";
3070 IF 64 < G AND G < 74 THEN J=G- 64:PRINT ""X$"  ";
3080 NEXT:PRINT:RETURN
3090 ' Blink Computer Move5
3100 LOCATE 2* J3+ 3, 4* I3+ 1:COLOR 26,0:PRINT CHR$(1):COLOR 7,0
3110 I= I3:J= J3
3120 GOSUB 2940
3130 FOR NN= 1 TO 1000:NEXT
3140 RETURN
3150 '   Blink Player's Move5
3160 IF PT= 2 THEN CC= 0
3170 IF PT= 1 THEN CC= 2
3180 LOCATE 2* J+ 3,4* I+ 1:COLOR 26,0:PRINT CHR$(2):COLOR 7,0
3190 GOSUB 2940
3200 FOR NN=1 TO 500: NEXT
3210 RETURN
3220 '   Input Statements
3230 SOUND 3000,2
3240 X$=INKEY$:IF X$="" THEN 3240 ELSE IF X$=CHR$(27) THEN 2730 ELSE RETURN
3250 '   Print Score
3260 LOCATE 5,36:PRINT CHR$(2);RIGHT$ ("  "+ STR$ (SC(1)),3);" ":LOCATE 19,36:PRINT CHR$(1);RIGHT$ ("  "+STR$ (SC(2)),3);" ";:LOCATE 1,1
3270 RETURN
3280 '   Board Data
3290 DATA 0,1,-1,1,-1,0,-1,-1,0,-1,1,-1,1,0,1,1
3300 '   5 Other  Othello Board
3310 CLS:LOCATE 1,10:PRINT"O T H E L L O"
3320 LOCATE 3,5:PRINT"1   2   3   4   5   6   7   8"
3330 FOR N= 1 TO 8:LOCATE 3+2*N,1:PRINT CHR$(N+64):NEXT
3340 LOCATE 4,3   :PRINT"ษอออหอออหอออหอออหอออหอออหอออหอออป":FOR N=1 TO 13 STEP 2
3350 LOCATE 4+ N,3:PRINT"บ   บ   บ   บ   บ   บ   บ   บ   บ"
3360 LOCATE 5+ N,3:PRINT"ฬอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออน":NEXT
3370 LOCATE 4+ N,3:PRINT"บ   บ   บ   บ   บ   บ   บ   บ   บ"
3380 LOCATE 5+N,3 :PRINT"ศอออสอออสอออสอออสอออสอออสอออสอออผ"
3390 FOR I= 1 TO 8
3400 FOR J= 1 TO 8:LOCATE 2* J+ 3,4* I+ 1:FACE= (A(I,J)+ 3)/2
3410 IF FACE = 1.5 THEN PRINT" " ELSE PRINT CHR$(FACE)
3420 NEXT J,I
3430 GOSUB 3250
3440 RETURN
3450 END
