      *>****************************************************************DCZDSR
      *> FICHIER : COMMAREA Lec seg risque SASR                         DCZDSR
      *>----------------------------------------------------------------DCZDSR
      *CONTROL NOSOURCE                                                 DCZDSR
      *> Description d'un segment commarea                              DCZDSR
      *>                                                                DCZDSR
      *> Créateur         :  S.Bousquet-V                               DCZDSR
      *> Date de création :  29/09/04                                   DCZDSR
      *> Longueur enreg.  :                                             DCZDSR
      *>                                                                DCZDSR
      *> Description :                                                  DCZDSR
      *> -------------                                                  DCZDSR
      *> Auteur           :  S.Bousquet-V                               DCZDSR
      *> Date de Création :  29/09/04                                   DCZDSR
      *> Origine Création :                                             DCZDSR
      *>                                                                DCZDSR
      *> Cette zone fait le lien avec le sous programme de lecture      DCZDSR
      *> du segment risque DCSR30.                                      DCZDSR
      *> Cette lecture peut concerner une personne ou une ET.           DCZDSR
      *> Pour une ET, le segment retour sera alimenté avec un seul      DCZDSR
      *> segment risque, pour une personne on peut avoir en             DCZDSR
      *> retour un ou deux segments risque (cas des Pro-EI).            DCZDSR
      *> Remonté le 24/05/05 par Michel BOYRIE (J060098).               DCZDSR
      *>----------------------------------------------------------------DCZDSR
      *> MOT CLES :                                                     DCZDSR
      *> BALE2V2 SASR DCSR30                                            DCZDSR
      *>----------------------------------------------------------------DCZDSR
      *CONTROL SOURCE                                                   DCZDSR
      *> Utilisation :                                                  DCZDSR
      *> copy DCZDSR30 replacing leading ==ZD1R== by ==prefix==.        DCZDSR
      *>****************************************************************DCZDSR
      *> -- 10/05/2024 16:36:43 BIB:DCP SESSION:9461  USER:USER         DCZDSR
      *>----------------------------------------------------------------DCZDSR
      *> COMMAREA Lec seg risque SASR                                   DCZDSR
       01               ZD1R.                                           DCZDSR
      *> Code Etablissement entité juridique                            *00001
               10       ZD1R-CODXET    PIC X(5).                        *00001
      *> Identifiant personne                                           *00006
               10       ZD1R-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00006
      *> Numéro entité titulaire                                        *00011
               10       ZD1R-NODIET    PIC S9(10) PACKED-DECIMAL.       *00011
               10       ZD1R-FILLER    PIC X(16).                       *00017
      *> Code erreur                                                    *00033
               10       ZD1R-WCOREX    PIC X(3).                        *00033
      *> Rubrique groupe segment risque                                 *00036
               10       ZD1R-GRDLSR    OCCURS 002.                      *00036
      *> Type segment risques / categ client                            *00036
                11      ZD1R-CTMBSR    PIC X(2).                        *00036
      *> Code segment risques / categ client                            *00040
                11      ZD1R-CDMBSR    PIC X(8).                        *00040
               10       ZD1R-FILLER    PIC X(27).                       *00056
      *> Longueur de la structure : 00082 octets                        *00082
