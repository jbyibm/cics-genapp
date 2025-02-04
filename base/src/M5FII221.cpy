      *>****************************************************************M5FII221
      *> FICHIER : NPE- Extraction M72A personne NPE                    M5FII221
      *>----------------------------------------------------------------M5FII221
      *CONTROL NOSOURCE                                                 M5FII221
      *> Auteur           :  Muriel DI GIANI                            M5FII221
      *> Date de Création :  27/10/23                                   M5FII221
      *> Origine Création :  P36441 - Refonte du Moteur Forbearance     M5FII221
      *>                                                                M5FII221
      *> Extraction des personnes NPE actives                           M5FII221
      *> reprend les données de la table M72A                           M5FII221
      *>                                                                M5FII221
      *>----------------------------------------------------------------M5FII221
      *> MOT CLES :                                                     M5FII221
      *> MOTEUR FORBEARANCE                                             M5FII221
      *>----------------------------------------------------------------M5FII221
      *CONTROL SOURCE                                                   M5FII221
      *> Utilisation :                                                  M5FII221
      *> copy M5FII221 replacing leading ==I221== by ==prefix==.        M5FII221
      *>****************************************************************M5FII221
      *> -- 16/04/2024 18:15:44 BIB:M5B SESSION:9419  USER:USER         M5FII221
      *>----------------------------------------------------------------M5FII221
      *> NPE- Extraction M72A personne NPE                              M5FII221
       01               I221.                                           M5FII221
      *> Code Etab Banque Entité Juridique                              *00001
               10       I221-COCXBQ    PIC X(5).                        *00001
      *> Identifiant personne                                           *00006
               10       I221-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00006
      *> Num chrono NPE                                                 *00011
               10       I221-NSM5NP    PIC S9(7) PACKED-DECIMAL.        *00011
      *> Code statut NPE personne                                       *00015
               10       I221-CEM5PS    PIC X(3).                        *00015
      *> Indic NPE actif                                                *00018
               10       I221-CIM5PS    PIC X(1).                        *00018
      *> Code décision NPE                                              *00019
               10       I221-CRM5DN    PIC X(2).                        *00019
      *> Date effet entrée NPE (SSAA-MM-JJ)                             *00021
               10       I221-DDM5EN    PIC X(10).                       *00021
      *> Date effet sortie NPE (SSAA-MM-JJ)                             *00031
               10       I221-DFM5SN    PIC X(10).                       *00031
      *> Date arrêté entrée en NPE (SSAA-MM-JJ)                         *00041
               10       I221-DAM5EN    PIC X(10).                       *00041
      *> Date arrêté sortie de NPE (SSAA-MM-JJ)                         *00051
               10       I221-DAM5SN    PIC X(10).                       *00051
      *> Indic gestion manuelle sortie NPE                              *00061
               10       I221-CIM5MS    PIC X(1).                        *00061
      *> Code segment risque Bâle 2 Personne                            *00062
               10       I221-CDDABA    PIC X(8).                        *00062
      *> Code note Bale2                                                *00070
               10       I221-CBMBNO    PIC X(20).                       *00070
      *> Identifiant Moteur Bale2                                       *00090
               10       I221-IDMBMO    PIC X(8).                        *00090
      *> Code cause NPE                                                 *00098
               10       I221-COM5CN    PIC X(1).                        *00098
      *> Type opérateur origine suivi NPE                               *00099
               10       I221-CTM5ON    PIC X(2).                        *00099
      *> Numéro de règle origine                                        *00101
               10       I221-NXM5RG    PIC X(2).                        *00101
      *> Num chrono NPE prec                                            *00103
               10       I221-NSM5N1    PIC S9(7) PACKED-DECIMAL.        *00103
      *> Date trait entrée suivi NPE (SSAA-MM-JJ)                       *00107
               10       I221-DTM5EN    PIC X(10).                       *00107
      *> Date trait sortie suivi NPE (SSAA-MM-JJ)                       *00117
               10       I221-DTM5SN    PIC X(10).                       *00117
      *> TS création élément (TIMESTAMP)                                *00127
               10       I221-HDEHET    PIC X(26).                       *00127
      *> TS maj élément (TIMESTAMP)                                     *00153
               10       I221-HMEHET    PIC X(26).                       *00153
               10       I221-FILLER    PIC X(22).                       *00179
