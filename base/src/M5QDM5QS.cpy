      *>****************************************************************M5QDM5QS
      *> MESSAGES Q/R M175QS00 : Q/R chapeau Création Forbearance       M5QDM5QS
      *>----------------------------------------------------------------M5QDM5QS
      *CONTROL NOSOURCE                                                 M5QDM5QS
      *> Cette QR permet de créer une Forbearance                       M5QDM5QS
      *> - sa première étape du cycle                                   M5QDM5QS
      *> - sa concession et ses motifs                                  M5QDM5QS
      *> - ses Difficultés associées                                    M5QDM5QS
      *> - ses mesures                                                  M5QDM5QS
      *> - sa viabilité                                                 M5QDM5QS
      *>----------------------------------------------------------------M5QDM5QS
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5QS
      *>----------------------------------------------------------------M5QDM5QS
      *> Mots clés :                                                    M5QDM5QS
      *> FORBEARANCE M-5 M175QS00                                       M5QDM5QS
      *>----------------------------------------------------------------M5QDM5QS
      *CONTROL SOURCE                                                   M5QDM5QS
      *> Utilisation :                                                  M5QDM5QS
      *> copy M5QDM5QS replacing QUESTION  by QUESTION-xxx              M5QDM5QS
      *>                         REPONSE   by REPONSE-xxx               M5QDM5QS
      *>                         REDEFINES by REDEFINES                 M5QDM5QS
      *>                         leading ==QU== by ==Qx==               M5QDM5QS
      *>                         leading ==RE== by ==Rx==.              M5QDM5QS
      *>****************************************************************M5QDM5QS
      *>#GN 17/07/2024 08:37:06 BIB:CTRS.M5B SESSION:9584  USER:USER    M5QDM5QS
       >>if AA-E-MESSAGES not defined                                   M5QDM5QS
         >>define AA-E-MESSAGES as ' '                                  M5QDM5QS
       >>end-if                                                         M5QDM5QS
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5QS
      *>****************************************************************M5QDM5QS
      *> Questions Q/R M175QS00                                         M5QDM5QS
      *>****************************************************************M5QDM5QS
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QS
       01               QUESTION.                                       M5QDM5QS
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:S100 ---M5QDM5QS
      *> QR Partie commune niveau Application                           M5QDM5QS
            03          QU00.                                           M5QDM5QS
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
               10       FILLER         PIC X(00658).                    *00013
      *> Longueur de la structure : 00670 octets                        *00670
         >>end-if                                                       M5QDM5QS
      *>--- ID='M5S194' ---------------------------------- #SEG:S194 ---M5QDM5QS
      *> Q POST Etape Concession Forbearance                            M5QDM5QS
            03          QU94           REDEFINES QU00.                  M5QDM5QS
               10       FILLER         PIC X(00012).                    *00001
      *> Code action                                                    *00013
               10       QU94-CASETR    PIC X.                           *00013
      *> Code Etab Banque Entité Juridique                              *00014
               10       QU94-COCXBQ    PIC X(5).                        *00014
      *> Identifiant Contrat                                            *00019
               10       QU94-IDDIEP    PIC X(27).                       *00019
      *> Code statut PE/NPE contrat                                     *00046
               10       QU94-CEM5CT    PIC X(3).                        *00046
      *> Type concession                                                *00049
               10       QU94-CTM5CS    PIC X(1).                        *00049
      *> libellé motif intervention Forb                                *00050
               10       QU94-LDM5FO    PIC X(64).                       *00050
      *> Lib origine motif intervention                                 *00114
               10       QU94-LDM5OM    PIC X(30).                       *00114
      *> Lib référence piste audit                                      *00144
               10       QU94-LIM5PA    PIC X(30).                       *00144
      *> Date effet interv Forb (SSAAMMJJ)                              *00174
               10       QU94-DDM5FO    PIC X(8).                        *00174
      *> Décision Forbearance opération                                 *00182
               10       QU94-CRM5FB    PIC X(1).                        *00182
      *> Indic evt défaut RAD forbearance                               *00183
               10       QU94-CIM5DF    PIC X(1).                        *00183
      *> Commentaire IHM                                                *00184
               10       QU94-LRM5CO    PIC X(254).                      *00184
      *> Date décision refus (SSAAMMJJ)                                 *00438
               10       QU94-DGM5RF    PIC X(8).                        *00438
      *> Commentaire refus                                              *00446
               10       QU94-LRM5RF    PIC X(200).                      *00446
      *> Date première échéance (SSAAMMJJ)                              *00646
               10       QU94-DHM5PE    PIC X(8).                        *00646
      *> Indic note défaut fin de mois                                  *00654
               10       QU94-CIM5W5    PIC X(1).                        *00654
      *> Type opérateur                                                 *00655
               10       QU94-CTM5OP    PIC X(2).                        *00655
      *> Référence externe agent                                        *00657
               10       QU94-NOCEAG    PIC 9(7).                        *00657
               10       QU94-NOCEAGX   REDEFINES QU94-NOCEAG            *00657
                                       PIC X(007).                      *00657
      *> Code Produit National                                          *00664
               10       QU94-COEGPX    PIC X(6).                        *00664
      *> Code origine concession                                        *00670
               10       QU94-CMM5CS    PIC X(1).                        *00670
      *> Longueur de la structure : 00670 octets                        *00670
      *>--- ID='M5S195' ---------------------------------- #SEG:S195 ---M5QDM5QS
      *> Q Création/MAJ Forbearance Motifs                              M5QDM5QS
            03          QU95           REDEFINES QU00.                  M5QDM5QS
               10       FILLER         PIC X(00012).                    *00001
      *> Code evt déclencheur motif                                     *00013
               10       QU95-COM5DM    PIC X(8).                        *00013
      *> Code traitement evt déclencheur                                *00021
               10       QU95-COM5TT    PIC X(1).                        *00021
      *> Type opérateur                                                 *00022
               10       QU95-CTM5OP    PIC X(2).                        *00022
      *> Date effet interv Forb (SSAAMMJJ)                              *00024
               10       QU95-DDM5FO    PIC X(8).                        *00024
      *> Lib origine motif intervention                                 *00032
               10       QU95-LDM5OM    PIC X(30).                       *00032
      *> Lib référence piste audit                                      *00062
               10       QU95-LIM5PA    PIC X(30).                       *00062
      *> Référence externe agent                                        *00092
               10       QU95-NOCEAG    PIC 9(7).                        *00092
               10       QU95-NOCEAGX   REDEFINES QU95-NOCEAG            *00092
                                       PIC X(007).                      *00092
      *> Longueur de la structure : 00098 octets                        *00098
      *>--- ID='M5S196' ---------------------------------- #SEG:S196 ---M5QDM5QS
      *> Q Création/MAJ Forbearance Mesures                             M5QDM5QS
            03          QU96           REDEFINES QU00.                  M5QDM5QS
               10       FILLER         PIC X(00012).                    *00001
      *> Code mesure Forbearance                                        *00013
               10       QU96-CDM5ME    PIC XX.                          *00013
      *> Type opérateur                                                 *00015
               10       QU96-CTM5OP    PIC X(2).                        *00015
      *> Référence externe agent                                        *00017
               10       QU96-NOCEAG    PIC 9(7).                        *00017
               10       QU96-NOCEAGX   REDEFINES QU96-NOCEAG            *00017
                                       PIC X(007).                      *00017
      *> Longueur de la structure : 00023 octets                        *00023
      *>--- ID='M5S197' ---------------------------------- #SEG:S197 ---M5QDM5QS
      *> Q Création/MAJ Forbearance Viabilité                           M5QDM5QS
            03          QU97           REDEFINES QU00.                  M5QDM5QS
               10       FILLER         PIC X(00012).                    *00001
      *> Indicateur statut viabilité                                    *00013
               10       QU97-CIM5VI    PIC X(1).                        *00013
      *> Date début statut viabilité (SSAAMMJJ)                         *00014
               10       QU97-DDM5VI    PIC X(8).                        *00014
      *> Commentaire viabilité IHM                                      *00022
               10       QU97-LRM5VI    PIC X(254).                      *00022
      *> Type opérateur                                                 *00276
               10       QU97-CTM5OP    PIC X(2).                        *00276
      *> Référence externe agent                                        *00278
               10       QU97-NOCEAG    PIC 9(7).                        *00278
               10       QU97-NOCEAGX   REDEFINES QU97-NOCEAG            *00278
                                       PIC X(007).                      *00278
      *> Longueur de la structure : 00284 octets                        *00284
       >>end-if                                                         M5QDM5QS
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5QS
      *>****************************************************************M5QDM5QS
      *> Réponses Q/R M175QS00                                          M5QDM5QS
      *>****************************************************************M5QDM5QS
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QS
       01               REPONSE.                                        M5QDM5QS
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:S100 ---M5QDM5QS
      *> QR Partie commune niveau Application                           M5QDM5QS
            03          RE00.                                           M5QDM5QS
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
               10       FILLER         PIC X(00963).                    *00013
      *> Longueur de la structure : 00975 octets                        *00975
         >>end-if                                                       M5QDM5QS
      *>--- ID='AISA06' ---------------------------------- #SEG:SA06 ---M5QDM5QS
      *> R Réponse Standard Libellé sur 80                              M5QDM5QS
            03          RE06           REDEFINES RE00.                  M5QDM5QS
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
      *>--- ID='M5S182' ---------------------------------- #SEG:S182 ---M5QDM5QS
      *> R GET Etape Concession Forbearance                             M5QDM5QS
            03          RE82           REDEFINES RE00.                  M5QDM5QS
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       RE82-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       RE82-IDDIEP    PIC X(27).                       *00018
      *> Num cycle Forbearance                                          *00045
               10       RE82-NSM5CY    PIC 9(7).                        *00045
      *> Num étape dans cycle Forb                                      *00052
               10       RE82-NSM5ET    PIC 9(7).                        *00052
      *> Référence produit / service                                    *00059
               10       RE82-CODIRF    PIC X(11).                       *00059
      *> Code Guichet Interbancaire                                     *00070
               10       RE82-COCXGU    PIC X(5).                        *00070
      *> Code type produit service                                      *00075
               10       RE82-CODIPR    PIC X(4).                        *00075
      *> Code Produit National                                          *00079
               10       RE82-COEGPX    PIC X(6).                        *00079
      *> Libellé type produit / service                                 *00085
               10       RE82-LIGXPR    PIC X(32).                       *00085
      *> Code segment risque Bâle 2 ET                                  *00117
               10       RE82-CDDIBA    PIC X(8).                        *00117
      *> Code catégorie segment risque                                  *00125
               10       RE82-COMBSR    PIC X(4).                        *00125
      *> Code statut PE/NPE contrat                                     *00129
               10       RE82-CEM5CT    PIC X(3).                        *00129
      *> Code surv étape Forbearance                                    *00132
               10       RE82-CEM5ET    PIC X(4).                        *00132
      *> Valeur état Forbearance                                        *00136
               10       RE82-LVM5ET    PIC X(20).                       *00136
      *> Type concession                                                *00156
               10       RE82-CTM5CS    PIC X(1).                        *00156
      *> libellé motif intervention Forb                                *00157
               10       RE82-LDM5FO    PIC X(64).                       *00157
      *> Lib origine motif intervention                                 *00221
               10       RE82-LDM5OM    PIC X(30).                       *00221
      *> Lib référence piste audit                                      *00251
               10       RE82-LIM5PA    PIC X(30).                       *00251
      *> Date effet interv Forb (SSAAMMJJ)                              *00281
               10       RE82-DDM5FO    PIC X(8).                        *00281
      *> Décision Forbearance opération                                 *00289
               10       RE82-CRM5FB    PIC X(1).                        *00289
      *> Indic evt défaut RAD forbearance                               *00290
               10       RE82-CIM5DF    PIC X(1).                        *00290
      *> Commentaire IHM                                                *00291
               10       RE82-LRM5CO    PIC X(254).                      *00291
      *> Date décision refus (SSAAMMJJ)                                 *00545
               10       RE82-DGM5RF    PIC X(8).                        *00545
      *> Commentaire refus                                              *00553
               10       RE82-LRM5RF    PIC X(200).                      *00553
      *> Date première échéance (SSAAMMJJ)                              *00753
               10       RE82-DHM5PE    PIC X(8).                        *00753
      *> Type opérateur                                                 *00761
               10       RE82-CTM5OP    PIC X(2).                        *00761
      *> Référence externe agent                                        *00763
               10       RE82-NOCEAG    PIC 9(7).                        *00763
      *> libellé motif intervention                                     *00770
               10       RE82-LDM5MI    PIC X(64).                       *00770
      *> Libellé erreur                                                 *00834
               10       RE82-LICCER    PIC X(080).                      *00834
      *> Indic note défaut fin de mois                                  *00914
               10       RE82-CIM5W5    PIC X(1).                        *00914
      *> Valeur sortie prévisionnelle Forb                              *00915
               10       RE82-LVM5SO    PIC X(60).                       *00915
      *> Code origine concession                                        *00975
               10       RE82-CMM5CS    PIC X(1).                        *00975
      *> Longueur de la structure : 00975 octets                        *00975
       >>end-if                                                         M5QDM5QS
       >>define AA-E-MESSAGES off                                       M5QDM5QS
