      ******************************************************************M8QDM8T1
      * MESSAGES Q/R M178T100 : Q/R rech. éligibilité sur trigger       M8QDM8T1
      *-----------------------------------------------------------------M8QDM8T1
      * Cette Q/R restitue pour un client, son éligibilité aux          M8QDM8T1
      * triggers BAD LOANS.                                             M8QDM8T1
      *                                                                 M8QDM8T1
      * Si le client n'est plus éligible, la Q/R restitue son           M8QDM8T1
      * éligibilité précédente (la plus récente).                       M8QDM8T1
      *                                                                 M8QDM8T1
      *-----------------------------------------------------------------M8QDM8T1
      * Utilisation :                                                   M8QDM8T1
      * COPY M8QDM8T1 REPLACING QUESTION  BY QUESTION-xxx               M8QDM8T1
      *                         REPONSE   BY REPONSE-xxx                M8QDM8T1
      *                         REDEFINES BY REDEFINES                  M8QDM8T1
      *                         LEADING ==QU== BY ==Qx==                M8QDM8T1
      *                         LEADING ==RE== BY ==Rx==                M8QDM8T1
      ******************************************************************M8QDM8T1
      *-- 18/08/2022 10:08:44 BIB: M8B SESSION:       USER: J070188     M8QDM8T1
       >>if AA-E-MESSAGES not defined                                   M8QDM8T1
         >>define AA-E-MESSAGES as ' '                                  M8QDM8T1
       >>end-if                                                         M8QDM8T1
       >>if AA-E-MESSAGES not = 'R'                                     M8QDM8T1
      ******************************************************************M8QDM8T1
      * Questions Q/R M178T100                                          M8QDM8T1
      ******************************************************************M8QDM8T1
         >>if AA-E-MESSAGES = ' '                                       M8QDM8T1
       01                 QUESTION.                                     M8QDM8T1
      *-----------------------------------------------------------------M8QDM8T1
      * QR Partie commune MAD-CTX-RISQUES                               M8QDM8T1
           03             QU00.                                         M8QDM8T1
             05           QU00-00.                                      *00001
      * QR ADT Standard Inter-Domaine                                   *00001
               10         QU00-SA00.                                    *00001
      * QR Longueur Segment Question/Réponse                            *00001
                11        QU00-WLGQR   PIC 9(4).                        *00001
                11        QU00-WLGQRXX REDEFINES QU00-WLGQR             *00001
                                       PIC X(004).                      *00001
      * LONGUEUR FLUX                                                   *00001
                11        QU00-XZ3LNG  REDEFINES QU00-WLGQR             *00001
                                       PIC 9(4).                        *00001
      * QR Code Segment Question/Réponse                                *00005
                11        QU00-WLNQR.                                   *00005
      * QR Type de Segment ECHANGES                                     *00005
                 12       QU00-CTSEQR  PIC X.                           *00005
      * QR Code Structure Question/Réponse                              *00006
                 12       QU00-WLNQR6  PIC X(6).                        *00006
      * QR Nature d'un Segment ECHANGES                                 *00012
                 12       QU00-CNSEQR  PIC X.                           *00012
      * CODE STRUCTURE DONNEES                                          *00005
                11        QU00-XZ3SGE  REDEFINES QU00-WLNQR             *00005
                                       PIC X(8).                        *00005
             05           QU00-SUITE.                                   *00013
               10              FILLER  PIC X(00020).                    *00013
         >>end-if                                                       M8QDM8T1
      *--- M8TM8C ------------------------------------------------------M8QDM8T1
      * Q recherche éligibilité sur trigger                             M8QDM8T1
           03             QU8C         REDEFINES QU00.                  M8QDM8T1
               10              FILLER  PIC X(00012).                    *00001
      * Code Etab Banque Entité Juridique                               *00013
               10         QU8C-COCXBQ  PIC X(5).                        *00013
      * Identifiant personne                                            *00018
               10         QU8C-NODAPE  PIC 9(9).                        *00018
               10         QU8C-NODAPEX REDEFINES QU8C-NODAPE            *00018
                                       PIC X(009).                      *00018
      * Code Trigger BAD LOANS                                          *00027
               10         QU8C-CDMSTR  PIC X(5).                        *00027
      * Code choix critères                                             *00032
               10         QU8C-COPXCH  PIC X.                           *00032
       >>end-if                                                         M8QDM8T1
       >>if AA-E-MESSAGES not = 'Q'                                     M8QDM8T1
      ******************************************************************M8QDM8T1
      * Réponses Q/R M178T100                                           M8QDM8T1
      ******************************************************************M8QDM8T1
         >>if AA-E-MESSAGES = ' '                                       M8QDM8T1
       01                 REPONSE.                                      M8QDM8T1
      *-----------------------------------------------------------------M8QDM8T1
      * QR Partie commune MAD-CTX-RISQUES                               M8QDM8T1
           03             RE00.                                         M8QDM8T1
             05           RE00-00.                                      *00001
      * QR ADT Standard Inter-Domaine                                   *00001
               10         RE00-SA00.                                    *00001
      * QR Longueur Segment Question/Réponse                            *00001
                11        RE00-WLGQR   PIC 9(4).                        *00001
      * LONGUEUR FLUX                                                   *00001
                11        RE00-XZ3LNG  REDEFINES RE00-WLGQR             *00001
                                       PIC 9(4).                        *00001
      * QR Code Segment Question/Réponse                                *00005
                11        RE00-WLNQR.                                   *00005
      * QR Type de Segment ECHANGES                                     *00005
                 12       RE00-CTSEQR  PIC X.                           *00005
      * QR Code Structure Question/Réponse                              *00006
                 12       RE00-WLNQR6  PIC X(6).                        *00006
      * QR Nature d'un Segment ECHANGES                                 *00012
                 12       RE00-CNSEQR  PIC X.                           *00012
      * CODE STRUCTURE DONNEES                                          *00005
                11        RE00-XZ3SGE  REDEFINES RE00-WLNQR             *00005
                                       PIC X(8).                        *00005
             05           RE00-SUITE.                                   *00013
               10              FILLER  PIC X(00121).                    *00013
         >>end-if                                                       M8QDM8T1
      *--- AISA06 ------------------------------------------------------M8QDM8T1
      * R Réponse Standard Libellé sur 80                               M8QDM8T1
           03             RE06         REDEFINES RE00.                  M8QDM8T1
               10              FILLER  PIC X(00012).                    *00001
      * R Partie commune Code Retour Réponse                            *00013
               10         RE06-SA05.                                    *00013
      * Code erreur                                                     *00013
                11        RE06-WCOREX.                                  *00013
      * Code retour Echanges                                            *00013
                 12       RE06-WCORE3  PIC 9(3).                        *00013
      * Clé Réduite Messages Erreur PETRA                               *00016
               10         RE06-GRXXCR.                                  *00016
      * Code Domaine de Gestion PACBASE                                 *00016
                11        RE06-WCODM   PIC X(3).                        *00016
      * Code Message erreur (008)                                       *00019
                11        RE06-WCOLE   PIC X(8).                        *00019
      * Libelle Message Erreur sur 80 car.                              *00027
               10         RE06-WLE80.                                   *00027
      * Libellé erreur                                                  *00027
                11        RE06-LISTER  PIC X(79).                       *00027
      * Indic présence info complémentaire                              *00106
                11        RE06-CISTPI  PIC X.                           *00106
      *--- M8TM8D ------------------------------------------------------M8QDM8T1
      * R recherche éligibilité sur trigger                             M8QDM8T1
           03             RE8D         REDEFINES RE00.                  M8QDM8T1
               10              FILLER  PIC X(00012).                    *00001
      * Code Etab Banque Entité Juridique                               *00013
               10         RE8D-COCXBQ  PIC X(5).                        *00013
      * Identifiant personne                                            *00018
               10         RE8D-NODAPE  PIC 9(9).                        *00018
      * Code Trigger BAD LOANS                                          *00027
               10         RE8D-CDMSTR  PIC X(5).                        *00027
      * TS création enregistrement                                      *00032
               10         RE8D-HDEHEG  PIC X(26).                       *00032
      * Date événement calcul Indicateur                                *00058
               10         RE8D-DTMSTG  PIC X(8).                        *00058
      * Indicateur eligib au trigger                                    *00066
               10         RE8D-CIMSTG  PIC X.                           *00066
      * TS création enregistrement précédent                            *00067
               10         RE8D-HDEHE1  PIC X(26).                       *00067
      * Date Calcul Indicateur précédent                                *00093
               10         RE8D-DTMST1  PIC X(8).                        *00093
      * Indicateur eligib précéd. au trigger                            *00101
               10         RE8D-CIMST1  PIC X.                           *00101
      * Libellé Trigger BAD LOANS                                       *00102
               10         RE8D-LBMSTR  PIC X(32).                       *00102
       >>end-if                                                         M8QDM8T1
       >>define AA-E-MESSAGES off                                       M8QDM8T1
