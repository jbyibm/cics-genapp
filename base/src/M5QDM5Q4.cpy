      *>****************************************************************M5QDM5Q4
      *> MESSAGES Q/R M175Q400 : Q/R Consult Seuil Indic. Forb.         M5QDM5Q4
      *>----------------------------------------------------------------M5QDM5Q4
      *CONTROL NOSOURCE                                                 M5QDM5Q4
      *> Cette QR restitue le référentiel des seuils d'acceptabilité    M5QDM5Q4
      *> pour la fiche Forberance                                       M5QDM5Q4
      *>                                                                M5QDM5Q4
      *> Elle peut être appelée pour renvoyer unitairement un seuil     M5QDM5Q4
      *> ou la liste complète des seuils associés à la fiche            M5QDM5Q4
      *> Forbearance                                                    M5QDM5Q4
      *> _                                                              M5QDM5Q4
      *>----------------------------------------------------------------M5QDM5Q4
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5Q4
      *>----------------------------------------------------------------M5QDM5Q4
      *> Mots clés :                                                    M5QDM5Q4
      *> FORBEARANCE M-5 M175Q400                                       M5QDM5Q4
      *>----------------------------------------------------------------M5QDM5Q4
      *CONTROL SOURCE                                                   M5QDM5Q4
      *> Utilisation :                                                  M5QDM5Q4
      *> copy M5QDM5Q4 replacing QUESTION  by QUESTION-xxx              M5QDM5Q4
      *>                         REPONSE   by REPONSE-xxx               M5QDM5Q4
      *>                         REDEFINES by REDEFINES                 M5QDM5Q4
      *>                         leading ==QU== by ==Qx==               M5QDM5Q4
      *>                         leading ==RE== by ==Rx==.              M5QDM5Q4
      *>****************************************************************M5QDM5Q4
      *> -- 03/06/2024 16:55:43 BIB:M5B SESSION:9506  USER:USER         M5QDM5Q4
       >>if AA-E-MESSAGES not defined                                   M5QDM5Q4
         >>define AA-E-MESSAGES as ' '                                  M5QDM5Q4
       >>end-if                                                         M5QDM5Q4
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5Q4
      *>****************************************************************M5QDM5Q4
      *> Questions Q/R M175Q400                                         M5QDM5Q4
      *>****************************************************************M5QDM5Q4
         >>if AA-E-MESSAGES = ' '                                       M5QDM5Q4
       01               QUESTION.                                       M5QDM5Q4
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5Q4
      *> QR Partie commune niveau Application                           M5QDM5Q4
            03          QU00.                                           M5QDM5Q4
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
               10       FILLER         PIC X(00007).                    *00013
      *> Longueur de la structure : 00019 octets                        *00019
         >>end-if                                                       M5QDM5Q4
      *>--- ID='M5S144' ------------------------------------------------M5QDM5Q4
      *> Q Qualif FORB param seuils ratios                              M5QDM5Q4
            03          QU44           REDEFINES QU00.                  M5QDM5Q4
               10       FILLER         PIC X(00012).                    *00001
      *> Code action                                                    *00013
               10       QU44-CASETR    PIC X.                           *00013
      *> Type données Bilan                                             *00014
               10       QU44-CTM5BI    PIC X(6).                        *00014
      *> Longueur de la structure : 00019 octets                        *00019
       >>end-if                                                         M5QDM5Q4
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5Q4
      *>****************************************************************M5QDM5Q4
      *> Réponses Q/R M175Q400                                          M5QDM5Q4
      *>****************************************************************M5QDM5Q4
         >>if AA-E-MESSAGES = ' '                                       M5QDM5Q4
       01               REPONSE.                                        M5QDM5Q4
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5Q4
      *> QR Partie commune niveau Application                           M5QDM5Q4
            03          RE00.                                           M5QDM5Q4
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
         >>end-if                                                       M5QDM5Q4
      *>--- ID='AISA06' ------------------------------------------------M5QDM5Q4
      *> R Réponse Standard Libellé sur 80                              M5QDM5Q4
            03          RE06           REDEFINES RE00.                  M5QDM5Q4
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
      *>--- ID='M5S145' ------------------------------------------------M5QDM5Q4
      *> R Qualif FORB param seuils ratios                              M5QDM5Q4
            03          RE45           REDEFINES RE00.                  M5QDM5Q4
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE45-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE45-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE45-WCORE3    PIC 9(3).                        *00013
      *> Type données Bilan                                             *00016
               10       RE45-CTM5BI    PIC X(6).                        *00016
      *> Taux seuil acceptabilité                                       *00022
               10       RE45-TXM5SE    PIC 9(3)V99.                     *00022
      *> Longueur de la structure : 00026 octets                        *00026
       >>end-if                                                         M5QDM5Q4
       >>define AA-E-MESSAGES off                                       M5QDM5Q4
