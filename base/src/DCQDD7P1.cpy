      *>****************************************************************DCQDD7P1
      *> MESSAGES Q/R D177P100 : Lecture catégorie client SADS          DCQDD7P1
      *>----------------------------------------------------------------DCQDD7P1
      *CONTROL NOSOURCE                                                 DCQDD7P1
      *> Q/R LIRE catégorie client et segment risque                    DCQDD7P1
      *>                                                                DCQDD7P1
      *> BUT : Lire la(les) catégorie client ainsi que le(les)          DCQDD7P1
      *> segments risque d'une personne ou d'une entité titulaire.      DCQDD7P1
      *> Ces données sont stockées au niveau des tables DU7G (pers)     DCQDD7P1
      *> et DU5G (ET)                                                   DCQDD7P1
      *>----------------------------------------------------------------DCQDD7P1
      *> Niveau d'exposition : Q/R Inter Domaine (Privée GCE)           DCQDD7P1
      *>----------------------------------------------------------------DCQDD7P1
      *> Mots clés :                                                    DCQDD7P1
      *> BALE2V5 SADS                                                   DCQDD7P1
      *>----------------------------------------------------------------DCQDD7P1
      *CONTROL SOURCE                                                   DCQDD7P1
      *> Utilisation :                                                  DCQDD7P1
      *> copy DCQDD7P1 replacing QUESTION  by QUESTION-xxx              DCQDD7P1
      *>                         REPONSE   by REPONSE-xxx               DCQDD7P1
      *>                         REDEFINES by REDEFINES                 DCQDD7P1
      *>                         leading ==QU== by ==Qx==               DCQDD7P1
      *>                         leading ==RE== by ==Rx==.              DCQDD7P1
      *>****************************************************************DCQDD7P1
      *>#GN 23/08/2024 16:20:30 BIB:CTRS.DCP SESSION:9652  USER:J062907 DCQDD7P1
       >>if AA-E-MESSAGES not defined                                   DCQDD7P1
         >>define AA-E-MESSAGES as ' '                                  DCQDD7P1
       >>end-if                                                         DCQDD7P1
       >>if AA-E-MESSAGES not = 'R'                                     DCQDD7P1
      *>****************************************************************DCQDD7P1
      *> Questions Q/R D177P100                                         DCQDD7P1
      *>****************************************************************DCQDD7P1
         >>if AA-E-MESSAGES = ' '                                       DCQDD7P1
       01               QUESTION.                                       DCQDD7P1
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:SD00 ---DCQDD7P1
      *> QR Partie commune CLIENT                                       DCQDD7P1
            03          QU00.                                           DCQDD7P1
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
               10       FILLER         PIC X(00024).                    *00013
      *> Longueur de la structure : 00036 octets                        *00036
         >>end-if                                                       DCQDD7P1
      *>--- ID='DCSD6R' ---------------------------------- #SEG:SD6R ---DCQDD7P1
      *> Q Demande lecture catégorie client                             DCQDD7P1
            03          QU6R           REDEFINES QU00.                  DCQDD7P1
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etablissement entité juridique                            *00013
               10       QU6R-CODXET    PIC X(5).                        *00013
      *> Identifiant personne                                           *00018
               10       QU6R-NODAPE    PIC 9(9).                        *00018
               10       QU6R-NODAPEX   REDEFINES QU6R-NODAPE            *00018
                                       PIC X(009).                      *00018
      *> Numéro entité titulaire                                        *00027
               10       QU6R-NODIET    PIC 9(10).                       *00027
               10       QU6R-NODIETX   REDEFINES QU6R-NODIET            *00027
                                       PIC X(010).                      *00027
      *> Longueur de la structure : 00036 octets                        *00036
       >>end-if                                                         DCQDD7P1
       >>if AA-E-MESSAGES not = 'Q'                                     DCQDD7P1
      *>****************************************************************DCQDD7P1
      *> Réponses Q/R D177P100                                          DCQDD7P1
      *>****************************************************************DCQDD7P1
         >>if AA-E-MESSAGES = ' '                                       DCQDD7P1
       01               REPONSE.                                        DCQDD7P1
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:SD00 ---DCQDD7P1
      *> QR Partie commune CLIENT                                       DCQDD7P1
            03          RE00.                                           DCQDD7P1
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
               10       FILLER         PIC X(00463).                    *00013
      *> Longueur de la structure : 00475 octets                        *00475
         >>end-if                                                       DCQDD7P1
      *>--- ID='AISA06' ---------------------------------- #SEG:SA06 ---DCQDD7P1
      *> R Réponse Standard Libellé sur 80                              DCQDD7P1
            03          RE06           REDEFINES RE00.                  DCQDD7P1
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
      *>--- ID='DCSD1A' ---------------------------------- #SEG:SD1A ---DCQDD7P1
      *> R Réponse lecture catég client bis                             DCQDD7P1
            03          RE1A           REDEFINES RE00.                  DCQDD7P1
               10       FILLER         PIC X(00012).                    *00001
      *> Code erreur                                                    *00013
               10       RE1A-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                11      RE1A-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
               10       RE1A-CODXET    PIC X(5).                        *00016
      *> Identifiant personne                                           *00021
               10       RE1A-NODAPE    PIC 9(9).                        *00021
      *> Numéro entité titulaire                                        *00030
               10       RE1A-NODIET    PIC 9(10).                       *00030
      *> Rubrique groupe segment risque                                 *00040
               10       RE1A-GRDLSR    OCCURS 004.                      *00040
      *> Type segment risques / categ client                            *00040
                11      RE1A-CTMBSR    PIC X(2).                        *00040
      *> Code segment risques / categ client                            *00048
                11      RE1A-CDMBSR    PIC X(8).                        *00048
      *> Code segment risques / categ client                            *00080
                11      RE1A-CDMBS6    PIC X(8).                        *00080
      *> Code utilisateur application                                   *00112
                11      RE1A-COGEUT    PIC X(8).                        *00112
      *> Lib motif forcage dossier archivage                            *00144
                11      RE1A-LBDYFO    PIC X(80).                       *00144
      *> Libellé affectation segmentation                               *00464
               10       RE1A-LIDLFO    PIC X(12).                       *00464
      *> Longueur de la structure : 00475 octets                        *00475
      *>--- ID='DCSD6S' ---------------------------------- #SEG:SD6S ---DCQDD7P1
      *> R Réponse lecture catégorie client                             DCQDD7P1
            03          RE6S           REDEFINES RE00.                  DCQDD7P1
               10       FILLER         PIC X(00012).                    *00001
      *> Code erreur                                                    *00013
               10       RE6S-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                11      RE6S-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
               10       RE6S-CODXET    PIC X(5).                        *00016
      *> Identifiant personne                                           *00021
               10       RE6S-NODAPE    PIC 9(9).                        *00021
      *> Numéro entité titulaire                                        *00030
               10       RE6S-NODIET    PIC 9(10).                       *00030
      *> Rubrique groupe segment risque                                 *00040
               10       RE6S-GRDLSR    OCCURS 004.                      *00040
      *> Type segment risques / categ client                            *00040
                11      RE6S-CTMBSR    PIC X(2).                        *00040
      *> Code segment risques / categ client                            *00048
                11      RE6S-CDMBSR    PIC X(8).                        *00048
      *> Libellé affectation segmentation                               *00080
               10       RE6S-LIDLFO    PIC X(12).                       *00080
      *> Longueur de la structure : 00091 octets                        *00091
       >>end-if                                                         DCQDD7P1
       >>define AA-E-MESSAGES off                                       DCQDD7P1
