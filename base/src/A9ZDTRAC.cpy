      *CONTROL NOSOURCE                                                 A9ZDTRAC
      *>****************************************************************A9ZDTRAC
      *> Zone de communication module de trace xxTRAC (S9TRAC).         A9ZDTRAC
      *> Dans Pacbase, correspond au Segment ZA04, renommé ES00 dans    A9ZDTRAC
      *> les squelettes programmes Q/R.                                 A9ZDTRAC
      *>****************************************************************A9ZDTRAC
      *CONTROL SOURCE                                                   A9ZDTRAC
      *> --- Zone de communication module de trace xxTRAC (S9TRAC)      A9ZDTRAC
       01                 TRAC.                                         A9ZDTRAC
             10           TRAC-GRSTGE.                                  A9ZDTRAC
              11          TRAC-IDSGPR  PIC X(8).                        A9ZDTRAC
              11          TRAC-CVSTTR  PIC X(1).                        A9ZDTRAC
                      88  TRAC-ACTION-TRACE     VALUE '0'.              A9ZDTRAC
                      88  TRAC-ACTION-ALERTE    VALUE '4'.              A9ZDTRAC
                      88  TRAC-ACTION-ANOMALIE  VALUE '8'.              A9ZDTRAC
                      88  TRAC-ACTION-ABEND     VALUE 'C'.              A9ZDTRAC
              11          TRAC-WABCOD  PIC X(4).                        A9ZDTRAC
              11          TRAC-CISTDB  PIC X(1).                        A9ZDTRAC
                      88  TRAC-TRACE-DB2        VALUE '1'               A9ZDTRAC
                                                FALSE '0'.              A9ZDTRAC
             10           TRAC-GRSTPA.                                  A9ZDTRAC
              11          TRAC-IDSTPA  PIC X(4).                        A9ZDTRAC
              11          TRAC-COSTBI  PIC X(3).                        A9ZDTRAC
              11          TRAC-IDSTSE  PIC X(5).                        A9ZDTRAC
              11          TRAC-GRSTSF.                                  A9ZDTRAC
               12         TRAC-COSTFO  PIC X(2).                        A9ZDTRAC
               12         TRAC-COSTSF  PIC X(2).                        A9ZDTRAC
             10           TRAC-GRSTDB.                                  A9ZDTRAC
              11          TRAC-WORDRE  PIC X(6).                        A9ZDTRAC
              11          TRAC-WTABLE  PIC X(10).                       A9ZDTRAC
             10           TRAC-XCLER7  PIC X(17).                       A9ZDTRAC
             10           TRAC-LLSTME  PIC X(136).                      A9ZDTRAC
             10           TRAC-FILLER  PIC X(101).                      A9ZDTRAC
      *> --- Compatibilité framework accès Db2 Pacbase                  A9ZDTRAC
       >>if not AA-A-DB2-TRACE                                          A9ZDTRAC
       >>define AA-A-DB2-TRACE as b'1' override                         A9ZDTRAC
       66                 SQL-VTRACE RENAMES TRAC-GRSTSF                A9ZDTRAC
                                        THRU TRAC-WORDRE.               A9ZDTRAC
       66                 SQL-VTABLE RENAMES TRAC-WTABLE.               A9ZDTRAC
       >>end-if                                                         A9ZDTRAC
