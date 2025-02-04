      *>****************************************************************M52DM72N
      *> TABLE DB2 M72N : Fiche Forbearance                             M52DM72N
      *>----------------------------------------------------------------M52DM72N
      *CONTROL NOSOURCE                                                 M52DM72N
      *> Auteur           :  Muriel DI GIANNI                           M52DM72N
      *> Date de Création :  11/08/22                                   M52DM72N
      *> Origine Création :  31984 refonte qualification forbearance    M52DM72N
      *>                                                                M52DM72N
      *>                                                                M52DM72N
      *> Segment de description de la table M72N.                       M52DM72N
      *>                                                                M52DM72N
      *> Table permettant d'enregistrer toutes les fiches Forbearance   M52DM72N
      *> créées sur le nouvel IHM MYWAY via le processus Qualifier      M52DM72N
      *> la Forbearance                                                 M52DM72N
      *>                                                                M52DM72N
      *>----------------------------------------------------------------M52DM72N
      *> MOT CLES :                                                     M52DM72N
      *>                                                                M52DM72N
      *>----------------------------------------------------------------M52DM72N
      *CONTROL SOURCE                                                   M52DM72N
      *> Utilisation :                                                  M52DM72N
      *> copy M52DM72N replacing leading ==M72N== by ==prefix==         M52DM72N
      *>                         leading ==V-M72N== by ==V-prefix==.    M52DM72N
      *>****************************************************************M52DM72N
      *> -- 24/06/2024 09:05:50 BIB:M5B SESSION:9544  USER:USER         M52DM72N
      *>----------------------------------------------------------------M52DM72N
      *> Fiche Forbearance                                              M52DM72N
       01               M72N.                                           M52DM72N
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72N-COCXBQ    PIC X(5).                        *00001
      *> Identifiant personne                                           *00006
               10       M72N-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00006
      *> TS création enregistrement (TIMESTAMP)                         *00011
               10       M72N-HDEHEG    PIC X(26).                       *00011
      *> Ref ext agent création enreg                                   *00037
               10       M72N-NUCEEC    PIC S9(7) PACKED-DECIMAL.        *00037
      *> Note affichable BPCE                                           *00041
               10       M72N-COMBND    PIC X(8).                        *00041
      *> Indicateur impayé                                              *00049
               10       M72N-CIM5W2    PIC X(1).                        *00049
      *> Indicateur dépassement découvert                               *00050
               10       M72N-CIM5W3    PIC X(1).                        *00050
      *> Indic créance Forbearance                                      *00051
               10       M72N-CIMRFB    PIC X.                           *00051
      *> Indic Tiers en watch-list                                      *00052
               10       M72N-CIDYTW    PIC X(1).                        *00052
      *> Niveau risque qualif Forbearance                               *00053
               10       M72N-CVM5NR    PIC X(1).                        *00053
      *> Indicateur early warning                                       *00054
               10       M72N-CIM5W9    PIC X(1).                        *00054
      *> Ind Eligible Forb suite diff financ                            *00055
               10       M72N-CIM5TE    PIC X.                           *00055
      *> Indic fiche forb associée PIM                                  *00056
               10       M72N-CIM5PI    PIC X(1).                        *00056
      *> Longueur de la structure : 00056 octets                        *00056
      *>                                                                M52DM72N
       >>if AA-A-DB2NOIND not defined                                   M52DM72N
       01               V-M72N.                                         M52DM72N
               10       V-M72N-COCXBQ  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-NODAPE  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-HDEHEG  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-NUCEEC  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-COMBND  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-CIM5W2  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-CIM5W3  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-CIMRFB  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-CIDYTW  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-CVM5NR  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-CIM5W9  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-CIM5TE  PIC S9(4) COMP-5.                M52DM72N
               10       V-M72N-CIM5PI  PIC S9(4) COMP-5.                M52DM72N
       01               V-M72N-R       REDEFINES V-M72N.                M52DM72N
               10       V-M72N-A       PIC S9(4) COMP-5                 M52DM72N
                                       OCCURS 00013.                    M52DM72N
       >>end-if                                                         M52DM72N
       >>define AA-A-DB2NOIND off                                       M52DM72N
