      *>****************************************************************BRQDBR05
      *> MESSAGES Q/R B17R0500 : Gestion nouv réf SUPRA                 BRQDBR05
      *>----------------------------------------------------------------BRQDBR05
      *CONTROL NOSOURCE                                                 BRQDBR05
      *> -- principes --                                                BRQDBR05
      *> Gestion de la référence SUPRA (IDDIEP) depuis une              BRQDBR05
      *> référence contrat SIRIS (RICE)                                 BRQDBR05
      *> -                                                              BRQDBR05
      *> Création, modification, supression enregistrement              BRQDBR05
      *> -                                                              BRQDBR05
      *> -- Retour --                                                   BRQDBR05
      *> SA06              si non trouvé ou erreur                      BRQDBR05
      *> COCXBq + IDDIEP   si OK                                        BRQDBR05
      *> le code banque COCXBq est nul pour la nouvelle codification    BRQDBR05
      *>----------------------------------------------------------------BRQDBR05
      *> Niveau d'exposition : Q/R Inter Domaine (Privée GCE)           BRQDBR05
      *>----------------------------------------------------------------BRQDBR05
      *> Mots clés :                                                    BRQDBR05
      *>                                                                BRQDBR05
      *>----------------------------------------------------------------BRQDBR05
      *CONTROL SOURCE                                                   BRQDBR05
      *> Utilisation :                                                  BRQDBR05
      *> copy BRQDBR05 replacing QUESTION  by QUESTION-xxx              BRQDBR05
      *>                         REPONSE   by REPONSE-xxx               BRQDBR05
      *>                         REDEFINES by REDEFINES                 BRQDBR05
      *>                         leading ==QU== by ==Qx==               BRQDBR05
      *>                         leading ==RE== by ==Rx==.              BRQDBR05
      *>****************************************************************BRQDBR05
      *> -- 31/05/2024 15:57:58 BIB:BRC SESSION:9501  USER:USER         BRQDBR05
       >>if AA-E-MESSAGES not defined                                   BRQDBR05
         >>define AA-E-MESSAGES as ' '                                  BRQDBR05
       >>end-if                                                         BRQDBR05
       >>if AA-E-MESSAGES not = 'R'                                     BRQDBR05
      *>****************************************************************BRQDBR05
      *> Questions Q/R B17R0500                                         BRQDBR05
      *>****************************************************************BRQDBR05
         >>if AA-E-MESSAGES = ' '                                       BRQDBR05
       01               QUESTION.                                       BRQDBR05
      *>--- CODE=WLNQR6 ------------------------------------------------BRQDBR05
      *> QR Partie commune CONTRAT                                      BRQDBR05
            03          QU00.                                           BRQDBR05
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
               10       FILLER         PIC X(00036).                    *00013
      *> Longueur de la structure : 00048 octets                        *00048
         >>end-if                                                       BRQDBR05
      *>--- ID='BRSB4A' ------------------------------------------------BRQDBR05
      *> Q Recherche réf SUPRA depuis SIRIS                             BRQDBR05
            03          QU4A           REDEFINES QU00.                  BRQDBR05
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       QU4A-COCXBQ    PIC X(5).                        *00013
      *> Code type produit service                                      *00018
               10       QU4A-CODIPR    PIC X(4).                        *00018
      *> Référence Produit MYSYS                                        *00022
               10       QU4A-IDMZCS    PIC X(27).                       *00022
      *> Longueur de la structure : 00048 octets                        *00048
      *>--- ID='BRSB4C' ------------------------------------------------BRQDBR05
      *> Q Recherche réf SIRIS depuis SUPRA                             BRQDBR05
            03          QU4C           REDEFINES QU00.                  BRQDBR05
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       QU4C-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       QU4C-IDDIEP    PIC X(27).                       *00018
      *> Longueur de la structure : 00044 octets                        *00044
       >>end-if                                                         BRQDBR05
       >>if AA-E-MESSAGES not = 'Q'                                     BRQDBR05
      *>****************************************************************BRQDBR05
      *> Réponses Q/R B17R0500                                          BRQDBR05
      *>****************************************************************BRQDBR05
         >>if AA-E-MESSAGES = ' '                                       BRQDBR05
       01               REPONSE.                                        BRQDBR05
      *>--- CODE=WLNQR6 ------------------------------------------------BRQDBR05
      *> QR Partie commune CONTRAT                                      BRQDBR05
            03          RE00.                                           BRQDBR05
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
         >>end-if                                                       BRQDBR05
      *>--- ID='AISA06' ------------------------------------------------BRQDBR05
      *> R Réponse Standard Libellé sur 80                              BRQDBR05
            03          RE06           REDEFINES RE00.                  BRQDBR05
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
      *>--- ID='BRSB4B' ------------------------------------------------BRQDBR05
      *> R Recherche réf SUPRA depuis SIRIS                             BRQDBR05
            03          RE4B           REDEFINES RE00.                  BRQDBR05
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE4B-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE4B-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE4B-WCORE3    PIC 9(3).                        *00013
      *> Code Etab Banque Entité Juridique                              *00016
               10       RE4B-COCXBQ    PIC X(5).                        *00016
      *> Identifiant Contrat                                            *00021
               10       RE4B-IDDIEP    PIC X(27).                       *00021
      *> Longueur de la structure : 00047 octets                        *00047
      *>--- ID='BRSB4D' ------------------------------------------------BRQDBR05
      *> R Recherche réf SIRIS depuis SUPRA                             BRQDBR05
            03          RE4D           REDEFINES RE00.                  BRQDBR05
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE4D-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE4D-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE4D-WCORE3    PIC 9(3).                        *00013
      *> Code Etab Banque Entité Juridique                              *00016
               10       RE4D-COCXBQ    PIC X(5).                        *00016
      *> Code type produit service                                      *00021
               10       RE4D-CODIPR    PIC X(4).                        *00021
      *> Référence Produit MYSYS                                        *00025
               10       RE4D-IDMZCS    PIC X(27).                       *00025
      *> Code format référence contrat MYSYS                            *00052
               10       RE4D-COBRFT    PIC X(2).                        *00052
      *> Longueur de la structure : 00053 octets                        *00053
       >>end-if                                                         BRQDBR05
       >>define AA-E-MESSAGES off                                       BRQDBR05
