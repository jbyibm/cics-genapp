      *>****************************************************************M5FII22A
      *> FICHIER : MO- Concessions avec titulaires                      M5FII22A
      *>----------------------------------------------------------------M5FII22A
      *CONTROL NOSOURCE                                                 M5FII22A
      *> Auteur           :  Florent DARD                               M5FII22A
      *> Date de Création :  08/09/23                                   M5FII22A
      *> Origine Création :  P36441 - Refonte du Moteur Forbearance     M5FII22A
      *>                                                                M5FII22A
      *>                                                                M5FII22A
      *> Les concessions reçu de synchro/vario reformaté après          M5FII22A
      *> contrôle de la validité des données en entrée.                 M5FII22A
      *>                                                                M5FII22A
      *>----------------------------------------------------------------M5FII22A
      *> MOT CLES :                                                     M5FII22A
      *> MOTEUR FORBEARANCE                                             M5FII22A
      *>----------------------------------------------------------------M5FII22A
      *CONTROL SOURCE                                                   M5FII22A
      *> Utilisation :                                                  M5FII22A
      *> copy M5FII22A replacing leading ==I22A== by ==prefix==.        M5FII22A
      *>****************************************************************M5FII22A
      *> -- 16/04/2024 18:15:52 BIB:M5B SESSION:9419  USER:USER         M5FII22A
      *>----------------------------------------------------------------M5FII22A
      *> MO- Concessions avec titulaires                                M5FII22A
       01               I22A.                                           M5FII22A
      *> Code Etab Banque Entité Juridique                              *00001
               10       I22A-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       I22A-IDDIEP    PIC X(27).                       *00006
      *> Code Guichet Interbancaire                                     *00033
               10       I22A-COCXGU    PIC X(5).                        *00033
      *> Code type produit service                                      *00038
               10       I22A-CODIPR    PIC X(4).                        *00038
      *> Référence produit / service                                    *00042
               10       I22A-CODIRF    PIC X(11).                       *00042
      *> Identifiant personne                                           *00053
               10       I22A-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00053
      *> Type concession                                                *00058
               10       I22A-CTM5CS    PIC X(1).                        *00058
      *> Code origine concession                                        *00059
               10       I22A-CMM5CS    PIC X(1).                        *00059
      *> Date effet concession (SSAA-MM-JJ)                             *00060
               10       I22A-DFM5CS    PIC X(10).                       *00060
      *> Code Produit National                                          *00070
               10       I22A-COEGPX    PIC X(6).                        *00070
      *> Mt impayé                                                      *00076
               10       I22A-MTM5IM    PIC S9(13) PACKED-DECIMAL.       *00076
      *> Montant capital restant dû                                     *00083
               10       I22A-MKMKRE    PIC S9(15) PACKED-DECIMAL.       *00083
      *> Numéro dossier contentieux                                     *00091
               10       I22A-NOMKDO    PIC S9(7) PACKED-DECIMAL.        *00091
      *> Code état plan apurement                                       *00095
               10       I22A-CEMKPA    PIC X.                           *00095
      *> Code type plan recouvrement                                    *00096
               10       I22A-CDMKTQ    PIC X.                           *00096
      *> Date première échéance (SSAA-MM-JJ)                            *00097
               10       I22A-DHM5PE    PIC X(10).                       *00097
      *> Indicateur exception pour CFF                                  *00107
               10       I22A-CIM5XC    PIC X(1).                        *00107
      *> Indic concess signif Bullet PROF                               *00108
               10       I22A-CIM5CB    PIC X(1).                        *00108
      *> Indic concess signif franchise PROF                            *00109
               10       I22A-CIM5CF    PIC X(1).                        *00109
      *> Indic concess signif échéancier                                *00110
               10       I22A-CIM5CE    PIC X(1).                        *00110
      *> Code statut NPE personne                                       *00111
               10       I22A-CEM5PS    PIC X(3).                        *00111
      *> Code cause NPE                                                 *00114
               10       I22A-COM5CN    PIC X(1).                        *00114
      *> Code segment risque Bâle 2 ET                                  *00115
               10       I22A-CDDIBA    PIC X(8).                        *00115
      *> Code catégorie segment risque                                  *00123
               10       I22A-COMBSR    PIC X(4).                        *00123
      *> Code catégorie segment risque                                  *00127
               10       I22A-COMBS1    PIC X(4).                        *00127
      *> Code décision défaut                                           *00131
               10       I22A-CRM5DF    PIC X(2).                        *00131
      *> Identifiant créance CTX                                        *00133
               10       I22A-IDMKCE    PIC X(12).                       *00133
      *> Code déchéance terme                                           *00145
               10       I22A-COMEDT    PIC X.                           *00145
      *> CODE INDICATEUR PLAN NEIERTZ                                   *00146
               10       I22A-CIMKNE    PIC X.                           *00146
      *> Code réaménagement                                             *00147
               10       I22A-CDFARE    PIC X.                           *00147
      *> Code aiguillage traitement synchro                             *00148
               10       I22A-CTM5TT    PIC XX.                          *00148
      *> Code motif Concession Synchro                                  *00150
               10       I22A-CDM5MC    PIC XX.                          *00150
      *> Code famille dossier                                           *00152
               10       I22A-CDMKFA    PIC X(2).                        *00152
      *> Libellé Motif concession                                       *00154
               10       I22A-LIM5MC    PIC X(30).                       *00154
      *> Indicateur note défaut                                         *00184
               10       I22A-CIM5ND    PIC X(1).                        *00184
      *> Indicateur présence fiche qualif                               *00185
               10       I22A-CIM5FI    PIC X(1).                        *00185
      *> Indic concess signif Bullet CORP                               *00186
               10       I22A-CIM5CD    PIC X(1).                        *00186
      *> Indic concess signif franchise CORP                            *00187
               10       I22A-CIM5CG    PIC X(1).                        *00187
               10       I22A-FILLER    PIC X(113).                      *00188
