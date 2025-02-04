      *CONTROL NOSOURCE                                                 A9ZDMESS
      *>****************************************************************A9ZDMESS
      *> Zone de communication module recherche libellé d'erreur        A9ZDMESS
      *> xxMESS, (S9MESS).                                              A9ZDMESS
      *> Dans Pacbase, correspond au Segment ZA03, renommé ZA00 dans    A9ZDMESS
      *> les squelettes programmes Q/R.                                 A9ZDMESS
      *> Zone de travail : uniquement requise pour les fonctions de     A9ZDMESS
      *> contrôle du contenu des Messages, correspond au Segment XS00,  A9ZDMESS
      *> à supprimer lors de la réécriture du code de contrôle car      A9ZDMESS
      *> redondant avec ZA03.                                           A9ZDMESS
      *>****************************************************************A9ZDMESS
      *CONTROL SOURCE                                                   A9ZDMESS
      *> --- Zone de travail pour accès module recherche libellé erreur A9ZDMESS
       01                 MESW.                                         A9ZDMESS
               10         MESW-XCLER7.                                  A9ZDMESS
                11        MESW-XAPPLI  PIC X(3)  VALUE SPACE.           A9ZDMESS
                11        MESW-XTYEN   PIC X(1)  VALUE SPACE.           A9ZDMESS
                11        MESW-XSEEC.                                   A9ZDMESS
                 12       MESW-XFIENR.                                  A9ZDMESS
                  13      MESW-XCOSD   PIC X(2)  VALUE SPACE.           A9ZDMESS
                  13      MESW-XCOSG   PIC X(2)  VALUE SPACE.           A9ZDMESS
                 12       MESW-FILLER  PIC X(2)  VALUE SPACE.           A9ZDMESS
                11        MESW-XNUER4.                                  A9ZDMESS
                 12       MESW-XNUERR.                                  A9ZDMESS
                  13      MESW-XNUER9  PIC 9(3)  VALUE ZERO.            A9ZDMESS
                 12       MESW-XTYERR  PIC X(1)  VALUE SPACE.           A9ZDMESS
                11        MESW-XNLGN   PIC X(3)  VALUE SPACE.           A9ZDMESS
               10         MESW-XGRAER  PIC X(1)  VALUE SPACE.           A9ZDMESS
               10         MESW-XLIER1  PIC X(30) VALUE SPACE.           A9ZDMESS
               10         MESW-XLIER2  PIC X(36) VALUE SPACE.           A9ZDMESS
               10         MESW-FILLER  PIC X(6)  VALUE SPACE.           A9ZDMESS
      *> --- Zone de communication module recherche libellé erreur      A9ZDMESS
       01                 MESS.                                         A9ZDMESS
               10         MESS-GRXXDE.                                  A9ZDMESS
                11        MESS-XCLER7.                                  A9ZDMESS
                 12       MESS-XAPPLI  PIC X(3)  VALUE SPACE.           A9ZDMESS
                 12       MESS-XTYEN   PIC X(1)  VALUE SPACE.           A9ZDMESS
                      88  MESS-XTYEN-AUTO-SEG VALUE 'A'.                A9ZDMESS
                      88  MESS-XTYEN-AUTO-ECR VALUE 'H'.                A9ZDMESS
                      88  MESS-XTYEN-AUTO-IDX VALUE 'I'.                A9ZDMESS
                      88  MESS-XTYEN-PART-PGM VALUE 'P'.                A9ZDMESS
                 12       MESS-XSEEC.                                   A9ZDMESS
                  13      MESS-XFIENR.                                  A9ZDMESS
                   14     MESS-XCOSD   PIC X(2)  VALUE SPACE.           A9ZDMESS
                   14     MESS-XCOSG   PIC X(2)  VALUE SPACE.           A9ZDMESS
                  13      MESS-FILLER  PIC X(2)  VALUE SPACE.           A9ZDMESS
                 12       MESS-XNUER4.                                  A9ZDMESS
                  13      MESS-XNUERR.                                  A9ZDMESS
                   14     MESS-XNUER9  PIC 9(3)  VALUE ZERO.            A9ZDMESS
                  13      MESS-XTYERR  PIC X(1)  VALUE SPACE.           A9ZDMESS
                 12       MESS-XNLGN   PIC X(3)  VALUE SPACE.           A9ZDMESS
                 11       MESS-WCOACT  PIC X(1)  VALUE SPACE.           A9ZDMESS
               10         MESS-GRXXDS.                                  A9ZDMESS
                11        MESS-GRXXCR.                                  A9ZDMESS
                 12       MESS-WCODM   PIC X(3)  VALUE SPACE.           A9ZDMESS
                 12       MESS-WCOLE   PIC X(8)  VALUE SPACE.           A9ZDMESS
                11        MESS-XGRAER  PIC X(1)  VALUE SPACE.           A9ZDMESS
                11        MESS-WLE80.                                   A9ZDMESS
                 12       MESS-LISTER  PIC X(79) VALUE SPACE.           A9ZDMESS
                 12       MESS-CISTPI  PIC X(1)  VALUE SPACE.           A9ZDMESS
                11        MESS-WX080   REDEFINES                        A9ZDMESS
                          MESS-WLE80.                                   A9ZDMESS
                 12       MESS-XLIER1  PIC X(30).                       A9ZDMESS
                 12       MESS-XLIER2  PIC X(36).                       A9ZDMESS
                 12       MESS-FILLER  PIC X(14).                       A9ZDMESS
                11        MESS-WNOMES.                                  A9ZDMESS
                 12       MESS-XZ3RET  PIC X(4)  VALUE SPACE.           A9ZDMESS
                 12       MESS-XZ3ANO  PIC X(10) VALUE SPACE.           A9ZDMESS
                 12       MESS-FILLER  PIC X(3)  VALUE SPACE.           A9ZDMESS
                11        MESS-FILLER  PIC X(3)  VALUE SPACE.           A9ZDMESS
               10         MESS-WCTABE  PIC X(1)  VALUE SPACE.           A9ZDMESS
               10         MESS-WCORE3  PIC 9(3)  VALUE ZERO.            A9ZDMESS
       >>if AA-G-PACBASE                                                A9ZDMESS
       66                 ZA00-XNUERR  RENAMES MESS-XNUERR.             A9ZDMESS
       66                 ZA00-XTYERR  RENAMES MESS-XTYERR.             A9ZDMESS
       66                 ZA00-WLE80   RENAMES MESS-WLE80.              A9ZDMESS
       >>end-if                                                         A9ZDMESS
