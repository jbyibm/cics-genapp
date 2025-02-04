      *>****************************************************************HMFIIM1W
      *> FICHIER : Données EVENEMENTS DEFAUT SEQUANA                    HMFIIM1W
      *>----------------------------------------------------------------HMFIIM1W
      *CONTROL NOSOURCE                                                 HMFIIM1W
      *> Auteur           :  François ARTUSO                            HMFIIM1W
      *> Date de Création :  16/06/10                                   HMFIIM1W
      *> Origine Création :  projet 4345 : Base Evènements - induits    HMFIIM1W
      *>                     Bâle2                                      HMFIIM1W
      *>                                                                HMFIIM1W
      *> Modifié par :       François ARTUSO                            HMFIIM1W
      *> Modifié le  :       20/07/10                                   HMFIIM1W
      *> Motif de Modif. :   projet 4345 : Base Evènements - induits    HMFIIM1W
      *>                     Bâle2_- ajout rubrique DAMRTR              HMFIIM1W
      *>                                                                HMFIIM1W
      *> Modifié par :       François ARTUSO                            HMFIIM1W
      *> Modifié le  :       21/07/10                                   HMFIIM1W
      *> Motif de Modif. :   projet 4345 : Base Evènements - induits    HMFIIM1W
      *>                     Bâle2_- ajout rubrique CDMBSR              HMFIIM1W
      *> Modifié par :       François ARTUSO                            HMFIIM1W
      *> Modifié le  :       13/08/10                                   HMFIIM1W
      *> Motif de Modif. :   projet 4345 : Base Evènements - induits    HMFIIM1W
      *>                     Bâle2_- ajout rubriques                    HMFIIM1W
      *> Modifié par :       Mc Lainé _F Artuso                         HMFIIM1W
      *> Modifié le  :       18/08/10                                   HMFIIM1W
      *> Motif de Modif. :   travaux notation Bâle 2 BPCE               HMFIIM1W
      *>                     ajout CIMRSU en fin de segment             HMFIIM1W
      *> Notation moteur BP des clients PART et PRO du GCE.             HMFIIM1W
      *> Fichier des Evènements Client SEQUANA destiné à la             HMFIIM1W
      *> constitution du flux unique.                                   HMFIIM1W
      *> Description des données élémentaires de l'ensemble des         HMFIIM1W
      *> évènements de défaut du client.                                HMFIIM1W
      *> Modifié par :       herraud Vilain                             HMFIIM1W
      *> Modifié le  :       08/07/11                                   HMFIIM1W
      *> Motif de Modif. :   projet 8714 NIE                            HMFIIM1W
      *>                     ajout rubrique                             HMFIIM1W
      *> Remonté le 26/07/10 par Michel HERRAUD (J060168).              HMFIIM1W
      *> Modifié par :       JM BRETON                                  HMFIIM1W
      *> Modifié le  :       19/07/11                                   HMFIIM1W
      *> Motif de Modif. :   Ajout de COMREV                            HMFIIM1W
      *>                                                                HMFIIM1W
      *> Modifié par :       BRETON / LESTRADE                          HMFIIM1W
      *> Modifié le  :       24/06/13                                   HMFIIM1W
      *> Motif de Modif. :   Ajout de IDMREO et CIM3TA                  HMFIIM1W
      *>                                                                HMFIIM1W
      *> Modifié par :       herraud Vouaux                             HMFIIM1W
      *> Modifié le  :       14/02/14                                   HMFIIM1W
      *> Motif de Modif. :   P011157 lot 2 (SPLS),                      HMFIIM1W
      *>                     retour arriere du 24/6/2013                HMFIIM1W
      *> Modifié par :       QUENON DI GIANNI                           HMFIIM1W
      *> Modifié le  :       15/04/22                                   HMFIIM1W
      *> Motif de Modif. :   RefDoIT 11260 - 026818 FCR-NED-Nouveau-    HMFIIM1W
      *>                     défaut - ajout IRMRRP + revision du        HMFIIM1W
      *>                     filler                                     HMFIIM1W
      *>----------------------------------------------------------------HMFIIM1W
      *> MOT CLES :                                                     HMFIIM1W
      *> NOC BPCE                                                       HMFIIM1W
      *>----------------------------------------------------------------HMFIIM1W
      *CONTROL SOURCE                                                   HMFIIM1W
      *> Utilisation :                                                  HMFIIM1W
      *> copy MHFIIM1W replacing leading ==IM1W== by ==prefix==.        HMFIIM1W
      *>****************************************************************HMFIIM1W
      *>#GN 30/08/2024 12:02:48 BIB:CTRS.MRB SESSION:9664  USER:USER    HMFIIM1W
      *>-------------------------------------------------- #SEG:IM1W ---HMFIIM1W
      *> Données EVENEMENTS DEFAUT SEQUANA                              HMFIIM1W
       01               IM1W.                                           HMFIIM1W
      *> En-tête fichier données SEQUANA                                *00001
               10       IM1W-IM5B.                                      *00001
      *> Nombre enregistrements                                         *00001
                11      IM1W-WQCEN2    PIC 9(10).                       *00001
      *> Code application émettrice                                     *00011
                11      IM1W-CODMAP    PIC X(10).                       *00011
      *> Code Etab Banque Entité Juridique                              *00021
                11      IM1W-COCXBQ    PIC X(5).                        *00021
      *> Code Guichet Interbancaire                                     *00026
                11      IM1W-COCXGU    PIC X(5).                        *00026
      *> Code type produit service                                      *00031
                11      IM1W-CODIPR    PIC X(4).                        *00031
      *> Référence produit / service                                    *00035
                11      IM1W-CODIRF    PIC X(11).                       *00035
      *> Identifiant Entité Titulaire                                   *00046
                11      IM1W-IDDIET    PIC X(11).                       *00046
      *> Identifiant Personne                                           *00057
                11      IM1W-IDMBPA    PIC X(9).                        *00057
      *> Date arrêté (SSAA-MM-JJ)                                       *00066
                11      IM1W-DAMBAR    PIC X(10).                       *00066
      *> Nom fichier                                                    *00076
                11      IM1W-WLNFIC    PIC X(24).                       *00076
      *> Alphanumérique Banalisée 053                                   *00100
                11      IM1W-WX053     PIC X(53).                       *00100
               10       IM1W-FILLER    PIC X(150).                      *00153
      *> Identifiant événement défaut                                   *00303
               10       IM1W-IDMREV    PIC X(25).                       *00303
      *> Code type incident                                             *00328
               10       IM1W-CTMIIN    PIC X(2).                        *00328
      *> Date début incident (SSAA-MM-JJ)                               *00330
               10       IM1W-DDMRIN    PIC X(10).                       *00330
      *> Date fin incident (SSAA-MM-JJ)                                 *00340
               10       IM1W-DFMRIN    PIC X(10).                       *00340
      *> Code statut incident                                           *00350
               10       IM1W-CEMIIN    PIC X(1).                        *00350
      *> Code évènement défaut                                          *00351
               10       IM1W-CTMREV    PIC X(3).                        *00351
      *> Date début événement défaut (SSAA-MM-JJ)                       *00354
               10       IM1W-DDMREV    PIC X(10).                       *00354
      *> Date clôture événement défaut (SSAA-MM-JJ)                     *00364
               10       IM1W-DFMREV    PIC X(10).                       *00364
      *> Date début statut évènement défaut (SSAA-MM-JJ)                *00374
               10       IM1W-DDMRST    PIC X(10).                       *00374
      *> Date prévis fin période probatoire (SSAA-MM-JJ)                *00384
               10       IM1W-DFMRP1    PIC X(10).                       *00384
      *> Code statut actuel événement défaut                            *00394
               10       IM1W-CEMREV    PIC X(3).                        *00394
      *> Code type événement défaut                                     *00397
               10       IM1W-CVMREV    PIC X(1).                        *00397
      *> Date traitement OPC (SSAA-MM-JJ)                               *00398
               10       IM1W-DAMRTR    PIC X(10).                       *00398
      *> Indicateur suspension évènement                                *00408
               10       IM1W-CIMRSU    PIC X(1).                        *00408
      *> Lib motif événement de défaut                                  *00409
               10       IM1W-LMM3EV    PIC X(200).                      *00409
      *> Code état evt défaut NIE Base evt                              *00609
               10       IM1W-COMREV    PIC X(3).                        *00609
      *> Référence contrat partenaire                                   *00612
               10       IM1W-IRMRRP    PIC X(50).                       *00612
               10       IM1W-FILLER    PIC X(039).                      *00662
      *> Longueur de la structure : 00700 octets                        *00700
