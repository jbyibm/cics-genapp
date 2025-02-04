      *>****************************************************************EGQDEG72
      *> MESSAGES Q/R E17G7200 : Restitution Domaine produit            EGQDEG72
      *>----------------------------------------------------------------EGQDEG72
      *CONTROL NOSOURCE                                                 EGQDEG72
      *> restitution des infos du catalogue                             EGQDEG72
      *> à partir du code produit national                              EGQDEG72
      *> Interrogation de la EV2X                                       EGQDEG72
      *> retour SA06 si Anomalie                                        EGQDEG72
      *> Alim Sa05 si ok                                                EGQDEG72
      *>----------------------------------------------------------------EGQDEG72
      *> Niveau d'exposition : Q/R Inter Domaine (Privée GCE)           EGQDEG72
      *>----------------------------------------------------------------EGQDEG72
      *> Mots clés :                                                    EGQDEG72
      *> BALE II                                                        EGQDEG72
      *>----------------------------------------------------------------EGQDEG72
      *CONTROL SOURCE                                                   EGQDEG72
      *> Utilisation :                                                  EGQDEG72
      *> copy EGQDEG72 replacing QUESTION  by QUESTION-xxx              EGQDEG72
      *>                         REPONSE   by REPONSE-xxx               EGQDEG72
      *>                         REDEFINES by REDEFINES                 EGQDEG72
      *>                         leading ==QU== by ==Qx==               EGQDEG72
      *>                         leading ==RE== by ==Rx==.              EGQDEG72
      *>****************************************************************EGQDEG72
      *> -- 04/06/2024 14:29:19 BIB:EGE SESSION:9508  USER:USER         EGQDEG72
       >>if AA-E-MESSAGES not defined                                   EGQDEG72
         >>define AA-E-MESSAGES as ' '                                  EGQDEG72
       >>end-if                                                         EGQDEG72
       >>if AA-E-MESSAGES not = 'R'                                     EGQDEG72
      *>****************************************************************EGQDEG72
      *> Questions Q/R E17G7200                                         EGQDEG72
      *>****************************************************************EGQDEG72
         >>if AA-E-MESSAGES = ' '                                       EGQDEG72
       01               QUESTION.                                       EGQDEG72
      *>--- CODE=WLNQR6 ------------------------------------------------EGQDEG72
      *> QR partie commune CATALOGUE                                    EGQDEG72
            03          QU00.                                           EGQDEG72
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
               10       FILLER         PIC X(00022).                    *00013
      *> Longueur de la structure : 00034 octets                        *00034
         >>end-if                                                       EGQDEG72
      *>--- ID='EGSE4I' ------------------------------------------------EGQDEG72
      *> Q restit domaine produit                                       EGQDEG72
            03          QU4I           REDEFINES QU00.                  EGQDEG72
               10       FILLER         PIC X(00012).                    *00001
      *> Code Produit National                                          *00013
               10       QU4I-COEGPX    PIC X(6).                        *00013
      *> Code PS CNCE Large                                             *00019
               10       QU4I-COEGPY    PIC X(16).                       *00019
      *> Longueur de la structure : 00034 octets                        *00034
       >>end-if                                                         EGQDEG72
       >>if AA-E-MESSAGES not = 'Q'                                     EGQDEG72
      *>****************************************************************EGQDEG72
      *> Réponses Q/R E17G7200                                          EGQDEG72
      *>****************************************************************EGQDEG72
         >>if AA-E-MESSAGES = ' '                                       EGQDEG72
       01               REPONSE.                                        EGQDEG72
      *>--- CODE=WLNQR6 ------------------------------------------------EGQDEG72
      *> QR partie commune CATALOGUE                                    EGQDEG72
            03          RE00.                                           EGQDEG72
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
               10       FILLER         PIC X(00187).                    *00013
      *> Longueur de la structure : 00199 octets                        *00199
         >>end-if                                                       EGQDEG72
      *>--- ID='AISA06' ------------------------------------------------EGQDEG72
      *> R Réponse Standard Libellé sur 80                              EGQDEG72
            03          RE06           REDEFINES RE00.                  EGQDEG72
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
      *>--- ID='EGSE4J' ------------------------------------------------EGQDEG72
      *> R restit domaine produit                                       EGQDEG72
            03          RE4J           REDEFINES RE00.                  EGQDEG72
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE4J-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE4J-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE4J-WCORE3    PIC 9(3).                        *00013
      *> Code domaine P/S CNCE                                          *00016
               10       RE4J-COEGPD    PIC X(1).                        *00016
      *> Nom Court Domaine Nomenclature CNCE                            *00017
               10       RE4J-LCEGDO    PIC X(32).                       *00017
      *> Code Macro Famille CNCE V2                                     *00049
               10       RE4J-COEGXM    PIC X(2).                        *00049
      *> Code Type Famille PS V2                                        *00051
               10       RE4J-COEGXF    PIC X(4).                        *00051
      *> Code Type 2ieme Regroupement CNCE V2                           *00055
               10       RE4J-COEGX3    PIC X(07).                       *00055
      *> Code Type 1ier Regroupement CNCE                               *00062
               10       RE4J-COEGX4    PIC X(10).                       *00062
      *> Nom Long Nomenclature CNCE                                     *00072
               10       RE4J-LLEGXE    PIC X(128).                      *00072
      *> Longueur de la structure : 00199 octets                        *00199
       >>end-if                                                         EGQDEG72
       >>define AA-E-MESSAGES off                                       EGQDEG72
