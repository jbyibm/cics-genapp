      *CONTROL NOSOURCE                                                 ADAD9520
      *>****************************************************************ADAD9520
      *> Variable de travail de traitements de Date et Heure au         ADAD9520
      *> standard Pacbase.                                              ADAD9520
      *> Cette COPY doit être appelée en Working-Storage Section une    ADAD9520
      *> fois en cas de traitement de Dates ou Heures par PERFORM       ADAD9520
      *> F9520.                                                         ADAD9520
      *>****************************************************************ADAD9520
      *CONTROL SOURCE                                                   ADAD9520
       01               DAT6.                                           ADAD9520
             10         DAT61.                                          ADAD9520
               15       DAT619         PIC 99.                          ADAD9520
             10         DAT62.                                          ADAD9520
               15       DAT629         PIC 99.                          ADAD9520
             10         DAT63          PIC XX.                          ADAD9520
       01               DAT8.                                           ADAD9520
             10         DAT81          PIC XX.                          ADAD9520
             10         DAT8S1         PIC X.                           ADAD9520
             10         DAT82          PIC XX.                          ADAD9520
             10         DAT8S2         PIC X.                           ADAD9520
             10         DAT83          PIC XX.                          ADAD9520
       01               DAT8E          REDEFINES DAT8.                  ADAD9520
             10         DAT81E         PIC X(4).                        ADAD9520
             10         DAT82E         PIC XX.                          ADAD9520
             10         DAT83E         PIC XX.                          ADAD9520
       01               DAT6C.                                          ADAD9520
             10         DAT61C         PIC XX.                          ADAD9520
             10         DAT62C         PIC XX.                          ADAD9520
             10         DAT63C.                                         ADAD9520
               15       DAT63CC        PIC XX.                          ADAD9520
               15       DAT64C         PIC XX.                          ADAD9520
       01               DAT8C.                                          ADAD9520
             10         DAT81C         PIC XX.                          ADAD9520
             10         DAT8S1C        PIC X VALUE '/'.                 ADAD9520
             10         DAT82C         PIC XX.                          ADAD9520
             10         DAT8S2C        PIC X VALUE '/'.                 ADAD9520
             10         DAT83C.                                         ADAD9520
               15       DAT83CC        PIC XX.                          ADAD9520
               15       DAT84C         PIC XX.                          ADAD9520
       01               DAT7.                                           ADAD9520
             10         DAT71          PIC XX.                          ADAD9520
             10         DAT72          PIC XX.                          ADAD9520
             10         DAT73          PIC XX.                          ADAD9520
       01               DAT-TRANS.                                      ADAD9520
           05           DAT-CTYD       PIC XX VALUE '61'.               ADAD9520
           05           DAT-CTYT       PIC XX VALUE '61'.               ADAD9520
           05           DAT-CTY        PIC XX VALUE '19'.               ADAD9520
           05           DAT-ADO        PIC X VALUE SPACE.               ADAD9520
           05           DATE8S         PIC 9(8).                        ADAD9520
           05           DATE81         PIC 9(8).                        ADAD9520
           05           DATE82         PIC 9(8).                        ADAD9520
       01               DATCTY.                                         ADAD9520
           05           DATCTY9        PIC 99.                          ADAD9520
       01               DAT7C.                                          ADAD9520
             10         DAT71C         PIC XX.                          ADAD9520
             10         DAT72C         PIC XX.                          ADAD9520
             10         DAT73C         PIC XX.                          ADAD9520
             10         DAT74C         PIC XX.                          ADAD9520
       01               DAT8G.                                          ADAD9520
             10         DAT81G         PIC XX.                          ADAD9520
             10         DAT82G         PIC XX.                          ADAD9520
             10         DAT8S1G        PIC X VALUE '-'.                 ADAD9520
             10         DAT83G         PIC XX.                          ADAD9520
             10         DAT8S2G        PIC X VALUE '-'.                 ADAD9520
             10         DAT84G         PIC XX.                          ADAD9520
       01               TT-DAT.                                         ADAD9520
           05           T-DAT         PIC X OCCURS 5.                   ADAD9520
       01               LEAP-YEAR.                                      ADAD9520
           05           LEAP-FLAG     PIC X.                            ADAD9520
           05           LEAP-REM      PIC 99.                           ADAD9520
