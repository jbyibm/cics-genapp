      *>****************************************************************M5FII51C
      *> FICHIER : Synchro : Crédit réaménagé                           M5FII51C
      *>----------------------------------------------------------------M5FII51C
      *CONTROL NOSOURCE                                                 M5FII51C
      *> Auteur           :  Christophe Bruneaux                        M5FII51C
      *> Date de Création :  16/01/15                                   M5FII51C
      *> Origine Création :  Projet 017431 NPE Forbearance              M5FII51C
      *>                                                                M5FII51C
      *> Ce segment synthétise les informations générales d'un crédit   M5FII51C
      *> transmis par Synchro. Selon le type d'information, certaines   M5FII51C
      *> seront renseignées ou non.                                     M5FII51C
      *> Les données proviennent des tables BC01, BH03 et BH02          M5FII51C
      *> (tables Synchro)                                               M5FII51C
      *>----------------------------------------------------------------M5FII51C
      *> MOT CLES :                                                     M5FII51C
      *> NPE FORBEARANCE                                                M5FII51C
      *>----------------------------------------------------------------M5FII51C
      *CONTROL SOURCE                                                   M5FII51C
      *> Utilisation :                                                  M5FII51C
      *> copy M5FII51C replacing leading ==I51C== by ==prefix==.        M5FII51C
      *>****************************************************************M5FII51C
      *> -- 05/06/2024 16:28:41 BIB:M5B SESSION:9510  USER:USER         M5FII51C
      *>----------------------------------------------------------------M5FII51C
      *> Synchro : Crédit réaménagé                                     M5FII51C
       01               I51C.                                           M5FII51C
      *> -------- Partie commune                                        *00001
               10       I51C-ZGRP00.                                    *00001
      *> Code Etab Banque Entité Juridique                              *00001
                11      I51C-COCXBQ    PIC X(5).                        *00001
      *> Identifiant crédit                                             *00006
                11      I51C-IDMCCT    PIC X(7).                        *00006
      *> Date effet contrat crédit (SSAAMMJJ)                           *00013
                11      I51C-DTF9EF    PIC X(8).                        *00013
      *> Code type information                                          *00021
                11      I51C-CDM5IN    PIC XX.                          *00021
      *> Code Critère de tri                                            *00023
                11      I51C-CTM5TR    PIC XX.                          *00023
      *> Date arrêté fichier concession (SSAA-MM-JJ)                    *00025
                11      I51C-DAM5CS    PIC X(10).                       *00025
      *> ----- Partie spécifique                                        *00035
               10       I51C-ZGRP01.                                    *00035
      *> Identifiant Contrat                                            *00035
                11      I51C-IDDIEP    PIC X(27).                       *00035
      *> Identifiant contrat refinancé                                  *00062
                11      I51C-IDM5CR    PIC X(27).                       *00062
               10       I51C-FILLER    PIC X(412).                      *00089
      *> Longueur de la structure : 00500 octets                        *00500
