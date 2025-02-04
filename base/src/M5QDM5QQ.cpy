      *>****************************************************************M5QDM5QQ
      *> MESSAGES Q/R M175QQ00 : Q/R MAJ Annulation défaut FORB         M5QDM5QQ
      *>----------------------------------------------------------------M5QDM5QQ
      *CONTROL NOSOURCE                                                 M5QDM5QQ
      *> Cette QR va mettre à jour les données Forbearance en cas       M5QDM5QQ
      *> de demande d'annulation du défaut (modification IHM)           M5QDM5QQ
      *> les tables MAJ :                                               M5QDM5QQ
      *> - M72D  Cycle                                                  M5QDM5QQ
      *> - M72E  Etape                                                  M5QDM5QQ
      *> - M72F  Motifs                                                 M5QDM5QQ
      *>----------------------------------------------------------------M5QDM5QQ
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5QQ
      *>----------------------------------------------------------------M5QDM5QQ
      *> Mots clés :                                                    M5QDM5QQ
      *> FORBEARANCE M-5 M175QQ00                                       M5QDM5QQ
      *>----------------------------------------------------------------M5QDM5QQ
      *CONTROL SOURCE                                                   M5QDM5QQ
      *> Utilisation :                                                  M5QDM5QQ
      *> copy M5QDM5QQ replacing QUESTION  by QUESTION-xxx              M5QDM5QQ
      *>                         REPONSE   by REPONSE-xxx               M5QDM5QQ
      *>                         REDEFINES by REDEFINES                 M5QDM5QQ
      *>                         leading ==QU== by ==Qx==               M5QDM5QQ
      *>                         leading ==RE== by ==Rx==.              M5QDM5QQ
      *>****************************************************************M5QDM5QQ
      *> -- 29/05/2024 16:35:15 BIB:M5B SESSION:9497  USER:USER         M5QDM5QQ
       >>if AA-E-MESSAGES not defined                                   M5QDM5QQ
         >>define AA-E-MESSAGES as ' '                                  M5QDM5QQ
       >>end-if                                                         M5QDM5QQ
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5QQ
      *>****************************************************************M5QDM5QQ
      *> Questions Q/R M175QQ00                                         M5QDM5QQ
      *>****************************************************************M5QDM5QQ
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QQ
       01               QUESTION.                                       M5QDM5QQ
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QQ
      *> QR Partie commune niveau Application                           M5QDM5QQ
            03          QU00.                                           M5QDM5QQ
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
               10       FILLER         PIC X(00537).                    *00013
      *> Longueur de la structure : 00549 octets                        *00549
         >>end-if                                                       M5QDM5QQ
      *>--- ID='M5S19C' ------------------------------------------------M5QDM5QQ
      *> Q MAJ ANNULATION DEFAUT FORB                                   M5QDM5QQ
            03          QU9C           REDEFINES QU00.                  M5QDM5QQ
               10       FILLER         PIC X(00012).                    *00001
      *> Code action                                                    *00013
               10       QU9C-CASETR    PIC X.                           *00013
      *> Code Etab Banque Entité Juridique                              *00014
               10       QU9C-COCXBQ    PIC X(5).                        *00014
      *> Identifiant Contrat                                            *00019
               10       QU9C-IDDIEP    PIC X(27).                       *00019
      *> Num cycle Forbearance                                          *00046
               10       QU9C-NSM5CY    PIC 9(7).                        *00046
               10       QU9C-NSM5CYX   REDEFINES QU9C-NSM5CY            *00046
                                       PIC X(007).                      *00046
      *> Num étape dans cycle Forb                                      *00053
               10       QU9C-NSM5ET    PIC 9(7).                        *00053
               10       QU9C-NSM5ETX   REDEFINES QU9C-NSM5ET            *00053
                                       PIC X(007).                      *00053
      *> Décision Forbearance opération                                 *00060
               10       QU9C-CRM5FB    PIC X(1).                        *00060
      *> Indic evt défaut RAD forbearance                               *00061
               10       QU9C-CIM5DF    PIC X(1).                        *00061
      *> Commentaire IHM                                                *00062
               10       QU9C-LRM5CO    PIC X(254).                      *00062
      *> Date décision refus (SSAAMMJJ)                                 *00316
               10       QU9C-DGM5RF    PIC X(8).                        *00316
      *> Commentaire refus                                              *00324
               10       QU9C-LRM5RF    PIC X(200).                      *00324
      *> Date première échéance (SSAAMMJJ)                              *00524
               10       QU9C-DHM5PE    PIC X(8).                        *00524
      *> Indic note défaut fin de mois                                  *00532
               10       QU9C-CIM5W5    PIC X(1).                        *00532
      *> Type opérateur                                                 *00533
               10       QU9C-CTM5OP    PIC X(2).                        *00533
      *> Référence externe agent                                        *00535
               10       QU9C-NOCEAG    PIC 9(7).                        *00535
               10       QU9C-NOCEAGX   REDEFINES QU9C-NOCEAG            *00535
                                       PIC X(007).                      *00535
      *> Code programme origine                                         *00542
               10       QU9C-IDMRPO    PIC X(8).                        *00542
      *> Longueur de la structure : 00549 octets                        *00549
       >>end-if                                                         M5QDM5QQ
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5QQ
      *>****************************************************************M5QDM5QQ
      *> Réponses Q/R M175QQ00                                          M5QDM5QQ
      *>****************************************************************M5QDM5QQ
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QQ
       01               REPONSE.                                        M5QDM5QQ
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QQ
      *> QR ADT Standard Inter-Domaine                                  M5QDM5QQ
            03          RE00.                                           M5QDM5QQ
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
         >>end-if                                                       M5QDM5QQ
      *>--- ID='AISA06' ------------------------------------------------M5QDM5QQ
      *> R Réponse Standard Libellé sur 80                              M5QDM5QQ
            03          RE06           REDEFINES RE00.                  M5QDM5QQ
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
       >>end-if                                                         M5QDM5QQ
       >>define AA-E-MESSAGES off                                       M5QDM5QQ
