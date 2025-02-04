      *>****************************************************************M5QDM5QH
      *> MESSAGES Q/R M175QH00 : Q/R Consultation mesures FORB          M5QDM5QH
      *>----------------------------------------------------------------M5QDM5QH
      *CONTROL NOSOURCE                                                 M5QDM5QH
      *> Cette QR permet de :                                           M5QDM5QH
      *> restituer les mesures d'une forbearance                        M5QDM5QH
      *>                                                                M5QDM5QH
      *>                                                                M5QDM5QH
      *>                                                                M5QDM5QH
      *>----------------------------------------------------------------M5QDM5QH
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5QH
      *>----------------------------------------------------------------M5QDM5QH
      *> Mots clés :                                                    M5QDM5QH
      *> FORBEARANCE M-5 M175QH00                                       M5QDM5QH
      *>----------------------------------------------------------------M5QDM5QH
      *CONTROL SOURCE                                                   M5QDM5QH
      *> Utilisation :                                                  M5QDM5QH
      *> copy M5QDM5QH replacing QUESTION  by QUESTION-xxx              M5QDM5QH
      *>                         REPONSE   by REPONSE-xxx               M5QDM5QH
      *>                         REDEFINES by REDEFINES                 M5QDM5QH
      *>                         leading ==QU== by ==Qx==               M5QDM5QH
      *>                         leading ==RE== by ==Rx==.              M5QDM5QH
      *>****************************************************************M5QDM5QH
      *> -- 13/06/2024 10:25:43 BIB:M5B SESSION:9524  USER:USER         M5QDM5QH
       >>if AA-E-MESSAGES not defined                                   M5QDM5QH
         >>define AA-E-MESSAGES as ' '                                  M5QDM5QH
       >>end-if                                                         M5QDM5QH
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5QH
      *>****************************************************************M5QDM5QH
      *> Questions Q/R M175QH00                                         M5QDM5QH
      *>****************************************************************M5QDM5QH
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QH
       01               QUESTION.                                       M5QDM5QH
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QH
      *> QR Partie commune niveau Application                           M5QDM5QH
            03          QU00.                                           M5QDM5QH
              05        QU00-00.                                        *00001
      *> QR ADT Standard Inter-Domaine                                  *00001
               10       QU00-SA00.                                      *00001
      *> QR Longueur Segment Question/Réponse                           *00001
                11      QU00-WLGQR     PIC 9(4).                        *00001
                11      QU00-WLGQRXX   REDEFINES QU00-WLGQR             *00001
                                       PIC X(004).                      *00001
      *> LONGUEUR FLUX                                                  *00001
                11      QU00-XZ3LNG    REDEFINES QU00-WLGQR             *00001
                                       PIC 9(4).                        *00001
      *> QR Code Segment Question/Réponse                               *00005
                11      QU00-WLNQR.                                     *00005
      *> QR Type de Segment ECHANGES                                    *00005
                 12     QU00-CTSEQR    PIC X.                           *00005
      *> QR Code Structure Question/Réponse                             *00006
                 12     QU00-WLNQR6    PIC X(6).                        *00006
      *> QR Nature d'un Segment ECHANGES                                *00012
                 12     QU00-CNSEQR    PIC X.                           *00012
      *> CODE STRUCTURE DONNEES                                         *00005
                11      QU00-XZ3SGE    REDEFINES QU00-WLNQR             *00005
                                       PIC X(8).                        *00005
              05        QU00-SUITE.                                     *00013
               10       FILLER         PIC X(00047).                    *00013
      *> Longueur de la structure : 00059 octets                        *00059
         >>end-if                                                       M5QDM5QH
      *>--- ID='M5S175' ------------------------------------------------M5QDM5QH
      *> Q Consultation Mesures Forbearance                             M5QDM5QH
            03          QU75           REDEFINES QU00.                  M5QDM5QH
               10       FILLER         PIC X(00012).                    *00001
      *> Code action                                                    *00013
               10       QU75-CASETR    PIC X.                           *00013
      *> Code Etab Banque Entité Juridique                              *00014
               10       QU75-COCXBQ    PIC X(5).                        *00014
      *> Identifiant Contrat                                            *00019
               10       QU75-IDDIEP    PIC X(27).                       *00019
      *> Num cycle Forbearance                                          *00046
               10       QU75-NSM5CY    PIC 9(7).                        *00046
               10       QU75-NSM5CYX   REDEFINES QU75-NSM5CY            *00046
                                       PIC X(007).                      *00046
      *> Num étape dans cycle Forb                                      *00053
               10       QU75-NSM5ET    PIC 9(7).                        *00053
               10       QU75-NSM5ETX   REDEFINES QU75-NSM5ET            *00053
                                       PIC X(007).                      *00053
      *> Longueur de la structure : 00059 octets                        *00059
       >>end-if                                                         M5QDM5QH
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5QH
      *>****************************************************************M5QDM5QH
      *> Réponses Q/R M175QH00                                          M5QDM5QH
      *>****************************************************************M5QDM5QH
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QH
       01               REPONSE.                                        M5QDM5QH
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QH
      *> QR Partie commune niveau Application                           M5QDM5QH
            03          RE00.                                           M5QDM5QH
              05        RE00-00.                                        *00001
      *> QR ADT Standard Inter-Domaine                                  *00001
               10       RE00-SA00.                                      *00001
      *> QR Longueur Segment Question/Réponse                           *00001
                11      RE00-WLGQR     PIC 9(4).                        *00001
      *> LONGUEUR FLUX                                                  *00001
                11      RE00-XZ3LNG    REDEFINES RE00-WLGQR             *00001
                                       PIC 9(4).                        *00001
      *> QR Code Segment Question/Réponse                               *00005
                11      RE00-WLNQR.                                     *00005
      *> QR Type de Segment ECHANGES                                    *00005
                 12     RE00-CTSEQR    PIC X.                           *00005
      *> QR Code Structure Question/Réponse                             *00006
                 12     RE00-WLNQR6    PIC X(6).                        *00006
      *> QR Nature d'un Segment ECHANGES                                *00012
                 12     RE00-CNSEQR    PIC X.                           *00012
      *> CODE STRUCTURE DONNEES                                         *00005
                11      RE00-XZ3SGE    REDEFINES RE00-WLNQR             *00005
                                       PIC X(8).                        *00005
              05        RE00-SUITE.                                     *00013
               10       FILLER         PIC X(00094).                    *00013
      *> Longueur de la structure : 00106 octets                        *00106
         >>end-if                                                       M5QDM5QH
      *>--- ID='AISA06' ------------------------------------------------M5QDM5QH
      *> R Réponse Standard Libellé sur 80                              M5QDM5QH
            03          RE06           REDEFINES RE00.                  M5QDM5QH
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE06-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE06-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE06-WCORE3    PIC 9(3).                        *00013
      *> Clé Réduite Messages Erreur PETRA                              *00016
               10       RE06-GRXXCR.                                    *00016
      *> Code Domaine de Gestion PACBASE                                *00016
                11      RE06-WCODM     PIC X(3).                        *00016
      *> Code Message erreur (008)                                      *00019
                11      RE06-WCOLE     PIC X(8).                        *00019
      *> Libelle Message Erreur sur 80 car.                             *00027
               10       RE06-WLE80.                                     *00027
      *> Libellé erreur                                                 *00027
                11      RE06-LISTER    PIC X(79).                       *00027
      *> Indic présence info complémentaire                             *00106
                11      RE06-CISTPI    PIC X.                           *00106
      *> Longueur de la structure : 00106 octets                        *00106
      *>--- ID='M5S176' ------------------------------------------------M5QDM5QH
      *> R Consultation Mesures Forbearance                             M5QDM5QH
            03          RE76           REDEFINES RE00.                  M5QDM5QH
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       RE76-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       RE76-IDDIEP    PIC X(27).                       *00018
      *> Num cycle Forbearance                                          *00045
               10       RE76-NSM5CY    PIC 9(7).                        *00045
      *> Num étape dans cycle Forb                                      *00052
               10       RE76-NSM5ET    PIC 9(7).                        *00052
      *> Code mesure Forbearance                                        *00059
               10       RE76-CDM5ME    PIC XX.                          *00059
      *> Date début effet mesure sur FB (SSAAMMJJ)                      *00061
               10       RE76-DDM5MF    PIC X(8).                        *00061
      *> Date fin effet mesure sur FB (SSAAMMJJ)                        *00069
               10       RE76-DFM5MF    PIC X(8).                        *00069
      *> Référence externe agent                                        *00077
               10       RE76-NOCEAG    PIC 9(7).                        *00077
      *> Code programme origine                                         *00084
               10       RE76-IDMRPO    PIC X(8).                        *00084
      *> Longueur de la structure : 00091 octets                        *00091
       >>end-if                                                         M5QDM5QH
       >>define AA-E-MESSAGES off                                       M5QDM5QH
