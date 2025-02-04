      *>****************************************************************M5FII22G
      *> FICHIER : MO- Stock Forbearance enrichi /pers                  M5FII22G
      *>----------------------------------------------------------------M5FII22G
      *CONTROL NOSOURCE                                                 M5FII22G
      *> Auteur           :  Muriel DIGIANNI                            M5FII22G
      *> Date de Création :  06/11/23                                   M5FII22G
      *> Origine Création :  PR005967 refonte forbearance PRO           M5FII22G
      *>                                                                M5FII22G
      *>                                                                M5FII22G
      *> Segment des forbearance du stock à mettre à jour               M5FII22G
      *> va servir à synchroniser avec les nouvelles concessions        M5FII22G
      *> par contrat et plus par personne                               M5FII22G
      *>----------------------------------------------------------------M5FII22G
      *> MOT CLES :                                                     M5FII22G
      *> MOTEUR FORBEARANCE                                             M5FII22G
      *>----------------------------------------------------------------M5FII22G
      *CONTROL SOURCE                                                   M5FII22G
      *> Utilisation :                                                  M5FII22G
      *> copy M5FII22G replacing leading ==I22G== by ==prefix==.        M5FII22G
      *>****************************************************************M5FII22G
      *> -- 16/04/2024 18:16:03 BIB:M5B SESSION:9419  USER:USER         M5FII22G
      *>----------------------------------------------------------------M5FII22G
      *> MO- Stock Forbearance enrichi /pers                            M5FII22G
       01               I22G.                                           M5FII22G
      *> Code Etab Banque Entité Juridique                              *00001
               10       I22G-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       I22G-IDDIEP    PIC X(27).                       *00006
      *> Code Guichet Interbancaire                                     *00033
               10       I22G-COCXGU    PIC X(5).                        *00033
      *> Code type produit service                                      *00038
               10       I22G-CODIPR    PIC X(4).                        *00038
      *> Référence produit / service                                    *00042
               10       I22G-CODIRF    PIC X(11).                       *00042
      *> Num cycle Forbearance                                          *00053
               10       I22G-NSM5CY    PIC S9(7) PACKED-DECIMAL.        *00053
      *> Num étape dans cycle Forb                                      *00057
               10       I22G-NSM5ET    PIC S9(7) PACKED-DECIMAL.        *00057
      *> Code statut Forbearance                                        *00061
               10       I22G-CEM5TF    PIC X(1).                        *00061
      *> Code surv étape Forbearance                                    *00062
               10       I22G-CEM5ET    PIC X(4).                        *00062
      *> Code statut PE/NPE contrat                                     *00066
               10       I22G-CEM5CT    PIC X(3).                        *00066
      *> Date fin estimée periode probatoire (SSAA-MM-JJ)               *00069
               10       I22G-DFM5ES    PIC X(10).                       *00069
      *> Num cycle Forb de étape prec                                   *00079
               10       I22G-NSM5C1    PIC S9(7) PACKED-DECIMAL.        *00079
      *> Num étape prec dans cycle Forb                                 *00083
               10       I22G-NSM5E1    PIC S9(7) PACKED-DECIMAL.        *00083
      *> Code surv étape Forb prec                                      *00087
               10       I22G-CEM5E1    PIC X(4).                        *00087
      *> Code statut PE/NPE contrat prec                                *00091
               10       I22G-CEM5C1    PIC X(3).                        *00091
      *> Identifiant personne                                           *00094
               10       I22G-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00094
      *> Indic impayé > 30j contrat                                     *00099
               10       I22G-CIM5W6    PIC X(1).                        *00099
      *> Indic impayé > 30j tous contrats                               *00100
               10       I22G-CIM5W7    PIC X(1).                        *00100
      *> Code statut Forbearance proposé                                *00101
               10       I22G-CEM5T2    PIC X(1).                        *00101
      *> Code surv étape Forb proposé                                   *00102
               10       I22G-CEM5E2    PIC X(4).                        *00102
      *> Code statut PE/NPE contrat proposé                             *00106
               10       I22G-CEM5C2    PIC X(3).                        *00106
      *> Numéro de règle proposée                                       *00109
               10       I22G-NXM5R2    PIC X(2).                        *00109
      *> Code défaut Forbearance                                        *00111
               10       I22G-CEM5DF    PIC XX.                          *00111
      *> Date première échéance (SSAA-MM-JJ)                            *00113
               10       I22G-DHM5PE    PIC X(10).                       *00113
      *> Code segment risque Bâle 2 ET                                  *00123
               10       I22G-CDDIBA    PIC X(8).                        *00123
      *> Num chrono NPE                                                 *00131
               10       I22G-NSM5NP    PIC S9(7) PACKED-DECIMAL.        *00131
      *> Date effet entrée cycle Forb (SSAA-MM-JJ)                      *00135
               10       I22G-DDM5CF    PIC X(10).                       *00135
               10       I22G-FILLER    PIC X(06).                       *00145
