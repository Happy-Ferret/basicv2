0 V=53248:POKE54276,0:POKE54290,0:POKE54278,240:POKE54292,240:POKE54276,129
1 POKE54290,17:POKEV+33,0:POKEV+32,0:SC=1024:CL=55296:CO=54272:POKE54296,15
5 POKE56,28:POKE55,0:FOR I=12544 TO 12551:POKEI,0:NEXT
10 GOSUB 8000:GOSUB 8060:GOTO1000
99 IF K=1 THEN 99
100 IF K<>12 AND K<>20 THEN 150
105 POKESC+Y*40+X,32:X=X-(K=12)*(X>0)+(K=20)*(X<39):IF PEEK(SC+Y*40+X)<>32 THEN D=1
110 POKECL+Y*40+X,3:POKESC+Y*40+X,0
115 RETURN
150 IF K=36 AND SX<0 THEN SX=X:SY=Y-1:POKE54273,72:POKE54272,169
155 RETURN
200 POKESC+SY*40+SX,32:SY=SY-1:IF SY<1 THEN SX=-1:RETURN
205 P=PEEK(SC+SY*40+SX)
210 POKECL+SY*40+SX,7:POKESC+SY*40+SX,2:IF P=32 THEN RETURN
215 POKE54273,34:POKE54272,75:POKESC+SY*40+SX,4
220 IF P<>1 THEN 250
225 FOR Y1=8 TO 0 STEP-2:FOR X1=10 TO 0 STEP-2:P=IN+Y1*6+X1
230 IF PEEK(P)<>SY OR PEEK(P+1)<>SX THEN 245
235 S=S+(12-Y1)*5:NO=NO-1:POKEP+1,255:X1=0:Y1=0
245 NEXT:NEXT:GOTO 275
250 IF P<>3 THEN 275
255 FOR J=0 TO 5:IF S(J)=SC+SY*40+SX THENS=S+5:S(J)=0:J=5
260 NEXT
275 POKESC+SY*40+SX,32:SX=-1:RETURN
300 POKES(J),32:S(J)=S(J)+40:IF S(J)>1983 THEN S(J)=0:RETURN
305 P=PEEK(S(J)):POKES(J)+CO,3:POKES(J),3
310 IF P=32 THEN RETURN
315 POKES(J),4:POKE54273,43:POKE54272,52:IF P=0 THEN D=1
320 IF S(J)=SC+SX+SY*40 THEN SX=-1
325 POKES(J),32:S(J)=0:RETURN
500 S1=INT(RND(1)*6):IF S(S1)>0 THEN RETURN
505 FOR Y1=8 TO 0 STEP-2:IF PEEK(IN+Y1*6+S1*2+1)=255 THEN 550
510 S(S1)=SC+(PEEK(IN+Y1*6+S1*2)+1)*40+PEEK(IN+Y1*6+S1*2+1):Y1=0
550 NEXT:RETURN
1000 D=0:FORI=1 TO SP:K=PEEK(PE):IF K<>64 THEN GOSUB 99
1005 IF SX>=0 THEN GOSUB 200
1010 FOR J=0 TO 5:IF S(J)>0 THEN GOSUB 300
1015 NEXT:POKE54273,0:POKE54272,0:POKE54287,0:POKE54286,0
1020 IF RND(1)>.5 THEN GOSUB 500
1100 NEXT:SYS 7168:IF NO<21 THEN SP=3:IF NO<11 THEN SP=2:IF NO<6 THEN SP=1
1101 POKE54287,2:POKE54286,37:IF PEEK(12303)=36 THEN POKE12303,129:GOTO1104
1102 POKE12303,36
1104 IF PEEK(7604)=0 AND D=0 AND NO>0 THEN 1000
1105 IF NO=0 THEN GOSUB 8050:GOTO 1000
1110 POKESC+Y*40+X,4:POKE54273,61:POKE54272,126
1115 FOR I=15 TO 0 STEP-.1:POKE54296,I:NEXT:POKE54287,0:POKE54286,0:POKESC+Y*40+X,0
1117 POKE54273,0:POKE54272,0
1118 IF PEEK(7604)=0 THEN B=B+1:IF B<4 THEN POKE54296,15:GOTO 1000
1120 POKEV+24,20:PRINT"{clear}{down*24}{purple}{space*13}**game over**"
1125 PRINT"{down}you scored"S:RUN
8000 FOR AD=7168 TO 7393
8005 READ A:POKEAD,A:NEXT
8010 FOR AD=12288 TO 12351:READ A:POKEAD,A:NEXT
8015 POKEV+24,28
8050 FOR Y1=0 TO 4:FOR X1=0 TO5:POKE7620+Y1*12+X1*2,Y1*2+1:POKE7621+Y1*12+X1*2,X1*3
8052 NEXT:NEXT
8055 POKE7605,1:POKE7604,0:SX=-1:SY=0:NO=30:SP=4:RETURN
8060 B=1:PRINT"{clear}":FORI=1984 TO 2023
8065 POKEI,5:POKEI+CO,6:NEXT:X=1:Y=23:PE=197:S=0
8070 IN=7620:DIM S(5):POKECL+Y*40+X,3:POKESC+Y*40+X,0
8075 FORY1=1TO4:PRINT"{red}{home}{down*18}"SPC(Y1*10-7)"eee{down}{left*3}eee{down}{left*3}eee";
8077 PRINT"{down}{left*3}f g";
8080 NEXT:RETURN
9000 DATA162,7,142,179,29,162,0,142,180,29,189,197,29,201,255,240,56,141,177,29
9001 DATA189,196,29,141,176,29,169,32,141,178,29,32,162,28,189,197,29,24,109
9005 DATA181,29,157,197,29,201,0,208,5,160,1,140,180,29,201,39,208,5,160,1,140
9010 DATA180,29,141,177,29,169,1,141,178,29,32,162,28,232,232,224,60,208,187
9015 DATA173,180,29,208,1,96,169,0,141,180,29,169,32,141,178,29,162,0,189
9020 DATA197,29,201,255,240,27,141,177,29,189,196,29,141,176,29,32,162,28,254
9025 DATA196,29,189,196,29,201,22,208,5,160,1,140,180,29,232,232,224,60,208
9028 DATA216,173,181,29,201,1,240,4,169,1,208,2,169,255
9030 DATA141,181,29,173,180,29,208,3,76,0,28,96
9035 DATA138,72,152,72,172,176,29,169,0,133,31,169,4,133,32,162,0,24,169
9037 DATA40,109,31,0,133,31,169,0,109,32,0,133,32,232,236,176,29
9040 DATA208,235,172,177,29,173,178,29,145,31,24,169,212,109,32,0,133
9045 DATA32,173,179,29,145,31,104,168,104,170,96,0,16,16,56,124
9050 DATA124,254,254,126,90,255,189,189,36,66,36,0,0,0,16,16,16,56,84,0,84,56
9055 DATA16,56,56,16,0,108,213,128,132,39,174,197,78
9060 DATA255,255,255,255,255,255,255,255,255,254,252,248,240,224,192,128
9065 DATA255,127,63,31,15,7,3,1