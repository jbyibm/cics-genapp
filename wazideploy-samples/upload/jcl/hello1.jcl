//HELLO01 JOB 'WD-PKGBIND',MSGLEVEL=(1,1),MSGCLASS=R,NOTIFY=&SYSUID
//*
//* PRINT "HELLO WORLD" ON JOB OUTPUT
//*
//* #SUB1
//* #SUB2
//* #SUB3
//STEP0001 EXEC PGM=IEBGENER
//SYSIN    DD DUMMY
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD *
HELLO, WORLD #SUB1
HELLO, WORLD #SUB2
HELLO, WORLD #SUB3
/*
//SYSUT2   DD SYSOUT=*
//
