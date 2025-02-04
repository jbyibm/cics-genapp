      *>****************************************************************M5QDM5QJ
      *> MESSAGES Q/R M175QJ00 : Q/R Consult viabilité Forb             M5QDM5QJ
      *>----------------------------------------------------------------M5QDM5QJ
      *CONTROL NOSOURCE                                                 M5QDM5QJ
      *> Cette QR permet de restituer                                   M5QDM5QJ
      *> la viabilité d'une forbearance                                 M5QDM5QJ
      *>                                                                M5QDM5QJ
      *>                                                                M5QDM5QJ
      *>                                                                M5QDM5QJ
      *>----------------------------------------------------------------M5QDM5QJ
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5QJ
      *>----------------------------------------------------------------M5QDM5QJ
      *> Mots clés :                                                    M5QDM5QJ
      *> FORBEARANCE M-5 M175QJ00                                       M5QDM5QJ
      *>----------------------------------------------------------------M5QDM5QJ
      *CONTROL SOURCE                                                   M5QDM5QJ
      *> Utilisation :                                                  M5QDM5QJ
      *> copy M5QDM5QJ replacing QUESTION  by QUESTION-xxx              M5QDM5QJ
      *>                         REPONSE   by REPONSE-xxx               M5QDM5QJ
      *>                         REDEFINES by REDEFINES                 M5QDM5QJ
      *>                         leading ==QU== by ==Qx==               M5QDM5QJ
      *>                         leading ==RE== by ==Rx==.              M5QDM5QJ
      *>****************************************************************M5QDM5QJ
      *> -- 29/05/2024 16:34:19 BIB:M5B SESSION:9497  USER:USER         M5QDM5QJ
       >>if AA-E-MESSAGES not defined                                   M5QDM5QJ
         >>define AA-E-MESSAGES as ' '                                  M5QDM5QJ
       >>end-if                                                         M5QDM5QJ
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5QJ
      *>****************************************************************M5QDM5QJ
      *> Questions Q/R M175QJ00                                         M5QDM5QJ
      *>****************************************************************M5QDM5QJ
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QJ
       01               QUESTION.                                       M5QDM5QJ
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QJ
      *> QR Partie commune niveau Application                           M5QDM5QJ
            03          QU00.                                           M5QDM5QJ
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
               10       FILLER         PIC X(00040).                    *00013
      *> Longueur de la structure : 00052 octets                        *00052
         >>end-if                                                       M5QDM5QJ
      *>--- ID='M5S179' ------------------------------------------------M5QDM5QJ
      *> Q Consultation viabilite Forbearance                           M5QDM5QJ
            03          QU79           REDEFINES QU00.                  M5QDM5QJ
               10       FILLER         PIC X(00012).                    *00001
      *> Code action                                                    *00013
               10       QU79-CASETR    PIC X.                           *00013
      *> Code Etab Banque Entité Juridique                              *00014
               10       QU79-COCXBQ    PIC X(5).                        *00014
      *> Identifiant Contrat                                            *00019
               10       QU79-IDDIEP    PIC X(27).                       *00019
      *> Num cycle Forbearance                                          *00046
               10       QU79-NSM5CY    PIC 9(7).                        *00046
               10       QU79-NSM5CYX   REDEFINES QU79-NSM5CY            *00046
                                       PIC X(007).                      *00046
      *> Longueur de la structure : 00052 octets                        *00052
       >>end-if                                                         M5QDM5QJ
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5QJ
      *>****************************************************************M5QDM5QJ
      *> Réponses Q/R M175QJ00                                          M5QDM5QJ
      *>****************************************************************M5QDM5QJ
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QJ
       01               REPONSE.                                        M5QDM5QJ
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QJ
      *> QR Partie commune niveau Application                           M5QDM5QJ
            03          RE00.                                           M5QDM5QJ
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
               10       FILLER         PIC X(00333).                    *00013
      *> Longueur de la structure : 00345 octets                        *00345
         >>end-if                                                       M5QDM5QJ
      *>--- ID='AISA06' ------------------------------------------------M5QDM5QJ
      *> R Réponse Standard Libellé sur 80                              M5QDM5QJ
            03          RE06           REDEFINES RE00.                  M5QDM5QJ
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
      *>--- ID='M5S180' ------------------------------------------------M5QDM5QJ
      *> R Consultation Viabilité Forbearance                           M5QDM5QJ
            03          RE80           REDEFINES RE00.                  M5QDM5QJ
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       RE80-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       RE80-IDDIEP    PIC X(27).                       *00018
      *> Num cycle Forbearance                                          *00045
               10       RE80-NSM5CY    PIC 9(7).                        *00045
      *> Indicateur statut viabilité                                    *00052
               10       RE80-CIM5VI    PIC X(1).                        *00052
      *> Date début statut viabilité (SSAAMMJJ)                         *00053
               10       RE80-DDM5VI    PIC X(8).                        *00053
      *> Date de fin statut viabilité (SSAAMMJJ)                        *00061
               10       RE80-DFM5VI    PIC X(8).                        *00061
      *> Date dernière mise à jour viabilité (SSAAMMJJ)                 *00069
               10       RE80-DLM5VI    PIC X(8).                        *00069
      *> Commentaire viabilité IHM                                      *00077
               10       RE80-LRM5VI    PIC X(254).                      *00077
      *> Référence externe agent                                        *00331
               10       RE80-NOCEAG    PIC 9(7).                        *00331
      *> Code programme origine                                         *00338
               10       RE80-IDMRPO    PIC X(8).                        *00338
      *> Longueur de la structure : 00345 octets                        *00345
       >>end-if                                                         M5QDM5QJ
       >>define AA-E-MESSAGES off                                       M5QDM5QJ
