      *>****************************************************************M5FII79X
      *> FICHIER : Fichier anomalie NPE Forbearance                     M5FII79X
      *>----------------------------------------------------------------M5FII79X
      *CONTROL NOSOURCE                                                 M5FII79X
      *> Auteur           :  Jacques Sernesi                            M5FII79X
      *> Date de Création :  08/01/15                                   M5FII79X
      *> Origine Création :  Projet 017431 : TOPS NPE / Forbearance     M5FII79X
      *>                                                                M5FII79X
      *>                                                                M5FII79X
      *> Segment de description du fichier des anomalies utilisé        M5FII79X
      *> dans les traitements NPE et Forbearance                        M5FII79X
      *>----------------------------------------------------------------M5FII79X
      *> MOT CLES :                                                     M5FII79X
      *> M-5 NPE FORBEARANCE                                            M5FII79X
      *>----------------------------------------------------------------M5FII79X
      *CONTROL SOURCE                                                   M5FII79X
      *> Utilisation :                                                  M5FII79X
      *> copy M5FII79X replacing leading ==I79X== by ==prefix==.        M5FII79X
      *>****************************************************************M5FII79X
      *> -- 06/06/2024 13:41:23 BIB:M5B SESSION:9512  USER:USER         M5FII79X
      *>----------------------------------------------------------------M5FII79X
      *> Fichier anomalie NPE Forbearance                               M5FII79X
       01               I79X.                                           M5FII79X
      *> Date traitement (date système) (SSAA-MM-JJ)                    *00001
               10       I79X-DAMKTR    PIC X(10).                       *00001
               10       I79X-FILLER    PIC X(01).                       *00011
      *> Identifiant traitement Forb                                    *00012
               10       I79X-IDM5TT    PIC X(10).                       *00012
               10       I79X-FILLER    PIC X(01).                       *00022
      *> Periodicite traitement                                         *00023
               10       I79X-PTM5PE    PIC X(1).                        *00023
               10       I79X-FILLER    PIC X(01).                       *00024
      *> Code externe programme                                         *00025
               10       I79X-CDSGPR    PIC X(8).                        *00025
               10       I79X-FILLER    PIC X(01).                       *00033
      *> Libellé de Programme                                           *00034
               10       I79X-LNSGPR    PIC X(36).                       *00034
               10       I79X-FILLER    PIC X(01).                       *00070
      *> Code anomalie NPE FORBEARANCE                                  *00071
               10       I79X-CDM5AN    PIC X(05).                       *00071
               10       I79X-FILLER    PIC X(01).                       *00076
      *> Type anomalie                                                  *00077
               10       I79X-CTM5AN    PIC X(02).                       *00077
               10       I79X-FILLER    PIC X(01).                       *00079
      *> Libelle message anomalie                                       *00080
               10       I79X-LLM5AN    PIC X(150).                      *00080
               10       I79X-FILLER    PIC X(01).                       *00230
      *> Zone groupe données anomalie                                   *00231
               10       I79X-GRM5DA    PIC X(150).                      *00231
               10       I79X-FILLER    PIC X(01).                       *00381
      *> Zone groupe données anomalie                                   *00382
               10       I79X-GRM5D1    PIC X(150).                      *00382
               10       I79X-FILLER    PIC X(500).                      *00532
      *> Longueur de la structure : 01031 octets                        *01031
