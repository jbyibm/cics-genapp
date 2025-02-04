      *>****************************************************************M5FII21K
      *> FICHIER : Contrat Refinancé sur concession                     M5FII21K
      *>----------------------------------------------------------------M5FII21K
      *CONTROL NOSOURCE                                                 M5FII21K
      *> Auteur           :  Nicole TURCO                               M5FII21K
      *> Date de Création :  05/12/14                                   M5FII21K
      *> Origine Création :  Projet 017431 : Forbearance NPE            M5FII21K
      *>                                                                M5FII21K
      *>                                                                M5FII21K
      *> Segment de description du fichier des contrats refinancés      M5FII21K
      *> sur une concession de type refinancement.                      M5FII21K
      *>                                                                M5FII21K
      *>----------------------------------------------------------------M5FII21K
      *> MOT CLES :                                                     M5FII21K
      *> FORBEARANCE 017431                                             M5FII21K
      *>----------------------------------------------------------------M5FII21K
      *CONTROL SOURCE                                                   M5FII21K
      *> Utilisation :                                                  M5FII21K
      *> copy M5FII21K replacing leading ==I21K== by ==prefix==.        M5FII21K
      *>****************************************************************M5FII21K
      *> -- 16/04/2024 18:15:29 BIB:M5B SESSION:9419  USER:USER         M5FII21K
      *>----------------------------------------------------------------M5FII21K
      *> Contrat Refinancé sur concession                               M5FII21K
       01               I21K.                                           M5FII21K
      *> Code Etab Banque Entité Juridique                              *00001
               10       I21K-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       I21K-IDDIEP    PIC X(27).                       *00006
      *> Date effet concession (SSAA-MM-JJ)                             *00033
               10       I21K-DFM5CS    PIC X(10).                       *00033
      *> Identifiant contrat refinancé                                  *00043
               10       I21K-IDM5CR    PIC X(27).                       *00043
               10       I21K-FILLER    PIC X(131).                      *00070
