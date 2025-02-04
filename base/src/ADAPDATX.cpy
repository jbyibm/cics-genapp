      *CONTROL NOSOURCE                                                 ADAPDATX
      *>****************************************************************ADAPDATX
      *> Appel du module Gestion des Dates                              ADAPDATX
      *> Confer TMR 11 0068                                             ADAPDATX
      *>----------------------------------------------------------------ADAPDATX
      *> Paramètres obligatoires :                                      ADAPDATX
      *> - Néant                                                        ADAPDATX
      *> Paramètres facultatifs (selon contexte) :                      ADAPDATX
      *> - leading ZS : préfixe des zones du service                    ADAPDATX
      *>****************************************************************ADAPDATX
      *CONTROL SOURCE                                                   ADAPDATX
       >>evaluate true                                                  ADAPDATX
         >>when AA-G-BATCH                                              ADAPDATX
           copy A8ZPDATX.                                               ADAPDATX
         >>when AA-G-CICS                                               ADAPDATX
           copy A9ZPDATX.                                               ADAPDATX
         >>when other                                                   ADAPDATX
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< ADAPDATX
      *>>> Le service de Gestion des Dates n'est actuellement       <<< ADAPDATX
      *>>> disponible que pour le Batch et le TP CICS.              <<< ADAPDATX
      *>>> Contacter le support.                                    <<< ADAPDATX
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< ADAPDATX
       >>end-evaluate                                                   ADAPDATX
