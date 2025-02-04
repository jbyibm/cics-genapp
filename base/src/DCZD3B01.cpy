      *>****************************************************************DCZD3B01
      *> WORKING : Commarea désignation ET                              DCZD3B01
      *>----------------------------------------------------------------DCZD3B01
      *CONTROL NOSOURCE                                                 DCZD3B01
      *> Description d'un segment commarea                              DCZD3B01
      *>                                                                DCZD3B01
      *> Créateur         :  B. POUPARD                                 DCZD3B01
      *> Date de création :  07/06/94                                   DCZD3B01
      *> Longueur enreg.  :  0192                                       DCZD3B01
      *>                                                                DCZD3B01
      *> Description :                                                  DCZD3B01
      *> -------------                                                  DCZD3B01
      *> - commarea du sous-programme DC3B01 -                          DCZD3B01
      *> à partir d'un N° d'ET ou d'un RICE rattaché à l'ET             DCZD3B01
      *> renvoie des infos diverses (code usage, code état,             DCZD3B01
      *> désignation bancaire courte, etc.)                             DCZD3B01
      *> valeurs prises par WCORE3 :                                    DCZD3B01
      *> - 000 - la requête a normalement abouti                        DCZD3B01
      *> - 001 - non trouvé sqlcode = 100                               DCZD3B01
      *> - 003 - problème DB2 erreur grave                              DCZD3B01
      *> Modifié par :       JM BRETON                                  DCZD3B01
      *> Modifié le  :       04/04/11                                   DCZD3B01
      *> Motif de Modif. :   Modification pour le projet 8123(EIRL      DCZD3B01
      *>                     lot1). AJOUT NODAP2 et NODAPS qui          DCZD3B01
      *>                     corespondent au professionnel du           DCZD3B01
      *>                     client bancaire.                           DCZD3B01
      *> ************************************************************   DCZD3B01
      *> Modifié par :       BRETON / MARCHESINI                        DCZD3B01
      *> Modifié le  :       24/10/12                                   DCZD3B01
      *> Motif de Modif. :   Ajout CODAPJ                               DCZD3B01
      *>                                                                DCZD3B01
      *> ATTENTION : SEGMENT A UTILISER EN FORMAT D'ENTREE              DCZD3B01
      *> Ajout de CIDIED demandé par C.Delberghe le 15/03/96.           DCZD3B01
      *>----------------------------------------------------------------DCZD3B01
      *> MOT CLES :                                                     DCZD3B01
      *>                                                                DCZD3B01
      *>----------------------------------------------------------------DCZD3B01
      *CONTROL SOURCE                                                   DCZD3B01
      *> Utilisation :                                                  DCZD3B01
      *> copy DCZD3B01 replacing leading ==3B01== by ==prefix==.        DCZD3B01
      *>****************************************************************DCZD3B01
      *>#GN 05/11/2024 13:21:27 BIB:CTRS.DCP SESSION:5550  USER:USER    DCZD3B01
      *>-------------------------------------------------- #SEG:ZD74 ---DCZD3B01
      *> Commarea désignation ET                                        DCZD3B01
       01               3B01.                                           DCZD3B01
      *> Code Etab Banque Entité Juridique                              *00001
               10       3B01-COCXBQ    PIC X(5).                        *00001
      *> Code Guichet Interbancaire                                     *00006
               10       3B01-COCXGU    PIC X(5).                        *00006
      *> Code type produit service                                      *00011
               10       3B01-CODIPR    PIC X(4).                        *00011
      *> Numéro compte P/S                                              *00015
               10       3B01-NOGXCP    PIC X(11).                       *00015
      *> Numéro entité titulaire                                        *00026
               10       3B01-NODIET    PIC 9(10).                       *00026
      *> Code fonction                                                  *00036
               10       3B01-COSFFC    PIC X.                           *00036
               10       3B01-FILLER    PIC X(19).                       *00037
      *> Code type usage entité titulaire                               *00056
               10       3B01-CODIUS    PIC X.                           *00056
      *> Mode composition entité titulaire                              *00057
               10       3B01-CODIMC    PIC X.                           *00057
      *> Code état personne/entité titulaire                            *00058
               10       3B01-CODAET    PIC X.                           *00058
      *> Code motif clôture pers / ent-tit                              *00059
               10       3B01-CODACL    PIC X.                           *00059
      *> Date fermeture entité titulaire (JJMMSSAA)                     *00060
               10       3B01-DIDAFE    PIC X(8).                        *00060
      *> Date enregistrement entité titulaire (JJMMSSAA)                *00068
               10       3B01-DADICR    PIC X(8).                        *00068
      *> Désignation bancaire courte                                    *00076
               10       3B01-LIDICD    PIC X(32).                       *00076
      *> Code retour Echanges                                           *00108
               10       3B01-WCORE3    PIC 9(3).                        *00108
      *> Libellé erreur 30C                                             *00111
               10       3B01-WLE30     PIC X(30).                       *00111
      *> Identifiant élément structure                                  *00141
               10       3B01-NOCEE1    PIC 9(7).                        *00141
      *> Identifiant Elément structure                                  *00148
               10       3B01-NOCEEL    PIC 9(7).                        *00148
      *> Indicateur entité titulaire douteuse                           *00155
               10       3B01-CIDIED    PIC 9.                           *00155
      *> Identifiant personne                                           *00156
               10       3B01-NODAPE    PIC 9(9).                        *00156
      *> Deuxième personne en relation                                  *00165
               10       3B01-NODAP2    PIC 9(9).                        *00165
      *> Numéro chrono professionnel                                    *00174
               10       3B01-NODAPS    PIC 9(2).                        *00174
      *> Code personnalité juridique                                    *00176
               10       3B01-CODAPJ    PIC X.                           *00176
               10       3B01-FILLER    PIC X(09).                       *00177
      *> Longueur de la structure : 00185 octets                        *00185
