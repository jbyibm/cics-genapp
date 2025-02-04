      *>****************************************************************M5FII22L
      *> FICHIER : MO- Demande MAJ indic trt M72O                       M5FII22L
      *>----------------------------------------------------------------M5FII22L
      *CONTROL NOSOURCE                                                 M5FII22L
      *> Auteur           :  Muriel DI GIANNI                           M5FII22L
      *> Date de Création :  23/11/23                                   M5FII22L
      *> Origine Création :  PR005967 Refonte Forbearance PRO           M5FII22L
      *>                                                                M5FII22L
      *>                                                                M5FII22L
      *> Description des données pour mise à jour M72O                  M5FII22L
      *>                                                                M5FII22L
      *>                                                                M5FII22L
      *>----------------------------------------------------------------M5FII22L
      *> MOT CLES :                                                     M5FII22L
      *>                                                                M5FII22L
      *>----------------------------------------------------------------M5FII22L
      *CONTROL SOURCE                                                   M5FII22L
      *> Utilisation :                                                  M5FII22L
      *> copy M5FII22L replacing leading ==I22L== by ==prefix==.        M5FII22L
      *>****************************************************************M5FII22L
      *> -- 16/04/2024 18:16:13 BIB:M5B SESSION:9419  USER:USER         M5FII22L
      *>----------------------------------------------------------------M5FII22L
      *> MO- Demande MAJ indic trt M72O                                 M5FII22L
       01               I22L.                                           M5FII22L
      *> Code Etab Banque Entité Juridique                              *00001
               10       I22L-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       I22L-IDDIEP    PIC X(27).                       *00006
      *> Identifiant personne                                           *00033
               10       I22L-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00033
               10       I22L-FILLER    PIC X(63).                       *00038
