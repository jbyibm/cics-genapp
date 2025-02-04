      *CONTROL NOSOURCE                                                 AGAPAUD2
      *>****************************************************************AGAPAUD2
      *> Tracabilité programme - Reco "Audit Archivage 2010" #5         AGAPAUD2
      *> Fin d'exécution                                                AGAPAUD2
      *>----------------------------------------------------------------AGAPAUD2
      *> Paramètres obligatoires :                                      AGAPAUD2
      *> - Néant                                                        AGAPAUD2
      *> Paramètres facultatifs (selon contexte) :                      AGAPAUD2
      *> - Néant                                                        AGAPAUD2
      *> Variables de compilation :                                     AGAPAUD2
      *> - Néant                                                        AGAPAUD2
      *>****************************************************************AGAPAUD2
      *CONTROL SOURCE                                                   AGAPAUD2
      *>                                                                AGAPAUD2
      *> Tracabilité programme - Reco "Audit Archivage 2010" #5 - Fin   AGAPAUD2
           if not RECO-ARCH-2010-5-wasRUN                               AGAPAUD2
             set RECO-ARCH-2010-5-wasRUN to true                        AGAPAUD2
      *> --- Message fin de programme en SYSOUT                         AGAPAUD2
       >>if AA-G-MIXED                                                  AGAPAUD2
             if CEE3INF-SYS-SUBSYS < X'80000000'                        AGAPAUD2
       >>end-if                                                         AGAPAUD2
             display PROGE ' - FIN PROGRAMME'                           AGAPAUD2
       >>if AA-G-MIXED                                                  AGAPAUD2
             end-if                                                     AGAPAUD2
       >>end-if                                                         AGAPAUD2
           end-if                                                       AGAPAUD2
