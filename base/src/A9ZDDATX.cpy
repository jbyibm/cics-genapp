      *>****************************************************************A9ZDDATX
      *> LINKAGE SFDB05 : Gestion des dates BATCH                       A9ZDDATX
      *>----------------------------------------------------------------A9ZDDATX
      *CONTROL NOSOURCE                                                 A9ZDDATX
      *> Zone de communication module Gestion des Dates                 A9ZDDATX
      *> Confer TMR 11 0068                                             A9ZDDATX
      *> - Module batch : SFDB05                                        A9ZDDATX
      *>   call 'SFDB05' using ZS00 end-call                            A9ZDDATX
      *>----------------------------------------------------------------A9ZDDATX
      *> Paramètres obligatoires :                                      A9ZDDATX
      *> - Néant                                                        A9ZDDATX
      *> Paramètres facultatifs (selon contexte) :                      A9ZDDATX
      *> - leading ZS : préfixe des zones du service                    A9ZDDATX
      *>----------------------------------------------------------------A9ZDDATX
      *> MOT CLES :                                                     A9ZDDATX
      *>                                                                A9ZDDATX
      *>----------------------------------------------------------------A9ZDDATX
      *CONTROL SOURCE                                                   A9ZDDATX
      *> Utilisation :                                                  A9ZDDATX
      *> copy A9ZDDATX replacing leading ==ZS== by ==prefix==.          A9ZDDATX
      *>****************************************************************A9ZDDATX
      *>#GN 07/10/2024 10:51:38 BIB:CTRS.SFO SESSION:5498  USER:USER    A9ZDDATX
       01               ZS00.                                           A9ZDDATX
      *>-------------------------------------------------- #SEG:ZS1A ---A9ZDDATX
      *> Zone comm. Gestion des dates (In)                              A9ZDDATX
           02           ZS1A.                                           A9ZDDATX
      *> Format d'une date                                              *00001
               10       ZS1A-CTSDDA    PIC X.                           *00001
                    88  ZS1A-CTSDDA-SSAAQQQ  VALUE 'A'.                 *00001
                    88  ZS1A-CTSDDA-JJMMSSAA VALUE 'J'.                 *00001
                    88  ZS1A-CTSDDA-NNSSAA   VALUE 'N'.                 *00001
                    88  ZS1A-CTSDDA-QQQSSAA  VALUE 'Q'.                 *00001
                    88  ZS1A-CTSDDA-SSAAMMJJ VALUE 'S'.                 *00001
      *> Date au format NNSSAA                                          *00002
               10       ZS1A-DASDNN.                                    *00002
      *> Numéro de semaine dans l'année                                 *00002
                11      ZS1A-WDNN      PIC 99.                          *00002
      *> Siècle année                                                   *00004
                11      ZS1A-WDSA3     PIC X(4).                        *00004
      *> Date format SSAAMMJJ                                           *00008
               10       ZS1A-DASDSJ.                                    *00008
      *> Siècle année                                                   *00008
                11      ZS1A-WDSA      PIC X(4).                        *00008
      *> Mois                                                           *00012
                11      ZS1A-WDMM      PIC X(2).                        *00012
      *> Jour                                                           *00014
                11      ZS1A-WDJJ      PIC X(2).                        *00014
      *> Date format JJMMSSAA                                           *00016
               10       ZS1A-DASDCJ.                                    *00016
      *> Jour                                                           *00016
                11      ZS1A-WDJJ1     PIC X(2).                        *00016
      *> Mois                                                           *00018
                11      ZS1A-WDMM1     PIC X(2).                        *00018
      *> Siècle année                                                   *00020
                11      ZS1A-WDSA1     PIC X(4).                        *00020
      *> Date en quantième format QQQSSAA                               *00024
               10       ZS1A-DASDQC.                                    *00024
      *> Quantième d'une date QQQ                                       *00024
                11      ZS1A-DASDQQ    PIC 9(3).                        *00024
      *> Siècle année                                                   *00027
                11      ZS1A-WDSA4     PIC X(4).                        *00027
      *> Date en quantième format SSAAQQQ                               *00031
               10       ZS1A-DASDQS.                                    *00031
      *> Siècle année                                                   *00031
                11      ZS1A-WDSA5     PIC X(4).                        *00031
      *> Quantième d'une date QQQ                                       *00035
                11      ZS1A-DASDQ1    PIC 9(3).                        *00035
      *> Type de traitement                                             *00038
               10       ZS1A-CTSDTR    PIC X.                           *00038
                    88  ZS1A-CTSDTR-ANNEES      VALUE 'A'.              *00038
                    88  ZS1A-CTSDTR-CONTROLE    VALUE 'C'.              *00038
                    88  ZS1A-CTSDTR-DIFFERENCE  VALUE 'D'.              *00038
                    88  ZS1A-CTSDTR-FIN-SEMAINE VALUE 'F'.              *00038
                    88  ZS1A-CTSDTR-JOURS       VALUE 'J'.              *00038
                    88  ZS1A-CTSDTR-MOIS        VALUE 'M'.              *00038
                    88  ZS1A-CTSDTR-SEMAINES    VALUE 'S'.              *00038
                    88  ZS1A-CTSDTR-TRANSFORME  VALUE 'T'.              *00038
      *> Identifiant Calendrier                                         *00039
               10       ZS1A-WIDCL     PIC XXX.                         *00039
      *> Valeur increm / decremen                                       *00042
               10       ZS1A-QTSDID    PIC S9(3).                       *00042
      *> Date format SSAAMMJJ                                           *00045
               10       ZS1A-DASDS1.                                    *00045
      *> Siècle année                                                   *00045
                11      ZS1A-WDSA2     PIC X(4).                        *00045
      *> Mois                                                           *00049
                11      ZS1A-WDMM2     PIC X(2).                        *00049
      *> Jour                                                           *00051
                11      ZS1A-WDJJ2     PIC X(2).                        *00051
      *> Longueur de la structure : 00052 octets                        *00052
      *>-------------------------------------------------- #SEG:ZS1B ---A9ZDDATX
      *> Zone comm. Gestion des dates (Out)                             A9ZDDATX
           02           ZS1B.                                           A9ZDDATX
      *> Code retour traitement de dates                                *00001
               10       ZS1B-COSDRT    PIC X.                           *00001
                    88  ZS1B-COSDRT-OK               VALUE ' '.         *00001
                    88  ZS1B-COSDRT-ERR-FORMAT       VALUE '1'.         *00001
                    88  ZS1B-COSDRT-ERR-CALENDRIER   VALUE '2'.         *00001
                    88  ZS1B-COSDRT-ERR-FORMAT-DATE2 VALUE '3'.         *00001
                    88  ZS1B-COSDRT-ERR-INCREMENT    VALUE '4'.         *00001
                    88  ZS1B-COSDRT-ERR-TRAITEMENT   VALUE '5'.         *00001
      *> Date au format NNSSAA                                          *00002
               10       ZS1B-DASDNN.                                    *00002
      *> Numéro de semaine dans l'année                                 *00002
                11      ZS1B-WDNN      PIC 99.                          *00002
      *> Siècle année                                                   *00004
                11      ZS1B-WDSA3     PIC X(4).                        *00004
      *> Date format SSAAMMJJ                                           *00008
               10       ZS1B-DASDSJ.                                    *00008
      *> Siècle année                                                   *00008
                11      ZS1B-WDSA      PIC X(4).                        *00008
      *> Mois                                                           *00012
                11      ZS1B-WDMM      PIC X(2).                        *00012
      *> Jour                                                           *00014
                11      ZS1B-WDJJ      PIC X(2).                        *00014
      *> Date format JJMMSSAA                                           *00016
               10       ZS1B-DASDCJ.                                    *00016
      *> Jour                                                           *00016
                11      ZS1B-WDJJ1     PIC X(2).                        *00016
      *> Mois                                                           *00018
                11      ZS1B-WDMM1     PIC X(2).                        *00018
      *> Siècle année                                                   *00020
                11      ZS1B-WDSA1     PIC X(4).                        *00020
      *> Date en quantième format QQQSSAA                               *00024
               10       ZS1B-DASDQC.                                    *00024
      *> Quantième d'une date QQQ                                       *00024
                11      ZS1B-DASDQQ    PIC 9(3).                        *00024
      *> Siècle année                                                   *00027
                11      ZS1B-WDSA4     PIC X(4).                        *00027
      *> Date en quantième format SSAAQQQ                               *00031
               10       ZS1B-DASDQS.                                    *00031
      *> Siècle année                                                   *00031
                11      ZS1B-WDSA5     PIC X(4).                        *00031
      *> Quantième d'une date QQQ                                       *00035
                11      ZS1B-DASDQ1    PIC 9(3).                        *00035
      *> Type du jour                                                   *00038
               10       ZS1B-CTSDJR    PIC X.                           *00038
                    88  ZS1B-CTSDJR-FERIE   VALUE 'F'.                  *00038
                    88  ZS1B-CTSDJR-OUVERT  VALUE 'O'.                  *00038
                    88  ZS1B-CTSDJR-WEEKEND VALUE 'W'.                  *00038
      *> Numéro jour semaine                                            *00039
               10       ZS1B-NOSDRG    PIC X.                           *00039
                    88  ZS1B-NOSDRG-LUNDI    VALUE '1'.                 *00039
                    88  ZS1B-NOSDRG-MARDI    VALUE '2'.                 *00039
                    88  ZS1B-NOSDRG-MERCREDI VALUE '3'.                 *00039
                    88  ZS1B-NOSDRG-JEUDI    VALUE '4'.                 *00039
                    88  ZS1B-NOSDRG-VENDREDI VALUE '5'.                 *00039
                    88  ZS1B-NOSDRG-SAMEDI   VALUE '6'.                 *00039
                    88  ZS1B-NOSDRG-DIMANCHE VALUE '7'.                 *00039
      *> Libellé du jour                                                *00040
               10       ZS1B-LNSDJR    PIC X(8).                        *00040
      *> Libellé du mois                                                *00048
               10       ZS1B-LNSDMS    PIC X(9).                        *00048
      *> Date formatée en clair                                         *00057
               10       ZS1B-DASDFT    PIC X(26).                       *00057
      *> Date formatée en clair                                         *00083
               10       ZS1B-DASDF1    PIC X(18).                       *00083
      *> Nb jours                                                       *00101
               10       ZS1B-QTSDJR    PIC 9(3).                        *00101
      *> Nombre de mois                                                 *00104
               10       ZS1B-QTSDMS    PIC 9(3).                        *00104
      *> Nombre d'années                                                *00107
               10       ZS1B-QTSDAN    PIC 9(3).                        *00107
      *> Longueur de la structure : 00109 octets                        *00109
