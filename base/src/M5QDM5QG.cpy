      *>****************************************************************M5QDM5QG
      *> MESSAGES Q/R M175QG00 : Q/R Consult état contrat FORB          M5QDM5QG
      *>----------------------------------------------------------------M5QDM5QG
      *CONTROL NOSOURCE                                                 M5QDM5QG
      *> Cette QR permet de restituer :                                 M5QDM5QG
      *> l'état d'un contrat lié à une forbearance                      M5QDM5QG
      *>                                                                M5QDM5QG
      *>                                                                M5QDM5QG
      *>                                                                M5QDM5QG
      *>----------------------------------------------------------------M5QDM5QG
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5QG
      *>----------------------------------------------------------------M5QDM5QG
      *> Mots clés :                                                    M5QDM5QG
      *> FORBEARANCE M-5 M175QG00                                       M5QDM5QG
      *>----------------------------------------------------------------M5QDM5QG
      *CONTROL SOURCE                                                   M5QDM5QG
      *> Utilisation :                                                  M5QDM5QG
      *> copy M5QDM5QG replacing QUESTION  by QUESTION-xxx              M5QDM5QG
      *>                         REPONSE   by REPONSE-xxx               M5QDM5QG
      *>                         REDEFINES by REDEFINES                 M5QDM5QG
      *>                         leading ==QU== by ==Qx==               M5QDM5QG
      *>                         leading ==RE== by ==Rx==.              M5QDM5QG
      *>****************************************************************M5QDM5QG
      *> -- 29/05/2024 16:33:57 BIB:M5B SESSION:9497  USER:USER         M5QDM5QG
       >>if AA-E-MESSAGES not defined                                   M5QDM5QG
         >>define AA-E-MESSAGES as ' '                                  M5QDM5QG
       >>end-if                                                         M5QDM5QG
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5QG
      *>****************************************************************M5QDM5QG
      *> Questions Q/R M175QG00                                         M5QDM5QG
      *>****************************************************************M5QDM5QG
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QG
       01               QUESTION.                                       M5QDM5QG
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QG
      *> QR Partie commune niveau Application                           M5QDM5QG
            03          QU00.                                           M5QDM5QG
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
         >>end-if                                                       M5QDM5QG
      *>--- ID='M5S173' ------------------------------------------------M5QDM5QG
      *> Q Consultation détail contrat FORB                             M5QDM5QG
            03          QU73           REDEFINES QU00.                  M5QDM5QG
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       QU73-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       QU73-IDDIEP    PIC X(27).                       *00018
      *> Longueur de la structure : 00044 octets                        *00044
       >>end-if                                                         M5QDM5QG
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5QG
      *>****************************************************************M5QDM5QG
      *> Réponses Q/R M175QG00                                          M5QDM5QG
      *>****************************************************************M5QDM5QG
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QG
       01               REPONSE.                                        M5QDM5QG
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QG
      *> QR Partie commune niveau Application                           M5QDM5QG
            03          RE00.                                           M5QDM5QG
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
               10       FILLER         PIC X(00890).                    *00013
      *> Longueur de la structure : 00902 octets                        *00902
         >>end-if                                                       M5QDM5QG
      *>--- ID='AISA06' ------------------------------------------------M5QDM5QG
      *> R Réponse Standard Libellé sur 80                              M5QDM5QG
            03          RE06           REDEFINES RE00.                  M5QDM5QG
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
      *>--- ID='M5S174' ------------------------------------------------M5QDM5QG
      *> R Consultation détail contrat FORB                             M5QDM5QG
            03          RE74           REDEFINES RE00.                  M5QDM5QG
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       RE74-COCXBQ    PIC X(5).                        *00013
      *> Identifiant Contrat                                            *00018
               10       RE74-IDDIEP    PIC X(27).                       *00018
      *> Num cycle Forbearance                                          *00045
               10       RE74-NSM5CY    PIC 9(7).                        *00045
      *> Num étape dans cycle Forb                                      *00052
               10       RE74-NSM5ET    PIC 9(7).                        *00052
      *> Référence produit / service                                    *00059
               10       RE74-CODIRF    PIC X(11).                       *00059
      *> Code Guichet Interbancaire                                     *00070
               10       RE74-COCXGU    PIC X(5).                        *00070
      *> Code type produit service                                      *00075
               10       RE74-CODIPR    PIC X(4).                        *00075
      *> Code Produit National                                          *00079
               10       RE74-COEGPX    PIC X(6).                        *00079
      *> Libellé type produit / service                                 *00085
               10       RE74-LIGXPR    PIC X(32).                       *00085
      *> Code segment risque Bâle 2 ET                                  *00117
               10       RE74-CDDIBA    PIC X(8).                        *00117
      *> Code catégorie segment risque                                  *00125
               10       RE74-COMBSR    PIC X(4).                        *00125
      *> Code statut PE/NPE contrat                                     *00129
               10       RE74-CEM5CT    PIC X(3).                        *00129
      *> Code surv étape Forbearance                                    *00132
               10       RE74-CEM5ET    PIC X(4).                        *00132
      *> Indicateur occurrence active                                   *00136
               10       RE74-CIDCOA    PIC X(1).                        *00136
      *> Type concession                                                *00137
               10       RE74-CTM5CS    PIC X(1).                        *00137
      *> libellé motif intervention Forb                                *00138
               10       RE74-LDM5FO    PIC X(64).                       *00138
      *> Lib origine motif intervention                                 *00202
               10       RE74-LDM5OM    PIC X(30).                       *00202
      *> Lib référence piste audit                                      *00232
               10       RE74-LIM5PA    PIC X(30).                       *00232
      *> Date effet interv Forb (SSAAMMJJ)                              *00262
               10       RE74-DDM5FO    PIC X(8).                        *00262
      *> Décision Forbearance opération                                 *00270
               10       RE74-CRM5FB    PIC X(1).                        *00270
      *> Indic evt défaut RAD forbearance                               *00271
               10       RE74-CIM5DF    PIC X(1).                        *00271
      *> Commentaire IHM                                                *00272
               10       RE74-LRM5CO    PIC X(254).                      *00272
      *> Date décision refus (SSAAMMJJ)                                 *00526
               10       RE74-DGM5RF    PIC X(8).                        *00526
      *> Commentaire refus                                              *00534
               10       RE74-LRM5RF    PIC X(200).                      *00534
      *> Date première échéance (SSAAMMJJ)                              *00734
               10       RE74-DHM5PE    PIC X(8).                        *00734
      *> Type opérateur                                                 *00742
               10       RE74-CTM5OP    PIC X(2).                        *00742
      *> Référence externe agent                                        *00744
               10       RE74-NOCEAG    PIC 9(7).                        *00744
      *> libellé motif intervention                                     *00751
               10       RE74-LDM5MI    PIC X(64).                       *00751
      *> Valeur état Forbearance                                        *00815
               10       RE74-LVM5ET    PIC X(20).                       *00815
      *> Valeur sortie prévisionnelle Forb                              *00835
               10       RE74-LVM5SO    PIC X(60).                       *00835
      *> Code origine concession                                        *00895
               10       RE74-CMM5CS    PIC X(1).                        *00895
      *> Num étape prec dans cycle Forb                                 *00896
               10       RE74-NSM5E1    PIC 9(7).                        *00896
      *> Longueur de la structure : 00902 octets                        *00902
       >>end-if                                                         M5QDM5QG
       >>define AA-E-MESSAGES off                                       M5QDM5QG
