      *CONTROL NOSOURCE                                                 AGADAUDT
      *>****************************************************************AGADAUDT
      *> Tracabilité programme - Reco "Audit Archivage 2010" #5         AGADAUDT
      *-----------------------------------------------------------------AGADAUDT
      *> Paramètres obligatoires :                                      AGADAUDT
      *> - Néant                                                        AGADAUDT
      *> Paramètres facultatifs (selon contexte) :                      AGADAUDT
      *> - Néant                                                        AGADAUDT
      *> Variables de compilation :                                     AGADAUDT
      *> - Néant                                                        AGADAUDT
      *>****************************************************************AGADAUDT
      *CONTROL SOURCE                                                   AGADAUDT
      *>                                                                AGADAUDT
      *> Tracabilité programme - Reco "Audit Archivage 2010" #5         AGADAUDT
      *> Date système format JJMMSSAA (C)                               AGADAUDT
       01               W-BA0C-DASDSY  PIC X(8).                        AGADAUDT
      *> Date système format SSAA-MM-JJ (G)                             AGADAUDT
       01               W-BA0G-DASDSY  PIC X(10).                       AGADAUDT
      *> Date système format JJ/MM/SSAA (M)                             AGADAUDT
       01               W-BA0M-DASDSY  PIC X(10).                       AGADAUDT
      *> Indicateur d'exécution : 0=jamais, 1=1ère fois, 2=après 1ère   AGADAUDT
       01                              PIC X VALUE '0'.                 AGADAUDT
                    88  RECO-ARCH-2010-5-notRUN VALUE '0'               AGADAUDT
                                                FALSE '1'.              AGADAUDT
                    88  RECO-ARCH-2010-5-wasRUN VALUE '2'.              AGADAUDT
