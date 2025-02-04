      *>****************************************************************ADAPDATE
      *> Routine de traitements de Date et Heure.                       ADAPDATE
      *CONTROL NOSOURCE                                                 ADAPDATE
      *> Cette COPY doit être appelée en Procedure Division une fois en ADAPDATE
      *> cas de traitement de Dates ou Heures.                          ADAPDATE
      *>----------------------------------------------------------------ADAPDATE
      *> Transformation du format d'une Date :                          ADAPDATE
      *> - alimenter la variable 5-DATE-<s> correspondant au format     ADAPDATE
      *>   source (C, D, E, G, I, M, S)                                 ADAPDATE
      *> - pour une conversion d'une date sans siècle vers une date     ADAPDATE
      *>   avec siècle, alimenter l'indicateur DAT-ADO avec l'une des   ADAPDATE
      *>   valeurs :                                                    ADAPDATE
      *>   - '0' ou "set 5-DATE-SIECLE-DEF to true" : utilisation du    ADAPDATE
      *>         siècle par défaut 5-DATE-SIECLE                        ADAPDATE
      *>   - '1' ou "set 5-DATE-1900-AVANT to true" : siècle '19' si    ADAPDATE
      *>         année < pivot, sinon '20'                              ADAPDATE
      *>   - '2' ou "set 5-DATE-2000-AVANT to true" : siècle '20' si    ADAPDATE
      *>         année < pivot, sinon '19'                              ADAPDATE
      *> - appeler par PERFORM la routine CONVERTIR-DE-DATE-<s>         ADAPDATE
      *>   correspondant au format source                               ADAPDATE
      *> - appeler par PERFORM la routine CONVERTIR-VERS-DATE-<c>       ADAPDATE
      *>   correspondant au format cible                                ADAPDATE
      *> - récupérer la date transformée dans la variable 5-DATE-<c>    ADAPDATE
      *>   correspondant au format cible                                ADAPDATE
      *> Les fonctions de transformations utilisent la zone 5-DATE-S    ADAPDATE
      *> comme zone de travail entre une fonction CONVERTIR-DE-DATE-<s> ADAPDATE
      *> et une fonction CONVERTIR-VERS-DATE-<c>.                       ADAPDATE
      *>----------------------------------------------------------------ADAPDATE
      *> Toutes les transformations standards sont prévues.             ADAPDATE
      *> L'optimiseur du compilateur COBOL éliminera le code superflus. ADAPDATE
      *>----------------------------------------------------------------ADAPDATE
      *> Paramètres obligatoires :                                      ADAPDATE
      *> Néant.                                                         ADAPDATE
      *>----------------------------------------------------------------ADAPDATE
      *> Variables de compilation :                                     ADAPDATE
      *> Néant.                                                         ADAPDATE
      *CONTROL SOURCE                                                   ADAPDATE
      *>****************************************************************ADAPDATE
      *>                                                                ADAPDATE
      *> TRANSFORMATION DATE FORMAT C : JJMMSSAA                        ADAPDATE
       CONVERTIR-DE-DATE-C SECTION.                                     ADAPDATE
           move DD   of 5-DATE-C to DD   of 5-DATE-S                    ADAPDATE
           move MM   of 5-DATE-C to MM   of 5-DATE-S                    ADAPDATE
           move YYYY of 5-DATE-C to YYYY of 5-DATE-S.                   ADAPDATE
       CONVERTIR-DE-DATE-C-FN.                                          ADAPDATE
           exit section.                                                ADAPDATE
       CONVERTIR-VERS-DATE-C SECTION.                                   ADAPDATE
           move DD   of 5-DATE-S to DD   of 5-DATE-C                    ADAPDATE
           move MM   of 5-DATE-S to MM   of 5-DATE-C                    ADAPDATE
           move YYYY of 5-DATE-S to YYYY of 5-DATE-C.                   ADAPDATE
       CONVERTIR-VERS-DATE-C-FN.                                        ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> TRANSFORMATION DATE FORMAT D : JJMMAA                          ADAPDATE
       CONVERTIR-DE-DATE-D SECTION.                                     ADAPDATE
           move DD   of 5-DATE-D to DD   of 5-DATE-S                    ADAPDATE
           move MM   of 5-DATE-D to MM   of 5-DATE-S                    ADAPDATE
           move YY   of 5-DATE-D to YY   of 5-DATE-S                    ADAPDATE
           perform DEFINIR-SIECLE.                                      ADAPDATE
       CONVERTIR-DE-DATE-D-FN.                                          ADAPDATE
           exit section.                                                ADAPDATE
       CONVERTIR-VERS-DATE-D SECTION.                                   ADAPDATE
           move DD   of 5-DATE-S to DD   of 5-DATE-D                    ADAPDATE
           move MM   of 5-DATE-S to MM   of 5-DATE-D                    ADAPDATE
           move YY   of 5-DATE-S to YY   of 5-DATE-D.                   ADAPDATE
       CONVERTIR-VERS-DATE-D-FN.                                        ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> TRANSFORMATION DATE FORMAT E : JJ/MM/AA                        ADAPDATE
       CONVERTIR-DE-DATE-E SECTION.                                     ADAPDATE
           move DD   of 5-DATE-E to DD   of 5-DATE-S                    ADAPDATE
           move MM   of 5-DATE-E to MM   of 5-DATE-S                    ADAPDATE
           move YY   of 5-DATE-E to YY   of 5-DATE-S                    ADAPDATE
           perform DEFINIR-SIECLE.                                      ADAPDATE
       CONVERTIR-DE-DATE-E-FN.                                          ADAPDATE
           exit section.                                                ADAPDATE
       CONVERTIR-VERS-DATE-E SECTION.                                   ADAPDATE
           move DD   of 5-DATE-S to DD   of 5-DATE-E                    ADAPDATE
           move MM   of 5-DATE-S to MM   of 5-DATE-E                    ADAPDATE
           move YY   of 5-DATE-S to YY   of 5-DATE-E                    ADAPDATE
           move DATSEP           to S1   of 5-DATE-E                    ADAPDATE
                                    S2   of 5-DATE-E.                   ADAPDATE
       CONVERTIR-VERS-DATE-E-FN.                                        ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> TRANSFORMATION DATE FORMAT G : SSAA-MM-JJ                      ADAPDATE
       CONVERTIR-DE-DATE-G SECTION.                                     ADAPDATE
           move DD   of 5-DATE-G to DD   of 5-DATE-S                    ADAPDATE
           move MM   of 5-DATE-G to MM   of 5-DATE-S                    ADAPDATE
           move YYYY of 5-DATE-G to YYYY of 5-DATE-S.                   ADAPDATE
       CONVERTIR-DE-DATE-G-FN.                                          ADAPDATE
           exit section.                                                ADAPDATE
       CONVERTIR-VERS-DATE-G SECTION.                                   ADAPDATE
           move DD   of 5-DATE-S to DD   of 5-DATE-G                    ADAPDATE
           move MM   of 5-DATE-S to MM   of 5-DATE-G                    ADAPDATE
           move YYYY of 5-DATE-S to YYYY of 5-DATE-G                    ADAPDATE
           move DATSET           to S1   of 5-DATE-G                    ADAPDATE
                                    S2   of 5-DATE-G.                   ADAPDATE
       CONVERTIR-VERS-DATE-G-FN.                                        ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> TRANSFORMATION DATE FORMAT I : AAMMJJ                          ADAPDATE
       CONVERTIR-DE-DATE-I SECTION.                                     ADAPDATE
           move DD   of 5-DATE-I to DD   of 5-DATE-S                    ADAPDATE
           move MM   of 5-DATE-I to MM   of 5-DATE-S                    ADAPDATE
           move YY   of 5-DATE-I to YY   of 5-DATE-S                    ADAPDATE
           perform DEFINIR-SIECLE.                                      ADAPDATE
       CONVERTIR-DE-DATE-I-FN.                                          ADAPDATE
           exit section.                                                ADAPDATE
       CONVERTIR-VERS-DATE-I SECTION.                                   ADAPDATE
           move DD   of 5-DATE-S to DD   of 5-DATE-I                    ADAPDATE
           move MM   of 5-DATE-S to MM   of 5-DATE-I                    ADAPDATE
           move YY   of 5-DATE-S to YY   of 5-DATE-I.                   ADAPDATE
       CONVERTIR-VERS-DATE-I-FN.                                        ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> TRANSFORMATION DATE FORMAT M : JJ/MM/SSAA                      ADAPDATE
       CONVERTIR-DE-DATE-M SECTION.                                     ADAPDATE
           move DD   of 5-DATE-M to DD   of 5-DATE-S                    ADAPDATE
           move MM   of 5-DATE-M to MM   of 5-DATE-S                    ADAPDATE
           move YYYY of 5-DATE-M to YYYY of 5-DATE-S.                   ADAPDATE
       CONVERTIR-DE-DATE-M-FN.                                          ADAPDATE
           exit section.                                                ADAPDATE
       CONVERTIR-VERS-DATE-M SECTION.                                   ADAPDATE
           move DD   of 5-DATE-S to DD   of 5-DATE-M                    ADAPDATE
           move MM   of 5-DATE-S to MM   of 5-DATE-M                    ADAPDATE
           move YYYY of 5-DATE-S to YYYY of 5-DATE-M                    ADAPDATE
           move DATSEP           to S1   of 5-DATE-M                    ADAPDATE
                                    S2   of 5-DATE-M.                   ADAPDATE
       CONVERTIR-VERS-DATE-M-FN.                                        ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> TRANSFORMATION DATE FORMAT S : SSAAMMJJ                        ADAPDATE
       CONVERTIR-DE-DATE-S SECTION.                                     ADAPDATE
           continue.                                                    ADAPDATE
       CONVERTIR-DE-DATE-S-FN.                                          ADAPDATE
           exit section.                                                ADAPDATE
       CONVERTIR-VERS-DATE-S SECTION.                                   ADAPDATE
           continue.                                                    ADAPDATE
       CONVERTIR-VERS-DATE-S-FN.                                        ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> ALIMENTATION DU SIECLE SUR DATE SANS SIECLE                    ADAPDATE
       DEFINIR-SIECLE SECTION.                                          ADAPDATE
           evaluate true also true                                      ADAPDATE
             when not 5-DATE-1900-AVANT and not 5-DATE-2000-AVANT       ADAPDATE
                  also any                                              ADAPDATE
               move 5-DATE-SIECLE to CC of 5-DATE-S                     ADAPDATE
             when 5-DATE-1900-AVANT also YY in 5-DATE-S <  5-DATE-PIVOT ADAPDATE
             when 5-DATE-2000-AVANT also YY in 5-DATE-S >= 5-DATE-PIVOT ADAPDATE
               move '19' to CC of 5-DATE-S                              ADAPDATE
             when other                                                 ADAPDATE
               move '20' to CC of 5-DATE-S                              ADAPDATE
           end-evaluate.                                                ADAPDATE
       DEFINIR-SIECLE-FN.                                               ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DATE FORMAT I VERS D (ADI : AAMMJJ --> JJMMAA)                 ADAPDATE
       INVERSER-DATE-I SECTION.                                         ADAPDATE
           move DD of 5-DATE-I to DD of 5-DATE-D                        ADAPDATE
           move MM of 5-DATE-I to MM of 5-DATE-D                        ADAPDATE
           move YY of 5-DATE-I to YY of 5-DATE-D.                       ADAPDATE
       INVERSER-DATE-I-FN.                                              ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DATE FORMAT D VERS I (sans équivalent : JJMMAA --> AAMMJJ)     ADAPDATE
       INVERSER-DATE-D SECTION.                                         ADAPDATE
           move DD of 5-DATE-D to DD of 5-DATE-I                        ADAPDATE
           move MM of 5-DATE-D to MM of 5-DATE-I                        ADAPDATE
           move YY of 5-DATE-D to YY of 5-DATE-I.                       ADAPDATE
       INVERSER-DATE-D-FN.                                              ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DATE FORMAT C VERS S (sans équivalent : JJMMSSAA --> SSAAMMJJ) ADAPDATE
       INVERSER-DATE-C SECTION.                                         ADAPDATE
           move DD   of 5-DATE-C to DD   of 5-DATE-S                    ADAPDATE
           move MM   of 5-DATE-C to MM   of 5-DATE-S                    ADAPDATE
           move YYYY of 5-DATE-C to YYYY of 5-DATE-S.                   ADAPDATE
       INVERSER-DATE-C-FN.                                              ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DATE FORMAT S VERS C (ADS : SSAAMMJJ --> JJMMSSAA)             ADAPDATE
       INVERSER-DATE-S SECTION.                                         ADAPDATE
           move DD   of 5-DATE-S to DD   of 5-DATE-C                    ADAPDATE
           move MM   of 5-DATE-S to MM   of 5-DATE-C                    ADAPDATE
           move YYYY of 5-DATE-S to YYYY of 5-DATE-C.                   ADAPDATE
       INVERSER-DATE-S-FN.                                              ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DATE FORMAT D VERS E (ADE : JJMMAA --> JJ/MM/AA)               ADAPDATE
       EDITER-DATE-D SECTION.                                           ADAPDATE
           move DD of 5-DATE-D to DD of 5-DATE-E                        ADAPDATE
           move MM of 5-DATE-D to MM of 5-DATE-E                        ADAPDATE
           move YY of 5-DATE-D to YY of 5-DATE-E                        ADAPDATE
           move DATSEP         to S1 of 5-DATE-E                        ADAPDATE
                                  S2 of 5-DATE-E.                       ADAPDATE
       EDITER-DATE-D-FN.                                                ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DATE FORMAT I VERS E (ADF : AAMMJJ --> JJ/MM/AA)               ADAPDATE
       EDITER-DATE-I SECTION.                                           ADAPDATE
           move DD of 5-DATE-I to DD of 5-DATE-E                        ADAPDATE
           move MM of 5-DATE-I to MM of 5-DATE-E                        ADAPDATE
           move YY of 5-DATE-I to YY of 5-DATE-E                        ADAPDATE
           move DATSEP         to S1 of 5-DATE-E                        ADAPDATE
                                  S2 of 5-DATE-E.                       ADAPDATE
       EDITER-DATE-I-FN.                                                ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DATE FORMAT C VERS M (ADM : JJMMSSAA --> JJ/MM/SSAA)           ADAPDATE
       EDITER-DATE-C SECTION.                                           ADAPDATE
           move DD   of 5-DATE-C to DD   of 5-DATE-M                    ADAPDATE
           move MM   of 5-DATE-C to MM   of 5-DATE-M                    ADAPDATE
           move YYYY of 5-DATE-C to YYYY of 5-DATE-M                    ADAPDATE
           move DATSEP           to S1   of 5-DATE-M                    ADAPDATE
                                    S2   of 5-DATE-M.                   ADAPDATE
       EDITER-DATE-C-FN.                                                ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DATE FORMAT S VERS M (sans équivalent : SSAAMMJJ -->           ADAPDATE
      *>                                                    JJ/MM/SSAA) ADAPDATE
       EDITER-DATE-S SECTION.                                           ADAPDATE
           move DD   of 5-DATE-S to DD   of 5-DATE-M                    ADAPDATE
           move MM   of 5-DATE-S to MM   of 5-DATE-M                    ADAPDATE
           move YYYY of 5-DATE-S to YYYY of 5-DATE-M                    ADAPDATE
           move DATSEP           to S1   of 5-DATE-M                    ADAPDATE
                                    S2   of 5-DATE-M.                   ADAPDATE
       EDITER-DATE-S-FN.                                                ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> HEURE FORMAT EDITION (TIF : HHMMSS --> HH:MM:SS)               ADAPDATE
       EDITER-HEURE SECTION.                                            ADAPDATE
           move HH in 5-TIME to HH in TIMDAY                            ADAPDATE
           move MM in 5-TIME to MM in TIMDAY                            ADAPDATE
           move SS in 5-TIME to SS in TIMDAY                            ADAPDATE
           move TIMSEP to S1 in TIMDAY                                  ADAPDATE
                          S2 in TIMDAY.                                 ADAPDATE
       EDITER-HEURE-FN.                                                 ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> VALIDATION D'UNE DATE SSAAMMJJ depuis 5-DATE-S                 ADAPDATE
       VALIDER-DATE SECTION.                                            ADAPDATE
           if function test-formatted-datetime ('YYYYMMDD', 5-DATE-S)   ADAPDATE
              = 0                                                       ADAPDATE
             set 5-DATE-VALIDE to true                                  ADAPDATE
           else                                                         ADAPDATE
             set 5-DATE-INVALIDE to true                                ADAPDATE
           end-if.                                                      ADAPDATE
       VALIDER-DATE-FN.                                                 ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> VALIDATION D'UNE HEURE HHMMSS depuis 5-TIME                    ADAPDATE
       VALIDER-HEURE SECTION.                                           ADAPDATE
           if function test-formatted-datetime ('hhmmss', 5-TIME)       ADAPDATE
              = 0                                                       ADAPDATE
             set 5-TIME-VALIDE to true                                  ADAPDATE
           else                                                         ADAPDATE
             set 5-TIME-INVALIDE to true                                ADAPDATE
           end-if.                                                      ADAPDATE
       VALIDER-HEURE-FN.                                                ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> NOMBRE DE JOURS ENTRE DEUX DATES FORMAT S SSAAMMJJ             ADAPDATE
      *> (Ne vérifie pas que les dates sont valides)                    ADAPDATE
       SOUSTRAIRE-DATE SECTION.                                         ADAPDATE
           compute NUM-DAYS = function integer-of-date (5-DATE-D1)      ADAPDATE
                            - function integer-of-date (5-DATE-D2).     ADAPDATE
       SOUSTRAIRE-DATE-FN.                                              ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DATE FORMAT S +/- N JOURS (DAO S NUM-DAYS 5-DATE-S)            ADAPDATE
      *> (Ne vérifie pas que les dates sont valides)                    ADAPDATE
       DECALER-DATE SECTION.                                            ADAPDATE
           compute 5-DATE-D1 =                                          ADAPDATE
             function date-of-integer (                                 ADAPDATE
               function integer-of-date (5-DATE-D1) + NUM-DAYS).        ADAPDATE
       DECALER-DATE-FN.                                                 ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> AJOUTER UN TEMPS T2 EN HHMMSS A UNE HEURE T1 EN HHMMSS         ADAPDATE
      *> (Ne vérifie pas que les heures sont valides)                   ADAPDATE
       AJOUTER-HEURE SECTION.                                           ADAPDATE
           compute NUM-SECS =                                           ADAPDATE
               function seconds-from-formatted-time ('hhmmss',          ADAPDATE
                                                   5-TIME-T1)           ADAPDATE
             + function seconds-from-formatted-time ('hhmmss',          ADAPDATE
                                                   5-TIME-T2)           ADAPDATE
           if NUM-SECS < 86400                                          ADAPDATE
             set 5-TIME-MEME-JOUR to true                               ADAPDATE
             move function formatted-time ('hhmmss', NUM-SECS)          ADAPDATE
                  to 5-TIME                                             ADAPDATE
           else                                                         ADAPDATE
             set 5-TIME-LENDEMAIN to true                               ADAPDATE
             move function formatted-time ('hhmmss', NUM-SECS - 86400)  ADAPDATE
                  to 5-TIME                                             ADAPDATE
           end-if.                                                      ADAPDATE
       AJOUTER-HEURE-FN.                                                ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> DIFFERENCE EN SECONDES ET HHMMSS ENTRE DEUX HEURES HHMMSS      ADAPDATE
      *> (Ne vérifie pas que les heures sont valides)                   ADAPDATE
       SOUSTRAIRE-HEURE SECTION.                                        ADAPDATE
           compute NUM-SECS =                                           ADAPDATE
                   function seconds-from-formatted-time ('hhmmss',      ADAPDATE
                                                         5-TIME-T1)     ADAPDATE
                 - function seconds-from-formatted-time ('hhmmss',      ADAPDATE
                                                         5-TIME-T2)     ADAPDATE
           if NUM-SECS >= 0                                             ADAPDATE
             set 5-TIME-MEME-JOUR to true                               ADAPDATE
             move function formatted-time ('hhmmss', NUM-SECS)          ADAPDATE
                  to 5-TIME                                             ADAPDATE
           else                                                         ADAPDATE
             set 5-TIME-LA-VEILLE to true                               ADAPDATE
             move function formatted-time ('hhmmss', 86400 + NUM-SECS)  ADAPDATE
                  to 5-TIME                                             ADAPDATE
           end-if.                                                      ADAPDATE
       SOUSTRAIRE-HEURE-FN.                                             ADAPDATE
           exit section.                                                ADAPDATE
      *>                                                                ADAPDATE
      *> HEURE +/- N SECONDES                                           ADAPDATE
      *> (Ne vérifie pas que l'heure est valide)                        ADAPDATE
       DECALER-HEURE SECTION.                                           ADAPDATE
           compute NUM-SECS = NUM-SECS +                                ADAPDATE
               function seconds-from-formatted-time('hhmmss', 5-TIME)   ADAPDATE
           evaluate true                                                ADAPDATE
             when NUM-SECS < 0                                          ADAPDATE
               set 5-TIME-LA-VEILLE to true                             ADAPDATE
               move function formatted-time ('hhmmss',                  ADAPDATE
                                             86400 + NUM-SECS)          ADAPDATE
                    to 5-TIME                                           ADAPDATE
             when NUM-SECS < 86400                                      ADAPDATE
               set 5-TIME-MEME-JOUR to true                             ADAPDATE
               move function formatted-time ('hhmmss', NUM-SECS)        ADAPDATE
                    to 5-TIME                                           ADAPDATE
             when NUM-SECS > 86400                                      ADAPDATE
               set 5-TIME-LENDEMAIN to true                             ADAPDATE
               move function formatted-time ('hhmmss',                  ADAPDATE
                                             NUM-SECS - 86400)          ADAPDATE
                    to 5-TIME                                           ADAPDATE
           end-evaluate.                                                ADAPDATE
       DECALER-HEURE-FN.                                                ADAPDATE
           exit section.                                                ADAPDATE
       >>if AA-G-CICS                                                   ADAPDATE
      *> DATE ET HEURE CICS                                             ADAPDATE
       LIRE-DATE-HEURE-CICS SECTION.                                    ADAPDATE
           exec cics                                                    ADAPDATE
             asktime abstime(5-CICS-ABSTIME)                            ADAPDATE
           end-exec                                                     ADAPDATE
           exec cics                                                    ADAPDATE
             formattime abstime(5-CICS-ABSTIME)                         ADAPDATE
                        yyyymmdd (DATCE)  *> no datesep() ! overflow... ADAPDATE
                        time (TIMCO)      *> no timesep() ! overflow... ADAPDATE
           end-exec.                                                    ADAPDATE
       LIRE-DATE-HEURE-CICS-FN.                                         ADAPDATE
           exit section.                                                ADAPDATE
       >>end-if                                                         ADAPDATE
       >>if AA-G-PACBASE                                                ADAPDATE
           copy ADAP9520.                                               ADAPDATE
       >>end-if                                                         ADAPDATE
