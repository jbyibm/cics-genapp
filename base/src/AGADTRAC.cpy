      *CONTROL NOSOURCE                                                 AGADTRAC
      *>****************************************************************AGADTRAC
      *> Trace anomalie et abend.                                       AGADTRAC
      *> Déclaration de la zone de communications avec le module xxTRAC AGADTRAC
      *> - A8ZDTRAC : module batch S8TRAC (à créer)                     AGADTRAC
      *> - A9ZDTRAC : module CICS S9TRAC                                AGADTRAC
      *-----------------------------------------------------------------AGADTRAC
      *> Les modules xxTRAC permettent d'enregistrer une trace en cas   AGADTRAC
      *> de problème et de déclencher un abend selon la gravité de ce   AGADTRAC
      *> problème.                                                      AGADTRAC
      *-----------------------------------------------------------------AGADTRAC
      *> Paramètres REPLACING facultatifs :                             AGADTRAC
      *> - leading ==TRAC== : préfixe des zones de communication        AGADTRAC
      *>****************************************************************AGADTRAC
      *CONTROL SOURCE                                                   AGADTRAC
       >>evaluate true                                                  AGADTRAC
      *>  >>when AA-G-BATCH                                             AGADTRAC
      *>    copy A8ZDTRAC.    *> TODO: créer le module S8TRAC           AGADTRAC
         >>when AA-G-CICS                                               AGADTRAC
           copy A9ZDTRAC.                                               AGADTRAC
         >>when other                                                   AGADTRAC
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AGADTRAC
      *>>> Le service de trace n'est actuellement disponible que    <<< AGADTRAC
      *>>> pour CICS. Contacter le support.                         <<< AGADTRAC
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AGADTRAC
       >>end-evaluate                                                   AGADTRAC
