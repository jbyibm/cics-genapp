      *CONTROL NOSOURCE                                                 AGAVINIT
      *>****************************************************************AGAVINIT
      *> Initialisation des variables de compilation conditionnelle     AGAVINIT
      *> d'Architecture Générale.                                       AGAVINIT
      *> ---------------------------------------------------------------AGAVINIT
      *> - AA-G-BATCH      : programme Batch                            AGAVINIT
      *> - AA-G-CICS       : programme TP CICS                          AGAVINIT
      *> - AA-G-EXCI       : programme Batch avec interface EXCI        AGAVINIT
      *> - AA-G-MIXED      : programme mixte Batch et TP CICS           AGAVINIT
      *> - AA-G-PACBASE    : programme migré depuis Pacbase             AGAVINIT
      *> - AA-G-VARPACBASE : utilisation des variables standard Pacbase AGAVINIT
      *> - IGY-ADV         : valeur de l'option de compilation          AGAVINIT
      *>                     ADV/NOADV                                  AGAVINIT
      *>****************************************************************AGAVINIT
      *CONTROL SOURCE                                                   AGAVINIT
      *> --- Variables calculées automatiquement (ne pas modifier)      AGAVINIT
       >>define AA-G-BATCH as b'0'                                      AGAVINIT
       >>define AA-G-CICS as b'0'                                       AGAVINIT
       >>define AA-G-EXCI as b'0'                                       AGAVINIT
       >>define AA-G-MIXED as b'0'                                      AGAVINIT
       >>if AA-G-PACBASE not defined                                    AGAVINIT
       >>define AA-G-PACBASE as b'0'                                    AGAVINIT
       >>end-if                                                         AGAVINIT
       >>define AA-G-VARPACBASE as b'0'                                 AGAVINIT
       >>define IGY-ADV as parameter                                    AGAVINIT
       >>if IGY-ADV not defined                                         AGAVINIT
       >>define IGY-ADV as b'1'                                         AGAVINIT
       >>end-if                                                         AGAVINIT
