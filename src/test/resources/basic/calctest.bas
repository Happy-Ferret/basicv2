0 PRINT CHR$(147)
10 M=RND(1)
11 A=0
12 B=0
20 IF M<0.6 THEN 1000
30 GOTO 2000
1000 A=INT(RND(1)*99+1)
1010 B=INT(RND(1)*99+1)
1020 IF A<B THEN C=A:A=B:B=C
1030 PRINT STR$(A)+" - "+STR$(B)
1040 INPUT E
1045 T=A-B
1050 IF T=E THEN PRINT"STIMMT":GOTO 10
1060 GOTO 1030
2000 A=INT(RND(1)*10+1)
2010 B=INT(RND(1)*10+1)
2030 PRINT STR$(A)+" * "+STR$(B)
2040 INPUT E
2045 T=A*B
2050 IF T=E THEN PRINT"STIMMT":GOTO 10
2060 GOTO 2030
