      *CONTROL NOSOURCE                                                 AAAPGSYN
      *>****************************************************************AAAPGSYN
      *> Calcul des Configurations au niveau global                     AAAPGSYN
      *>----------------------------------------------------------------AAAPGSYN
      *> Conditions d'utilisation :                                     AAAPGSYN
      *> Ce COPYBOOK doit être appelé avant les appels aux routines     AAAPGSYN
      *> "CALCULER-CLE-dd" et CALCULER-CONF-dd" de chacune des          AAAPGSYN
      *> ressources déclarées avec Synchronisation.                     AAAPGSYN
      *>----------------------------------------------------------------AAAPGSYN
      *> Paramètres obligatoires :                                      AAAPGSYN
      *> - Néant                                                        AAAPGSYN
      *> Paramètres facultatifs (selon contexte) :                      AAAPGSYN
      *> - Néant                                                        AAAPGSYN
      *> Variables de compilation :                                     AAAPGSYN
      *> - AA-A-MAXNS : calculée, niveau de synchronisation maximum     AAAPGSYN
      *>   toutes ressources                                            AAAPGSYN
      *>****************************************************************AAAPGSYN
      *CONTROL SOURCE                                                   AAAPGSYN
       >>if AA-A-MAXNS > 0                                              AAAPGSYN
           move high-value to IND                                       AAAPGSYN
           move 0 to MAX-CF                                             AAAPGSYN
       >>end-if                                                         AAAPGSYN
