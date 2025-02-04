      *CONTROL NOSOURCE                                                 AGAPAUD1
      *>****************************************************************AGAPAUD1
      *> Tracabilité programme - Reco "Audit Archivage 2010" #5         AGAPAUD1
      *> Début d'exécution                                              AGAPAUD1
      *>----------------------------------------------------------------AGAPAUD1
      *> Paramètres obligatoires :                                      AGAPAUD1
      *> - Néant                                                        AGAPAUD1
      *> Paramètres facultatifs (selon contexte) :                      AGAPAUD1
      *> - Néant                                                        AGAPAUD1
      *> Variables de compilation :                                     AGAPAUD1
      *> - Néant                                                        AGAPAUD1
      *>****************************************************************AGAPAUD1
      *CONTROL SOURCE                                                   AGAPAUD1
      *>                                                                AGAPAUD1
      *> Tracabilité programme - Reco "Audit Archivage 2010" #5 - Début AGAPAUD1
           if RECO-ARCH-2010-5-notRUN                                   AGAPAUD1
             set RECO-ARCH-2010-5-notRUN to false                       AGAPAUD1
      *> --- Préparation de la date du jour dans différents formats     AGAPAUD1
      *> DATCE : SSAAMMJJ                                               AGAPAUD1
             move function current-date to DATCE                        AGAPAUD1
      *> W-BA0C-DASDSY : JJMMSSAA                                       AGAPAUD1
             move DATCE (7:2) to W-BA0C-DASDSY (1:2)                    AGAPAUD1
             move DATCE (5:2) to W-BA0C-DASDSY (3:2)                    AGAPAUD1
             move DATCE (1:4) to W-BA0C-DASDSY (5:4)                    AGAPAUD1
      *> W-BA0G-DASDSY : SSAA-MM-JJ                                     AGAPAUD1
             move DATCE (1:4) to W-BA0G-DASDSY (1:4)                    AGAPAUD1
             move DATCE (5:2) to W-BA0G-DASDSY (6:2)                    AGAPAUD1
             move DATCE (7:2) to W-BA0G-DASDSY (9:2)                    AGAPAUD1
             move '-'         to W-BA0G-DASDSY (5:1)                    AGAPAUD1
                                 W-BA0G-DASDSY (8:1)                    AGAPAUD1
      *> W-BA0M-DASDSY : JJ/MM/SSAA                                     AGAPAUD1
             move DATCE (7:2) to W-BA0M-DASDSY (1:2)                    AGAPAUD1
             move DATCE (5:2) to W-BA0M-DASDSY (4:2)                    AGAPAUD1
             move DATCE (1:4) to W-BA0M-DASDSY (7:4)                    AGAPAUD1
             move '/'         to W-BA0M-DASDSY (3:1)                    AGAPAUD1
                                 W-BA0M-DASDSY (6:1)                    AGAPAUD1
       >>if AA-G-MIXED                                                  AGAPAUD1
             copy AGZP3INF.                                             AGAPAUD1
             if CEE3INF-SYS-SUBSYS < X'80000000'                        AGAPAUD1
       >>end-if                                                         AGAPAUD1
      *> --- Message dans la log MVS                                    AGAPAUD1
             display 'GCE001I IDENTITE PROGRAMME ' PROGE                AGAPAUD1
                     ' (' PROGR ' ' COBASE ' ' APPLI ' ' NUGNA ' '      AGAPAUD1
                     DATGNC ' ' TIMGN ')' upon CONSOLE                  AGAPAUD1
      *> --- Message début de programme en SYSOUT                       AGAPAUD1
             display PROGE ' - DEBUT PROGRAMME (' PROGR ' ' COBASE ' '  AGAPAUD1
                     APPLI ' ' NUGNA ' ' DATGNC ' ' TIMGN '), LE '      AGAPAUD1
                     W-BA0M-DASDSY                                      AGAPAUD1
       >>if AA-G-MIXED                                                  AGAPAUD1
             end-if                                                     AGAPAUD1
       >>end-if                                                         AGAPAUD1
           end-if                                                       AGAPAUD1
