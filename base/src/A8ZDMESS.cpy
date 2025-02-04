      *CONTROL NOSOURCE                                                 A8ZDMESS
      *>****************************************************************A8ZDMESS
      *> Zone de communication module recherche libellé d'erreur        A8ZDMESS
      *> xxMESS, (S8MESS).                                              A8ZDMESS
      *> Dans Pacbase, correspond au Segment ZA03, renommé ZA00 dans    A8ZDMESS
      *> les squelettes batchs.                                         A8ZDMESS
      *>****************************************************************A8ZDMESS
      *CONTROL SOURCE                                                   A8ZDMESS
      *> --- Zone de communication module recherche libellé d'erreur    A8ZDMESS
       01                 MESS.                                         A8ZDMESS
               10         MESS-GRXXDE.                                  A8ZDMESS
                11        MESS-XCLER7.                                  A8ZDMESS
                 12       MESS-XAPPLI  PIC X(3).                        A8ZDMESS
                 12       MESS-XTYEN   PIC X(1).                        A8ZDMESS
                      88  MESS-XTYEN-AUTO-SEG VALUE 'A'.                A8ZDMESS
                      88  MESS-XTYEN-PART-PGM VALUE 'Q'.                A8ZDMESS
                 12       MESS-XSEEC.                                   A8ZDMESS
                  13      MESS-XFIENR.                                  A8ZDMESS
                   14     MESS-XCOSD   PIC X(2).                        A8ZDMESS
                   14     MESS-XCOSG   PIC X(2).                        A8ZDMESS
                  13      MESS-FILLER  PIC X(2).                        A8ZDMESS
                 12       MESS-XNUER4.                                  A8ZDMESS
                  13      MESS-XNUERR.                                  A8ZDMESS
                   14     MESS-XNUER9  PIC 9(3).                        A8ZDMESS
                  13      MESS-XTYERR  PIC X(1).                        A8ZDMESS
                 12       MESS-XNLGN   PIC X(3).                        A8ZDMESS
                 11       MESS-WCOACT  PIC X(1).                        A8ZDMESS
               10         MESS-GRXXDS.                                  A8ZDMESS
                11        MESS-GRXXCR.                                  A8ZDMESS
                 12       MESS-WCODM   PIC X(3).                        A8ZDMESS
                 12       MESS-WCOLE   PIC X(8).                        A8ZDMESS
                11        MESS-XGRAER  PIC X(1).                        A8ZDMESS
                11        MESS-WLE80.                                   A8ZDMESS
                 12       MESS-LISTER  PIC X(79).                       A8ZDMESS
                 12       MESS-CISTPI  PIC X(1).                        A8ZDMESS
                11        MESS-WX080   REDEFINES                        A8ZDMESS
                          MESS-WLE80.                                   A8ZDMESS
                 12       MESS-XLIER1  PIC X(30).                       A8ZDMESS
                 12       MESS-XLIER2  PIC X(36).                       A8ZDMESS
                 12       MESS-FILLER  PIC X(14).                       A8ZDMESS
                11        MESS-WNOMES.                                  A8ZDMESS
                 12       MESS-XZ3RET  PIC X(4).                        A8ZDMESS
                 12       MESS-XZ3ANO  PIC X(10).                       A8ZDMESS
                 12       MESS-FILLER  PIC X(3).                        A8ZDMESS
                11        MESS-FILLER  PIC X(3).                        A8ZDMESS
               10         MESS-WCTABE  PIC X(1).                        A8ZDMESS
               10         MESS-WCORE3  PIC 9(3).                        A8ZDMESS
