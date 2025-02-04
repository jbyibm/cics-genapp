      *>****************************************************************M5FEI5
      *> FICHIER : Liv. Synchro Crédits I52* en ano                     M5FEI5
      *>----------------------------------------------------------------M5FEI5
      *CONTROL NOSOURCE                                                 M5FEI5
      *> Auteur           :  Christophe Bruneaux                        M5FEI5
      *> Date de Création :  16/01/15                                   M5FEI5
      *> Origine Création :  Projet 017431 NPE Forbearance              M5FEI5
      *>                                                                M5FEI5
      *> Ce segment décrit les contrats livrés par Synchro qui sont     M5FEI5
      *> détectés en anomalies                                          M5FEI5
      *>----------------------------------------------------------------M5FEI5
      *> MOT CLES :                                                     M5FEI5
      *> NPE FORBEARANCE M-5                                            M5FEI5
      *>----------------------------------------------------------------M5FEI5
      *CONTROL SOURCE                                                   M5FEI5
      *> Utilisation :                                                  M5FEI5
      *> copy M5FEI52Z replacing leading ==I52Z== by ==prefix==.        M5FEI5
      *>****************************************************************M5FEI5
      *> -- 13/05/2024 15:30:40 BIB:M5B SESSION:9467  USER:USER         M5FEI5
      *>----------------------------------------------------------------M5FEI5
      *> Liv. Synchro Crédits I52* en ano                               M5FEI5
       01               I52Z.                                           M5FEI5
      *> ----- Partie commune                                           *00001
               10       I52Z-ZGRP01.                                    *00001
      *> Code type information                                          *00001
                11      I52Z-CDM5IN    PIC XX.                          *00001
      *> Code aiguillage traitement synchro                             *00003
                11      I52Z-CTM5TT    PIC XX.                          *00003
      *> Code Etab Banque Entité Juridique                              *00005
                11      I52Z-COCXBQ    PIC X(5).                        *00005
      *> Identifiant crédit                                             *00010
                11      I52Z-IDMCCT    PIC X(7).                        *00010
      *> Date effet contrat crédit (JJMMSSAA)                           *00017
                11      I52Z-DTF9EF    PIC X(8).                        *00017
      *> Date traitement OPC création motif (SSAAMMJJ)                  *00025
                11      I52Z-DTM5CM    PIC X(8).                        *00025
      *> Code origine crédit / dossier                                  *00033
                11      I52Z-CDFAOR    PIC X(1).                        *00033
               10       I52Z-FILLER    PIC X(467).                      *00034
      *> Longueur de la structure : 00500 octets                        *00500
