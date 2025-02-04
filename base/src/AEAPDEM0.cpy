      *CONTROL NOSOURCE                                                 AEAPDEM0
      *>****************************************************************AEAPDEM0
      *> Programme Q/R : fonctions attachées à une Q/R appelée.         AEAPDEM0
      *>                                                                AEAPDEM0
      *> Ce code est dupliqué pour chaque Q/R appelée et fait appel au  AEAPDEM0
      *> code mutualisé décrit dans le copybool AEA5DEM0.               AEAPDEM0
      *>----------------------------------------------------------------AEAPDEM0
      *> Paramètres REPLACING obligatoires :                            AEAPDEM0
      *> - :N: : identifiant du Service appelé                          AEAPDEM0
      *> - :ZCDEM: : zone de communication Echanges Demandeur           AEAPDEM0
      *>----------------------------------------------------------------AEAPDEM0
      *> Variables de compilation locales :                             AEAPDEM0
      ******************************************************************AEAPDEM0
      *CONTROL SOURCE                                                   AEAPDEM0
      *>                                                                AEAPDEM0
      *> --- Initialisation de l'appel au Service demandé               AEAPDEM0
       INITIALISER-:QID:-:N: SECTION.                                   AEAPDEM0
           set address of :ZCDEM: to address of AD0:N:                  AEAPDEM0
           set address of W-DEM0 to address of W-DEM:N:                 AEAPDEM0
           perform INITIALISER-DEMANDEUR                                AEAPDEM0
           set AD0:N:-ZCPTSQ to address of QUESTION-DEM:N:              AEAPDEM0
           set W-DEM:N:-ZCPTSQ to AD0:N:-ZCPTSQ.                        AEAPDEM0
       INITIALISER-:QID:-:N:-FN.                                        AEAPDEM0
           exit section.                                                AEAPDEM0
      *>                                                                AEAPDEM0
      *> --- Ecriture d'une Question pour le Service demandé            AEAPDEM0
       ECRIRE-QUESTION-:QID:-:N: SECTION.                               AEAPDEM0
           set address of :ZCDEM: to address of AD0:N:                  AEAPDEM0
           set address of W-DEM0 to address of W-DEM:N:                 AEAPDEM0
           perform ECRIRE-QUESTION.                                     AEAPDEM0
       ECRIRE-QUESTION-:QID:-:N:-FN.                                    AEAPDEM0
           exit section.                                                AEAPDEM0
      *>                                                                AEAPDEM0
      *> --- Finalisation de l'appel au Service demandé                 AEAPDEM0
       FINALISER-:QID:-:N: SECTION.                                     AEAPDEM0
           set address of :ZCDEM: to address of AD0:N:                  AEAPDEM0
           set address of W-DEM0 to address of W-DEM:N:                 AEAPDEM0
           perform FINALISER-DEMANDEUR.                                 AEAPDEM0
       FINALISER-:QID:-:N:-FN.                                          AEAPDEM0
           exit section.                                                AEAPDEM0
      *>                                                                AEAPDEM0
      *> --- Lecture d'une Réponse pour le Service demandé              AEAPDEM0
       LIRE-REPONSE-:QID:-:N: SECTION.                                  AEAPDEM0
           set address of :ZCDEM: to address of AD0:N:                  AEAPDEM0
           set address of W-DEM0 to address of W-DEM:N:                 AEAPDEM0
           perform LIRE-REPONSE                                         AEAPDEM0
           if AD0:N:-ZCRC = 000 or 100                                  AEAPDEM0
             move MESSAGE-RECU (1:MESSAGE-RECU-LENGTH)                  AEA5DEM0
               to REPONSE-DEM:N:                                        AEA5DEM0
           end-if.                                                      AEAPDEM0
       LIRE-REPONSE-:QID:-:N:-FN.                                       AEAPDEM0
           exit section.                                                AEAPDEM0
      *>                                                                AEAPDEM0
      *> --- Purge des Réponses en attente                              AEAPDEM0
       PURGER-REPONSES-:QID:-:N: SECTION.                               AEAPDEM0
           set address of :ZCDEM: to address of AD0:N:                  AEAPDEM0
           set address of W-DEM0 to address of W-DEM:N:                 AEAPDEM0
           perform PURGER-REPONSES.                                     AEAPDEM0
       PURGER-REPONSES-:QID:-:N:-FN.                                    AEAPDEM0
           exit section.                                                AEAPDEM0
