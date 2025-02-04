      *>****************************************************************M5QDM5QR
      *> MESSAGES Q/R M175QR00 : Q/R Liste étapes historisées           M5QDM5QR
      *>----------------------------------------------------------------M5QDM5QR
      *CONTROL NOSOURCE                                                 M5QDM5QR
      *> Cette QR permet de restituer                                   M5QDM5QR
      *> la liste des étapes historisées d'une forbearance              M5QDM5QR
      *>                                                                M5QDM5QR
      *>                                                                M5QDM5QR
      *>                                                                M5QDM5QR
      *>----------------------------------------------------------------M5QDM5QR
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5QR
      *>----------------------------------------------------------------M5QDM5QR
      *> Mots clés :                                                    M5QDM5QR
      *> FORBEARANCE M-5 M175QR00                                       M5QDM5QR
      *>----------------------------------------------------------------M5QDM5QR
      *CONTROL SOURCE                                                   M5QDM5QR
      *> Utilisation :                                                  M5QDM5QR
      *> copy M5QDM5QR replacing QUESTION  by QUESTION-xxx              M5QDM5QR
      *>                         REPONSE   by REPONSE-xxx               M5QDM5QR
      *>                         REDEFINES by REDEFINES                 M5QDM5QR
      *>                         leading ==QU== by ==Qx==               M5QDM5QR
      *>                         leading ==RE== by ==Rx==.              M5QDM5QR
      *>****************************************************************M5QDM5QR
      *>#GN 10/07/2024 13:51:29 BIB:CTRS.M5B SESSION:9572  USER:USER    M5QDM5QR
       >>if AA-E-MESSAGES not defined                                   M5QDM5QR
         >>define AA-E-MESSAGES as ' '                                  M5QDM5QR
       >>end-if                                                         M5QDM5QR
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5QR
      *>****************************************************************M5QDM5QR
      *> Questions Q/R M175QR00                                         M5QDM5QR
      *>****************************************************************M5QDM5QR
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QR
       01               QUESTION.                                       M5QDM5QR
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:S100 ---M5QDM5QR
      *> QR Partie commune niveau Application                           M5QDM5QR
            03          QU00.                                           M5QDM5QR
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
               10       FILLER         PIC X(00032).                    *00013
      *> Longueur de la structure : 00044 octets                        *00044
         >>end-if                                                       M5QDM5QR
      *>--- ID='M5S188' ---------------------------------- #SEG:S188 ---M5QDM5QR
      *> Q Liste historique étapes FORB                                 M5QDM5QR
            03          QU88           REDEFINES QU00.                  M5QDM5QR
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       QU88-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       QU88-IDDIEP    PIC X(27).                       *00018
      *> Longueur de la structure : 00044 octets                        *00044
       >>end-if                                                         M5QDM5QR
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5QR
      *>****************************************************************M5QDM5QR
      *> Réponses Q/R M175QR00                                          M5QDM5QR
      *>****************************************************************M5QDM5QR
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QR
       01               REPONSE.                                        M5QDM5QR
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:S100 ---M5QDM5QR
      *> QR Partie commune niveau Application                           M5QDM5QR
            03          RE00.                                           M5QDM5QR
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
               10       FILLER         PIC X(00615).                    *00013
      *> Longueur de la structure : 00627 octets                        *00627
         >>end-if                                                       M5QDM5QR
      *>--- ID='AISA06' ---------------------------------- #SEG:SA06 ---M5QDM5QR
      *> R Réponse Standard Libellé sur 80                              M5QDM5QR
            03          RE06           REDEFINES RE00.                  M5QDM5QR
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
      *>--- ID='M5S185' ---------------------------------- #SEG:S185 ---M5QDM5QR
      *> R GET Etape Viabilite Forbearance                              M5QDM5QR
            03          RE85           REDEFINES RE00.                  M5QDM5QR
               10       FILLER         PIC X(00012).                    *00001
      *> Indicateur statut viabilité                                    *00013
               10       RE85-CIM5VI    PIC X(1).                        *00013
      *> Date début statut viabilité (SSAAMMJJ)                         *00014
               10       RE85-DDM5VI    PIC X(8).                        *00014
      *> Date dernière mise à jour viabilité (SSAAMMJJ)                 *00022
               10       RE85-DLM5VI    PIC X(8).                        *00022
      *> Commentaire viabilité IHM                                      *00030
               10       RE85-LRM5VI    PIC X(254).                      *00030
      *> Type opérateur                                                 *00284
               10       RE85-CTM5OP    PIC X(2).                        *00284
      *> Référence externe agent                                        *00286
               10       RE85-NOCEAG    PIC 9(7).                        *00286
      *> Longueur de la structure : 00292 octets                        *00292
      *>--- ID='M5S189' ---------------------------------- #SEG:S189 ---M5QDM5QR
      *> R Liste historique étapes FORB                                 M5QDM5QR
            03          RE89           REDEFINES RE00.                  M5QDM5QR
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       RE89-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       RE89-IDDIEP    PIC X(27).                       *00018
      *> Num cycle Forbearance                                          *00045
               10       RE89-NSM5CY    PIC 9(7).                        *00045
      *> Num étape dans cycle Forb                                      *00052
               10       RE89-NSM5ET    PIC 9(7).                        *00052
      *> Date trait entrée étape Forb (SSAAMMJJ)                        *00059
               10       RE89-DTM5EE    PIC X(8).                        *00059
      *> Date déb période probatoire (SSAAMMJJ)                         *00067
               10       RE89-DDM5PB    PIC X(8).                        *00067
      *> Date décision etape Forb (SSAAMMJJ)                            *00075
               10       RE89-DAM5DE    PIC X(8).                        *00075
      *> Référence externe agent                                        *00083
               10       RE89-NOCEAG    PIC 9(7).                        *00083
      *> libellé motif intervention                                     *00090
               10       RE89-LDM5MI    PIC X(64).                       *00090
      *> Code surv étape Forbearance                                    *00154
               10       RE89-CEM5ET    PIC X(4).                        *00154
      *> Code segment risque Bâle 2 ET                                  *00158
               10       RE89-CDDIBA    PIC X(8).                        *00158
      *> Commentaire IHM                                                *00166
               10       RE89-LRM5CO    PIC X(254).                      *00166
      *> Commentaire refus                                              *00420
               10       RE89-LRM5RF    PIC X(200).                      *00420
      *> Date première échéance (SSAAMMJJ)                              *00620
               10       RE89-DHM5PE    PIC X(8).                        *00620
      *> Longueur de la structure : 00627 octets                        *00627
      *>--- ID='M5S19E' ---------------------------------- #SEG:S19E ---M5QDM5QR
      *> R Détail mesures historique étape                              M5QDM5QR
            03          RE9E           REDEFINES RE00.                  M5QDM5QR
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       RE9E-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       RE9E-IDDIEP    PIC X(27).                       *00018
      *> Num cycle Forbearance                                          *00045
               10       RE9E-NSM5CY    PIC 9(7).                        *00045
      *> Num étape dans cycle Forb                                      *00052
               10       RE9E-NSM5ET    PIC 9(7).                        *00052
      *> Code mesure Forbearance                                        *00059
               10       RE9E-CDM5ME    PIC XX.                          *00059
      *> Libellé mesure Forbearance                                     *00061
               10       RE9E-LBM5ME    PIC X(80).                       *00061
      *> Longueur de la structure : 00140 octets                        *00140
      *>--- ID='M5S19F' ---------------------------------- #SEG:S19F ---M5QDM5QR
      *> R Détail Motifs historique étapes                              M5QDM5QR
            03          RE9F           REDEFINES RE00.                  M5QDM5QR
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       RE9F-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       RE9F-IDDIEP    PIC X(27).                       *00018
      *> Num cycle Forbearance                                          *00045
               10       RE9F-NSM5CY    PIC 9(7).                        *00045
      *> Num étape dans cycle Forb                                      *00052
               10       RE9F-NSM5ET    PIC 9(7).                        *00052
      *> Date effet interv Forb (SSAAMMJJ)                              *00059
               10       RE9F-DDM5FO    PIC X(8).                        *00059
      *> libellé motif intervention Forb                                *00067
               10       RE9F-LDM5FO    PIC X(64).                       *00067
      *> Lib origine motif intervention                                 *00131
               10       RE9F-LDM5OM    PIC X(30).                       *00131
      *> Lib référence piste audit                                      *00161
               10       RE9F-LIM5PA    PIC X(30).                       *00161
      *> Longueur de la structure : 00190 octets                        *00190
       >>end-if                                                         M5QDM5QR
       >>define AA-E-MESSAGES off                                       M5QDM5QR
