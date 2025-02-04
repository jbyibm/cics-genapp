      *>****************************************************************ADADDATE
      *> Variable de traitements de Date et Heure.                      ADADDATE
      *CONTROL NOSOURCE                                                 ADADDATE
      *> Cette COPY doit être appelée en Working-Storage Section une    ADADDATE
      *> fois en cas de traitement de Dates ou Heures.                  ADADDATE
      *>----------------------------------------------------------------ADADDATE
      *> Paramètres obligatoires :                                      ADADDATE
      *> Néant.                                                         ADADDATE
      *>----------------------------------------------------------------ADADDATE
      *> Variables de compilation :                                     ADADDATE
      *> Néant.                                                         ADADDATE
      *>----------------------------------------------------------------ADADDATE
      *> Compatibilité Pacbase :                                        ADADDATE
      *> Les noms de certaines variables ne suivent pas le plan de      ADADDATE
      *> nommage de Pacbase. Les noms Pacbase sont indiqués en          ADADDATE
      *> commentaires flottant sur chaque variable.                     ADADDATE
      *> Si nécessaire, certains noms de variables peuvent être         ADADDATE
      *> modifiés lors de l'appel du COPYBOOK ADADDATE ; dans ce cas    ADADDATE
      *> les mêmes modifications doivent être appliquées à l'appel du   ADADDATE
      *> COPYBOOK de procédure AAAPDATE.                                ADADDATE
      *CONTROL SOURCE                                                   ADADDATE
      *>****************************************************************ADADDATE
      *>                                                                ADADDATE
      *> --- Variables compatibles Pacbase                              ADADDATE
      *>                                                                ADADDATE
      *> DATE DU JOUR COMPLETE                                          ADADDATE
       01               FULL-CURRENT-DATE.                              ADADDATE
      *> DATE DU JOUR                                                   ADADDATE
           05           DATCE.                                          ADADDATE
             10         CENTUR.                                         ADADDATE
               15       CC             PIC XX VALUE '20'.               ADADDATE
             10         DATOR.                                          ADADDATE
               15       DATOA.                                          ADADDATE
                 20     YY             PIC XX.                          ADADDATE
               15       DATOM.                                          ADADDATE
                 20     MM             PIC XX.                          ADADDATE
               15       DATOJ.                                          ADADDATE
                 20     DD             PIC XX.                          ADADDATE
      *> HEURE COURANTE HHMMSSCC                                        ADADDATE
           05           TIMCO.                                          ADADDATE
             10         TIMCOH.                                         ADADDATE
               15       HH             PIC XX.                          ADADDATE
             10         TIMCOM.                                         ADADDATE
               15       MM             PIC XX.                          ADADDATE
             10         TIMCOS.                                         ADADDATE
               15       SS             PIC XX.                          ADADDATE
             10         TIMOC.                                          ADADDATE
               15       TIMCOC.                                         ADADDATE
                 20     CC             PIC XX.                          ADADDATE
      *> TIME-ZONE                                                      ADADDATE
           05           TZ.                                             ADADDATE
             10         TZ-GMT         PIC X.                           ADADDATE
                    88  TZ-BEHIND-GMT  VALUE '-'.                       ADADDATE
                    88  TZ-AHEAD-GMT   VALUE '+'.                       ADADDATE
             10         TZ-HH          PIC XX.                          ADADDATE
             10         TZ-MM          PIC XX.                          ADADDATE
      *> HEURE FORMAT HH:MM:SS                                          ADADDATE
       01               TIMDAY.                                         ADADDATE
           05           TIMHOU.                                         ADADDATE
             10         HH             PIC XX.                          ADADDATE
           05           TIMS1.                                          ADADDATE
             10         S1             PIC X VALUE ':'.                 ADADDATE
           05           TIMMIN.                                         ADADDATE
             10         MM             PIC XX.                          ADADDATE
           05           TIMS2.                                          ADADDATE
             10         S2             PIC X VALUE ':'.                 ADADDATE
           05           TIMSEC.                                         ADADDATE
             10         SS             PIC XX.                          ADADDATE
      *> SEPARATEUR DATE PAR DEFAUT                                     ADADDATE
       01               DATSEP         PIC X VALUE '/'.                 ADADDATE
      *> SEPARATEUR DATE FORMAT G                                       ADADDATE
       01               DATSET         PIC X VALUE '-'.                 ADADDATE
      *> SEPARATEUR DATE DE TRAVAIL (non utilisé dans version COBOL)    ADADDATE
       01               DATSEW         PIC X.                           ADADDATE
      *> SEPARATEUR HEURE PAR DEFAUT                                    ADADDATE
       01               TIMSEP         PIC X VALUE ':'.                 ADADDATE
      *> NOMBRE DE JOURS DANS CALCULS SUR DATE                          ADADDATE
       01               NUM-DAYS       PIC S9(9).                       ADADDATE
      *>                                                                ADADDATE
      *> --- Variables de communication avec les routines               ADADDATE
      *>                                                                ADADDATE
      *> DATE FORMAT C : JJMMSSAA                                       ADADDATE
       01               5-DATE-C.                        *> DAT7C       ADADDATE
           05           DD             PIC XX.           *> DAT71C      ADADDATE
           05           MM             PIC XX.           *> DAT72C      ADADDATE
           05           YYYY.                                           ADADDATE
             10         CC             PIC XX.           *> DAT73C      ADADDATE
             10         YY             PIC XX.           *> DAT74C      ADADDATE
      *> DATE FORMAT D : JJMMAA                                         ADADDATE
       01               5-DATE-D.                        *> DAT7        ADADDATE
           05           DD             PIC XX.           *> DAT71       ADADDATE
           05           MM             PIC XX.           *> DAT72       ADADDATE
           05           YY             PIC XX.           *> DAT73       ADADDATE
      *> DATE FORMAT E : JJ/MM/AA                                       ADADDATE
       01               5-DATE-E.                        *> DAT8        ADADDATE
           05           DD             PIC XX.           *> DAT81       ADADDATE
           05           S1             PIC X.            *> DAT8S1      ADADDATE
           05           MM             PIC XX.           *> DAT82       ADADDATE
           05           S2             PIC X.            *> DAT8S2      ADADDATE
           05           YY             PIC XX.           *> DAT83       ADADDATE
      *> DATE FORMAT G : SSAA-MM-JJ                                     ADADDATE
       01               5-DATE-G.                        *> DAT8G       ADADDATE
           05           YYYY.                                           ADADDATE
             10         CC             PIC XX.           *> DAT81G      ADADDATE
             10         YY             PIC XX.           *> DAT82G      ADADDATE
           05           S1             PIC X VALUE '-'.  *> DAT8S1G     ADADDATE
           05           MM             PIC XX.           *> DAT83G      ADADDATE
           05           S2             PIC X VALUE '-'.  *> DATS2G      ADADDATE
           05           DD             PIC XX.           *> DAT84G      ADADDATE
      *> DATE FORMAT I : AAMMJJ                                         ADADDATE
       01               5-DATE-I.                        *> DAT6        ADADDATE
           05           YY             PIC XX.           *> DAT61       ADADDATE
           05           MM             PIC XX.           *> DAT62       ADADDATE
           05           DD             PIC XX.           *> DAT63       ADADDATE
      *> DATE FORMAT M : JJ/MM/SSAA                                     ADADDATE
       01               5-DATE-M.                        *> DAT8C       ADADDATE
           05           DD             PIC XX.           *> DAT81C      ADADDATE
           05           S1             PIC X VALUE '/'.  *> DATS1C      ADADDATE
           05           MM             PIC XX.           *> DAT82C      ADADDATE
           05           S2             PIC X VALUE '/'.  *> DATS2C      ADADDATE
           05           YYYY.                            *> DAT83C      ADADDATE
             10         CC             PIC XX.           *> DAT83CC     ADADDATE
             10         YY             PIC XX.           *> DAT84C      ADADDATE
      *> DATE FORMAT S : SSAAMMJJ                                       ADADDATE
       01               5-DATE-S.                        *> DAT6C       ADADDATE
           05           YYYY.                                           ADADDATE
             10         CC.                              *> DAT61C      ADADDATE
               15       CC9            PIC 99.                          ADADDATE
             10         YY.                              *> DAT62C      ADADDATE
               15       YY9            PIC 99.                          ADADDATE
           05           MM             PIC XX.           *> DAT63CC     ADADDATE
           05           DD             PIC XX.           *> DAT64C      ADADDATE
      *> HEURE FORMAT HHMMSS                                            ADADDATE
       01               5-TIME.                                         ADADDATE
           05           HH             PIC X(2).                        ADADDATE
           05           MM             PIC X(2).                        ADADDATE
           05           SS             PIC X(2).                        ADADDATE
      *> FENETRAGE DU SIECLE                                            ADADDATE
       01               5-DATE-PIVOT   PIC XX VALUE '61'. *> DAT-CTYT   ADADDATE
       01               5-DATE-SIECLE  PIC XX VALUE '19'. *> DAT-CTY    ADADDATE
       01               5-DATE-ADO     PIC X VALUE SPACE. *> DAT-ADO    ADADDATE
                    88  5-DATE-SIECLE-DEF    VALUE '0'.                 ADADDATE
                    88  5-DATE-1900-AVANT    VALUE '1'.                 ADADDATE
                    88  5-DATE-2000-AVANT    VALUE '2'.                 ADADDATE
      *> DATES FORMAT SSAAMMJJ POUR CALCULS                             ADADDATE
       01               5-DATE-D1      PIC 9(8).         *> DATE81      ADADDATE
       01               5-DATE-D2      PIC 9(8).         *> DATE82      ADADDATE
      *> HEURES FORMAT HHMMSS POUR CALCULS                              ADADDATE
       01               5-TIME-T1      PIC X(6).                        ADADDATE
       01               5-TIME-T2      PIC X(6).                        ADADDATE
       01               NUM-SECS       PIC S9(9) COMP-5.                ADADDATE
       01                              PIC X.                           ADADDATE
                    88  5-TIME-MEME-JOUR     VALUE '0'.                 ADADDATE
                    88  5-TIME-LA-VEILLE     VALUE '1'.                 ADADDATE
                    88  5-TIME-LENDEMAIN     VALUE '2'.                 ADADDATE
       >>if AA-G-CICS                                                   ADADDATE
      *> DATE ABSTIME POUR CICS                                         ADADDATE
       01               5-CICS-ABSTIME PIC S9(15) PACKED-DECIMAL.       ADADDATE
       >>end-if                                                         ADADDATE
      *>                                                                ADADDATE
      *> --- Variables de travail internes (ne pas utiliser)            ADADDATE
      *>                                                                ADADDATE
      *> CALCUL ANNEE BISSECTILE                                        ADADDATE
       01               5-DATE-M4     PIC 99 BINARY.     *> LEAP-REM    ADADDATE
       >>if not AA-G-VARPACBASE                                         ADADDATE
      *> INDICATEUR DATE VALIDE                                         ADADDATE
       01                             PIC X.             *> EN-PRE      ADADDATE
                    88  5-DATE-VALIDE       VALUE '1'.                  ADADDATE
                    88  5-DATE-INVALIDE     VALUE '5'.                  ADADDATE
       >>end-if                                                         ADADDATE
      *> INDICATEUR HEURE VALIDE                                        ADADDATE
       01                             PIC X.                            ADADDATE
                    88  5-TIME-VALIDE       VALUE '1'.                  ADADDATE
                    88  5-TIME-INVALIDE     VALUE '5'.                  ADADDATE
       >>if AA-G-PACBASE                                                ADADDATE
           copy ADAD9520.                                               ADADDATE
       >>end-if                                                         ADADDATE
