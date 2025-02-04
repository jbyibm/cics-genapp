      *>****************************************************************M5FII21I
      *> FICHIER : Remettant Nafi Synchro Vario                         M5FII21I
      *>----------------------------------------------------------------M5FII21I
      *CONTROL NOSOURCE                                                 M5FII21I
      *> Auteur           :  P.Rolland    s3289                         M5FII21I
      *> Date de Création :  14/11/14                                   M5FII21I
      *> Origine Création :  FORBEARANCE 017431                         M5FII21I
      *>                                                                M5FII21I
      *>                                                                M5FII21I
      *> Segment de description du fichier des remettants NAFI,         M5FII21I
      *> SYNCHRO, VARIO.                                                M5FII21I
      *>                                                                M5FII21I
      *> Modifié par :       P.Lafitte                                  M5FII21I
      *> Modifié le  :       20/05/19                                   M5FII21I
      *> Motif de Modif. :   Projet Nouveau Defaut : 026818-02          M5FII21I
      *>                                                                M5FII21I
      *> Ajout de la date de 1ère échéance. Elle sera renseignée pour   M5FII21I
      *> les contrats issue de VARIO ou de SYNCHRO, hors GECCO.         M5FII21I
      *>                                                                M5FII21I
      *> Modifié par :       Manuela Pinto J62673                       M5FII21I
      *> Modifié le  :       12/07/22                                   M5FII21I
      *> Motif de Modif. :   029723-05 - Exception CFF Forbearance      M5FII21I
      *>                     CCID: E34015  PSI:6928                     M5FII21I
      *>                                                                M5FII21I
      *> Ajouter la rubrique CIM5XC                                     M5FII21I
      *>----------------------------------------------------------------M5FII21I
      *> MOT CLES :                                                     M5FII21I
      *> FORBEARANCE 017431                                             M5FII21I
      *>----------------------------------------------------------------M5FII21I
      *CONTROL SOURCE                                                   M5FII21I
      *> Utilisation :                                                  M5FII21I
      *> copy M5FII21I replacing leading ==I21I== by ==prefix==.        M5FII21I
      *>****************************************************************M5FII21I
      *> -- 16/04/2024 18:15:26 BIB:M5B SESSION:9419  USER:USER         M5FII21I
      *>----------------------------------------------------------------M5FII21I
      *> Remettant Nafi Synchro Vario                                   M5FII21I
       01               I21I.                                           M5FII21I
      *> Code Etab Banque Entité Juridique                              *00001
               10       I21I-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       I21I-IDDIEP    PIC X(27).                       *00006
      *> Type concession                                                *00033
               10       I21I-CTM5CS    PIC X(1).                        *00033
      *> Code origine concession                                        *00034
               10       I21I-CMM5CS    PIC X(1).                        *00034
      *> Date effet concession (SSAA-MM-JJ)                             *00035
               10       I21I-DFM5CS    PIC X(10).                       *00035
      *> Date arrêté fichier concession (SSAA-MM-JJ)                    *00045
               10       I21I-DAM5CS    PIC X(10).                       *00045
      *> Code Produit Service                                           *00055
               10       I21I-COEGPS    PIC X(6).                        *00055
      *> Numéro entité titulaire                                        *00061
               10       I21I-NODIET    PIC S9(10) PACKED-DECIMAL.       *00061
      *> Mt impayé                                                      *00067
               10       I21I-MTM5IM    PIC S9(13) PACKED-DECIMAL.       *00067
      *> Montant capital restant dû                                     *00074
               10       I21I-MKMKRE    PIC S9(15) PACKED-DECIMAL.       *00074
      *> ---- Groupe données VARIO                                      *00082
               10       I21I-GRM5CV.                                    *00082
      *> Numéro dossier contentieux                                     *00082
                11      I21I-NOMKDO    PIC S9(7) PACKED-DECIMAL.        *00082
      *> Identifiant créance CTX                                        *00086
                11      I21I-IDMKCE    PIC X(12).                       *00086
      *> Code état plan apurement                                       *00098
                11      I21I-CEMKPA    PIC X.                           *00098
      *> Code activité créance                                          *00099
                11      I21I-COMECR    PIC XX.                          *00099
      *> Code déchéance terme                                           *00101
                11      I21I-COMEDT    PIC X.                           *00101
      *> Date début accord plan apurement (SSAA-MM-JJ)                  *00102
                11      I21I-DDMKAC    PIC X(10).                       *00102
      *> Date création créance (SSAA-MM-JJ)                             *00112
                11      I21I-DDMKCC    PIC X(10).                       *00112
      *> Code type plan recouvrement                                    *00122
                11      I21I-CDMKTQ    PIC X.                           *00122
      *> CODE INDICATEUR PLAN NEIERTZ                                   *00123
                11      I21I-CIMKNE    PIC X.                           *00123
      *> Code état gestion en sous-traitance                            *00124
                11      I21I-CEMKST    PIC X.                           *00124
      *> Code famille dossier                                           *00125
                11      I21I-CDMKFA    PIC X(2).                        *00125
                11      I21I-FILLER    PIC X(100).                      *00127
      *> ---- Groupe de données Synchro                                 *00227
               10       I21I-GRM5SY.                                    *00227
      *> Code réaménagement                                             *00227
                11      I21I-CDFARE    PIC X.                           *00227
      *> Code aiguillage traitement synchro                             *00228
                11      I21I-CTM5TT    PIC XX.                          *00228
      *> Code motif Concession Synchro                                  *00230
                11      I21I-CDM5MC    PIC XX.                          *00230
      *> Libellé Motif concession                                       *00232
                11      I21I-LIM5MC    PIC X(30).                       *00232
                11      I21I-FILLER    PIC X(100).                      *00262
      *> ---- Groupe données NAFI                                       *00362
               10       I21I-GRM5NA.                                    *00362
      *> Type évènement CRE crédit CEFI                                 *00362
                11      I21I-CTFMEN    PIC X(2).                        *00362
      *> Identifiant contrat CEFI                                       *00364
                11      I21I-IDFMSM    PIC X(27).                       *00364
      *> Identifiant incident                                           *00391
                11      I21I-IDMIIN    PIC X(25).                       *00391
                11      I21I-FILLER    PIC X(100).                      *00416
      *> Code anomalie NPE FORBEARANCE                                  *00516
               10       I21I-CDM5AN    PIC X(05).                       *00516
      *> Date première échéance (SSAA-MM-JJ)                            *00521
               10       I21I-DHM5PE    PIC X(10).                       *00521
      *> Indicateur exception pour CFF                                  *00531
               10       I21I-CIM5XC    PIC X(1).                        *00531
      *> Indic concess signif Bullet PROF                               *00532
               10       I21I-CIM5CB    PIC X(1).                        *00532
      *> Indic concess signif franchise PROF                            *00533
               10       I21I-CIM5CF    PIC X(1).                        *00533
      *> Indic concess signif échéancier                                *00534
               10       I21I-CIM5CE    PIC X(1).                        *00534
      *> Indic concess signif Bullet CORP                               *00535
               10       I21I-CIM5CD    PIC X(1).                        *00535
      *> Indic concess signif franchise CORP                            *00536
               10       I21I-CIM5CG    PIC X(1).                        *00536
               10       I21I-FILLER    PIC X(274).                      *00537
