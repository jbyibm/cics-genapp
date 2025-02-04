      *>****************************************************************M5QDM5Q9
      *> MESSAGES Q/R M175Q900 : Q/R Consult étape fiche Forbearance    M5QDM5Q9
      *>----------------------------------------------------------------M5QDM5Q9
      *CONTROL NOSOURCE                                                 M5QDM5Q9
      *> Cette QR permet de consulter la situation de l'étape           M5QDM5Q9
      *> de la Fiche Forbearance.                                       M5QDM5Q9
      *> Elle renvoie les données de la table M72S, ainsi le local      M5QDM5Q9
      *> pourra conditionner la suite du processus de qualification     M5QDM5Q9
      *> de la Forbearance                                              M5QDM5Q9
      *>----------------------------------------------------------------M5QDM5Q9
      *> Niveau d'exposition : Q/R interne à l'Application              M5QDM5Q9
      *>----------------------------------------------------------------M5QDM5Q9
      *> Mots clés :                                                    M5QDM5Q9
      *> FORBEARANCE M-5 M175Q900                                       M5QDM5Q9
      *>----------------------------------------------------------------M5QDM5Q9
      *CONTROL SOURCE                                                   M5QDM5Q9
      *> Utilisation :                                                  M5QDM5Q9
      *> copy M5QDM5Q9 replacing QUESTION  by QUESTION-xxx              M5QDM5Q9
      *>                         REPONSE   by REPONSE-xxx               M5QDM5Q9
      *>                         REDEFINES by REDEFINES                 M5QDM5Q9
      *>                         leading ==QU== by ==Qx==               M5QDM5Q9
      *>                         leading ==RE== by ==Rx==.              M5QDM5Q9
      *>****************************************************************M5QDM5Q9
      *> -- 02/07/2024 15:32:33 BIB:M5B SESSION:9558  USER:USER         M5QDM5Q9
       >>if AA-E-MESSAGES not defined                                   M5QDM5Q9
         >>define AA-E-MESSAGES as ' '                                  M5QDM5Q9
       >>end-if                                                         M5QDM5Q9
       >>if AA-E-MESSAGES not = 'R'                                     M5QDM5Q9
      *>****************************************************************M5QDM5Q9
      *> Questions Q/R M175Q900                                         M5QDM5Q9
      *>****************************************************************M5QDM5Q9
         >>if AA-E-MESSAGES = ' '                                       M5QDM5Q9
       01               QUESTION.                                       M5QDM5Q9
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5Q9
      *> QR Partie commune niveau Application                           M5QDM5Q9
            03          QU00.                                           M5QDM5Q9
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
               10       FILLER         PIC X(00043).                    *00013
      *> Longueur de la structure : 00055 octets                        *00055
         >>end-if                                                       M5QDM5Q9
      *>--- ID='M5S153' ------------------------------------------------M5QDM5Q9
      *> Q Qualif FORB Consult Etape fiche                              M5QDM5Q9
            03          QU53           REDEFINES QU00.                  M5QDM5Q9
               10       FILLER         PIC X(00012).                    *00001
      *> Code Etab Banque Entité Juridique                              *00013
               10       QU53-COCXBQ    PIC X(5).                        *00013
      *> Identifiant personne                                           *00018
               10       QU53-NODAPE    PIC 9(9).                        *00018
               10       QU53-NODAPEX   REDEFINES QU53-NODAPE            *00018
                                       PIC X(009).                      *00018
      *> TS création enregistrement (TIMESTAMP)                         *00027
               10       QU53-HDEHEG    PIC X(26).                       *00027
      *> Code statut fiche                                              *00053
               10       QU53-CEM5SF    PIC X(3).                        *00053
      *> Longueur de la structure : 00055 octets                        *00055
       >>end-if                                                         M5QDM5Q9
       >>if AA-E-MESSAGES not = 'Q'                                     M5QDM5Q9
      *>****************************************************************M5QDM5Q9
      *> Réponses Q/R M175Q900                                          M5QDM5Q9
      *>****************************************************************M5QDM5Q9
         >>if AA-E-MESSAGES = ' '                                       M5QDM5Q9
       01               REPONSE.                                        M5QDM5Q9
      *>--- CODE=WLNQR6 ------------------------------------------------M5QDM5Q9
      *> QR Partie commune niveau Application                           M5QDM5Q9
            03          RE00.                                           M5QDM5Q9
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
               10       FILLER         PIC X(08430).                    *00013
      *> Longueur de la structure : 08442 octets                        *08442
         >>end-if                                                       M5QDM5Q9
      *>--- ID='AISA06' ------------------------------------------------M5QDM5Q9
      *> R Réponse Standard Libellé sur 80                              M5QDM5Q9
            03          RE06           REDEFINES RE00.                  M5QDM5Q9
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
      *>--- ID='M5S154' ------------------------------------------------M5QDM5Q9
      *> R Qualif FORB Consult Etape fiche                              M5QDM5Q9
            03          RE54           REDEFINES RE00.                  M5QDM5Q9
               10       FILLER         PIC X(00012).                    *00001
      *> Date création statut Fiche (SSAAMMJJ)                          *00013
               10       RE54-DDM5SF    PIC X(8).                        *00013
      *> Indicateur statut actif                                        *00021
               10       RE54-CIM5AF    PIC X(1).                        *00021
      *> Date finalisation statut fiche (SSAAMMJJ)                      *00022
               10       RE54-DDM5FI    PIC X(8).                        *00022
      *> Ref ext agent histo élément                                    *00030
               10       RE54-NUCEHE    PIC 9(7).                        *00030
      *> Code état hors périmètre forb                                  *00037
               10       RE54-CEM5HP    PIC X(1).                        *00037
      *> Code statut question prospective                               *00038
               10       RE54-CEM5QP    PIC X(1).                        *00038
      *> Code statut question difficulté fi                             *00039
               10       RE54-CEM5DI    PIC X(1).                        *00039
      *> Code statut question défaut                                    *00040
               10       RE54-CEM5DE    PIC X(1).                        *00040
      *> Commentaire situation financière                               *00041
               10       RE54-LRM5SF    PIC X(4000).                     *00041
      *> Code motif finalisation étape                                  *04041
               10       RE54-CMM5FI    PIC X(2).                        *04041
      *> Libellé commentaire final analyse                              *04043
               10       RE54-LRM5AI    PIC X(400).                      *04043
      *> Libellé commentaire quest prospectiv                           *04443
               10       RE54-LRM5QP    PIC X(4000).                     *04443
      *> Longueur de la structure : 08442 octets                        *08442
       >>end-if                                                         M5QDM5Q9
       >>define AA-E-MESSAGES off                                       M5QDM5Q9
