      *>****************************************************************M5VES197
      *> WORKING : Q Création/MAJ Forbearance Viabilité                 M5VES197
      *>----------------------------------------------------------------M5VES197
      *CONTROL NOSOURCE                                                 M5VES197
      *> Auteur           :  Muriel DI GIANNI                           M5VES197
      *> Date de Création :  03/10/23                                   M5VES197
      *> Origine Création :  PR005967 Forbearance PROF                  M5VES197
      *>                                                                M5VES197
      *> Cette question permet de créer la viabilité de l'étape         M5VES197
      *> de la Forbearance                                              M5VES197
      *>                                                                M5VES197
      *>----------------------------------------------------------------M5VES197
      *> MOT CLES :                                                     M5VES197
      *> QST M-5 QM5S197 M175S00 M5QS M175T00 M5QT M175U00 M5QU         M5VES197
      *>----------------------------------------------------------------M5VES197
      *CONTROL SOURCE                                                   M5VES197
      *> Utilisation :                                                  M5VES197
      *> copy M5VES197 replacing leading ==S197== by ==prefix==.        M5VES197
      *>****************************************************************M5VES197
      *>#GN 17/07/2024 09:07:14 BIB:CTRS.M5B SESSION:9584  USER:USER    M5VES197
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:S100 ---M5VES197
      *> QR Partie commune niveau Application                           M5VES197
       01               S100.                                           M5VES197
      *> QR ADT Standard Inter-Domaine                                  *00001
               10       S100-SA00.                                      *00001
      *> QR Longueur Segment Question/Réponse                           *00001
                11      S100-WLGQR     PIC 9(4)                         *00001
                                       VALUE ZERO.                      *00001
      *> LONGUEUR FLUX                                                  *00001
                11      S100-XZ3LNG    REDEFINES S100-WLGQR             *00001
                                       PIC 9(4).                        *00001
      *> QR Code Segment Question/Réponse                               *00005
                11      S100-WLNQR.                                     *00005
      *> QR Type de Segment ECHANGES                                    *00005
                 12     S100-CTSEQR    PIC X                            *00005
                                       VALUE SPACE.                     *00005
      *> QR Code Structure Question/Réponse                             *00006
                 12     S100-WLNQR6    PIC X(6)                         *00006
                                       VALUE SPACE.                     *00006
      *> QR Nature d'un Segment ECHANGES                                *00012
                 12     S100-CNSEQR    PIC X                            *00012
                                       VALUE SPACE.                     *00012
      *> CODE STRUCTURE DONNEES                                         *00005
                11      S100-XZ3SGE    REDEFINES S100-WLNQR             *00005
                                       PIC X(8).                        *00005
      *> Longueur de la structure : 00012 octets                        *00012
      *>--- ID='M5S197' ---------------------------------- #SEG:S197 ---M5VES197
      *> Q Création/MAJ Forbearance Viabilité                           M5VES197
       01               S197.                                           M5VES197
      *> Indicateur statut viabilité                                    *00001
               10       S197-CIM5VI    PIC X(1)                         *00001
                                       VALUE SPACE.                     *00001
      *> Date début statut viabilité (SSAAMMJJ)                         *00002
               10       S197-DDM5VI    PIC X(8)                         *00002
                                       VALUE SPACE.                     *00002
      *> Commentaire viabilité IHM                                      *00010
               10       S197-LRM5VI    PIC X(254)                       *00010
                                       VALUE SPACE.                     *00010
      *> Type opérateur                                                 *00264
               10       S197-CTM5OP    PIC X(2)                         *00264
                                       VALUE SPACE.                     *00264
      *> Référence externe agent                                        *00266
               10       S197-NOCEAG    PIC 9(7)                         *00266
                                       VALUE ZERO.                      *00266
      *> Longueur de la structure : 00272 octets                        *00272
