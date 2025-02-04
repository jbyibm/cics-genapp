      *CONTROL NOSOURCE                                                 ADADDATX
      *>****************************************************************ADADDATX
      *> Zone de communication module Gestion des Dates                 ADADDATX
      *> Confer TMR 11 0068                                             ADADDATX
      *>----------------------------------------------------------------ADADDATX
      *> Paramètres obligatoires :                                      ADADDATX
      *> - Néant                                                        ADADDATX
      *> Paramètres facultatifs (selon contexte) :                      ADADDATX
      *> - leading ZS : préfixe des zones du service                    ADADDATX
      *>****************************************************************ADADDATX
      *CONTROL SOURCE                                                   ADADDATX
       >>evaluate true                                                  ADADDATX
         >>when AA-G-BATCH                                              ADADDATX
           copy A8ZDDATX.                                               ADADDATX
         >>when AA-G-CICS                                               ADADDATX
           copy A9ZDDATX.                                               ADADDATX
         >>when other                                                   ADADDATX
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< ADADDATX
      *>>> Le service de Gestion des Dates n'est actuellement       <<< ADADDATX
      *>>> disponible que pour le Batch et le TP CICS.              <<< ADADDATX
      *>>> Contacter le support.                                    <<< ADADDATX
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< ADADDATX
       >>end-evaluate                                                   ADADDATX
