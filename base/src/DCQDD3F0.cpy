      *>****************************************************************DCQDD3F0
      *> MESSAGES Q/R D3F0     : INFOS ENTITE TITULAIRE                 DCQDD3F0
      *>----------------------------------------------------------------DCQDD3F0
      *CONTROL NOSOURCE                                                 DCQDD3F0
      *> Cette Q/R  a pour but de fournir la désignation bancaire       DCQDD3F0
      *> courte et le code usage d'un entité titulaire référencée       DCQDD3F0
      *> par son numéro ou un RICE rattaché à elle-même.                DCQDD3F0
      *>                                                                DCQDD3F0
      *>                                                                DCQDD3F0
      *>----------------------------------------------------------------DCQDD3F0
      *> Niveau d'exposition : Q/R Inter Domaine (Privée GCE)           DCQDD3F0
      *>----------------------------------------------------------------DCQDD3F0
      *> Mots clés :                                                    DCQDD3F0
      *> D3F0                                                           DCQDD3F0
      *>----------------------------------------------------------------DCQDD3F0
      *CONTROL SOURCE                                                   DCQDD3F0
      *> Utilisation :                                                  DCQDD3F0
      *> copy DCQDD3F0 replacing QUESTION  by QUESTION-xxx              DCQDD3F0
      *>                         REPONSE   by REPONSE-xxx               DCQDD3F0
      *>                         REDEFINES by REDEFINES                 DCQDD3F0
      *>                         leading ==QU== by ==Qx==               DCQDD3F0
      *>                         leading ==RE== by ==Rx==.              DCQDD3F0
      *>****************************************************************DCQDD3F0
      *>#GN 20/08/2024 17:42:46 BIB:CTRS.DCP SESSION:9644  USER:J062907 DCQDD3F0
       >>if AA-E-MESSAGES not defined                                   DCQDD3F0
         >>define AA-E-MESSAGES as ' '                                  DCQDD3F0
       >>end-if                                                         DCQDD3F0
       >>if AA-E-MESSAGES not = 'R'                                     DCQDD3F0
      *>****************************************************************DCQDD3F0
      *> Questions Q/R D3F0                                             DCQDD3F0
      *>****************************************************************DCQDD3F0
         >>if AA-E-MESSAGES = ' '                                       DCQDD3F0
       01               QUESTION.                                       DCQDD3F0
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:SD00 ---DCQDD3F0
      *> QR Partie commune CLIENT                                       DCQDD3F0
            03          QU00.                                           DCQDD3F0
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
               10       FILLER         PIC X(00042).                    *00013
      *> Longueur de la structure : 00054 octets                        *00054
         >>end-if                                                       DCQDD3F0
      *>--- ID='DCSD3E' ---------------------------------- #SEG:SD3E ---DCQDD3F0
      *> Q DESIGNATION ET ADRESSE ENTITE TITU                           DCQDD3F0
            03          QU3E           REDEFINES QU00.                  DCQDD3F0
               10       FILLER         PIC X(00012).                    *00001
      *> Q Partie commune Question (agent)                              *00013
               10       QU3E-SA07.                                      *00013
      *> Code agent alphanumérique                                      *00013
                11      QU3E-WNOAG     PIC X(7).                        *00013
      *> Code Etab Banque Entité Juridique                              *00020
               10       QU3E-COCXBQ    PIC X(5).                        *00020
      *> Code Guichet Interbancaire                                     *00025
               10       QU3E-COCXGU    PIC X(5).                        *00025
      *> Code type produit service                                      *00030
               10       QU3E-CODIPR    PIC X(4).                        *00030
      *> Numéro compte P/S                                              *00034
               10       QU3E-NOGXCP    PIC X(11).                       *00034
      *> Numéro entité titulaire                                        *00045
               10       QU3E-NODIET    PIC 9(10).                       *00045
               10       QU3E-NODIETX   REDEFINES QU3E-NODIET            *00045
                                       PIC X(010).                      *00045
      *> Longueur de la structure : 00054 octets                        *00054
       >>end-if                                                         DCQDD3F0
       >>if AA-E-MESSAGES not = 'Q'                                     DCQDD3F0
      *>****************************************************************DCQDD3F0
      *> Réponses Q/R D3F0                                              DCQDD3F0
      *>****************************************************************DCQDD3F0
         >>if AA-E-MESSAGES = ' '                                       DCQDD3F0
       01               REPONSE.                                        DCQDD3F0
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:SD00 ---DCQDD3F0
      *> QR Partie commune CLIENT                                       DCQDD3F0
            03          RE00.                                           DCQDD3F0
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
               10       FILLER         PIC X(00175).                    *00013
      *> Longueur de la structure : 00187 octets                        *00187
         >>end-if                                                       DCQDD3F0
      *>--- ID='AISA06' ---------------------------------- #SEG:SA06 ---DCQDD3F0
      *> R Réponse Standard Libellé sur 80                              DCQDD3F0
            03          RE06           REDEFINES RE00.                  DCQDD3F0
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
      *>--- ID='DCSD3G' ---------------------------------- #SEG:SD3G ---DCQDD3F0
      *> R DESIGNATION ENTITE TITULAIRE                                 DCQDD3F0
            03          RE3G           REDEFINES RE00.                  DCQDD3F0
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE3G-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE3G-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE3G-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
               10       RE3G-CODXET    PIC X(5).                        *00016
      *> Numéro entité titulaire                                        *00021
               10       RE3G-NODIET    PIC 9(10).                       *00021
      *> Code type usage entité titulaire                               *00031
               10       RE3G-CODIUS    PIC X.                           *00031
      *> Mode composition entité titulaire                              *00032
               10       RE3G-CODIMC    PIC X.                           *00032
      *> Code état personne/entité titulaire                            *00033
               10       RE3G-CODAET    PIC X.                           *00033
      *> Code motif clôture pers / ent-tit                              *00034
               10       RE3G-CODACL    PIC X.                           *00034
      *> Date fermeture entité titulaire (JJMMSSAA)                     *00035
               10       RE3G-DIDAFE    PIC X(8).                        *00035
      *> Date enregistrement entité titulaire (JJMMSSAA)                *00043
               10       RE3G-DADICR    PIC X(8).                        *00043
      *> Désignation bancaire courte                                    *00051
               10       RE3G-LIDICD    PIC X(32).                       *00051
      *> Identifiant Elément structure                                  *00083
               10       RE3G-NOCEEL    PIC 9(7).                        *00083
      *> Identifiant élément structure                                  *00090
               10       RE3G-NOCEE1    PIC 9(7).                        *00090
      *> Indicateur entité titulaire douteuse                           *00097
               10       RE3G-CIDIED    PIC 9.                           *00097
      *> Identifiant personne                                           *00098
               10       RE3G-NODAPE    PIC 9(9).                        *00098
      *> Désignation courte                                             *00107
               10       RE3G-LIDACR    PIC X(32).                       *00107
      *> Idt élément structure                                          *00139
               10       RE3G-NOCEE2    PIC 9(7).                        *00139
      *> Libellé Elément Structure                                      *00146
               10       RE3G-LICELI    PIC X(32).                       *00146
      *> Référence externe EDS                                          *00178
               10       RE3G-COCEEL    PIC 9(7).                        *00178
      *> Type élément structure                                         *00185
               10       RE3G-CTCEEL    PIC X(3).                        *00185
      *> Longueur de la structure : 00187 octets                        *00187
       >>end-if                                                         DCQDD3F0
       >>define AA-E-MESSAGES off                                       DCQDD3F0
