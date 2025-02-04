      *>****************************************************************M5FII51A
      *> FICHIER : Synchro : Généralité crédit                          M5FII51A
      *>----------------------------------------------------------------M5FII51A
      *CONTROL NOSOURCE                                                 M5FII51A
      *> Auteur           :  Christophe Bruneaux                        M5FII51A
      *> Date de Création :  16/01/15                                   M5FII51A
      *> Origine Création :  Projet 017431 NPE Forbearance              M5FII51A
      *>                                                                M5FII51A
      *> transmis par Synchro. Selon le type d'information, certaines   M5FII51A
      *> seront renseignées ou non.                                     M5FII51A
      *> Les données proviennent des tables BC01, BH03 et BH02          M5FII51A
      *> (tables Synchro)                                               M5FII51A
      *>                                                                M5FII51A
      *> Modifié par :       FERNANDEZ Laurent                          M5FII51A
      *> Modifié le  :       22/04/21                                   M5FII51A
      *> Motif de Modif. :   Projet Nouveau Defaut : 026818             M5FII51A
      *>                     V21.09 - PSI 5506 - GECOCH P30861          M5FII51A
      *> Dans le cadre de la mise en place Mesures Forbearance Fine,    M5FII51A
      *> Synchro nous livre de nouvelles données.                       M5FII51A
      *> Ajout de :                                                     M5FII51A
      *> - MTFNAR                                                       M5FII51A
      *> - CTFDEA                                                       M5FII51A
      *> - CCFDIT                                                       M5FII51A
      *>                                                                M5FII51A
      *> Modifié par :       Nicole LATRILLE                            M5FII51A
      *> Modifié le  :       20-11-23                                   M5FII51A
      *> Motif de Modif. :   Projet FORBEARANCE PR005967-01             M5FII51A
      *>                                                                M5FII51A
      *> Ajout rubriques MTEHRC, MTEHRD, NBM5NF, MTM5EC au Format       M5FII51A
      *> Interne dans le FILLER de X(297).                              M5FII51A
      *> FILLER = X(297) - 23c = X(274)                                 M5FII51A
      *>                                                                M5FII51A
      *>----------------------------------------------------------------M5FII51A
      *> MOT CLES :                                                     M5FII51A
      *> NPE FORBEARANCE                                                M5FII51A
      *>----------------------------------------------------------------M5FII51A
      *CONTROL SOURCE                                                   M5FII51A
      *> Utilisation :                                                  M5FII51A
      *> copy M5FII51A replacing leading ==I51A== by ==prefix==.        M5FII51A
      *>****************************************************************M5FII51A
      *> -- 16/04/2024 18:16:18 BIB:M5B SESSION:9419  USER:USER         M5FII51A
      *>----------------------------------------------------------------M5FII51A
      *> Synchro : Généralité crédit                                    M5FII51A
       01               I51A.                                           M5FII51A
      *> -------- Partie commune                                        *00001
               10       I51A-ZGRP00.                                    *00001
      *> Code Etab Banque Entité Juridique                              *00001
                11      I51A-COCXBQ    PIC X(5).                        *00001
      *> Identifiant crédit                                             *00006
                11      I51A-IDMCCT    PIC X(7).                        *00006
      *> Date effet contrat crédit (SSAAMMJJ)                           *00013
                11      I51A-DTF9EF    PIC X(8).                        *00013
      *> Code type information                                          *00021
                11      I51A-CDM5IN    PIC XX.                          *00021
      *> Code Critère de tri                                            *00023
                11      I51A-CTM5TR    PIC XX.                          *00023
      *> Date arrêté fichier concession (SSAA-MM-JJ)                    *00025
                11      I51A-DAM5CS    PIC X(10).                       *00025
      *> -------- Données Crédit                                        *00035
               10       I51A-ZGRP01.                                    *00035
      *> Numéro entité titulaire                                        *00035
                11      I51A-NODIET    PIC S9(10) PACKED-DECIMAL.       *00035
      *> Code réaménagement                                             *00041
                11      I51A-CDFARE    PIC X.                           *00041
      *> Date fin de préfinancement (SSAA-MM-JJ)                        *00042
                11      I51A-DFM5PF    PIC X(10).                       *00042
      *> Date de fin du crédit (SSAA-MM-JJ)                             *00052
                11      I51A-DFF9FI    PIC X(10).                       *00052
      *> Mt impayé                                                      *00062
                11      I51A-MTM5IM    PIC S9(13) PACKED-DECIMAL.       *00062
      *> Code Produit Service                                           *00069
                11      I51A-COEGPS    PIC X(6).                        *00069
      *> Date premier versement au client (SSAAMMJJ)                    *00075
                11      I51A-DTFBVS    PIC X(8).                        *00075
      *> -------- Données Histo Crédit                                  *00083
               10       I51A-ZGRP02.                                    *00083
      *> Numéro d'entité titulaire                                      *00083
                11      I51A-NODIE3    PIC S9(10) PACKED-DECIMAL.       *00083
      *>   Code réaménagement                                           *00089
                11      I51A-CDM5RE    PIC X(1).                        *00089
      *> Date de fin du crédit avant modif (SSAA-MM-JJ)                 *00090
                11      I51A-DFM5FI    PIC X(10).                       *00090
      *> Code type d'historisation du crédit                            *00100
                11      I51A-CDM5HI    PIC XX.                          *00100
      *> Code type de modification du crédit                            *00102
                11      I51A-CDM5MO    PIC XX.                          *00102
      *> Date d'historisation du crédit (SSAA-MM-JJ)                    *00104
                11      I51A-DDM5HI    PIC X(10).                       *00104
      *> Date création de modif du crédit (SSAA-MM-JJ)                  *00114
                11      I51A-DDM5CR    PIC X(10).                       *00114
      *> Mt échéances avant                                             *00124
                11      I51A-MTM5E1    PIC S9(11)V99 PACKED-DECIMAL.    *00124
      *> Mt échéances après                                             *00131
                11      I51A-MTM5E2    PIC S9(11)V99 PACKED-DECIMAL.    *00131
      *> -------- Données Avenant                                       *00138
               10       I51A-ZGRP03.                                    *00138
      *> Code type avenant                                              *00138
                11      I51A-CTM5AV    PIC X.                           *00138
      *> Code état branche financière                                   *00139
                11      I51A-CEM5FI    PIC X.                           *00139
      *> Date création de l'avenant (SSAA-MM-JJ)                        *00140
                11      I51A-DDM5CA    PIC X(10).                       *00140
      *> Quotient Echéance induit par avenant                           *00150
                11      I51A-TXM5AV    PIC S99V9(13) PACKED-DECIMAL.    *00150
      *> -------- Données Crédit Formatées                              *00158
               10       I51A-ZGRP04.                                    *00158
      *> Identifiant Contrat                                            *00158
                11      I51A-IDDIEP    PIC X(27).                       *00158
      *> Date première échéance (SSAA-MM-JJ)                            *00185
               10       I51A-DHM5PE    PIC X(10).                       *00185
      *> -------- Données Histo Crédit suite                            *00195
               10       I51A-ZGRP05.                                    *00195
      *> MONTANT ARRIERES INCORPORES AU CRD                             *00195
                11      I51A-MTFNAR    PIC S9(11)V99 PACKED-DECIMAL.    *00195
      *> Code type échéance aménagée                                    *00202
                11      I51A-CTFDEA    PIC X.                           *00202
      *> Code type calcul intérêts                                      *00203
                11      I51A-CCFDIT    PIC X.                           *00203
      *> MONTANT ECHEANCE MER                                           *00204
               10       I51A-MTEHRC    PIC S9(11)V99 PACKED-DECIMAL.    *00204
      *> Montant échéance MER                                           *00211
               10       I51A-MTEHRD    PIC S9(11)V99 PACKED-DECIMAL.    *00211
      *> Nombre mois franchises                                         *00218
               10       I51A-NBM5NF    PIC S9(3) PACKED-DECIMAL.        *00218
      *> Mt échéances cumulé                                            *00220
               10       I51A-MTM5EC    PIC S9(11)V99 PACKED-DECIMAL.    *00220
               10       I51A-FILLER    PIC X(274).                      *00227
