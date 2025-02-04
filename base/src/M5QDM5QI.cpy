      *>****************************************************************M5QDM5QI
      *> MESSAGES Q/R M175QI00 : Q/R Consultation Motifs FORB           M5QDM5QI
      *>----------------------------------------------------------------M5QDM5QI
      *CONTROL NOSOURCE                                                 M5QDM5QI
      *> Cette QR permet de restituer                                   M5QDM5QI
      *> les motifs d'une forbearance                                   M5QDM5QI
      *>                                                                M5QDM5QI
      *>                                                                M5QDM5QI
      *>                                                                M5QDM5QI
      *>----------------------------------------------------------------M5QDM5QI
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5QI
      *>----------------------------------------------------------------M5QDM5QI
      *> Mots clés :                                                    M5QDM5QI
      *> FORBEARANCE M-5 M175QI00                                       M5QDM5QI
      *>----------------------------------------------------------------M5QDM5QI
      *CONTROL SOURCE                                                   M5QDM5QI
      *> Utilisation :                                                  M5QDM5QI
      *> copy M5QDM5QI replacing QUESTION  by QUESTION-xxx              M5QDM5QI
      *>                         REPONSE   by REPONSE-xxx               M5QDM5QI
      *>                         REDEFINES by REDEFINES                 M5QDM5QI
      *>                         leading ==QU== by ==Qx==               M5QDM5QI
      *>                         leading ==RE== by ==Rx==.              M5QDM5QI
      *>****************************************************************M5QDM5QI
      *> -- 29/05/2024 16:34:12 BIB:M5B SESSION:9497  USER:USER         M5QDM5QI
       >>if AA-E-MESSAGES not defined                                   M5QDM5QI
         >>define AA-E-MESSAGES as ' '                                  M5QDM5QI
       >>end-if                                                         M5QDM5QI
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5QI
      *>****************************************************************M5QDM5QI
      *> Questions Q/R M175QI00                                         M5QDM5QI
      *>****************************************************************M5QDM5QI
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QI
       01               QUESTION.                                       M5QDM5QI
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QI
      *> QR Partie commune niveau Application                           M5QDM5QI
            03          QU00.                                           M5QDM5QI
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
               10       FILLER         PIC X(00051).                    *00013
      *> Longueur de la structure : 00063 octets                        *00063
         >>end-if                                                       M5QDM5QI
      *>--- ID='M5S177' ------------------------------------------------M5QDM5QI
      *> Q Consultation Motifs Forbearance                              M5QDM5QI
            03          QU77           REDEFINES QU00.                  M5QDM5QI
               10       FILLER         PIC X(00012).                    *00001
      *> Code action                                                    *00013
               10       QU77-CASETR    PIC X.                           *00013
      *> Code Etab Banque Entité Juridique                              *00014
               10       QU77-COCXBQ    PIC X(5).                        *00014
      *> Identifiant Contrat                                            *00019
               10       QU77-IDDIEP    PIC X(27).                       *00019
      *> Num cycle Forbearance                                          *00046
               10       QU77-NSM5CY    PIC 9(7).                        *00046
               10       QU77-NSM5CYX   REDEFINES QU77-NSM5CY            *00046
                                       PIC X(007).                      *00046
      *> Num étape dans cycle Forb                                      *00053
               10       QU77-NSM5ET    PIC 9(7).                        *00053
               10       QU77-NSM5ETX   REDEFINES QU77-NSM5ET            *00053
                                       PIC X(007).                      *00053
      *> Code origine motif intervention                                *00060
               10       QU77-CMM5MI    PIC X(4).                        *00060
      *> Longueur de la structure : 00063 octets                        *00063
       >>end-if                                                         M5QDM5QI
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5QI
      *>****************************************************************M5QDM5QI
      *> Réponses Q/R M175QI00                                          M5QDM5QI
      *>****************************************************************M5QDM5QI
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QI
       01               REPONSE.                                        M5QDM5QI
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QI
      *> QR Partie commune niveau Application                           M5QDM5QI
            03          RE00.                                           M5QDM5QI
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
               10       FILLER         PIC X(00494).                    *00013
      *> Longueur de la structure : 00506 octets                        *00506
         >>end-if                                                       M5QDM5QI
      *>--- ID='AISA06' ------------------------------------------------M5QDM5QI
      *> R Réponse Standard Libellé sur 80                              M5QDM5QI
            03          RE06           REDEFINES RE00.                  M5QDM5QI
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
      *>--- ID='M5S178' ------------------------------------------------M5QDM5QI
      *> R Consultation Motifs Forbearance                              M5QDM5QI
            03          RE78           REDEFINES RE00.                  M5QDM5QI
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       RE78-COCXBQ    PIC X(5).                        *00013
      *> Code origine motif intervention                                *00018
               10       RE78-CMM5MI    PIC X(4).                        *00018
      *> Identifiant Contrat                                            *00022
               10       RE78-IDDIEP    PIC X(27).                       *00022
      *> Num cycle Forbearance                                          *00049
               10       RE78-NSM5CY    PIC 9(7).                        *00049
      *> Num étape dans cycle Forb                                      *00056
               10       RE78-NSM5ET    PIC 9(7).                        *00056
      *> Code motif interv Forb                                         *00063
               10       RE78-CMM5FO    PIC X(3).                        *00063
      *> Type intervention Forb                                         *00066
               10       RE78-CTM5FO    PIC X(2).                        *00066
      *> Type opérateur                                                 *00068
               10       RE78-CTM5OP    PIC X(2).                        *00068
      *> Date effet interv Forb (SSAAMMJJ)                              *00070
               10       RE78-DDM5FO    PIC X(8).                        *00070
      *> Date arrêté du motif (SSAAMMJJ)                                *00078
               10       RE78-DAM5MO    PIC X(8).                        *00078
      *> Commentaire IHM                                                *00086
               10       RE78-LRM5CO    PIC X(254).                      *00086
      *> Lib origine motif intervention                                 *00340
               10       RE78-LDM5OM    PIC X(30).                       *00340
      *> Lib référence piste audit                                      *00370
               10       RE78-LIM5PA    PIC X(30).                       *00370
      *> Référence externe agent                                        *00400
               10       RE78-NOCEAG    PIC 9(7).                        *00400
      *> Idt trace IHM intervention                                     *00407
               10       RE78-NSM5TF    PIC 9(11).                       *00407
      *> Code programme origine                                         *00418
               10       RE78-IDMRPO    PIC X(8).                        *00418
      *> Date traitement OPC création motif (SSAAMMJJ)                  *00426
               10       RE78-DTM5CM    PIC X(8).                        *00426
      *> libellé motif intervention Forb                                *00434
               10       RE78-LDM5FO    PIC X(64).                       *00434
      *> Code evt déclencheur motif                                     *00498
               10       RE78-COM5DM    PIC X(8).                        *00498
      *> Code traitement evt déclencheur                                *00506
               10       RE78-COM5TT    PIC X(1).                        *00506
      *> Longueur de la structure : 00506 octets                        *00506
       >>end-if                                                         M5QDM5QI
       >>define AA-E-MESSAGES off                                       M5QDM5QI
