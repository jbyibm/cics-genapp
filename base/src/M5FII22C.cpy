      *>****************************************************************M5FII22C
      *> FICHIER : MO- Motifs difficultés financières                   M5FII22C
      *>----------------------------------------------------------------M5FII22C
      *CONTROL NOSOURCE                                                 M5FII22C
      *> Auteur           :  Florent DARD                               M5FII22C
      *> Date de Création :  25/09/23                                   M5FII22C
      *> Origine Création :  P36441 - Refonte du Moteur Forbearance     M5FII22C
      *>                                                                M5FII22C
      *>                                                                M5FII22C
      *> Description des motifs de difficultés financières qui          M5FII22C
      *> provoque la Forbearance.                                       M5FII22C
      *>                                                                M5FII22C
      *>----------------------------------------------------------------M5FII22C
      *> MOT CLES :                                                     M5FII22C
      *>                                                                M5FII22C
      *>----------------------------------------------------------------M5FII22C
      *CONTROL SOURCE                                                   M5FII22C
      *> Utilisation :                                                  M5FII22C
      *> copy M5FII22C replacing leading ==I22C== by ==prefix==.        M5FII22C
      *>****************************************************************M5FII22C
      *> -- 16/04/2024 18:15:55 BIB:M5B SESSION:9419  USER:USER         M5FII22C
      *>----------------------------------------------------------------M5FII22C
      *> MO- Motifs difficultés financières                             M5FII22C
       01               I22C.                                           M5FII22C
      *> Code Etab Banque Entité Juridique                              *00001
               10       I22C-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       I22C-IDDIEP    PIC X(27).                       *00006
      *> Code origine motif intervention                                *00033
               10       I22C-CMM5MI    PIC X(4).                        *00033
      *> Code motif interv Forb                                         *00037
               10       I22C-CMM5FO    PIC X(3).                        *00037
      *> Type intervention Forb                                         *00040
               10       I22C-CTM5FO    PIC X(2).                        *00040
      *> Date effet interv Forb (SSAA-MM-JJ)                            *00042
               10       I22C-DDM5FO    PIC X(10).                       *00042
      *> Date arrêté du motif (SSAA-MM-JJ)                              *00052
               10       I22C-DAM5MO    PIC X(10).                       *00052
      *> Lib origine motif intervention                                 *00062
               10       I22C-LDM5OM    PIC X(30).                       *00062
      *> Lib référence piste audit                                      *00092
               10       I22C-LIM5PA    PIC X(30).                       *00092
      *> Code programme origine                                         *00122
               10       I22C-IDMRPO    PIC X(8).                        *00122
      *> Identifiant personne                                           *00130
               10       I22C-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00130
      *> Type concession                                                *00135
               10       I22C-CTM5CS    PIC X(1).                        *00135
      *> Code origine concession                                        *00136
               10       I22C-CMM5CS    PIC X(1).                        *00136
      *> Ind complément motif concession                                *00137
               10       I22C-CIM5C1    PIC X(1).                        *00137
      *> Numéro dossier contentieux                                     *00138
               10       I22C-NOMKDO    PIC S9(7) PACKED-DECIMAL.        *00138
      *> Identifiant créance CTX                                        *00142
               10       I22C-IDMKCE    PIC X(12).                       *00142
      *> Code type plan recouvrement                                    *00154
               10       I22C-CDMKTQ    PIC X.                           *00154
      *> Code état plan apurement                                       *00155
               10       I22C-CEMKPA    PIC X.                           *00155
      *> Code déchéance terme                                           *00156
               10       I22C-COMEDT    PIC X.                           *00156
      *> CODE INDICATEUR PLAN NEIERTZ                                   *00157
               10       I22C-CIMKNE    PIC X.                           *00157
      *> Code réaménagement                                             *00158
               10       I22C-CDFARE    PIC X.                           *00158
      *> Code aiguillage traitement synchro                             *00159
               10       I22C-CTM5TT    PIC XX.                          *00159
      *> Code motif Concession Synchro                                  *00161
               10       I22C-CDM5MC    PIC XX.                          *00161
      *> Code famille dossier                                           *00163
               10       I22C-CDMKFA    PIC X(2).                        *00163
      *> Libellé Motif concession                                       *00165
               10       I22C-LIM5MC    PIC X(30).                       *00165
      *> Ind complément motif arriérés                                  *00195
               10       I22C-CIM5C2    PIC X(1).                        *00195
      *> Code évènement défaut                                          *00196
               10       I22C-CTMREV    PIC X(3).                        *00196
      *> Identifiant événement défaut                                   *00199
               10       I22C-IDMREV    PIC X(25).                       *00199
      *> Code statut actuel événement défaut                            *00224
               10       I22C-CEMREV    PIC X(3).                        *00224
      *> Ind complément motif note dégradée                             *00227
               10       I22C-CIM5C3    PIC X(1).                        *00227
      *> Code note Bale2                                                *00228
               10       I22C-CBMBNO    PIC X(20).                       *00228
      *> Identifiant Moteur Bale2                                       *00248
               10       I22C-IDMBMO    PIC X(8).                        *00248
      *> Date arrêté (SSAA-MM-JJ)                                       *00256
               10       I22C-DAMBRT    PIC X(10).                       *00256
      *> Référence Contrat Supra                                        *00266
               10       I22C-IDMZCG    PIC X(27).                       *00266
               10       I22C-FILLER    PIC X(8).                        *00293
