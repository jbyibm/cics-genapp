      *>****************************************************************M52DM72A
      *> TABLE DB2 M72A : Suivi NPE Personne                            M52DM72A
      *>----------------------------------------------------------------M52DM72A
      *CONTROL NOSOURCE                                                 M52DM72A
      *> Auteur           :  P.Rolland     s3236                        M52DM72A
      *> Date de Création :  17/10/14                                   M52DM72A
      *> Origine Création :  FORBEARANCE 017431                         M52DM72A
      *>                                                                M52DM72A
      *>                                                                M52DM72A
      *> Segment de description de la table M72A.                       M52DM72A
      *>                                                                M52DM72A
      *> Cette table contient le suivi de toutes les personnes qui      M52DM72A
      *> ont eu sur les 5 dernières années un statut Non Performing     M52DM72A
      *> Exposure (NPE).                                                M52DM72A
      *> Pour chaque personne concernée, une occurence est créée pour   M52DM72A
      *> chaque période où elle a été en NPE avec une date d'entrée     M52DM72A
      *> et une date de sortie du statut NPE.                           M52DM72A
      *> Une personne qui n'est pas en statut NPE est PE (Performing    M52DM72A
      *> Exposure).                                                     M52DM72A
      *> Les évènements déclencheurs du NPE sur une personne sont :     M52DM72A
      *>      - le client a un impayé immobilier > 90 jours             M52DM72A
      *>  ou  - le client a une note de défaut                          M52DM72A
      *>  ou  - le client a un contrat en forbearance NPE               M52DM72A
      *>  ou  - une décision de la Direction des Risques                M52DM72A
      *>----------------------------------------------------------------M52DM72A
      *> MOT CLES :                                                     M52DM72A
      *>                                                                M52DM72A
      *>----------------------------------------------------------------M52DM72A
      *CONTROL SOURCE                                                   M52DM72A
      *> Utilisation :                                                  M52DM72A
      *> copy M52DM72A replacing leading ==M72A== by ==prefix==         M52DM72A
      *>                         leading ==V-M72A== by ==V-prefix==.    M52DM72A
      *>****************************************************************M52DM72A
      *> -- 16/04/2024 18:14:13 BIB:M5B SESSION:9419  USER:USER         M52DM72A
      *>----------------------------------------------------------------M52DM72A
      *> Suivi NPE Personne                                             M52DM72A
       01               M72A.                                           M52DM72A
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72A-COCXBQ    PIC X(5).                        *00001
      *> Identifiant personne                                           *00006
               10       M72A-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00006
      *> Num chrono NPE                                                 *00011
               10       M72A-NSM5NP    PIC S9(7) PACKED-DECIMAL.        *00011
      *> Code statut NPE personne                                       *00015
               10       M72A-CEM5PS    PIC X(3).                        *00015
      *> Indic NPE actif                                                *00018
               10       M72A-CIM5PS    PIC X(1).                        *00018
      *> Code décision NPE                                              *00019
               10       M72A-CRM5DN    PIC X(2).                        *00019
      *> Date effet entrée NPE (SSAA-MM-JJ)                             *00021
               10       M72A-DDM5EN    PIC X(10).                       *00021
      *> Date effet sortie NPE (SSAA-MM-JJ)                             *00031
               10       M72A-DFM5SN    PIC X(10).                       *00031
      *> Date arrêté entrée en NPE (SSAA-MM-JJ)                         *00041
               10       M72A-DAM5EN    PIC X(10).                       *00041
      *> Date arrêté sortie de NPE (SSAA-MM-JJ)                         *00051
               10       M72A-DAM5SN    PIC X(10).                       *00051
      *> Indic gestion manuelle sortie NPE                              *00061
               10       M72A-CIM5MS    PIC X(1).                        *00061
      *> Code segment risque Bâle 2 Personne                            *00062
               10       M72A-CDDABA    PIC X(8).                        *00062
      *> Code note Bale2                                                *00070
               10       M72A-CBMBNO    PIC X(20).                       *00070
      *> Identifiant Moteur Bale2                                       *00090
               10       M72A-IDMBMO    PIC X(8).                        *00090
      *> Code cause NPE                                                 *00098
               10       M72A-COM5CN    PIC X(1).                        *00098
      *> Type opérateur origine suivi NPE                               *00099
               10       M72A-CTM5ON    PIC X(2).                        *00099
      *> Numéro de règle origine                                        *00101
               10       M72A-NXM5RG    PIC X(2).                        *00101
      *> Num chrono NPE prec                                            *00103
               10       M72A-NSM5N1    PIC S9(7) PACKED-DECIMAL.        *00103
      *> Date trait entrée suivi NPE (SSAA-MM-JJ)                       *00107
               10       M72A-DTM5EN    PIC X(10).                       *00107
      *> Date trait sortie suivi NPE (SSAA-MM-JJ)                       *00117
               10       M72A-DTM5SN    PIC X(10).                       *00117
      *> TS création élément (TIMESTAMP)                                *00127
               10       M72A-HDEHET    PIC X(26).                       *00127
      *> TS maj élément (TIMESTAMP)                                     *00153
               10       M72A-HMEHET    PIC X(26).                       *00153
      *>                                                                M52DM72A
       >>if AA-A-DB2NOIND not defined                                   M52DM72A
       01               V-M72A.                                         M52DM72A
               10       V-M72A-COCXBQ  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-NODAPE  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-NSM5NP  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-CEM5PS  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-CIM5PS  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-CRM5DN  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-DDM5EN  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-DFM5SN  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-DAM5EN  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-DAM5SN  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-CIM5MS  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-CDDABA  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-CBMBNO  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-IDMBMO  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-COM5CN  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-CTM5ON  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-NXM5RG  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-NSM5N1  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-DTM5EN  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-DTM5SN  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-HDEHET  PIC S9(4) COMP-5.                M52DM72A
               10       V-M72A-HMEHET  PIC S9(4) COMP-5.                M52DM72A
       01               V-M72A-R       REDEFINES V-M72A.                M52DM72A
               10       V-M72A-A       PIC S9(4) COMP-5                 M52DM72A
                                       OCCURS 00022.                    M52DM72A
       >>end-if                                                         M52DM72A
       >>define AA-A-DB2NOIND off                                       M52DM72A
