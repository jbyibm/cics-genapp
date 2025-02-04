      *> --- Zone de communication middleware Echanges                  AEADDEM0
           copy AEZDECHG.                                               AEADDEM0
      *> --- Zone de travail cinématique Demandeur                      AEADDEM0
       01               W-DEM0.                                         AEADDEM0
           10                          PIC X(1).                        AEADDEM0
                    88  F-DEM0-INITIAL           VALUE '0'.             AEADDEM0
                    88  F-DEM0-PREMIERE-QUESTION VALUE '1'.             AEADDEM0
                    88  F-DEM0-REPONSES-A-LIRE   VALUE '2'.             AEADDEM0
                    88  F-DEM0-DERNIERE-REPONSE  VALUE '3'.             AEADDEM0
                    88  F-DEM0-QUESTION-SUIVANTE VALUE '4'.             AEADDEM0
           10           W-DEM0-ZCPTSQ  POINTER.                         AEADDEM0
           10           W-DEM0-ZCPTSR  POINTER.                         AEADDEM0
           >>if AA-E-MULTICONV                                          AEADDEM0
      *> --- Pile chainée des Demandeurs (gestion des abends)           AEADDEM0
      *>     (utilisé uniquement dans la partie Linkage Section)        AEADDEM0
       01               W-DEM0-ITEM.                                    AEADDEM0
           10           W-DEM0-AZCDEM  POINTER.                         AEADDEM0
           10           W-DEM0-AWDEM0  POINTER.                         AEADDEM0
           10           W-DEM0-SUIVANT POINTER.                         AEADDEM0
           >>end-if                                                     AEADDEM0
