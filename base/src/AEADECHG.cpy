      *CONTROL NOSOURCE                                                 AEADECHG
      *>****************************************************************AEADECHG
      *> Programme Q/R : zones de travail                               AEADECHG
      *>----------------------------------------------------------------AEADECHG
      *> Paramètres REPLACING facultatifs (selon contexte) :            AEADECHG
      *>----------------------------------------------------------------AEADECHG
      *> Variables de compilation locales :                             AEADECHG
      *>****************************************************************AEADECHG
      *CONTROL SOURCE                                                   AEADECHG
      *> --- Variables de contrôles                                     AEADECHG
       01               ECH-MODE-ABEND          PIC X(1) VALUE '0'.     AEADECHG
                    88  ECH-MODE-SANS-ABEND     VALUE '1'               AEADECHG
                                                FALSE '0'.              AEADECHG
       >>if AA-G-PACBASE                                                AEADECHG
       01               W-ES00-CISTGE  REDEFINES ECH-MODE-ABEND         AEADECHG
                                       PIC X(1).                        AEADECHG
       >>end-if                                                         AEADECHG
       >>if AA-E-REPONDEUR                                              AEADECHG
      *> --- Vrai code retour Echanges sur lecture dernière Question    AEADECHG
       01               W-AR00-ZCRC    PIC 9(3).                        AEADECHG
       >>if AA-G-PACBASE                                                AEADECHG
       01               W-0Z00-ZCRC    REDEFINES W-AR00-ZCRC            AEADECHG
                                       PIC 9(3).                        AEADECHG
       >>end-if                                                         AEADECHG
       >>end-if                                                         AEADECHG
       >>if AA-E-DEMANDEUR                                              AEADECHG
       01               ECH-SERVEUR-ERREUR      PIC X(1) VALUE '0'.     AEADECHG
                    88  ECH-SERVEUR-EN-ERREUR   VALUE '1'               AEADECHG
                                                FALSE '0'.              AEADECHG
       >>if AA-G-PACBASE                                                AEADECHG
       01               W-ES00-CISTSP  REDEFINES ECH-SERVEUR-ERREUR     AEADECHG
                                       PIC X(1).                        AEADECHG
       >>end-if                                                         AEADECHG
       >>if AA-E-MULTICONV                                              AEADECHG
      *> --- Pile chainée des Demandeurs (gestion des abends)           AEADECHG
       01               W-DEM0-SOMMET  POINTER VALUE NULL.              AEADECHG
       01               W-DEM0-TRAVAIL POINTER.                         AEADECHG
       01               W-DEM0-SZCDEM  POINTER.                         AEADECHG
       01               W-DEM0-SWDEM0  POINTER.                         AEADECHG
       >>end-if                                                         AEADECHG
       >>end-if                                                         AEADECHG
       >>if AA-A-DB2                                                    AEADECHG
      *> --- Gestion Db2                                                AEADECHG
       01                 SQL-VCSQLC   PIC +(9)9.                       AEADECHG
       01                 SQL-VCSQLS   PIC X(5).                        AEADECHG
      *> Constitution d'un ABEND Db2                                    AEADECHG
       01               W-TRAC-ABEND-DB2.                               AEADECHG
           10                          PIC X VALUE 'U'.                 AEADECHG
           10           W-TRAC-SQLCODE PIC 999.                         AEADECHG
      *> Constitution d'un ABEND applicatif                             AEADECHG
       01               W-TRAC-ABEND-APP.                               AEADECHG
           10                          PIC XX VALUE 'da'.               AEADECHG
           10           W-TRAC-WABCO2  PIC XX.                          AEADECHG
       >>end-if                                                         AEADECHG
