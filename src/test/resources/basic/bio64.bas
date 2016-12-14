10 REM*********************************15 REM*                               *20 REM*     B I O R H Y T H M U S     *25 REM*                               *30 REM*  PROGRAMM ZUR ERMITTLUNG DES  *35 REM* BIORHYTHMUS, DES WOCHENTAGES  *40 REM*  UND BELIEBIGER ZEITSPANNEN   *45 REM*       (C64 BASIC 2.0)         *50 REM*  HEIMO PONNATH  HAMBURG 1987  *55 REM*                               *60 REM*********************************65 POKE 53280,0:POKE 53281,0:PRINTCHR$(30)70 PRINTCHR$(147)75 REM ---- VARIABLE,KONSTANTEN ---80 A$="":T$="":M$="":G$=""85 T=0:T1=0:T2=0:M=0:M1=0:M2=0:G=0:G1=0:G2=0:J=0:J1=0:J2=0:C=0:C1=0:C2=090 K=0:K1=0:K2=0:I=0:F=1:S=1:DZ=0:D=0:W=0:YK=0:YS=0:YG=0:RA=0:RB=0:TA=0:TB=095 BB=32:BH=24:XU=1:XO=32:YU=-140:YO=110:X=0:Y1=0:Y2=0:Y3=0:Z=0100 RA=BB/(XO-XU):RD=-BH/(YO-YU)105 TA=-BB*XU/(XO-XU)+5:TB=BH*YO/(YO-YU)+1110 DEF FN X(X)=RA*X+TA115 DEF FN Y(Y)=RD*Y+TB120 DEF FN K(X)=INT(100*SIN(.27318197*X)+.5)122 DEF FN S(X)=INT(100*SIN(.224399475*X)+.5)124 DEF FN G(X)=INT(100*SIN(.190399555*X)+.5)125 DIM M(12),M$(12),T$(6),A(12)130 REM135 DATA 31,JANUAR,28,FEBRUAR,31,MAERZ,30,APRIL,31,MAI,30,JUNI140 DATA 31,JULI,31,AUGUST,30,SEPTEMBER,31,OKTOBER,30,NOVEMBER,31,DEZEMBER145 DATA SAMSTAG,SONNTAG,MONTAG,DIENSTAG,MITTWOCH,DONNERSTAG,FREITAG147 DATA 0,31,59,90,120,151,181,212,243,273,304,334150 FOR I=1 TO 12155 READ M(I),M$(I)160 NEXT I165 FOR I=0 TO 6170 READ T$(I)175 NEXT I176 FOR I=1 TO 12177 READ A(I)178 NEXT I180 TJ=4:MJ=10:SJ=1582:REM BEGINN DES GREGORIANISCHEN KALENDERS290 REM ---- MENUE 1 ---------------295 PRINTCHR$(147)300 PRINTCHR$(18)"        B I O R H Y T H M U S         "CHR$(146)305 PRINT:PRINT:PRINT:PRINT:PRINT:PRINT310 PRINT:PRINTTAB(3)"FESTSTELLEN DES WOCHENTAGES......1"315 PRINT:PRINTTAB(3)"ZEITDIFFERENZ BERECHNEN..........2"320 PRINT:PRINTTAB(3)"BIORHYTHMUS BESTIMMEN............3"325 PRINT:PRINTTAB(3)"PROGRAMMENDE.....................4"330 PRINT:PRINT:PRINTTAB(8)"SIE HABEN DIE WAHL !"335 GET A$:IF VAL(A$)<1 OR VAL(A$)>4 THEN 335340 PRINTCHR$(147):IF VAL(A$)=4 THEN END345 ON VAL(A$) GOSUB 1000,2000,3000350 GET A$:IF A$="" THEN 350355 GOTO 295400 REM --- DATUMSEINGABE --------------405 PRINT:INPUT"TAG (Z.B. 12)        ";T$410 INPUT"MONAT (Z.B. 6)       ";M$415 INPUT"JAHR (Z.B. 1987)     ";G$420 T=VAL(T$):M=VAL(M$):G=VAL(G$)425 J=VAL(RIGHT$(G$,2)):C=VAL(LEFT$(G$,2))430 REM PRUEFEN OB GREGORIANISCH ODER JULIANISCH435 IF G<SJ THEN K=0:GOTO 470440 IF G>SJ THEN K=1:GOTO 470445 IF M<MJ THEN K=0:GOTO 470450 IF M>MJ THEN K=1:GOTO 470455 IF T<=TJ THEN K=0:GOTO 470457 IF T>TJ AND T<15 THEN PRINT"BEI DER KALENDERREFORM FOLGTE AUF DEN 4.10.1582"458 IF T>TJ AND T<15 THEN PRINT"SOFORT DER 15.10.1582!":GOTO 405460 K=1465 REM ZULAESSIGKEIT PRUEFEN470 IF M>12 THEN F=1:GOTO 515475 IF T<=M(M) THEN F=0:GOTO 490480 IF T>M(M) AND M<>2 THEN F=1:GOTO 515485 REM SCHALTJAHR FESTSTELLEN490 S=G-4*INT(G/4)495 IF K=0 AND S<1E-6 THEN S=0:REM JULIANISCHES SCHALTJAHR500 IF K=1 AND S<1E-6 AND (C-4*INT(C/4)<1E-6) THEN S=0:REM GREGORIAN. SCHALTJ.505 IF M=2 AND S=0 AND T<=29 THEN RETURN510 IF F=0 THEN RETURN515 PRINT"DIESES DATUM IST FALSCH!":PRINT"BITTE NEU EINGEBEN."520 GOTO 4051000 REM -- FESTSTELLEN DES WOCHENTAGES --1005 F=11010 GOSUB 400:REM DATUMSEINGABE1015 REM KALENDERFORMELN VON ZELLER1020 IF M=1 OR M=2 THEN M=M+12:J=J-1:IF J<0 THEN J=99:C=C-11025 DZ=T+INT(2.6*(M+1))+J+INT(J/4)1030 IF K=0 THEN D=DZ+5-C:REM JULIANISCHER KALENDER1035 IF K=1 THEN D=DZ+INT(C/4)-2*C:REM GREGORIANISCHER KALENDER1040 W=D-7*INT(D/7)1045 IF M=13 OR M=14 THEN M=M-12:J=J+1:IF J=100 THEN J=0:C=C+11050 PRINT:PRINT"DER "T"."M$(M)" "G" IST EIN "T$(W)1055 RETURN2000 REM -- ZEITDIFFERENZ BERECHNEN --2005 GOSUB 1000:REM EINGABE UND WOCHENTAG2010 T1=T:M1=M:G1=G:J1=J:C1=C:K1=K:S1=S2015 GOSUB 1000:REM 2.DATUM2020 T2=T:M2=M:G2=G:J2=J:C2=C:K2=K:S2=S2025 IF K1=0 AND K2=0 THEN 2085:REM NUR JULIANISCHE DATEN2030 IF K1=1 AND K2=1 THEN 2125:REM NUR GREGORIANISCHE DATEN2035 REM HIER DATUM 1 JULIANISCH,DATUM 2 GREGORIANISCH2040 T=T1:M=M1:G=G1:S=S12045 GOSUB 2165:REM JULIANISCH2050 GOSUB 2195:DZ=D2055 T=T2:M=M2:G=G2:S=S22060 GOSUB 2180:REM GREGORIANISCH2065 D=D+2:REM KORREKTUR2070 GOSUB 21952075 DI=D-DZ:GOTO 22152080 REM NUR JULIANISCHE DATEN2085 T=T1:M=M1:G=G1:S=S12090 GOSUB 21652095 GOSUB 2195:DZ=D2100 T=T2:M=M2:G=G2:S=S22105 GOSUB 21652110 GOSUB 21952115 DI=D-DZ:GOTO 22152120 REM NUR GREGORIANISCHE DATEN2125 T=T1:M=M1:G=G1:S=S12130 GOSUB 21802135 GOSUB 2195:DZ=D2140 T=T2:M=M2:G=G2:S=S22145 GOSUB 21802150 GOSUB 21952155 DI=D-DZ:GOTO 22152160 REM UP JULIANISCHE TAGZAHL2165 D=A(M)+G*365+INT(G/4)+T+12170 RETURN2175 REM UP GREGORIANISCHE TAGZAHL2180 D=A(M)+G*365+INT(G/4)-INT(G/100)+INT(G/400)+T+12185 RETURN2190 REM UP SCHALTJAHRKORREKTUR2195 IF S=0 AND M=1 THEN D=D-12200 IF S=0 AND M=2 AND T<29 THEN D=D-12205 RETURN2210 REM AUSGABE DER DIFFERENZ2215 PRINT:PRINT"DAZWISCHEN LIEGEN "DI" TAGE."2220 RETURN3000 REM --- BIORHYTHMUS BERECHNEN ----3005 PRINT:PRINT"BITTE GEBEN SIE EIN:"3010 PRINT"1.GEBURTSDATUM UND 2.AKTUELLES DATUM!"3015 GOSUB 2005:REM EINGABE,PRUEFEN,WOCHENTAG,DIFFERENZ3020 YK=FN K(DI):REM KOERPERKURVE3025 YS=FN S(DI):REM SEELENKURVE3030 YG=FN G(DI):REM GEISTKURVE3035 PRINT:PRINT"AM "T2"."M2"."G2" SIND DIE WERTE:"3040 PRINT:PRINT"KOERPERKURVE = "YK3045 PRINT"SEELENKURVE  = "YS3050 PRINT"GEISTKURVE   = "YG3055 GET A$:IF A$="" THEN 30553060 REM -- MENUE 2 -----3065 PRINTCHR$(147):PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT3070 PRINTTAB(5)"NEUES DATUM.............1"3075 PRINT:PRINTTAB(5)"MONATSGRAFIK............2"3080 PRINT:PRINTTAB(5)"ZURUECK ZU MENUE 1......3"3085 GET A$:IF VAL(A$)<1 OR VAL(A$)>3 THEN 30853090 IF A$="3" THEN PRINT:PRINTTAB(10)"BITTE TASTE DRUECKEN":RETURN3095 ON VAL(A$) GOSUB 3200,34003100 GET A$:IF A$="" THEN 31003105 GOTO 30653110 REM3200 REM --- BIORHYTHMUS NEUES DATUM --3205 PRINTCHR$(147)3210 PRINT:PRINT"BITTE NEUES AKTUELLES DATUM ANGEBEN:"3215 GOSUB 2015:REM EINGABE,PRUEFEN,WOCHENTAG,DIFFERENZ3220 GOSUB 3020:REM NEUE BIORHYTHMUSWERTE3225 RETURN3400 REM --- MONATSGRAFIK -------------3402 M=M2:D=DI-T23405 PRINTCHR$(147)CHR$(18)"BIORHYTHMUS IM "M$(M)G2CHR$(146)3410 GOSUB 3500:REM HINTERGRUND ZEICHNEN3415 D=D+Z:REM 0.TAG DES AKTUELLEN MONATS3420 L=M(M):IF S2=0 AND M=2 THEN L=L+13425 FOR I=1 TO L3430 X=FN X(I): Y1=FNY(FNK(D+I)):Y2=FNY(FNS(D+I)):Y3=FNY(FNG(D+I))3435 REM C128:PRINTCHR$(5);:SYS 65520,,Y1,X:PRINTCHR$(119);3436 PRINTCHR$(5);:POKE211,X:POKE214,Y1:SYS58640:PRINTCHR$(119);3440 REM C128:PRINTCHR$(28);:SYS65520,,Y2,X:PRINTCHR$(113);3441 PRINTCHR$(28);:POKE211,X:POKE214,Y2:SYS58640:PRINTCHR$(113);3445 REM C128:PRINTCHR$(31);:SYS65520,,Y3,X:PRINTCHR$(118);3446 PRINTCHR$(31);:POKE211,X:POKE214,Y3:SYS58640:PRINTCHR$(118);3450 NEXT I3455 PRINTCHR$(30)3460 GET A$:IF VAL(A$)<1 OR VAL(A$)>3 THEN 34603465 PRINTCHR$(147):IF VAL(A$)=3 THEN PRINTCHR$(18)" TASTE DRUECKEN! "CHR$(146):RETURN3470 IF VAL(A$)=1 THEN 34853475 Z=L:M=M+1:IF M=13 THEN PRINTCHR$(18)"BITTE TASTE!"CHR$(146):RETURN3480 GOTO 3405:REM NAECHSTER MONAT3485 M=M-1:IF M=0 THEN PRINTCHR$(18)"BITTE TASTE!"CHR$(146):RETURN3490 Z=-M(M):IF S2=0 AND M=2 THEN Z=Z-13495 GOTO 3405:REM VORMONAT3500 REM --- HINTERGRUND ZEICHNEN ----3505 PRINTTAB(5)CHR$(176);:FOR I=1 TO 30:PRINTCHR$(178);:NEXTI3510 PRINTCHR$(174):FOR L=1 TO 9:PRINTTAB(5);3515 FOR I=1 TO 32:PRINTCHR$(125);3520 NEXT I:PRINTCHR$(13)CHR$(145):NEXT L3525 PRINTTAB(5)CHR$(171);:FOR I=1 TO 30:PRINTCHR$(123);:NEXT I:PRINTCHR$(179)3530 FOR L=1 TO 9:PRINTTAB(5);3535 FOR I=1 TO 32:PRINTCHR$(125);3540 NEXT I:PRINTCHR$(13)CHR$(145):NEXT L3545 PRINTTAB(5)CHR$(171)CHR$(177)CHR$(177)CHR$(177);3550 FOR I=1 TO 5:PRINTCHR$(123)CHR$(177)CHR$(177)CHR$(177)CHR$(177);:NEXT I3555 PRINTCHR$(123)CHR$(177)CHR$(189)3560 PRINTTAB(5)CHR$(125)"   ";:FOR I=0 TO 5:PRINTTAB(9+5*I)CHR$(125);:NEXT I3565 PRINTCHR$(13)CHR$(145)3570 PRINTTAB(4)1TAB(8)5TAB(13)10TAB(18)15TAB(23)20TAB(28)25TAB(33)303575 PRINTCHR$(19)CHR$(17)" 100":FOR I=1 TO 9:PRINT:NEXT I3580 PRINT"   0":FOR I=1 TO 9:PRINT:NEXT I:PRINT"-100"3585 PRINT:PRINT:PRINT"VORMONAT (1) NACHMONAT (2) ENDE (3)"CHR$(19)3590 RETURN