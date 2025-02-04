      *CONTROL NOSOURCE                                                 AEADMSGE
      *>****************************************************************AEADMSGE
      *> Programme Q/R : zones de travail Message reçu                  AEADMSGE
      *>----------------------------------------------------------------AEADMSGE
      *> Paramètres REPLACING :                                         AEADMSGE
      *>----------------------------------------------------------------AEADMSGE
      *> Variables de compilation locales :                             AEADMSGE
      *>****************************************************************AEADMSGE
      *CONTROL SOURCE                                                   AEADMSGE
       01                 MESSAGE-RECU.                                 AEADMSGE
               10         MESSAGE-RECU-LENGTH PIC 9(4).                 AEADMSGE
               10         MESSAGE-RECU-WLNQR.                           AEADMSGE
                      88  QUESTION-AISA12     VALUE 'QAISA12 '.         AEADMSGE
                      88  QUESTION-AISA13     VALUE 'QAISA13 '.         AEADMSGE
                11        MESSAGE-RECU-CTSEQR PIC X.                    AEADMSGE
                11        MESSAGE-RECU-WLNQR6 PIC X(6).                 AEADMSGE
                11        MESSAGE-RECU-CNSEQR PIC X.                    AEADMSGE
               10                             PIC X(9987).              AEADMSGE
      *> COBOL peut aussi être idiot...                                 AEADMSGE
      *>01                 MESSAGE-RECU REDEFINES MESSAGE-RECU-MAX.     AEADMSGE
      *>        10                             PIC X                    AEADMSGE
      *>                                       OCCURS 0 TO 9999         AEADMSGE
      *>                                       DEPENDING ON             AEADMSGE
      *>                                       MESSAGE-RECU-LENGTH.     AEADMSGE
