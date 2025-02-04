      *>****************************************************************DCZD3V
      *> WORKING : Personnes d'une entité titulaire                     DCZD3V
      *>----------------------------------------------------------------DCZD3V
      *CONTROL NOSOURCE                                                 DCZD3V
      *>----------------------------------------------------------------DCZD3V
      *> MOT CLES :                                                     DCZD3V
      *>                                                                DCZD3V
      *>----------------------------------------------------------------DCZD3V
      *CONTROL SOURCE                                                   DCZD3V
      *> Utilisation :                                                  DCZD3V
      *> copy DCZD3V02 replacing leading ==ZD61== by ==prefix==.        DCZD3V
      *>****************************************************************DCZD3V
      *> -- 24/05/2024 10:42:49 BIB:DCP SESSION:9488  USER:USER         DCZD3V
      *>----------------------------------------------------------------DCZD3V
      *> Personnes d'une entité titulaire                               DCZD3V
       01               ZD61.                                           DCZD3V
      *> Code fonction                                                  *00001
               10       ZD61-WCODF     PIC X.                           *00001
      *> Code retour                                                    *00002
               10       ZD61-WCORE2    PIC 9(2).                        *00002
      *> Numéro entité titulaire                                        *00004
               10       ZD61-NODIET    PIC S9(10) PACKED-DECIMAL.       *00004
      *> Libelle Message Erreur sur 80 car.                             *00010
               10       ZD61-WLE80     PIC X(80).                       *00010
      *> Nombre occurrences                                             *00090
               10       ZD61-WCPTOC    PIC S9(4) BINARY.                *00090
      *> Identifiant personne                                           *00092
               10       ZD61-NODAPE    PIC S9(9) PACKED-DECIMAL         *00092
                                       OCCURS 100.                      *00092
               10       ZD61-FILLER    PIC X(30).                       *00592
      *> Longueur de la structure : 00621 octets                        *00621
