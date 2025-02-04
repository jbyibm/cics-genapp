      *>****************************************************************M52DM79F
      *> TABLE DB2 M79F : Param Segment Risque Forbearance              M52DM79F
      *>----------------------------------------------------------------M52DM79F
      *CONTROL NOSOURCE                                                 M52DM79F
      *> Auteur           :  Nicole TURCO                               M52DM79F
      *> Date de Création :  07/11/14                                   M52DM79F
      *> Origine Création :  Projet 017431 : Forbearence NPE            M52DM79F
      *>                                                                M52DM79F
      *>                                                                M52DM79F
      *> Segment de description de la table M79F.                       M52DM79F
      *>                                                                M52DM79F
      *> Cette table permet de paramétrer l'éligibilité des Segments    M52DM79F
      *> risque à la Forbearance et les critères de validation          M52DM79F
      *> Elle gère deux types d'éligibilité                             M52DM79F
      *>      - Eligibilité moteur et/ou IHM                            M52DM79F
      *>      - Eligibilité à la recherche de watchlist à l'IHM         M52DM79F
      *> Elle gère également les critères liés à la validation          M52DM79F
      *> par les experts du statut forbearance.                         M52DM79F
      *>                                                                M52DM79F
      *> Cette table stocke également des données issues de la table    M52DM79F
      *> MX7H. Un traitement assure la cohérence entre les 2 tables.    M52DM79F
      *>----------------------------------------------------------------M52DM79F
      *> MOT CLES :                                                     M52DM79F
      *>                                                                M52DM79F
      *>----------------------------------------------------------------M52DM79F
      *CONTROL SOURCE                                                   M52DM79F
      *> Utilisation :                                                  M52DM79F
      *> copy M52DM79F replacing leading ==M79F== by ==prefix==         M52DM79F
      *>                         leading ==V-M79F== by ==V-prefix==.    M52DM79F
      *>****************************************************************M52DM79F
      *> -- 16/04/2024 18:14:50 BIB:M5B SESSION:9419  USER:USER         M52DM79F
      *>----------------------------------------------------------------M52DM79F
      *> Param Segment Risque Forbearance                               M52DM79F
       01               M79F.                                           M52DM79F
      *> Code segment risques / categ client                            *00001
               10       M79F-CDMBSR    PIC X(8).                        *00001
      *> Libellé Segment risque Bale2                                   *00009
               10       M79F-LBMBSR    PIC X(32).                       *00009
      *> Code catégorie segment risque                                  *00041
               10       M79F-COMBSR    PIC X(4).                        *00041
      *> Indicateur 'A Valider'                                         *00045
               10       M79F-CIM5AV    PIC X(1).                        *00045
      *> Montant seuil validation automatique                           *00046
               10       M79F-MPM5VF    PIC S9(15) PACKED-DECIMAL.       *00046
      *> Délai validation automatique (jours)                           *00054
               10       M79F-PJM5VA    PIC S9(3) PACKED-DECIMAL.        *00054
      *> Indicateur éligibilité SR                                      *00056
               10       M79F-CIM5SR    PIC X(1).                        *00056
      *> Indicateur recherche watchlist                                 *00057
               10       M79F-CIM5WA    PIC X(1).                        *00057
      *> Date début validité (SSAA-MM-JJ)                               *00058
               10       M79F-DDEHVA    PIC X(10).                       *00058
      *> Date fin validité (SSAA-MM-JJ)                                 *00068
               10       M79F-DFEHVA    PIC X(10).                       *00068
      *>                                                                M52DM79F
       >>if AA-A-DB2NOIND not defined                                   M52DM79F
       01               V-M79F.                                         M52DM79F
               10       V-M79F-CDMBSR  PIC S9(4) COMP-5.                M52DM79F
               10       V-M79F-LBMBSR  PIC S9(4) COMP-5.                M52DM79F
               10       V-M79F-COMBSR  PIC S9(4) COMP-5.                M52DM79F
               10       V-M79F-CIM5AV  PIC S9(4) COMP-5.                M52DM79F
               10       V-M79F-MPM5VF  PIC S9(4) COMP-5.                M52DM79F
               10       V-M79F-PJM5VA  PIC S9(4) COMP-5.                M52DM79F
               10       V-M79F-CIM5SR  PIC S9(4) COMP-5.                M52DM79F
               10       V-M79F-CIM5WA  PIC S9(4) COMP-5.                M52DM79F
               10       V-M79F-DDEHVA  PIC S9(4) COMP-5.                M52DM79F
               10       V-M79F-DFEHVA  PIC S9(4) COMP-5.                M52DM79F
       01               V-M79F-R       REDEFINES V-M79F.                M52DM79F
               10       V-M79F-A       PIC S9(4) COMP-5                 M52DM79F
                                       OCCURS 00010.                    M52DM79F
       >>end-if                                                         M52DM79F
       >>define AA-A-DB2NOIND off                                       M52DM79F
