      *>****************************************************************M5FIHM2Q
      *> FICHIER : Segment livraison EWI Concessions                    M5FIHM2Q
      *>----------------------------------------------------------------M5FIHM2Q
      *CONTROL NOSOURCE                                                 M5FIHM2Q
      *> Auteur           :  Laurent FERNANDEZ                          M5FIHM2Q
      *> Date de Création :  03/12/20                                   M5FIHM2Q
      *> Origine Création :  Projet Nouveau Defaut : 026818             M5FIHM2Q
      *>                                                                M5FIHM2Q
      *> Ce segment correspond aux Concessions issues des outils        M5FIHM2Q
      *> de gestion Synchro, Vario et GECCO à destination de l'appli    M5FIHM2Q
      *> EWI.                                                           M5FIHM2Q
      *>                                                                M5FIHM2Q
      *> Modifié par :       GRAMFORT/FERNANDEZ                         M5FIHM2Q
      *> Modifié le  :       07/12/20                                   M5FIHM2Q
      *> Motif de Modif. :   RefDOit 9137 - remontée vers MCR           M5FIHM2Q
      *>                                                                M5FIHM2Q
      *>----------------------------------------------------------------M5FIHM2Q
      *> MOT CLES :                                                     M5FIHM2Q
      *> ADT NPE FORBEARANCE CONCESSION EWI                             M5FIHM2Q
      *>----------------------------------------------------------------M5FIHM2Q
      *CONTROL SOURCE                                                   M5FIHM2Q
      *> Utilisation :                                                  M5FIHM2Q
      *> copy M5FIHM2Q replacing leading ==HM2Q== by ==prefix==.        M5FIHM2Q
      *>****************************************************************M5FIHM2Q
      *> -- 16/04/2024 18:15:08 BIB:M5B SESSION:9419  USER:USER         M5FIHM2Q
      *>----------------------------------------------------------------M5FIHM2Q
      *> Segment livraison EWI Concessions                              M5FIHM2Q
       01               HM2Q.                                           M5FIHM2Q
      *> Code Etab Banque Entité Juridique                              *00001
               10       HM2Q-COCXBQ    PIC X(5).                        *00001
      *> Code application d'origine                                     *00006
               10       HM2Q-CDDFAP    PIC X(4).                        *00006
      *> Code Segment Pacbase                                           *00010
               10       HM2Q-COSBDP    PIC X(04).                       *00010
      *> Date création fichier (SSAA-MM-JJ)                             *00014
               10       HM2Q-DDHAFR    PIC X(10).                       *00014
      *> Identifiant personne                                           *00024
               10       HM2Q-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00024
      *> Numéro SIREN entreprise                                        *00029
               10       HM2Q-IRDQSN    PIC X(9).                        *00029
      *> Code segmentation risques                                      *00038
               10       HM2Q-CDMBSG    PIC X(8).                        *00038
               10       HM2Q-FILLER    PIC X(25).                       *00046
      *> Code Guichet Interbancaire                                     *00071
               10       HM2Q-COCXGU    PIC X(5).                        *00071
      *> Code type produit service                                      *00076
               10       HM2Q-CODIPR    PIC X(4).                        *00076
      *> Référence produit / service                                    *00080
               10       HM2Q-CODIRF    PIC X(11).                       *00080
      *> Type concession                                                *00091
               10       HM2Q-CTM5CS    PIC X(1).                        *00091
      *> Code origine concession                                        *00092
               10       HM2Q-CMM5CS    PIC X(1).                        *00092
      *> Date effet concession (SSAA-MM-JJ)                             *00093
               10       HM2Q-DFM5CS    PIC X(10).                       *00093
      *> Code statut NPE personne                                       *00103
               10       HM2Q-CEM5PS    PIC X(3).                        *00103
               10       HM2Q-FILLER    PIC X(365).                      *00106
