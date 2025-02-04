      *CONTROL NOSOURCE                                                 AEZDECHG
      *>****************************************************************AEZDECHG
      *>   DESCRIPTION DE LA ZONE DE COMMUNICATION MIDDLEWARE ECHANGES  AEZDECHG
      *>                                                                AEZDECHG
      *>   La zone de communication Middleware Echanges contient les    AEZDECHG
      *>   informations d'une conversation entre un programme appelant  AEZDECHG
      *>   et un programme appelé.                                      AEZDECHG
      *>   Les Messages sont communiquées au travers de pointeurs.      AEZDECHG
      *>   L'appelant passe un pointeur sur le Message envoyé.          AEZDECHG
      *>   L'appelé doit faire correspondre une zone de Linkage avec le AEZDECHG
      *>   pointeur sur le Message reçu.                                AEZDECHG
      *>   Il ne faut JAMAIS modifié le contenu d'un Message reçu sous  AEZDECHG
      *>   peine de déclencher un écrasement mémoire (storage           AEZDECHG
      *>   violation) dans CICS avec diverses conséquences pouvant      AEZDECHG
      *>   aller jusqu'à l'arrêt complet du CICS.                       AEZDECHG
      *-----------------------------------------------------------------AEZDECHG
      *> Utilisation :                                                  AEZDECHG
      *> COPY AEZDECHG REPLACING LEADING ==ZECH== BY ==prefix==.        AEZDECHG
      *>****************************************************************AEZDECHG
      *CONTROL SOURCE                                                   AEZDECHG
      *> QR Commarea Client                                             AEZDECHG
       01               ZECH.                                           AEZDECHG
      *> Identification / code transaction de la Q/R (obsolète)         AEZDECHG
               10       ZECH-FILLER    PIC X(4).                        *00001
      *> Pointeur sur segment Question                                  *00005
               10       ZECH-ZCPTSQ    POINTER.                         *00005
      *> Pointeur sur segment Réponse                                   *00009
               10       ZECH-ZCPTSR    POINTER.                         *00009
      *> Nombre de segments Question                                    *00013
               10       ZECH-ZCNBSQ    PIC S9(4) BINARY.                *00013
      *> Nombre de segments Réponse                                     *00015
               10       ZECH-ZCNBSR    PIC S9(4) BINARY.                *00015
      *> Code retour après action                                       *00017
               10       ZECH-ZCRC      PIC 9(3).                        *00017
      *> - OK                                                           *00017
                    88  ZECH-ZCRC-OK            VALUE 000.              *00017
      *> - Fin de lecture Message                                       *00017
                    88  ZECH-ZCRC-EOQ           VALUE 100.              *00017
      *> - Fin de lecture Message déjà atteinte                         *00017
                    88  ZECH-ZCRC-IL            VALUE 101.              *00017
      *> - Erreur : Q/R non opérationelle, serveur inactif              *00017
                    88  ZECH-ZCRC-ERR           VALUE 500.              *00017
      *> Identification Q/R (QID)                                       *00020
               10       ZECH-ZCCREQ    PIC X(8).                        *00020
      *> Zones techniques fonctionnement interne                        *00028
               10       ZECH-ZCINTERNAL.                                *00028
      *> Serveur Logique émetteur                                       *00028
                11      ZECH-ZCSLE     PIC X(8).                        *00028
      *> Serveur Logique récepteur                                      *00036
                11      ZECH-ZCSLR     PIC X(8).                        *00036
      *> Zones réservées au middleware Echanges                         *00044
                11      ZECH-ZCECH.                                     *00044
      *> Identifiant de la couche de communication                      *00044
                 12     ZECH-ZCMARQ    PIC X(8).                        *00044
      *> Indicateur de l'origine de l'appel                             *00052
                 12     ZECH-ZCIND     PIC X(1).                        *00052
      *> - Appel par ACS                                                *00052
                    88  ZECH-ZCIND-ACS          VALUE x'01'.            *00052
      *> - Appel par ACP                                                *00052
                    88  ZECH-ZCIND-ACP          VALUE x'02'.            *00052
      *> - Appel par MLSR                                               *00052
                    88  ZECH-ZCIND-MLSR         VALUE x'03'.            *00052
      *> Indicateur fin de lecture                                      *00053
                 12     ZECH-ZCQRIND   PIC X(1).                        *00053
                    88  ZECH-ZCINDD             VALUE x'00'.            *00053
      *> - Tous les Messages ont été lus                                *00053
                    88  ZECH-ZCINDF             VALUE x'FF'.            *00053
      *>                                                                *00054
                 12     ZECH-FILLER    PIC X(3).                        *00054
      *> Adresse unique Message                                         *00057
                 12     ZECH-ZCQRSEG   POINTER.                         *00057
      *> Identification de la QUEUE TS des Messges                      *00061
                 12     ZECH-ZCQTSID   PIC X(8).                        *00061
      *> Rang du Message à écrire dans la TS (Réponse)                  *00069
                 12     ZECH-ZCQNBC    PIC 9(4) COMP-5.                 *00069
      *> Rang du Message à écrire dans la TS (Réponse)                  *00071
                 12     ZECH-ZCRNBC    PIC 9(4) COMP-5.                 *00071
      *> Rang du Message courant (Question)                             *00073
                 12     ZECH-ZCQNB1    PIC 9(4) COMP-5.                 *00073
      *> Rang du Message courant (Réponse)                              *00075
                 12     ZECH-ZCRNB1    PIC 9(4) COMP-5.                 *00075
      *> Sysid origine                                                  *00077
                11      ZECH-ZCSYSO    PIC X(4).                        *00077
      *> Terminal d'origine                                             *00081
                11      ZECH-ZCTERMO   PIC X(4).                        *00081
      *> Numéro de tâche d'origine                                      *00085
                11      ZECH-ZCTSKO    PIC S9(7) PACKED-DECIMAL.        *00085
      *> Transaction d'origine                                          *00089
                11      ZECH-ZCTRNO    PIC X(4).                        *00089
      *> Userid d'origine                                               *00093
                11      ZECH-ZSCUSRO   PIC X(8).                        *00093
      *> Sysid backend                                                  *00101
                11      ZECH-ZCSYSB    PIC X(4).                        *00101
      *> Point de synchro backend                                       *00105
                11      ZECH-ZCSYNC    PIC X(1).                        *00105
      *> Code transaction I.S.L. (pour backend)                         *00106
                11      ZECH-ZCTRAN    PIC X(8).                        *00106
      *> Type d'Echange en cours                                        *00114
                11      ZECH-ZCTECH    PIC X(1).                        *00114
      *> Code abend (inutilisé)                                         *00115
                11      ZECH-ZCABCOD   PIC X(4).                        *00115
      *> Indicateur asynchrone                                          *00119
                11      ZECH-ZCASYN    PIC X(1).                        *00119
      *> Indicateur 7x24                                                *00120
                11      ZECH-ZCI724    PIC X(1).                        *00120
      *> Indicateur type asynchrone (T=TP B=batch)                      *00121
                11      ZECH-ZCTASY    PIC X(1).                        *00121
      *> Filler                                                         *00122
                11      ZECH-FILLER    PIC X(7).                        *00122
