      *CONTROL NOSOURCE                                                 AGAPTRAC
      *>****************************************************************AGAPTRAC
      *> Recherche libellés et aide.                                    AGAPTRAC
      *>----------------------------------------------------------------AGAPTRAC
      *> Appel au module xxTRAC :                                       AGAPTRAC
      *> - S8TRAC : module batch de trace et abend (à créer)            AGAPTRAC
      *> - S9TRAC : module CICS de trace et abend                       AGAPTRAC
      *>----------------------------------------------------------------AGAPTRAC
      *> SERVICE-TRACE-INIT                                             AGAPTRAC
      *> Initialisation de la zone message pour l'enregistrement des    AGAPTRAC
      *> trace.                                                         AGAPTRAC
      *>****************************************************************AGAPTRAC
      *CONTROL SOURCE                                                   AGAPTRAC
      *>                                                                AGAPTRAC
      *> --- Ecriture trace et éventuellement abend                     AGAPTRAC
       SERVICE-TRACE SECTION.                                           AGAPTRAC
       >>evaluate true                                                  AGAPTRAC
      *>  >>when AA-G-BATCH                                             AGAPTRAC
      *>    copy A8ZPTRAC.     *> TODO: créer le module S8TRAC          AGAPTRAC
         >>when AA-G-CICS                                               AGAPTRAC
           copy A9ZPTRAC.                                               AGAPTRAC
         >>when other                                                   AGAPTRAC
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AGAPTRAC
      *>>> Le service de trace n'est disponible actuellement que    <<< AGAPTRAC
      *>>> pour CICS. Contacter le support.                         <<< AGAPTRAC
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AGAPTRAC
       >>end-evaluate                                                   AGAPTRAC
           continue.                                                    AGAPTRAC
      *> --- Réinitialisation zone de communication trace               AGAPTRAC
           perform SERVICE-TRACE-INIT.                                  AGAPTRAC
       SERVICE-TRACE-FN.                                                AGAPTRAC
           exit section.                                                AGAPTRAC
      *>                                                                AGAPTRAC
      *> --- Initialisation de la clé pour les libellés spécifiques     AGAPTRAC
       SERVICE-TRACE-INIT SECTION.                                      AGAPTRAC
           move spaces to TRAC                                          AGAPTRAC
           set TRAC-TRACE-DB2 to false                                  AGAPTRAC
           set TRAC-ACTION-ANOMALIE to true.                            AGAPTRAC
       SERVICE-TRACE-INIT-FN.                                           AGAPTRAC
           exit section.                                                AGAPTRAC
