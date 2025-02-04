      *>****************************************************************M5QDM5QB
      *> MESSAGES Q/R M175QB00 : Q/R DELETE opération Fiche FORB        M5QDM5QB
      *>----------------------------------------------------------------M5QDM5QB
      *CONTROL NOSOURCE                                                 M5QDM5QB
      *> Cette QR supprime  l'opération et son détail sur une étape     M5QDM5QB
      *> de la fiche de qualification Forbearance                       M5QDM5QB
      *>----------------------------------------------------------------M5QDM5QB
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5QB
      *>----------------------------------------------------------------M5QDM5QB
      *> Mots clés :                                                    M5QDM5QB
      *> FORBEARANCE M-5 M175QB00                                       M5QDM5QB
      *>----------------------------------------------------------------M5QDM5QB
      *CONTROL SOURCE                                                   M5QDM5QB
      *> Utilisation :                                                  M5QDM5QB
      *> copy M5QDM5QB replacing QUESTION  by QUESTION-xxx              M5QDM5QB
      *>                         REPONSE   by REPONSE-xxx               M5QDM5QB
      *>                         REDEFINES by REDEFINES                 M5QDM5QB
      *>                         leading ==QU== by ==Qx==               M5QDM5QB
      *>                         leading ==RE== by ==Rx==.              M5QDM5QB
      *>****************************************************************M5QDM5QB
      *> -- 29/05/2024 16:33:17 BIB:M5B SESSION:9497  USER:USER         M5QDM5QB
       >>if AA-E-MESSAGES not defined                                   M5QDM5QB
         >>define AA-E-MESSAGES as ' '                                  M5QDM5QB
       >>end-if                                                         M5QDM5QB
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5QB
      *>****************************************************************M5QDM5QB
      *> Questions Q/R M175QB00                                         M5QDM5QB
      *>****************************************************************M5QDM5QB
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QB
       01               QUESTION.                                       M5QDM5QB
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QB
      *> QR Partie commune niveau Application                           M5QDM5QB
            03          QU00.                                           M5QDM5QB
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
               10       FILLER         PIC X(00046).                    *00013
      *> Longueur de la structure : 00058 octets                        *00058
         >>end-if                                                       M5QDM5QB
      *>--- ID='M5S158' ------------------------------------------------M5QDM5QB
      *> Q Qualif FORB DELETE Opération                                 M5QDM5QB
            03          QU58           REDEFINES QU00.                  M5QDM5QB
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       QU58-COCXBQ    PIC X(5).                        *00013
      *> Identifiant personne                                           *00018
               10       QU58-NODAPE    PIC 9(9).                        *00018
               10       QU58-NODAPEX   REDEFINES QU58-NODAPE            *00018
                                       PIC X(009).                      *00018
      *> TS création enregistrement (TIMESTAMP)                         *00027
               10       QU58-HDEHEG    PIC X(26).                       *00027
      *> Code statut fiche                                              *00053
               10       QU58-CEM5SF    PIC X(3).                        *00053
      *> Numéro opération statut fiche                                  *00056
               10       QU58-NSM5OP    PIC 9(3).                        *00056
               10       QU58-NSM5OPX   REDEFINES QU58-NSM5OP            *00056
                                       PIC X(003).                      *00056
      *> Longueur de la structure : 00058 octets                        *00058
       >>end-if                                                         M5QDM5QB
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5QB
      *>****************************************************************M5QDM5QB
      *> Réponses Q/R M175QB00                                          M5QDM5QB
      *>****************************************************************M5QDM5QB
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QB
       01               REPONSE.                                        M5QDM5QB
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QB
      *> QR ADT Standard Inter-Domaine                                  M5QDM5QB
            03          RE00.                                           M5QDM5QB
              05        RE00-00.                                        *00001
      *> QR Longueur Segment Question/Réponse                           *00001
               10       RE00-WLGQR     PIC 9(4).                        *00001
      *> LONGUEUR FLUX                                                  *00001
               10       RE00-XZ3LNG    REDEFINES RE00-WLGQR             *00001
                                       PIC 9(4).                        *00001
      *> QR Code Segment Question/Réponse                               *00005
               10       RE00-WLNQR.                                     *00005
      *> QR Type de Segment ECHANGES                                    *00005
                11      RE00-CTSEQR    PIC X.                           *00005
      *> QR Code Structure Question/Réponse                             *00006
                11      RE00-WLNQR6    PIC X(6).                        *00006
      *> QR Nature d'un Segment ECHANGES                                *00012
                11      RE00-CNSEQR    PIC X.                           *00012
      *> CODE STRUCTURE DONNEES                                         *00005
               10       RE00-XZ3SGE    REDEFINES RE00-WLNQR             *00005
                                       PIC X(8).                        *00005
              05        RE00-SUITE.                                     *00013
               10       FILLER         PIC X(00094).                    *00013
      *> Longueur de la structure : 00106 octets                        *00106
         >>end-if                                                       M5QDM5QB
      *>--- ID='AISA06' ------------------------------------------------M5QDM5QB
      *> R Réponse Standard Libellé sur 80                              M5QDM5QB
            03          RE06           REDEFINES RE00.                  M5QDM5QB
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
       >>end-if                                                         M5QDM5QB
       >>define AA-E-MESSAGES off                                       M5QDM5QB
