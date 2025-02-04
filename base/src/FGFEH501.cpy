      *>****************************************************************FGFEH501
      *> FICHIER : Détail général fichier Forbearance                   FGFEH501
      *>----------------------------------------------------------------FGFEH501
      *CONTROL NOSOURCE                                                 FGFEH501
      *> Auteur           :  Eric MAES                                  FGFEH501
      *> Date de Création :  04/02/15                                   FGFEH501
      *> Origine Création :  Projet 017431 - Forbearance                FGFEH501
      *>                                                                FGFEH501
      *> Fichier à destination de Forbearance                           FGFEH501
      *> Partie spécifique - Enregistrement détail général              FGFEH501
      *> Décomposition en 5 segments :                                  FGFEH501
      *> - H52A : Données communes                                      FGFEH501
      *> - H52B : Historique crédit                                     FGFEH501
      *> - H52C : Historique avenant                                    FGFEH501
      *> - H52D : Données COVID                                         FGFEH501
      *> - H52E : Complement Historique crédit                          FGFEH501
      *>                                                                FGFEH501
      *> Modifié par :       M.SCAGLIOLA                                FGFEH501
      *> Modifié le  :       21/06/19                                   FGFEH501
      *> Motif de modif. :   MNTEV-26818: Nouveau Default Forbearance   FGFEH501
      *>                     Modification filler pour prise en compte   FGFEH501
      *>                     de l'ajout DTEHPR dans H52B                FGFEH501
      *> Modifié par :       Ludovic COLMONT                            FGFEH501
      *> Modifié le  :       24/06/20                                   FGFEH501
      *> Motif de modif. :   Projet 028900 Forbearance covid            FGFEH501
      *>                     Complément du segment avec le H52D         FGFEH501
      *> Modifié par :       Ludovic COLMONT                            FGFEH501
      *> Modifié le  :       24/03/21                                   FGFEH501
      *> Motif de modif. :   026818 qualification fine Forbearance      FGFEH501
      *>                     Ajout du segment H52E pour EV 1X et 3F     FGFEH501
      *> Modifié par :       Annie  Decourselle                         FGFEH501
      *> Modifié le  :       16/10/23                                   FGFEH501
      *> Motif de modif. :   Ajout données pour Concessions             FGFEH501
      *>                     significatives - Ajout du segment H52F     FGFEH501
      *>                     diminution du filler passe de 254 à 212    FGFEH501
      *>----------------------------------------------------------------FGFEH501
      *> MOT CLES :                                                     FGFEH501
      *> FORBEARANCE                                                    FGFEH501
      *>----------------------------------------------------------------FGFEH501
      *CONTROL SOURCE                                                   FGFEH501
      *> Utilisation :                                                  FGFEH501
      *> copy FGFEH501 replacing leading ==H501== by ==prefix==.        FGFEH501
      *>****************************************************************FGFEH501
      *> -- 27/05/2024 08:12:47 BIB:FCR SESSION:9171  USER:I990886      FGFEH501
      *>----------------------------------------------------------------FGFEH501
      *> Détail général fichier Forbearance                             FGFEH501
       01               H501.                                           FGFEH501
      *> Partie commune segments Forbearance                            *00001
               10       H501-H51C.                                      *00001
      *> Code enregistrement                                            *00001
                11      H501-COFAFB    PIC X(2).                        *00001
      *> Type d'évènement                                               *00003
                11      H501-CTFAFB    PIC X(2).                        *00003
      *> Code Etab Banque Entité Juridique                              *00005
                11      H501-COCXBQ    PIC X(5).                        *00005
      *> IDENTIFIANT CREDIT ELEMENTAIRE                                 *00010
                11      H501-IDCT      PIC X(7).                        *00010
      *> DATE D EFFET (JJMMSSAA)                                        *00017
                11      H501-DTEF      PIC X(8).                        *00017
      *> Date traitement (JJMMSSAA)                                     *00025
                11      H501-DTFAFB    PIC X(8).                        *00025
      *> CODE ORIGINE CREDIT OU DOSSIER                                 *00033
                11      H501-CDFAOR    PIC X(1).                        *00033
      *> Détail général - Données communes                              *00034
               10       H501-H52A.                                      *00034
      *> IDENTIFIANT EMPRUNTEUR                                         *00034
                11      H501-IDTIEM    PIC X(9).                        *00034
      *> CODE REAMENAGEMENT                                             *00043
                11      H501-CDFARE    PIC X.                           *00043
      *> DATE FIN DE PREFINANCEMENT REELLE (JJMMSSAA)                   *00044
                11      H501-DFPF      PIC X(8).                        *00044
      *> DATE DE FIN DU CREDIT (JJMMSSAA)                               *00052
                11      H501-DFFACR    PIC X(8).                        *00052
      *> MONTANT IMPAYE CREDIT                                          *00060
                11      H501-MTIMPR    PIC S9(11)V99.                   *00060
      *> Code produit                                                   *00073
                11      H501-CDFCB4    PIC X(6).                        *00073
      *> Code Type de produit service                                   *00079
                11      H501-COFAPS    PIC X(4).                        *00079
      *> DATE PREMIER VERSEMENT (JJMMSSAA)                              *00083
                11      H501-DTVE1     PIC X(8).                        *00083
      *> MONTANT ACTUALISE CREDIT                                       *00091
                11      H501-MTCT      PIC 9(11)V99.                    *00091
      *> Détail général - Historique crédit                             *00104
               10       H501-H52B.                                      *00104
      *> ANCIEN IDENTIFIANT PERS/EMPRUNTEUR                             *00104
                11      H501-IDFPAN    PIC X(9).                        *00104
      *> CODE REAMENAGEMENT                                             *00113
                11      H501-CDFAR5    PIC X.                           *00113
      *> DATE DE FIN DU CREDIT (JJMMSSAA)                               *00114
                11      H501-DFFAC3    PIC X(8).                        *00114
      *> DATE FIN DE PREFINANCEMENT REELLE (JJMMSSAA)                   *00122
                11      H501-DFPF1     PIC X(8).                        *00122
      *> CODE TYPE MODIFICATION CREDIT                                  *00130
                11      H501-CDTM      PIC X(2).                        *00130
      *> CODE TYPE HISTORISATION                                        *00132
                11      H501-CDTHIS    PIC X(2).                        *00132
      *> DATE HISTORISATION (JJMMSSAA)                                  *00134
                11      H501-DTHIS     PIC X(8).                        *00134
      *> DATE DE CREATION (JJMMSSAA)                                    *00142
                11      H501-DTCR      PIC X(8).                        *00142
      *> MONTANT ANCIENNE ECHEANCE AVT OPTION                           *00150
                11      H501-MEFHAO    PIC S9(11)V99.                   *00150
      *> MONTANT ECHEANCE REDUITE SUITE RA                              *00163
                11      H501-MEFDRA    PIC S9(11)V99.                   *00163
      *> MONTANT ACTUALISE CREDIT                                       *00176
                11      H501-MTCT1     PIC 9(11)V99.                    *00176
      *> DATE ECHEANCE M.E.R. (JJMMSSAA)                                *00189
                11      H501-DTEHPR    PIC X(8).                        *00189
      *> Détail général - Historique avenant                            *00197
               10       H501-H52C.                                      *00197
      *> CODE TYPE AVENANT                                              *00197
                11      H501-CTFCAV    PIC X.                           *00197
      *> ETAT BRANCHE FINANCIERE                                        *00198
                11      H501-CEFAFI    PIC X.                           *00198
      *> DATE DE CREATION (JJMMSSAA)                                    *00199
                11      H501-DTFACR    PIC X(8).                        *00199
      *> QUOTIENT ECHEANCES INDUIT PAR AV                               *00207
                11      H501-TXFDAV    PIC 9(2)V9(13).                  *00207
      *> Détail général - données COVID                                 *00222
               10       H501-H52D.                                      *00222
      *> IDENTIFIANT PERSONNE                                           *00222
                11      H501-IDFPPE    PIC X(9).                        *00222
      *> Code type d'acte                                               *00231
                11      H501-CDFATE    PIC X.                           *00231
      *> Détail général - Historique crédit 2                           *00232
               10       H501-H52E.                                      *00232
      *> MONTANT ARRIERES INCORPORES AU CRD                             *00232
                11      H501-MTFNAR    PIC S9(11)V99.                   *00232
      *> Code type échéance aménagée                                    *00245
                11      H501-CTFDAM    PIC X.                           *00245
      *> Code type calcul intérêts                                      *00246
                11      H501-CCFDIT    PIC X.                           *00246
      *> Détail général - Historique crédit 3                           *00247
               10       H501-H52F.                                      *00247
      *> MONTANT ECHEANCE M.E.R.                                        *00247
                11      H501-MTEHRC    PIC S9(11)V99.                   *00247
      *> MONTANT ECHEANCE M.E.R.                                        *00260
                11      H501-MTEHRD    PIC 9(11)V99.                    *00260
      *> Franchise mois= durée différé amort.                           *00273
                11      H501-NPRBFA    PIC 9(3).                        *00273
      *> MONTANT ECHEANCE M.E.R.                                        *00276
                11      H501-MTEHR3    PIC S9(11)V99.                   *00276
               10       H501-FILLER    PIC X(212).                      *00289
      *> Longueur de la structure : 00500 octets                        *00500
