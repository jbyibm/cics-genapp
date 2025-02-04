      *>****************************************************************M5QDM5QC
      *> MESSAGES Q/R M175QC00 : Q/R CONSULT opération Fiche FORB       M5QDM5QC
      *>----------------------------------------------------------------M5QDM5QC
      *CONTROL NOSOURCE                                                 M5QDM5QC
      *> Cette QR renvoie les données de l'opération et son détail      M5QDM5QC
      *> sur une étape de la fiche de qualification Forbearance         M5QDM5QC
      *>                                                                M5QDM5QC
      *>                                                                M5QDM5QC
      *>                                                                M5QDM5QC
      *>----------------------------------------------------------------M5QDM5QC
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5QC
      *>----------------------------------------------------------------M5QDM5QC
      *> Mots clés :                                                    M5QDM5QC
      *> FORBEARANCE M-5 M175QC00                                       M5QDM5QC
      *>----------------------------------------------------------------M5QDM5QC
      *CONTROL SOURCE                                                   M5QDM5QC
      *> Utilisation :                                                  M5QDM5QC
      *> copy M5QDM5QC replacing QUESTION  by QUESTION-xxx              M5QDM5QC
      *>                         REPONSE   by REPONSE-xxx               M5QDM5QC
      *>                         REDEFINES by REDEFINES                 M5QDM5QC
      *>                         leading ==QU== by ==Qx==               M5QDM5QC
      *>                         leading ==RE== by ==Rx==.              M5QDM5QC
      *>****************************************************************M5QDM5QC
      *> -- 12/06/2024 16:14:41 BIB:M5B SESSION:9522  USER:USER         M5QDM5QC
       >>if AA-E-MESSAGES not defined                                   M5QDM5QC
         >>define AA-E-MESSAGES as ' '                                  M5QDM5QC
       >>end-if                                                         M5QDM5QC
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5QC
      *>****************************************************************M5QDM5QC
      *> Questions Q/R M175QC00                                         M5QDM5QC
      *>****************************************************************M5QDM5QC
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QC
       01               QUESTION.                                       M5QDM5QC
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QC
      *> QR Partie commune niveau Application                           M5QDM5QC
            03          QU00.                                           M5QDM5QC
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
         >>end-if                                                       M5QDM5QC
      *>--- ID='M5S162' ------------------------------------------------M5QDM5QC
      *> Q Qualif FORB Consult operation                                M5QDM5QC
            03          QU62           REDEFINES QU00.                  M5QDM5QC
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       QU62-COCXBQ    PIC X(5).                        *00013
      *> Identifiant personne                                           *00018
               10       QU62-NODAPE    PIC 9(9).                        *00018
               10       QU62-NODAPEX   REDEFINES QU62-NODAPE            *00018
                                       PIC X(009).                      *00018
      *> TS création enregistrement (TIMESTAMP)                         *00027
               10       QU62-HDEHEG    PIC X(26).                       *00027
      *> Code statut fiche                                              *00053
               10       QU62-CEM5SF    PIC X(3).                        *00053
      *> Numéro opération statut fiche                                  *00056
               10       QU62-NSM5OP    PIC 9(3).                        *00056
               10       QU62-NSM5OPX   REDEFINES QU62-NSM5OP            *00056
                                       PIC X(003).                      *00056
      *> Longueur de la structure : 00058 octets                        *00058
       >>end-if                                                         M5QDM5QC
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5QC
      *>****************************************************************M5QDM5QC
      *> Réponses Q/R M175QC00                                          M5QDM5QC
      *>****************************************************************M5QDM5QC
         >>if AA-E-MESSAGES = ' '                                       M5QDM5QC
       01               REPONSE.                                        M5QDM5QC
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5QC
      *> QR Partie commune niveau Application                           M5QDM5QC
            03          RE00.                                           M5QDM5QC
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
               10       FILLER         PIC X(00133).                    *00013
      *> Longueur de la structure : 00145 octets                        *00145
         >>end-if                                                       M5QDM5QC
      *>--- ID='AISA06' ------------------------------------------------M5QDM5QC
      *> R Réponse Standard Libellé sur 80                              M5QDM5QC
            03          RE06           REDEFINES RE00.                  M5QDM5QC
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
      *>--- ID='M5S163' ------------------------------------------------M5QDM5QC
      *> R Qualif FORB Consult Operation                                M5QDM5QC
            03          RE63           REDEFINES RE00.                  M5QDM5QC
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       RE63-COCXBQ    PIC X(5).                        *00013
      *> TS création enregistrement (TIMESTAMP)                         *00018
               10       RE63-HDEHEG    PIC X(26).                       *00018
      *> Identifiant personne                                           *00044
               10       RE63-NODAPE    PIC 9(9).                        *00044
      *> Code statut fiche                                              *00053
               10       RE63-CEM5SF    PIC X(3).                        *00053
      *> Numéro opération statut fiche                                  *00056
               10       RE63-NSM5OP    PIC 9(3).                        *00056
      *> Identifiant Contrat                                            *00059
               10       RE63-IDDIEP    PIC X(27).                       *00059
      *> Code type opération qualification                              *00086
               10       RE63-CTM5OF    PIC X(2).                        *00086
      *> Code statut questions significatives                           *00088
               10       RE63-CEM5QS    PIC X(1).                        *00088
      *> Code statut exonération test perte                             *00089
               10       RE63-CEM5EX    PIC X(1).                        *00089
      *> Code statut test perte                                         *00090
               10       RE63-CEM5PE    PIC X(1).                        *00090
      *> Décision Forbearance opération                                 *00091
               10       RE63-CRM5FB    PIC X(1).                        *00091
      *> Code décision défaut                                           *00092
               10       RE63-CRM5DF    PIC X(2).                        *00092
      *> Indicateur de traitement                                       *00094
               10       RE63-CIM5TR    PIC X.                           *00094
      *> Description caraq nouveau contrat                              *00095
               10       RE63-LDM5NC    PIC X(50).                       *00095
      *> Code nature qualification operation                            *00145
               10       RE63-CNM5QO    PIC X(1).                        *00145
      *> Longueur de la structure : 00145 octets                        *00145
      *>--- ID='M5S164' ------------------------------------------------M5QDM5QC
      *> R Qualif FORB Consult détail opérat                            M5QDM5QC
            03          RE64           REDEFINES RE00.                  M5QDM5QC
               10       FILLER         PIC X(00012).                    *00001
      *> Type détail opération                                          *00013
               10       RE64-CTM5DO    PIC X(2).                        *00013
      *> Valeur détail opération                                        *00015
               10       RE64-LVM5DO    PIC X(50).                       *00015
      *> Longueur de la structure : 00064 octets                        *00064
       >>end-if                                                         M5QDM5QC
       >>define AA-E-MESSAGES off                                       M5QDM5QC
