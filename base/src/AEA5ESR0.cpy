      *CONTROL NOSOURCE                                                 AEA5ESR0
      *>****************************************************************AEA5ESR0
      *> Appel routine middleware Couche Echanges "SEPESR0"             AEA5ESR0
      *>----------------------------------------------------------------AEA5ESR0
      *> Paramètres REPLACING obligatoires :                            AEA5ESR0
      *> - :ZCREP: : zone de communication Echanges Répondeur           AEA5ESR0
      *>----------------------------------------------------------------AEA5ESR0
      *> Variables de compilation locales :                             AEA5ESR0
      *>****************************************************************AEA5ESR0
      *CONTROL SOURCE                                                   AEA5ESR0
      *>                                                                AEA5ESR0
      *> --- Middleware Couche Echanges - Ecrire Segment Réponse        AEA5ESR0
       ECH-ECRIRE-REPONSE SECTION.                                      AEA5ESR0
           exec cics                                                    AEA5ESR0
             link program('SEPESR0')                                    AEA5ESR0
                  commarea(:ZCREP:)                                     AEA5ESR0
           end-exec                                                     AEA5ESR0
           if :ZCREP:-ZCRC not = 0                                      AEA5ESR0
      *>     Ecriture en SYSOUT                                         AEA5ESR0
             move 'AAAPAAAAAAAACB000' to MESS-XCLER7                    AEA5ESR0
             move spaces to MESS-WLE80                                  AEA5ESR0
             move :ZCREP:-ZCRC to MESS-WLE80                            AEA5ESR0
             move 'Q503' to TRAC-WABCOD                                 AEA5ESR0
             move 'C' to TRAC-CVSTTR                                    AEA5ESR0
             perform ECH-TRACE-MESSAGE                                  AEA5ESR0
           end-if.                                                      AEA5ESR0
       ECH-ECRIRE-REPONSE-FN.                                           AEA5ESR0
           exit section.                                                AEA5ESR0
