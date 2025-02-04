      *CONTROL NOSOURCE                                                 AGADPAC0
      *>****************************************************************AGADPAC0
      *> Variables standard Pacbase                                     AGADPAC0
      *> Ce copybook reproduit les variables de travail qui sont        AGADPAC0
      *> utilisées dans certaines fonctions du framework.               AGADPAC0
      *> Chaque programme COBOL doit appeler ce copybook.               AGADPAC0
      *-----------------------------------------------------------------AGADPAC0
      *> BLANC  : constante 1 caractère initialisée à SPACE             AGADPAC0
      *> IK     : résultat d'un accès, (Invalid Key) : '0'=OK, '1'=KO   AGADPAC0
      *> TALLI  : variable pour comptages (COBOL déclare TALLY)         AGADPAC0
      *> EN-PRE : indicateur présence ou état                           AGADPAC0
      *>****************************************************************AGADPAC0
      *CONTROL SOURCE                                                   AGADPAC0
       >>define AA-G-VARPACBASE as b'1' override                        AGADPAC0
      *> --- Variables Pacbase (pour compatibilité)                     AGADPAC0
       01               BLANC         PIC X VALUE SPACE.                AGADPAC0
       01               IK            PIC X.                            AGADPAC0
                    88  IK-OK               VALUE '0'                   AGADPAC0
                                            FALSE '1'.                  AGADPAC0
                    88  IK-KO               VALUE '1'                   AGADPAC0
                                            FALSE '0'.                  AGADPAC0
       01               TALLI         PIC S9(4) BINARY VALUE 0.         AGADPAC0
       01               EN-PRE        PIC X.                            AGADPAC0
      *> Contrôles de validité / invalidité sur date                    AGADPAC0
                    88  5-DATE-VALIDE       VALUE '1'.                  AGADPAC0
                    88  5-DATE-INVALIDE     VALUE '5'.                  AGADPAC0
