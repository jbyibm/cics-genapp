      *>****************************************************************M52DM72E
      *> TABLE DB2 M72E : Etape Cycle Forbearance Contrat               M52DM72E
      *>----------------------------------------------------------------M52DM72E
      *CONTROL NOSOURCE                                                 M52DM72E
      *> Auteur           :  P.Rolland     s3236                        M52DM72E
      *> Date de Création :  17/10/14                                   M52DM72E
      *> Origine Création :  FORBEARANCE 017431                         M52DM72E
      *>                                                                M52DM72E
      *> Modifié par :       Nicole TURCO                               M52DM72E
      *> Modifié le  :       10/12/14                                   M52DM72E
      *> Motif de Modif. :   FORBEARANCE 017431 : ajout rubriques       M52DM72E
      *>                     CTM5OS et NXM5RS                           M52DM72E
      *> Segment de description de la table M72E                        M52DM72E
      *>                                                                M52DM72E
      *> Cette table trace, pour chaque cycle de forbearance d'un       M52DM72E
      *> contrat, toutes les étapes qui le constituent.                 M52DM72E
      *> Les propriétés qui déterminent une nouvelle étape sont :       M52DM72E
      *>    - le changement du code surveillance de la forbearance      M52DM72E
      *>    - le changement de la date de début de période probatoire   M52DM72E
      *>    - le changement du statut PE/NPE du contrat                 M52DM72E
      *> Clé fonctionnelle: COCXBQ-IDDIEP-NSM5CY-CEM5ET-DDM5PB-CEM5CT   M52DM72E
      *>                                                                M52DM72E
      *> Chaque étape est caractérisée par une date de début de         M52DM72E
      *> période probatoire et une date de fin réelle de période        M52DM72E
      *> probatoire.                                                    M52DM72E
      *>----------------------------------------------------------------M52DM72E
      *> MOT CLES :                                                     M52DM72E
      *>                                                                M52DM72E
      *>----------------------------------------------------------------M52DM72E
      *CONTROL SOURCE                                                   M52DM72E
      *> Utilisation :                                                  M52DM72E
      *> copy M52DM72E replacing leading ==M72E== by ==prefix==         M52DM72E
      *>                         leading ==V-M72E== by ==V-prefix==.    M52DM72E
      *>****************************************************************M52DM72E
      *> -- 16/04/2024 18:14:19 BIB:M5B SESSION:9419  USER:USER         M52DM72E
      *>----------------------------------------------------------------M52DM72E
      *> Etape Cycle Forbearance Contrat                                M52DM72E
       01               M72E.                                           M52DM72E
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72E-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       M72E-IDDIEP    PIC X(27).                       *00006
      *> Num cycle Forbearance                                          *00033
               10       M72E-NSM5CY    PIC S9(7) PACKED-DECIMAL.        *00033
      *> Num étape dans cycle Forb                                      *00037
               10       M72E-NSM5ET    PIC S9(7) PACKED-DECIMAL.        *00037
      *> Code statut Forbearance                                        *00041
               10       M72E-CEM5TF    PIC X(1).                        *00041
      *> Code surv étape Forbearance                                    *00042
               10       M72E-CEM5ET    PIC X(4).                        *00042
      *> Indic étape Forbearance active                                 *00046
               10       M72E-CIM5ET    PIC X(1).                        *00046
      *> Code décision étape Forbearance                                *00047
               10       M72E-CRM5ET    PIC X(2).                        *00047
      *> Type opérateur origine entrée étape                            *00049
               10       M72E-CTM5OE    PIC X(2).                        *00049
      *> Numéro de règle origine                                        *00051
               10       M72E-NXM5RG    PIC X(2).                        *00051
      *> Type opérateur origine sortie étape                            *00053
               10       M72E-CTM5OS    PIC X(2).                        *00053
      *> Numéro de règle sortie étape                                   *00055
               10       M72E-NXM5RS    PIC X(2).                        *00055
      *> Date déb période probatoire (SSAA-MM-JJ)                       *00057
               10       M72E-DDM5PB    PIC X(10).                       *00057
      *> Date fin estimée periode probatoire (SSAA-MM-JJ)               *00067
               10       M72E-DFM5ES    PIC X(10).                       *00067
      *> Date fin période probatoire (SSAA-MM-JJ)                       *00077
               10       M72E-DFM5PB    PIC X(10).                       *00077
      *> Date arrêté entrée etape Forb (SSAA-MM-JJ)                     *00087
               10       M72E-DAM5EE    PIC X(10).                       *00087
      *> Date arrêté sortie etape Forb (SSAA-MM-JJ)                     *00097
               10       M72E-DAM5SE    PIC X(10).                       *00097
      *> Date limite validation Expert (SSAA-MM-JJ)                     *00107
               10       M72E-DLM5XP    PIC X(10).                       *00107
      *> Date décision etape Forb (SSAA-MM-JJ)                          *00117
               10       M72E-DAM5DE    PIC X(10).                       *00117
      *> Code statut PE/NPE contrat                                     *00127
               10       M72E-CEM5CT    PIC X(3).                        *00127
      *> Indicateur déclencheur NPE                                     *00130
               10       M72E-CIM5DE    PIC X(1).                        *00130
      *> Code cause NPE                                                 *00131
               10       M72E-COM5CN    PIC X(1).                        *00131
      *> Code segment risque Bâle 2 ET                                  *00132
               10       M72E-CDDIBA    PIC X(8).                        *00132
      *> Mt impayé                                                      *00140
               10       M72E-MTM5IM    PIC S9(13) PACKED-DECIMAL.       *00140
      *> Montant capital restant dû                                     *00147
               10       M72E-MKMKRE    PIC S9(15) PACKED-DECIMAL.       *00147
      *> Date trait entrée étape Forb (SSAA-MM-JJ)                      *00155
               10       M72E-DTM5EE    PIC X(10).                       *00155
      *> Date trait sortie étape Forb (SSAA-MM-JJ)                      *00165
               10       M72E-DTM5SE    PIC X(10).                       *00165
      *> TS création élément (TIMESTAMP)                                *00175
               10       M72E-HDEHET    PIC X(26).                       *00175
      *> TS maj élément (TIMESTAMP)                                     *00201
               10       M72E-HMEHET    PIC X(26).                       *00201
      *>                                                                M52DM72E
       >>if AA-A-DB2NOIND not defined                                   M52DM72E
       01               V-M72E.                                         M52DM72E
               10       V-M72E-COCXBQ  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-IDDIEP  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-NSM5CY  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-NSM5ET  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-CEM5TF  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-CEM5ET  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-CIM5ET  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-CRM5ET  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-CTM5OE  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-NXM5RG  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-CTM5OS  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-NXM5RS  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-DDM5PB  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-DFM5ES  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-DFM5PB  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-DAM5EE  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-DAM5SE  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-DLM5XP  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-DAM5DE  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-CEM5CT  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-CIM5DE  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-COM5CN  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-CDDIBA  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-MTM5IM  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-MKMKRE  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-DTM5EE  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-DTM5SE  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-HDEHET  PIC S9(4) COMP-5.                M52DM72E
               10       V-M72E-HMEHET  PIC S9(4) COMP-5.                M52DM72E
       01               V-M72E-R       REDEFINES V-M72E.                M52DM72E
               10       V-M72E-A       PIC S9(4) COMP-5                 M52DM72E
                                       OCCURS 00029.                    M52DM72E
       >>end-if                                                         M52DM72E
       >>define AA-A-DB2NOIND off                                       M52DM72E
