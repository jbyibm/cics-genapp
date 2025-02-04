      *CONTROL NOSOURCE                                                 AAAPGRTD
      *>****************************************************************AAAPGRTD
      *> Calcul des Ruptures Totales Dernières au niveau global         AAAPGRTD
      *>----------------------------------------------------------------AAAPGRTD
      *> Conditions d'utilisation :                                     AAAPGRTD
      *> Ce COPYBOOK doit être appelé après le calcul des Ruptures et   AAAPGRTD
      *> Synchronisations (Configuration) de chacune des ressources, et AAAPGRTD
      *> doit être suivi d'un appel à la routine "CALCULER-RTD-dd" de   AAAPGRTD
      *> chacune des ressources déclarées avec Ruptures et avec         AAAPGRTD
      *> Synchronisation.                                               AAAPGRTD
      *>----------------------------------------------------------------AAAPGRTD
      *> Paramètres obligatoires :                                      AAAPGRTD
      *> - Néant                                                        AAAPGRTD
      *> Paramètres facultatifs (selon contexte) :                      AAAPGRTD
      *> - Néant                                                        AAAPGRTD
      *> Variables de compilation :                                     AAAPGRTD
      *> - AA-A-MAXNR : calculée, niveau de rupture maximum toutes      AAAPGRTD
      *>   ressources                                                   AAAPGRTD
      *> - AA-A-MAXNS : calculée, niveau de synchronisation maximum     AAAPGRTD
      *>   toutes ressources                                            AAAPGRTD
      *>****************************************************************AAAPGRTD
      *CONTROL SOURCE                                                   AAAPGRTD
       >>if AA-A-MAXNR > 0 and AA-A-MAXNS > 0                           AAAPGRTD
           move RTD to RTP                                              AAAPGRTD
           move all '1' to RTD                                          AAAPGRTD
           move NRD to NRP                                              AAAPGRTD
           move 1 to NRD2 NRD                                           AAAPGRTD
       >>end-if                                                         AAAPGRTD
