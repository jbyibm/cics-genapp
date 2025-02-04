      *>****************************************************************DCQDD350
      *> MESSAGES Q/R D350     : INTERROGATION D'UNE ENTITE TITUL       DCQDD350
      *>----------------------------------------------------------------DCQDD350
      *CONTROL NOSOURCE                                                 DCQDD350
      *> Interrogation d'une ET                                         DCQDD350
      *> Attention le nom de la question est                            DCQDD350
      *>       QDCSU3I0 , QDCSU3I1 , QDCSU3I2 , QDCSU3I3 , QDCSU3I4     DCQDD350
      *>                                                                DCQDD350
      *> Segments questions :                                           DCQDD350
      *> * QDCSU3I0 : interro ensemble des informations                 DCQDD350
      *> * QDCSU3I1 : caractéristiques (mode de composition, type       DCQDD350
      *>              usage...)                                         DCQDD350
      *> * QDCSU3I2 : composition                                       DCQDD350
      *> * QDCSU3I3 : professionnel concerné                            DCQDD350
      *> * QDCSU3I4 : lieux d'activités concernés                       DCQDD350
      *> * QDCSU3I5 :                                                   DCQDD350
      *> * QDCSU3I6 :                                                   DCQDD350
      *> * QDCSU3I7 : interro ensemble des informations + mandataire    DCQDD350
      *>                                                                DCQDD350
      *> Segments réponses :                                            DCQDD350
      *> * RDCSU3J si segment question = QDCSU3I0 ou QDCSU3I1           DCQDD350
      *> * RDCSU3K si segment question = QDCSU3I2                       DCQDD350
      *> * RDCSU3L si segment question = QDCSU3I3                       DCQDD350
      *> * RDCSU3M si segment question = QDCSU3I4                       DCQDD350
      *> * RAISA03 si erreur                                            DCQDD350
      *>----------------------------------------------------------------DCQDD350
      *> Niveau d'exposition : Q/R Inter Domaine (Privée GCE)           DCQDD350
      *>----------------------------------------------------------------DCQDD350
      *> Mots clés :                                                    DCQDD350
      *> D350                                                           DCQDD350
      *>----------------------------------------------------------------DCQDD350
      *CONTROL SOURCE                                                   DCQDD350
      *> Utilisation :                                                  DCQDD350
      *> copy DCQDD350 replacing QUESTION  by QUESTION-xxx              DCQDD350
      *>                         REPONSE   by REPONSE-xxx               DCQDD350
      *>                         REDEFINES by REDEFINES                 DCQDD350
      *>                         leading ==QU== by ==Qx==               DCQDD350
      *>                         leading ==RE== by ==Rx==.              DCQDD350
      *>****************************************************************DCQDD350
      *>#GN 20/08/2024 17:49:42 BIB:CTRS.DCP SESSION:9644  USER:J062907 DCQDD350
       >>if AA-E-MESSAGES not defined                                   DCQDD350
         >>define AA-E-MESSAGES as ' '                                  DCQDD350
       >>end-if                                                         DCQDD350
       >>if AA-E-MESSAGES not = 'R'                                     DCQDD350
      *>****************************************************************DCQDD350
      *> Questions Q/R D350                                             DCQDD350
      *>****************************************************************DCQDD350
         >>if AA-E-MESSAGES = ' '                                       DCQDD350
       01               QUESTION.                                       DCQDD350
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:SD00 ---DCQDD350
      *> QR Partie commune CLIENT                                       DCQDD350
            03          QU00.                                           DCQDD350
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
               10       FILLER         PIC X(00022).                    *00013
      *> Longueur de la structure : 00034 octets                        *00034
         >>end-if                                                       DCQDD350
      *>--- ID='DCSU3I' ---------------------------------- #SEG:SD3I ---DCQDD350
      *> Q Interrogation de l'ET                                        DCQDD350
            03          QU3I           REDEFINES QU00.                  DCQDD350
               10       FILLER         PIC X(00012).                    *00001
      *> Q Partie commune Question (agent)                              *00013
               10       QU3I-SA07.                                      *00013
      *> Code agent alphanumérique                                      *00013
                11      QU3I-WNOAG     PIC X(7).                        *00013
      *> Code Etablissement entité juridique                            *00020
               10       QU3I-CODXET    PIC X(5).                        *00020
      *> Numéro entité titulaire                                        *00025
               10       QU3I-NODIET    PIC 9(10).                       *00025
               10       QU3I-NODIETX   REDEFINES QU3I-NODIET            *00025
                                       PIC X(010).                      *00025
      *> Longueur de la structure : 00034 octets                        *00034
       >>end-if                                                         DCQDD350
       >>if AA-E-MESSAGES not = 'Q'                                     DCQDD350
      *>****************************************************************DCQDD350
      *> Réponses Q/R D350                                              DCQDD350
      *>****************************************************************DCQDD350
         >>if AA-E-MESSAGES = ' '                                       DCQDD350
       01               REPONSE.                                        DCQDD350
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:SD00 ---DCQDD350
      *> QR Partie commune CLIENT                                       DCQDD350
            03          RE00.                                           DCQDD350
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
               10       FILLER         PIC X(00725).                    *00013
      *> Longueur de la structure : 00737 octets                        *00737
         >>end-if                                                       DCQDD350
      *>--- ID='AISA06' ---------------------------------- #SEG:SA06 ---DCQDD350
      *> R Réponse Standard Libellé sur 80                              DCQDD350
            03          RE06           REDEFINES RE00.                  DCQDD350
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
      *>--- ID='DCSU3J' ---------------------------------- #SEG:SD3J ---DCQDD350
      *> R Interro caractéristiques d'une ET                            DCQDD350
            03          RE3J           REDEFINES RE00.                  DCQDD350
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE3J-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE3J-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE3J-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
               10       RE3J-CODXET    PIC X(5).                        *00016
      *> Numéro entité titulaire                                        *00021
               10       RE3J-NODIET    PIC 9(10).                       *00021
      *> Code type usage entité titulaire                               *00031
               10       RE3J-CODIUS    PIC X.                           *00031
      *> Mode composition entité titulaire                              *00032
               10       RE3J-CODIMC    PIC X.                           *00032
      *> Groupe code et libellé désignation                             *00033
               10       RE3J-GRDICD    OCCURS 005.                      *00033
      *> Désignation bancaire courte                                    *00033
                11      RE3J-LIDICD    PIC X(32).                       *00033
      *> Code type désignation bancaire                                 *00193
                11      RE3J-CODIDS    PIC X(2).                        *00193
      *> Idt Elément structure                                          *00203
               10       RE3J-NODXEL    PIC 9(5).                        *00203
      *> Libellé Elément Structure                                      *00208
               10       RE3J-LIDXET    PIC X(32).                       *00208
      *> Lib complément désignation bancaire                            *00240
               10       RE3J-LIDICP    PIC X(32).                       *00240
      *> Alphanumérique Banalisée 032                                   *00272
               10       RE3J-WX032     PIC X(32).                       *00272
      *> Code état personne/entité titulaire                            *00304
               10       RE3J-CODAET    PIC X.                           *00304
      *> Date fermeture entité titulaire (JJMMSSAA)                     *00305
               10       RE3J-DIDAFE    PIC X(8).                        *00305
      *> Code motif clôture pers / ent-tit                              *00313
               10       RE3J-CODACL    PIC X.                           *00313
      *> Date enregistrement entité titulaire (JJMMSSAA)                *00314
               10       RE3J-DADICR    PIC X(8).                        *00314
      *> Code type élément structure                                    *00322
               10       RE3J-CODXEL    PIC XX.                          *00322
      *> Référence externe élément structure                            *00324
               10       RE3J-COCXEG    PIC 9(7).                        *00324
      *> Code entité administrative                                     *00331
               10       RE3J-COCEEM    PIC X(3).                        *00331
      *> Idt EDS contact                                                *00334
               10       RE3J-NOCEET    PIC 9(5).                        *00334
      *> Code type élément structure                                    *00339
               10       RE3J-CTCXEL    PIC XX.                          *00339
      *> Référence interne élément structure                            *00341
               10       RE3J-COCXEL    PIC 9(7).                        *00341
      *> Code entité administrative                                     *00348
               10       RE3J-COCXEA    PIC X(3).                        *00348
      *> Libellé Elément Structure                                      *00351
               10       RE3J-LICELI    PIC X(32).                       *00351
      *> Identifiant élément structure                                  *00383
               10       RE3J-NOCEE1    PIC 9(7).                        *00383
      *> Référence externe EDS                                          *00390
               10       RE3J-COCEEL    PIC 9(7).                        *00390
      *> Type élément structure                                         *00397
               10       RE3J-CTCEEL    PIC X(3).                        *00397
      *> Libellé calculé court EDS                                      *00400
               10       RE3J-LCCEL1    PIC X(32).                       *00400
      *> Désignation longue élément structure                           *00432
               10       RE3J-LLCELI    PIC X(64).                       *00432
      *> Référence externe agent                                        *00496
               10       RE3J-COCEAG    PIC 9(7).                        *00496
      *> Libellé fonction poste fonctionnel                             *00503
               10       RE3J-LNCEAG    PIC X(40).                       *00503
      *> Libellé Elément Structure                                      *00543
               10       RE3J-LICEL1    PIC X(32).                       *00543
      *> Identifiant Elément structure                                  *00575
               10       RE3J-NOCEEL    PIC 9(7).                        *00575
      *> Référence externe EDS                                          *00582
               10       RE3J-COCEE1    PIC 9(7).                        *00582
      *> Type élément structure                                         *00589
               10       RE3J-CTCEE1    PIC X(3).                        *00589
      *> Libellé calculé court EDS                                      *00592
               10       RE3J-LCCEL2    PIC X(32).                       *00592
      *> Désignation longue élément structure                           *00624
               10       RE3J-LLCEL1    PIC X(64).                       *00624
      *> Référence externe agent                                        *00688
               10       RE3J-COCEA7    PIC 9(7).                        *00688
      *> Libellé fonction poste fonctionnel                             *00695
               10       RE3J-LNCEA1    PIC X(40).                       *00695
      *> Code Cotation Bancaire                                         *00735
               10       RE3J-CODACB    PIC X(1).                        *00735
      *> Sous divis/mode composit. indivision                           *00736
               10       RE3J-CODIM5    PIC X.                           *00736
      *> Indic autor FATCA ouverture P/S                                *00737
               10       RE3J-CIDAOU    PIC X.                           *00737
      *> Longueur de la structure : 00737 octets                        *00737
      *>--- ID='DCSU3K' ---------------------------------- #SEG:SD3K ---DCQDD350
      *> R Interro personnes composant une ET                           DCQDD350
            03          RE3K           REDEFINES RE00.                  DCQDD350
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE3K-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE3K-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE3K-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
               10       RE3K-CODXET    PIC X(5).                        *00016
      *> Numéro entité titulaire                                        *00021
               10       RE3K-NODIET    PIC 9(10).                       *00021
      *> Identifiant personne                                           *00031
               10       RE3K-NODAPE    PIC 9(9).                        *00031
      *> Désignation courte particulier                                 *00040
               10       RE3K-LIDA1C    PIC X(32).                       *00040
      *> Indic responsable comptes ET                                   *00072
               10       RE3K-CODIRC    PIC X.                           *00072
      *> Code personnalité juridique                                    *00073
               10       RE3K-CODAPJ    PIC X.                           *00073
      *> Code civilité personne physique                                *00074
               10       RE3K-CODACV    PIC X(1).                        *00074
      *> Nom famille Personne Physique                                  *00075
               10       RE3K-LIDANP    PIC X(25).                       *00075
      *> Premier prénom état civil Personne                             *00100
               10       RE3K-LIDAPP    PIC X(20).                       *00100
      *> Nom usage Personne Physique                                    *00120
               10       RE3K-LIDANM    PIC X(25).                       *00120
      *> Date naissance personne physique (JJMMSSAA)                    *00145
               10       RE3K-DADANA    PIC X(8).                        *00145
      *> Type mandat                                                    *00153
               10       RE3K-CTDIMA    PIC X(2).                        *00153
      *> Longueur de la structure : 00154 octets                        *00154
      *>--- ID='DCSU3L' ---------------------------------- #SEG:SD3L ---DCQDD350
      *> R Interro professionnels d'une ET                              DCQDD350
            03          RE3L           REDEFINES RE00.                  DCQDD350
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE3L-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE3L-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE3L-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
               10       RE3L-CODXET    PIC X(5).                        *00016
      *> Numéro entité titulaire                                        *00021
               10       RE3L-NODIET    PIC 9(10).                       *00021
      *> Identifiant personne                                           *00031
               10       RE3L-NODAPE    PIC 9(9).                        *00031
      *> Numéro chrono professionnel                                    *00040
               10       RE3L-NODAPS    PIC 9(2).                        *00040
      *> Nom commercial professionnel                                   *00042
               10       RE3L-LIDANO    PIC X(40).                       *00042
      *> Longueur de la structure : 00081 octets                        *00081
      *>--- ID='DCSU3M' ---------------------------------- #SEG:SD3M ---DCQDD350
      *> R Les établissements d'une ET                                  DCQDD350
            03          RE3M           REDEFINES RE00.                  DCQDD350
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE3M-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE3M-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE3M-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
               10       RE3M-CODXET    PIC X(5).                        *00016
      *> Numéro entité titulaire                                        *00021
               10       RE3M-NODIET    PIC 9(10).                       *00021
      *> Identifiant personne                                           *00031
               10       RE3M-NODAPE    PIC 9(9).                        *00031
      *> Numéro chrono professionnel                                    *00040
               10       RE3M-NODAPS    PIC 9(2).                        *00040
      *> Numéro chrono lieu activité                                    *00042
               10       RE3M-NODALS    PIC 9(03).                       *00042
      *> Enseigne commerciale lieu d'activité                           *00045
               10       RE3M-LIDAEN    PIC X(40).                       *00045
      *> Désignation courte lieu activité                               *00085
               10       RE3M-LIDALI    PIC X(32).                       *00085
      *> Longueur de la structure : 00116 octets                        *00116
      *>--- ID='DCSU6X' ---------------------------------- #SEG:SD6X ---DCQDD350
      *> R Int. taux indivision personnes/CB                            DCQDD350
            03          RE6X           REDEFINES RE00.                  DCQDD350
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE6X-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE6X-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE6X-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
               10       RE6X-CODXET    PIC X(5).                        *00016
      *> Numéro entité titulaire                                        *00021
               10       RE6X-NODIET    PIC 9(10).                       *00021
      *> Identifiant personne                                           *00031
               10       RE6X-NODAPE    PIC 9(9).                        *00031
      *> Pourcentage Nue Propriété                                      *00040
               10       RE6X-TXDENP    PIC 9(3)V99.                     *00040
      *> Pourcentage pleine propriété                                   *00045
               10       RE6X-TXDEPP    PIC 9(3)V99.                     *00045
      *> Pourcentage usufruit                                           *00050
               10       RE6X-TXDEUS    PIC 9(3)V99.                     *00050
      *> Longueur de la structure : 00054 octets                        *00054
      *>--- ID='DCSU6X' ---------------------------------- #SEG:SU6X ---DCQDD350
      *> R Interro personnes composant une ET                           DCQDD350
            03          RE6X           REDEFINES RE00.                  DCQDD350
               10       FILLER         PIC X(00012).                    *00001
      *> R Int. taux indivision personnes/CB                            *00013
               10       RE6X-SD6X.                                      *00013
      *> R Partie commune Code Retour Réponse                           *00013
                11      RE6X-SA05.                                      *00013
      *> Code erreur                                                    *00013
                 12     RE6X-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                  13    RE6X-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
                11      RE6X-CODXET    PIC X(5).                        *00016
      *> Numéro entité titulaire                                        *00021
                11      RE6X-NODIET    PIC 9(10).                       *00021
      *> Identifiant personne                                           *00031
                11      RE6X-NODAPE    PIC 9(9).                        *00031
      *> Pourcentage Nue Propriété                                      *00040
                11      RE6X-TXDENP    PIC 9(3)V99.                     *00040
      *> Pourcentage pleine propriété                                   *00045
                11      RE6X-TXDEPP    PIC 9(3)V99.                     *00045
      *> Pourcentage usufruit                                           *00050
                11      RE6X-TXDEUS    PIC 9(3)V99.                     *00050
      *> Longueur de la structure : 00054 octets                        *00054
      *>--- ID='DCSU6Y' ---------------------------------- #SEG:SU6Y ---DCQDD350
      *> R Interro usufruitiers composant ET                            DCQDD350
            03          RE6Y           REDEFINES RE00.                  DCQDD350
               10       FILLER         PIC X(00012).                    *00001
      *> R Partie commune Code Retour Réponse                           *00013
               10       RE6Y-SA05.                                      *00013
      *> Code erreur                                                    *00013
                11      RE6Y-WCOREX.                                    *00013
      *> Code retour Echanges                                           *00013
                 12     RE6Y-WCORE3    PIC 9(3).                        *00013
      *> Code Etablissement entité juridique                            *00016
               10       RE6Y-CODXET    PIC X(5).                        *00016
      *> Numéro entité titulaire                                        *00021
               10       RE6Y-NODIET    PIC 9(10).                       *00021
      *> Identifiant personne                                           *00031
               10       RE6Y-NODAPE    PIC 9(9).                        *00031
      *> Désignation courte particulier                                 *00040
               10       RE6Y-LIDA1C    PIC X(32).                       *00040
               10       RE6Y-FILLER    PIC X(1).                        *00072
      *> Code personnalité juridique                                    *00073
               10       RE6Y-CODAPJ    PIC X.                           *00073
      *> Code civilité personne physique                                *00074
               10       RE6Y-CODACV    PIC X(1).                        *00074
      *> Nom famille Personne Physique                                  *00075
               10       RE6Y-LIDANP    PIC X(25).                       *00075
      *> Premier prénom état civil Personne                             *00100
               10       RE6Y-LIDAPP    PIC X(20).                       *00100
      *> Nom usage Personne Physique                                    *00120
               10       RE6Y-LIDANM    PIC X(25).                       *00120
      *> Date naissance personne physique (JJMMSSAA)                    *00145
               10       RE6Y-DADANA    PIC X(8).                        *00145
      *> Longueur de la structure : 00152 octets                        *00152
       >>end-if                                                         DCQDD350
       >>define AA-E-MESSAGES off                                       DCQDD350
