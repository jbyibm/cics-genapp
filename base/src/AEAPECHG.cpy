      *CONTROL NOSOURCE                                                 AEAPECHG
      *>****************************************************************AEAPECHG
      *> Programme Q/R : routines de services                           AEAPECHG
      *>----------------------------------------------------------------AEAPECHG
      *> Paramètres REPLACING obligatoires :                            AEAPECHG
      *> - :MESS-APP: : code application des libellés d'erreur          AEAPECHG
      *> - :MESS-GRP: : groupe des libellés d'erreur                    AEAPECHG
      *> - :ZCREP: : zone de communication Echanges si Répondeur        AEAPECHG
      *> - :ZCDEM: : zone de communication Echanges si Demandeur(s)     AEAPECHG
      *> - :RR: : préfixe message Réponse Demandeur                     AEAPECHG
      *> Paramètres REPLACING facultatifs (selon contexte) :            AEAPECHG
      *> - leading TRAC : zone de communication du module de trace      AEAPECHG
      *>                  xxTRAC (S9TRAC)                               AEAPECHG
      *> - leading MESS : zone de communication recherche libellés      AEAPECHG
      *>                  d'erreur xxMESS (S9MESS)                      AEAPECHG
      *>----------------------------------------------------------------AEAPECHG
      *> Variables de compilation locales :                             AEAPECHG
      *>****************************************************************AEAPECHG
      *CONTROL SOURCE                                                   AEAPECHG
       >>if AA-E-REPONDEUR                                              AEAPECHG
           copy AEA5REP0.                                               AEAPECHG
           copy AEA5LSQ0.                                               AEAPECHG
           copy AEA5ESR0.                                               AEAPECHG
       >>end-if                                                         AEAPECHG
       >>if AA-E-DEMANDEUR                                              AEAPECHG
           copy AEA5DEM0.                                               AEAPECHG
           copy AEA5ESQ0.                                               AEAPECHG
           copy AEA5LSR0.                                               AEAPECHG
       >>end-if                                                         AEAPECHG
           copy AEA5ERR0.                                               AEAPECHG
