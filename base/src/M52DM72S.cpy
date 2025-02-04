      *>****************************************************************M52DM72S
      *> TABLE DB2 M72S : Statut Fiche Forbearance                      M52DM72S
      *>----------------------------------------------------------------M52DM72S
      *CONTROL NOSOURCE                                                 M52DM72S
      *> Auteur           :  Muriel DI GIANNI                           M52DM72S
      *> Date de Création :  22/08/22                                   M52DM72S
      *> Origine Création :  31984 refonte qualification forbearance    M52DM72S
      *>                                                                M52DM72S
      *>                                                                M52DM72S
      *> Segment de description de la table M72S.                       M52DM72S
      *>                                                                M52DM72S
      *> Table permettant d'enregistrer toutes les étapes d'une         M52DM72S
      *> fiche Forbearance afin d'historiser les différentes saisies    M52DM72S
      *> de chaque acteur (instructeur et valideur)                     M52DM72S
      *> il existera une étape d'instruction                            M52DM72S
      *>             une étape de revue (facultative)                   M52DM72S
      *>             une étape de validation                            M52DM72S
      *>             une étape de traitement (une fois validée)         M52DM72S
      *> Modifié par :       Muriel DI GIANNI                           M52DM72S
      *> Modifié le  :       16/12/22                                   M52DM72S
      *> Motif de Modif. :   31984 refonte qualification forbearance    M52DM72S
      *>                                                                M52DM72S
      *> Ajout motif finalisation                                       M52DM72S
      *>----------------------------------------------------------------M52DM72S
      *> MOT CLES :                                                     M52DM72S
      *>                                                                M52DM72S
      *>----------------------------------------------------------------M52DM72S
      *CONTROL SOURCE                                                   M52DM72S
      *> Utilisation :                                                  M52DM72S
      *> copy M52DM72S replacing leading ==M72S== by ==prefix==         M52DM72S
      *>                         leading ==V-M72S== by ==V-prefix==.    M52DM72S
      *>****************************************************************M52DM72S
      *> -- 24/06/2024 22:06:31 BIB:M5B SESSION:9545  USER:USER         M52DM72S
      *>----------------------------------------------------------------M52DM72S
      *> Etape Fiche Forbearance                                        M52DM72S
       01               M72S.                                           M52DM72S
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72S-COCXBQ    PIC X(5).                        *00001
      *> Identifiant personne                                           *00006
               10       M72S-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00006
      *> TS création enregistrement (TIMESTAMP)                         *00011
               10       M72S-HDEHEG    PIC X(26).                       *00011
      *> Code statut fiche                                              *00037
               10       M72S-CEM5SF    PIC X(3).                        *00037
      *> Date création statut Fiche (SSAA-MM-JJ)                        *00040
               10       M72S-DDM5SF    PIC X(10).                       *00040
      *> Indicateur statut actif                                        *00050
               10       M72S-CIM5AF    PIC X(1).                        *00050
      *> Date finalisation statut fiche (SSAA-MM-JJ)                    *00051
               10       M72S-DDM5FI    PIC X(10).                       *00051
      *> Ref ext agent histo élément                                    *00061
               10       M72S-NUCEHE    PIC S9(7) PACKED-DECIMAL.        *00061
      *> Code état hors périmètre forb                                  *00065
               10       M72S-CEM5HP    PIC X(1).                        *00065
      *> Code statut question prospective                               *00066
               10       M72S-CEM5QP    PIC X(1).                        *00066
      *> Code statut question difficulté fi                             *00067
               10       M72S-CEM5DI    PIC X(1).                        *00067
      *> Code statut question défaut                                    *00068
               10       M72S-CEM5DE    PIC X(1).                        *00068
      *> Commentaire situation financière                               *00069
               10       M72S-LRM5SF-VAR.                                *00069
                    49  M72S-LRM5SF-LENGTH                              *00069
                                       PIC S9(4) COMP-5.                *00069
                    49  M72S-LRM5SF-DATA                                *00071
                                       PIC X(4000).                     *00071
      *> Code motif finalisation étape                                  *04071
               10       M72S-CMM5FI    PIC X(2).                        *04071
      *> Libellé commentaire final analyse                              *04073
               10       M72S-LRM5AI-VAR.                                *04073
                    49  M72S-LRM5AI-LENGTH                              *04073
                                       PIC S9(4) COMP-5.                *04073
                    49  M72S-LRM5AI-DATA                                *04075
                                       PIC X(400).                      *04075
      *> Libellé commentaire quest prospectiv                           *04475
               10       M72S-LRM5QP-VAR.                                *04475
                    49  M72S-LRM5QP-LENGTH                              *04475
                                       PIC S9(4) COMP-5.                *04475
                    49  M72S-LRM5QP-DATA                                *04477
                                       PIC X(4000).                     *04477
      *> Code niveau situation financ pers                              *08477
               10       M72S-CVM5AI    PIC X(1).                        *08477
      *> Longueur de la structure : 08477 octets                        *08477
      *>                                                                M52DM72S
       >>if AA-A-DB2NOIND not defined                                   M52DM72S
       01               V-M72S.                                         M52DM72S
               10       V-M72S-COCXBQ  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-NODAPE  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-HDEHEG  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-CEM5SF  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-DDM5SF  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-CIM5AF  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-DDM5FI  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-NUCEHE  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-CEM5HP  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-CEM5QP  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-CEM5DI  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-CEM5DE  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-LRM5SF  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-CMM5FI  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-LRM5AI  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-LRM5QP  PIC S9(4) COMP-5.                M52DM72S
               10       V-M72S-CVM5AI  PIC S9(4) COMP-5.                M52DM72S
       01               V-M72S-R       REDEFINES V-M72S.                M52DM72S
               10       V-M72S-A       PIC S9(4) COMP-5                 M52DM72S
                                       OCCURS 00017.                    M52DM72S
       >>end-if                                                         M52DM72S
       >>define AA-A-DB2NOIND off                                       M52DM72S
