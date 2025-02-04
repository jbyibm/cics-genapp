      *CONTROL NOSOURCE                                                 ADAP9520
      *>****************************************************************ADAP9520
      *> Routine de traitements de Date et Heure au standard Pacbase.   ADAP9520
      *> Cette COPY doit être appelée en Procedure Division une fois en ADAP9520
      *> cas de traitement de Dates ou Heures par PERFORM F9520.        ADAP9520
      *>****************************************************************ADAP9520
      *CONTROL SOURCE                                                   ADAP9520
      *>                                                                ADAP9520
       F9520 SECTION.                                                   ADAP9520
      *> --- De DATE FORMAT C : JJMMSSAA                                ADAP9520
       F9520-C. MOVE DAT73C TO DATCTY.                                  ADAP9520
                MOVE DAT71C TO DAT71.                                   ADAP9520
                MOVE DAT72C TO DAT72.                                   ADAP9520
                MOVE DAT74C TO DAT73.                                   ADAP9520
                MOVE '00111' TO TT-DAT GO TO F9520-T.                   ADAP9520
      *> --- De DATE FORMAT D : JJMMAA                                  ADAP9520
       F9520-D. MOVE DAT-CTY TO DATCTY DAT73C.                          ADAP9520
            IF DAT-ADO < '1'           GO TO F9520-DT.                  ADAP9520
            IF DAT-ADO = '2'           GO TO F9520-D2.                  ADAP9520
            IF DAT73 < DAT-CTYT MOVE '19' TO DATCTY DAT73C              ADAP9520
                           ELSE MOVE '20' TO DATCTY DAT73C.             ADAP9520
                                       GO TO F9520-DT.                  ADAP9520
       F9520-D2.                                                        ADAP9520
            IF DAT73 < DAT-CTYT MOVE '20' TO DATCTY DAT73C              ADAP9520
                           ELSE MOVE '19' TO DATCTY DAT73C.             ADAP9520
       F9520-DT. MOVE DAT71 TO DAT71C.                                  ADAP9520
                MOVE DAT72 TO DAT72C.                                   ADAP9520
                MOVE DAT73 TO DAT74C.                                   ADAP9520
                MOVE '00111' TO TT-DAT GO TO F9520-T.                   ADAP9520
      *> --- De DATE FORMAT E : JJ/MM/AA                                ADAP9520
       F9520-E. MOVE DAT-CTY TO DATCTY DAT83CC.                         ADAP9520
            IF DAT-ADO < '1'           GO TO F9520-ET.                  ADAP9520
            IF DAT-ADO = '2'           GO TO F9520-E2.                  ADAP9520
           IF DAT83 < DAT-CTYT MOVE '19' TO DATCTY DAT83CC              ADAP9520
                          ELSE MOVE '20' TO DATCTY DAT83CC.             ADAP9520
                                       GO TO F9520-ET.                  ADAP9520
       F9520-E2.                                                        ADAP9520
           IF DAT83 < DAT-CTYT MOVE '20' TO DATCTY DAT83CC              ADAP9520
                          ELSE MOVE '19' TO DATCTY DAT83CC.             ADAP9520
       F9520-ET. MOVE DAT81 TO DAT81C.                                  ADAP9520
                MOVE DAT82 TO DAT82C.                                   ADAP9520
                MOVE DAT83 TO DAT84C.                                   ADAP9520
                MOVE DATSEW TO DAT8S1C DAT8S2C.                         ADAP9520
                MOVE '01011' TO TT-DAT GO TO F9520-T.                   ADAP9520
      *> --- De DATE FORMAT G : SSAA-MM-JJ                              ADAP9520
       F9520-G. MOVE DAT81G TO DATCTY.                                  ADAP9520
                MOVE DAT82G TO DAT61.                                   ADAP9520
                MOVE DAT83G TO DAT62.                                   ADAP9520
                MOVE DAT84G TO DAT63.                                   ADAP9520
                MOVE '10110' TO TT-DAT GO TO F9520-T.                   ADAP9520
      *> --- De DATE FORMAT I : AAMMJJ                                  ADAP9520
       F9520-I. MOVE DAT-CTY TO DATCTY DAT61C.                          ADAP9520
            IF DAT-ADO < '1'           GO TO F9520-IT.                  ADAP9520
            IF DAT-ADO = '2'           GO TO F9520-I2.                  ADAP9520
            IF DAT61 < DAT-CTYT MOVE '19' TO DATCTY DAT61C              ADAP9520
                           ELSE MOVE '20' TO DATCTY DAT61C.             ADAP9520
                                       GO TO F9520-IT.                  ADAP9520
       F9520-I2.                                                        ADAP9520
            IF DAT61 < DAT-CTYT MOVE '20' TO DATCTY DAT61C              ADAP9520
                           ELSE MOVE '19' TO DATCTY DAT61C.             ADAP9520
       F9520-IT. MOVE DAT61 TO DAT62C.                                  ADAP9520
                MOVE DAT62 TO DAT63CC.                                  ADAP9520
                MOVE DAT63 TO DAT64C.                                   ADAP9520
                MOVE '10101' TO TT-DAT GO TO F9520-T.                   ADAP9520
      *> --- De DATE FORMAT M : JJ/MM/SSAA                              ADAP9520
       F9520-M. MOVE DAT83CC TO DATCTY.                                 ADAP9520
                MOVE DAT81C TO DAT81.                                   ADAP9520
                MOVE DAT82C TO DAT82.                                   ADAP9520
                MOVE DAT84C TO DAT83.                                   ADAP9520
                MOVE DATSEW TO DAT8S1 DAT8S2.                           ADAP9520
                MOVE '01011' TO TT-DAT GO TO F9520-T.                   ADAP9520
      *> --- De DATE FORMAT S : SSAAMMJJ                                ADAP9520
       F9520-S. MOVE DAT61C TO DATCTY.                                  ADAP9520
                MOVE DAT62C TO DAT61.                                   ADAP9520
                MOVE DAT63CC TO DAT62.                                  ADAP9520
                MOVE DAT64C TO DAT63.                                   ADAP9520
                MOVE '10101' TO TT-DAT.                                 ADAP9520
      *> --- Transformation                                             ADAP9520
       F9520-T. IF T-DAT (1) = '1'                                      ADAP9520
      *> --- De DATE FORMAT I : AAMMJJ                                  ADAP9520
      *>     Vers DATE FORMAT D : JJMMAA / DATE FORMAT C : JJMMSSAA     ADAP9520
                    MOVE DAT61 TO DAT73 DAT74C                          ADAP9520
                    MOVE DAT62 TO DAT72 DAT72C                          ADAP9520
                    MOVE DAT63 TO DAT71 DAT71C                          ADAP9520
                    MOVE DATCTY TO DAT73C.                              ADAP9520
                 IF T-DAT (2) = '1'                                     ADAP9520
      *> --- De DATE FORMAT E : JJ/MM/AA                                ADAP9520
      *>     Vers DATE FORMAT D : JJMMAA / DATE FORMAT C : JJMMSSAA     ADAP9520
                    MOVE DAT81 TO DAT71 DAT71C                          ADAP9520
                    MOVE DAT82 TO DAT72 DAT72C                          ADAP9520
                    MOVE DAT83 TO DAT73 DAT74C                          ADAP9520
                    MOVE DATCTY TO  DAT73C.                             ADAP9520
      *>--- De DATE FORMAT E : JJ/MM/AA                                 ADAP9520
      *>    Vers DATE FORMAT D : JJMMAA / DATE FORMAT C : JJMMSSAA      ADAP9520
                 IF T-DAT (3) = '1'                                     ADAP9520
                    MOVE DAT71 TO DAT81 DAT81C                          ADAP9520
                    MOVE DAT72 TO DAT82 DAT82C                          ADAP9520
                    MOVE DAT73 TO DAT83 DAT84C                          ADAP9520
                    MOVE DATSEW TO DAT8S1 DAT8S2                        ADAP9520
                         DAT8S1C DAT8S2C                                ADAP9520
                    MOVE DATCTY TO DAT83CC.                             ADAP9520
                 IF T-DAT (4) = '1'                                     ADAP9520
                    MOVE DAT71 TO DAT63 DAT64C                          ADAP9520
                    MOVE DAT72 TO DAT62 DAT63CC                         ADAP9520
                    MOVE DAT73 TO DAT61 DAT62C                          ADAP9520
                    MOVE DATCTY TO DAT61C.                              ADAP9520
                 IF T-DAT (5) = '1'                                     ADAP9520
                    MOVE DAT61 TO DAT82G                                ADAP9520
                    MOVE DAT62 TO DAT83G                                ADAP9520
                    MOVE DAT63 TO DAT84G                                ADAP9520
                    MOVE DATSEW TO DAT8S1G DAT8S2G                      ADAP9520
                    MOVE DATCTY TO DAT81G.                              ADAP9520
      *> --- Sortie transformation                                      ADAP9520
       F9520-Z. EXIT.                                                   ADAP9520
      *> --- Validation date                                            ADAP9520
       F9520-ER.  MOVE '1'   TO EN-PRE.                                 ADAP9520
               IF DAT6 NOT NUMERIC     GO TO F9520-KO.                  ADAP9520
               IF DATCTY NOT NUMERIC   GO TO F9520-KO.                  ADAP9520
               IF DAT62 > '12' OR DAT62 = '00' OR                       ADAP9520
                  DAT63 > '31' OR DAT63 = '00'                          ADAP9520
                                       GO TO F9520-KO.                  ADAP9520
               IF DAT63 > '30' AND                                      ADAP9520
                 (DAT62 = '04' OR DAT62 = '06' OR                       ADAP9520
                  DAT62 = '09' OR DAT62 = '11')                         ADAP9520
                                       GO TO F9520-KO.                  ADAP9520
               IF DAT62 NOT = '02'     GO TO F9520-FN.                  ADAP9520
               IF DAT63 > '29'         GO TO F9520-KO.                  ADAP9520
               IF   DAT619  = ZERO                                      ADAP9520
               DIVIDE  DATCTY9    BY 4 GIVING  LEAP-REM                 ADAP9520
               COMPUTE LEAP-REM = DATCTY9 - 4 * LEAP-REM                ADAP9520
               ELSE DIVIDE DAT619  BY 4 GIVING LEAP-REM                 ADAP9520
               COMPUTE LEAP-REM = DAT619 - 4 * LEAP-REM.                ADAP9520
               IF DAT63 < '29' OR LEAP-REM = ZERO                       ADAP9520
                                       GO TO F9520-FN.                  ADAP9520
       F9520-KO. MOVE '5' TO EN-PRE.                                    ADAP9520
       F9520-FN.                                                        ADAP9520
           exit section.                                                ADAP9520
