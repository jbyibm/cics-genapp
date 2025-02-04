      *CONTROL NOSOURCE                                                 AEA5LSQ0
      *>****************************************************************AEA5LSQ0
      *> Appel routine middleware Couche Echanges "SEPLSQ0"             AEA5LSQ0
      *>----------------------------------------------------------------AEA5LSQ0
      *> Paramètres REPLACING obligatoires :                            AEA5LSQ0
      *> - :ZCREP: : zone de communication Echanges Répondeur           AEA5LSQ0
      *>----------------------------------------------------------------AEA5LSQ0
      *> Variables de compilation locales :                             AEA5LSQ0
      *>****************************************************************AEA5LSQ0
      *CONTROL SOURCE                                                   AEA5LSQ0
      *>                                                                AEA5LSQ0
      *> --- Middleware Couche Echanges - Lire Segment Question         AEA5LSQ0
       ECH-LIRE-QUESTION SECTION.                                       AEA5LSQ0
           exec cics                                                    AEA5LSQ0
             link program('SEPLSQ0')                                    AEA5LSQ0
                  commarea(:ZCREP:)                                     AEA5LSQ0
           end-exec.                                                    AEA5LSQ0
       ECH-LIRE-QUESTION-FN.                                            AEA5LSQ0
           exit section.                                                AEA5LSQ0
