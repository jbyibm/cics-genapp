      *>****************************************************************M5FII51X
      *> FICHIER : Infos Synchro Crédits I51A/B/C                       M5FII51X
      *>----------------------------------------------------------------M5FII51X
      *CONTROL NOSOURCE                                                 M5FII51X
      *> Auteur           :  Laurent FERNANDEZ                          M5FII51X
      *> Date de Création :  27/05/15                                   M5FII51X
      *> Origine Création :  Projet 017431 NPE Forbearance              M5FII51X
      *>                                                                M5FII51X
      *> Ce segment synthétise les informations générales d'un crédit   M5FII51X
      *> transmis par Synchro. Selon le type d'information, certaines   M5FII51X
      *> seront renseignées ou non.                                     M5FII51X
      *> Les données proviennent des tables BC01, BH03 et BH02          M5FII51X
      *> (tables Synchro)                                               M5FII51X
      *>----------------------------------------------------------------M5FII51X
      *> MOT CLES :                                                     M5FII51X
      *> NPE FORBEARANCE                                                M5FII51X
      *>----------------------------------------------------------------M5FII51X
      *CONTROL SOURCE                                                   M5FII51X
      *> Utilisation :                                                  M5FII51X
      *> copy M5FII51X replacing leading ==I51X== by ==prefix==.        M5FII51X
      *>****************************************************************M5FII51X
      *> -- 16/04/2024 18:16:20 BIB:M5B SESSION:9419  USER:USER         M5FII51X
      *>----------------------------------------------------------------M5FII51X
      *> Infos Synchro Crédits I51A/B/C                                 M5FII51X
       01               I51X.                                           M5FII51X
      *> -------- Partie commune                                        *00001
               10       I51X-ZGRP00.                                    *00001
      *> Code Etab Banque Entité Juridique                              *00001
                11      I51X-COCXBQ    PIC X(5).                        *00001
      *> Identifiant crédit                                             *00006
                11      I51X-IDMCCT    PIC X(7).                        *00006
      *> Date effet contrat crédit (SSAAMMJJ)                           *00013
                11      I51X-DTF9EF    PIC X(8).                        *00013
      *> Code type information                                          *00021
                11      I51X-CDM5IN    PIC XX.                          *00021
      *> Code Critère de tri                                            *00023
                11      I51X-CTM5TR    PIC XX.                          *00023
      *> Date arrêté fichier concession (SSAA-MM-JJ)                    *00025
                11      I51X-DAM5CS    PIC X(10).                       *00025
               10       I51X-FILLER    PIC X(466).                      *00035
