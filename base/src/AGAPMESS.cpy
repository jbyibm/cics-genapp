      *CONTROL NOSOURCE                                                 AGAPMESS
      *>****************************************************************AGAPMESS
      *> Recherche libellés et aide.                                    AGAPMESS
      *>----------------------------------------------------------------AGAPMESS
      *> SERVICE-MESSAGE                                                AGAPMESS
      *> Appel au module xxMESS :                                       AGAPMESS
      *> - S8MESS : module batch de recherche des libellés              AGAPMESS
      *> - S9MESS : module CICS de recherche des libellés               AGAPMESS
      *>----------------------------------------------------------------AGAPMESS
      *> SERVICE-MESSAGE-INIT-PART                                      AGAPMESS
      *> Initialisation de la zone message pour une recherche de        AGAPMESS
      *> libellé explicite "MSGPART" (géré par $GM dans Pacbase).       AGAPMESS
      *>****************************************************************AGAPMESS
      *CONTROL SOURCE                                                   AGAPMESS
      *>                                                                AGAPMESS
      *> --- Recherche d'un libellé                                     AGAPMESS
       SERVICE-MESSAGE SECTION.                                         AGAPMESS
       >>evaluate true                                                  AGAPMESS
         >>when AA-G-BATCH                                              AGAPMESS
           copy A8ZPMESS.                                               AGAPMESS
         >>when AA-G-CICS                                               AGAPMESS
           copy A9ZPMESS.                                               AGAPMESS
         >>when other                                                   AGAPMESS
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AGAPMESS
      *>>> Le service d'accès messages n'est disponible qu'en BATCH <<< AGAPMESS
      *>>> et en CICS. Contacter le support.                        <<< AGAPMESS
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AGAPMESS
       >>end-evaluate                                                   AGAPMESS
           .                                                            AGAPMESS
       SERVICE-MESSAGE-FN.                                              AGAPMESS
           exit section.                                                AGAPMESS
      *>                                                                AGAPMESS
      *> --- Initialisation de la clé pour les libellés spécifiques     AGAPMESS
       SERVICE-MESSAGE-INIT-PART SECTION.                               AGAPMESS
           move SPACES to MESS                                          AGAPMESS
           move :MESS-APP: to MESS-XAPPLI                               AGAPMESS
           move :MESS-GRP: to MESS-XSEEC                                AGAPMESS
           move ZERO to MESS-XNLGN                                      AGAPMESS
       >>evaluate true                                                  AGAPMESS
         >>when AA-G-BATCH                                              AGAPMESS
           move 'Q' to MESS-XTYEN                                       AGAPMESS
         >>when AA-G-CICS                                               AGAPMESS
           move 'P' to MESS-XTYEN                                       AGAPMESS
       >>end-evaluate                                                   AGAPMESS
           move 'U' to MESS-WCOACT.                                     AGAPMESS
       SERVICE-MESSAGE-INIT-PART-FN.                                    AGAPMESS
           exit section.                                                AGAPMESS
