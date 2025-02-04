      *>****************************************************************M5FII21X
      *> FICHIER : Mesures FORB Synchro Gecco Vario                     M5FII21X
      *>----------------------------------------------------------------M5FII21X
      *CONTROL NOSOURCE                                                 M5FII21X
      *> Auteur           :  FERNANDEZ Laurent                          M5FII21X
      *> Date de Création :  10/03/21                                   M5FII21X
      *> Origine Création :                                             M5FII21X
      *>                                                                M5FII21X
      *>                                                                M5FII21X
      *> Segment de description du fichier des mesures Forbearance      M5FII21X
      *> issues des remettants Synchro Gecco vario.                     M5FII21X
      *>                                                                M5FII21X
      *>----------------------------------------------------------------M5FII21X
      *> MOT CLES :                                                     M5FII21X
      *> FORBEARANCE NDOD                                               M5FII21X
      *>----------------------------------------------------------------M5FII21X
      *CONTROL SOURCE                                                   M5FII21X
      *> Utilisation :                                                  M5FII21X
      *> copy M5FII21X replacing leading ==I21X== by ==prefix==.        M5FII21X
      *>****************************************************************M5FII21X
      *> -- 16/04/2024 18:15:42 BIB:M5B SESSION:9419  USER:USER         M5FII21X
      *>----------------------------------------------------------------M5FII21X
      *> Mesures FORB Synchro Gecco Vario                               M5FII21X
       01               I21X.                                           M5FII21X
      *> Code Etab Banque Entité Juridique                              *00001
               10       I21X-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       I21X-IDDIEP    PIC X(27).                       *00006
      *> Code origine concession                                        *00033
               10       I21X-CMM5CS    PIC X(1).                        *00033
      *> Code mesure Forbearance                                        *00034
               10       I21X-CDM5ME    PIC XX.                          *00034
               10       I21X-FILLER    PIC X(165).                      *00036
