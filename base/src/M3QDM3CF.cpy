      ******************************************************************M3QDM3CF
      * MESSAGES Q/R M173CF00 : Q/R Rech.categ. segment risque          M3QDM3CF
      *-----------------------------------------------------------------M3QDM3CF
      *CONTROL NOSOURCE                                                 M3QDM3CF
      * Cette requete permet de rechercher la catégorie segment         M3QDM3CF
      * risque pour un code segment risque donné (Table MX7H).          M3QDM3CF
      * Donnée de la question :                                         M3QDM3CF
      *    - CDMBSR : Le code segment risque                            M3QDM3CF
      * Données de la réponse :                                         M3QDM3CF
      *    - WCORE3 : Code retour (0 si OK, 1 si KO)                    M3QDM3CF
      *    - COMBSR : La catégorie segment risque                       M3QDM3CF
      * En réponse anomalie on recevra :                                M3QDM3CF
      *    -RAISA06/WCORE3 = 001 si problème                            M3QDM3CF
      *-----------------------------------------------------------------M3QDM3CF
      * Niveau d'exposition : Q/R Inter Domaine (Privée GCE)            M3QDM3CF
      *-----------------------------------------------------------------M3QDM3CF
      * Mots clés :                                                     M3QDM3CF
      * NII SM6K SM6J M173CF00                                          M3QDM3CF
      *-----------------------------------------------------------------M3QDM3CF
      *CONTROL SOURCE                                                   M3QDM3CF
      * Utilisation :                                                   M3QDM3CF
      * COPY M3QDM3CF REPLACING QUESTION  BY QUESTION-xxx               M3QDM3CF
      *                         REPONSE   BY REPONSE-xxx                M3QDM3CF
      *                         REDEFINES BY REDEFINES                  M3QDM3CF
      *                         LEADING ==QU== BY ==Qx==                M3QDM3CF
      *                         LEADING ==RE== BY ==Rx==.               M3QDM3CF
      ******************************************************************M3QDM3CF
      *-- 23/06/2023 12:05:11 BIB: M3C SESSION: 8895  USER: J070188     M3QDM3CF
       >>if AA-E-MESSAGES not defined                                   M3QDM3CF
         >>define AA-E-MESSAGES as ' '                                  M3QDM3CF
       >>end-if                                                         M3QDM3CF
       >>if AA-E-MESSAGES not = 'R'                                     M3QDM3CF
      ******************************************************************M3QDM3CF
      * Questions Q/R M173CF00                                          M3QDM3CF
      ******************************************************************M3QDM3CF
         >>if AA-E-MESSAGES = ' '                                       M3QDM3CF
       01               QUESTION.                                       M3QDM3CF
      *-----------------------------------------------------------------M3QDM3CF
      * QR Partie commune MAD-CONTENT-RISQUE                            M3QDM3CF
            03          QU00.                                           M3QDM3CF
              05        QU00-00.                                        *00001
      * QR ADT Standard Inter-Domaine                                   *00001
               10       QU00-SA00.                                      *00001
      * QR Longueur Segment Question/Réponse                            *00001
                11      QU00-WLGQR     PIC 9(4).                        *00001
                11      QU00-WLGQRXX   REDEFINES QU00-WLGQR             *00001
                                       PIC X(004).                      *00001
      * LONGUEUR FLUX                                                   *00001
                11      QU00-XZ3LNG    REDEFINES QU00-WLGQR             *00001
                                       PIC 9(4).                        *00001
      * QR Code Segment Question/Réponse                                *00005
                11      QU00-WLNQR.                                     *00005
      * QR Type de Segment ECHANGES                                     *00005
                 12     QU00-CTSEQR    PIC X.                           *00005
      * QR Code Structure Question/Réponse                              *00006
                 12     QU00-WLNQR6    PIC X(6).                        *00006
      * QR Nature d'un Segment ECHANGES                                 *00012
                 12     QU00-CNSEQR    PIC X.                           *00012
      * CODE STRUCTURE DONNEES                                          *00005
                11      QU00-XZ3SGE    REDEFINES QU00-WLNQR             *00005
                                       PIC X(8).                        *00005
              05        QU00-SUITE.                                     *00013
               10       FILLER         PIC X(00012).                    *00013
         >>end-if                                                       M3QDM3CF
      *--- M3SM6K ------------------------------------------------------M3QDM3CF
      * Q Acces catégorie segment risque                                M3QDM3CF
            03          QU6K           REDEFINES QU00.                  M3QDM3CF
               10       FILLER         PIC X(00012).                    *00001
      * Code segment risques / categ client                             *00013
               10       QU6K-CDMBSR    PIC X(8).                        *00013
       >>end-if                                                         M3QDM3CF
       >>if AA-E-MESSAGES not = 'Q'                                     M3QDM3CF
      ******************************************************************M3QDM3CF
      * Réponses Q/R M173CF00                                           M3QDM3CF
      ******************************************************************M3QDM3CF
         >>if AA-E-MESSAGES = ' '                                       M3QDM3CF
       01               REPONSE.                                        M3QDM3CF
      *-----------------------------------------------------------------M3QDM3CF
      * QR Partie commune MAD-CONTENT-RISQUE                            M3QDM3CF
            03          RE00.                                           M3QDM3CF
              05        RE00-00.                                        *00001
      * QR ADT Standard Inter-Domaine                                   *00001
               10       RE00-SA00.                                      *00001
      * QR Longueur Segment Question/Réponse                            *00001
                11      RE00-WLGQR     PIC 9(4).                        *00001
      * LONGUEUR FLUX                                                   *00001
                11      RE00-XZ3LNG    REDEFINES RE00-WLGQR             *00001
                                       PIC 9(4).                        *00001
      * QR Code Segment Question/Réponse                                *00005
                11      RE00-WLNQR.                                     *00005
      * QR Type de Segment ECHANGES                                     *00005
                 12     RE00-CTSEQR    PIC X.                           *00005
      * QR Code Structure Question/Réponse                              *00006
                 12     RE00-WLNQR6    PIC X(6).                        *00006
      * QR Nature d'un Segment ECHANGES                                 *00012
                 12     RE00-CNSEQR    PIC X.                           *00012
      * CODE STRUCTURE DONNEES                                          *00005
                11      RE00-XZ3SGE    REDEFINES RE00-WLNQR             *00005
                                       PIC X(8).                        *00005
              05        RE00-SUITE.                                     *00013
               10       FILLER         PIC X(00094).                    *00013
         >>end-if                                                       M3QDM3CF
      *--- AISA06 ------------------------------------------------------M3QDM3CF
      * R Réponse Standard Libellé sur 80                               M3QDM3CF
            03          RE06           REDEFINES RE00.                  M3QDM3CF
               10       FILLER         PIC X(00012).                    *00001
      * R Partie commune Code Retour Réponse                            *00013
               10       RE06-SA05.                                      *00013
      * Code erreur                                                     *00013
                11      RE06-WCOREX.                                    *00013
      * Code retour Echanges                                            *00013
                 12     RE06-WCORE3    PIC 9(3).                        *00013
      * Clé Réduite Messages Erreur PETRA                               *00016
               10       RE06-GRXXCR.                                    *00016
      * Code Domaine de Gestion PACBASE                                 *00016
                11      RE06-WCODM     PIC X(3).                        *00016
      * Code Message erreur (008)                                       *00019
                11      RE06-WCOLE     PIC X(8).                        *00019
      * Libelle Message Erreur sur 80 car.                              *00027
               10       RE06-WLE80.                                     *00027
      * Libellé erreur                                                  *00027
                11      RE06-LISTER    PIC X(79).                       *00027
      * Indic présence info complémentaire                              *00106
                11      RE06-CISTPI    PIC X.                           *00106
      *--- M3SM6J ------------------------------------------------------M3QDM3CF
      * R Acces catégorie segment risque                                M3QDM3CF
            03          RE6J           REDEFINES RE00.                  M3QDM3CF
               10       FILLER         PIC X(00012).                    *00001
      * R Partie commune Code Retour Réponse                            *00013
               10       RE6J-SA05.                                      *00013
      * Code erreur                                                     *00013
                11      RE6J-WCOREX.                                    *00013
      * Code retour Echanges                                            *00013
                 12     RE6J-WCORE3    PIC 9(3).                        *00013
      * Code catégorie segment risque                                   *00016
               10       RE6J-COMBSR    PIC X(4).                        *00016
       >>end-if                                                         M3QDM3CF
       >>define AA-E-MESSAGES off                                       M3QDM3CF
