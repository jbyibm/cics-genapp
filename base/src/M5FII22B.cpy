      *>****************************************************************M5FII22B
      *> FICHIER : MO- Concessions écartées                             M5FII22B
      *>----------------------------------------------------------------M5FII22B
      *CONTROL NOSOURCE                                                 M5FII22B
      *> Auteur           :  Florent DARD                               M5FII22B
      *> Date de Création :  22/09/23                                   M5FII22B
      *> Origine Création :  P36441 - Refonte du Moteur Forbearance     M5FII22B
      *>                                                                M5FII22B
      *>                                                                M5FII22B
      *> Les concessions ecartées par le moteur forbearance suite       M5FII22B
      *> au contrôle des données de la concessions et de son            M5FII22B
      *> éligibilité à la Forbearance.                                  M5FII22B
      *>                                                                M5FII22B
      *>----------------------------------------------------------------M5FII22B
      *> MOT CLES :                                                     M5FII22B
      *>                                                                M5FII22B
      *>----------------------------------------------------------------M5FII22B
      *CONTROL SOURCE                                                   M5FII22B
      *> Utilisation :                                                  M5FII22B
      *> copy M5FII22B replacing leading ==I22B== by ==prefix==.        M5FII22B
      *>****************************************************************M5FII22B
      *> -- 16/04/2024 18:15:54 BIB:M5B SESSION:9419  USER:USER         M5FII22B
      *>----------------------------------------------------------------M5FII22B
      *> MO- Concessions écartées                                       M5FII22B
       01               I22B.                                           M5FII22B
      *> Code Etab Banque Entité Juridique                              *00001
               10       I22B-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       I22B-IDDIEP    PIC X(27).                       *00006
      *> Type concession                                                *00033
               10       I22B-CTM5CS    PIC X(1).                        *00033
      *> Code origine concession                                        *00034
               10       I22B-CMM5CS    PIC X(1).                        *00034
      *> Date effet concession (SSAA-MM-JJ)                             *00035
               10       I22B-DFM5CS    PIC X(10).                       *00035
      *> Code Produit National                                          *00045
               10       I22B-COEGPX    PIC X(6).                        *00045
      *> Numéro dossier contentieux                                     *00051
               10       I22B-NOMKDO    PIC S9(7) PACKED-DECIMAL.        *00051
      *> Code état plan apurement                                       *00055
               10       I22B-CEMKPA    PIC X.                           *00055
      *> Code type plan recouvrement                                    *00056
               10       I22B-CDMKTQ    PIC X.                           *00056
      *> Date première échéance (SSAA-MM-JJ)                            *00057
               10       I22B-DHM5PE    PIC X(10).                       *00057
      *> Indicateur exception pour CFF                                  *00067
               10       I22B-CIM5XC    PIC X(1).                        *00067
      *> Libellé motif rejet enregistrement                             *00068
               10       I22B-LIPJRJ    PIC X(80).                       *00068
      *> ERROR GRAVITY                                                  *00148
               10       I22B-XGRAER    PIC X.                           *00148
               10       I22B-FILLER    PIC X(52).                       *00149
