      *>****************************************************************M52DM79C
      *> TABLE DB2 M79C : Param Cohérence Forbearance                   M52DM79C
      *>----------------------------------------------------------------M52DM79C
      *CONTROL NOSOURCE                                                 M52DM79C
      *> Auteur           :  Nicole TURCO                               M52DM79C
      *> Date de Création :  05/11/14                                   M52DM79C
      *> Origine Création :  Projet 017431 Forbearance NPE              M52DM79C
      *>                                                                M52DM79C
      *>                                                                M52DM79C
      *> Segment de description de la table M79C.                       M52DM79C
      *> Table de paramétrage des conditions et modalités               M52DM79C
      *> des interventions des acteurs (auto, agent ...) sur l'         M52DM79C
      *> analyse Forbearance                                            M52DM79C
      *> Cette table permet de garder une cohérence dans le modèle      M52DM79C
      *> de données Forbearance.                                        M52DM79C
      *> Elle dérive à partir d'un déclencheur et d'un traitement,      M52DM79C
      *> le motif d'intervention, l'origine du motif, le code           M52DM79C
      *> intervention et l'état de l'étape suite à l'intervention       M52DM79C
      *> (uniquement pour l'IHM).                                       M52DM79C
      *> Elle gère la correspondance avec le motif forbearance.         M52DM79C
      *> Elle gère l'éligibilité des motifs forbearance à l'IHM         M52DM79C
      *> (en saisie et/ou en affichage).                                M52DM79C
      *>                                                                M52DM79C
      *>----------------------------------------------------------------M52DM79C
      *> MOT CLES :                                                     M52DM79C
      *>                                                                M52DM79C
      *>----------------------------------------------------------------M52DM79C
      *CONTROL SOURCE                                                   M52DM79C
      *> Utilisation :                                                  M52DM79C
      *> copy M52DM79C replacing leading ==M79C== by ==prefix==         M52DM79C
      *>                         leading ==V-M79C== by ==V-prefix==.    M52DM79C
      *>****************************************************************M52DM79C
      *> -- 16/04/2024 18:14:44 BIB:M5B SESSION:9419  USER:USER         M52DM79C
      *>----------------------------------------------------------------M52DM79C
      *> Param intervention Forbearance                                 M52DM79C
       01               M79C.                                           M52DM79C
      *> Code evt déclencheur motif                                     *00001
               10       M79C-COM5DM    PIC X(8).                        *00001
      *> Code traitement evt déclencheur                                *00009
               10       M79C-COM5TT    PIC X(1).                        *00009
      *> Code origine motif intervention                                *00010
               10       M79C-CMM5MI    PIC X(4).                        *00010
      *> Code motif interv Forb                                         *00014
               10       M79C-CMM5FO    PIC X(3).                        *00014
      *> libellé motif intervention Forb                                *00017
               10       M79C-LDM5FO    PIC X(64).                       *00017
      *> Type intervention Forb                                         *00081
               10       M79C-CTM5FO    PIC X(2).                        *00081
      *> Indic étape Forbearance active                                 *00083
               10       M79C-CIM5ET    PIC X(1).                        *00083
      *> Code décision étape Forbearance                                *00084
               10       M79C-CRM5ET    PIC X(2).                        *00084
      *> Code éligibilité motif IHM                                     *00086
               10       M79C-COM5IH    PIC X(1).                        *00086
      *> Date début validité (SSAA-MM-JJ)                               *00087
               10       M79C-DDEHVA    PIC X(10).                       *00087
      *> Date fin validité (SSAA-MM-JJ)                                 *00097
               10       M79C-DFEHVA    PIC X(10).                       *00097
      *>                                                                M52DM79C
       >>if AA-A-DB2NOIND not defined                                   M52DM79C
       01               V-M79C.                                         M52DM79C
               10       V-M79C-COM5DM  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-COM5TT  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-CMM5MI  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-CMM5FO  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-LDM5FO  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-CTM5FO  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-CIM5ET  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-CRM5ET  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-COM5IH  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-DDEHVA  PIC S9(4) COMP-5.                M52DM79C
               10       V-M79C-DFEHVA  PIC S9(4) COMP-5.                M52DM79C
       01               V-M79C-R       REDEFINES V-M79C.                M52DM79C
               10       V-M79C-A       PIC S9(4) COMP-5                 M52DM79C
                                       OCCURS 00011.                    M52DM79C
       >>end-if                                                         M52DM79C
       >>define AA-A-DB2NOIND off                                       M52DM79C
