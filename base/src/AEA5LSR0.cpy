      *CONTROL NOSOURCE                                                 AEA5LSR0
      *>****************************************************************AEA5LSR0
      *> Appel routine middleware Couche Echanges "SEPLSR0"             AEA5LSR0
      *>----------------------------------------------------------------AEA5LSR0
      *> Paramètres REPLACING obligatoires :                            AEA5LSR0
      *> - :ZCDEM: : zone de communication Echanges Demandeur           AEA5LSR0
      *>----------------------------------------------------------------AEA5LSR0
      *> Variables de compilation locales :                             AEA5LSR0
      *>****************************************************************AEA5LSR0
      *CONTROL SOURCE                                                   AEA5LSR0
      *>                                                                AEA5LSR0
      *> --- Middleware Couche Echanges - Lire Segment Réponse          AEA5LSR0
       ECH-LIRE-REPONSE SECTION.                                        AEA5LSR0
           if ECH-MODE-SANS-ABEND                                       AEA5LSR0
             exec cics                                                  AEA5LSR0
               handle abend label (ECH-LIRE-REPONSE-HANDLE)             AEA5LSR0
             end-exec                                                   AEA5LSR0
             set ECH-SERVEUR-EN-ERREUR to true                          AEA5LSR0
           end-if                                                       AEA5LSR0
           exec cics                                                    AEA5LSR0
             link program('SEPLSR0')                                    AEA5LSR0
                  commarea(:ZCDEM:)                                     AEA5LSR0
           end-exec                                                     AEA5LSR0
           set ECH-SERVEUR-EN-ERREUR to false.                          AEA5LSR0
       ECH-LIRE-REPONSE-HANDLE.                                         AEA5LSR0
           if ECH-MODE-SANS-ABEND                                       AEA5LSR0
             perform ECH-INIT-HANDLE-ABEND                              AEA5LSR0
           end-if                                                       AEA5LSR0
           if :ZCDEM:-ZCRC = 500 and not ECH-MODE-SANS-ABEND            AEA5LSR0
             exec cics                                                  AEA5LSR0
               abend abcode ('Q500')                                    AEA5LSR0
             end-exec                                                   AEA5LSR0
           end-if                                                       AEA5LSR0
           if :ZCDEM:-ZCRC not = 0 and not = 100                        AEA5LSR0
             move 'AAAPAAAAAAAACD000' to MESS-XCLER7                    AEA5LSR0
             move :ZCDEM:-ZCRC to MESS-WLE80                            AEA5LSR0
             move 'Q505' to TRAC-WABCOD                                 AEA5LSR0
             if not ECH-MODE-SANS-ABEND                                 AEA5LSR0
               move 'C' to TRAC-CVSTTR                                  AEA5LSR0
             end-if                                                     AEA5LSR0
             perform ECH-TRACE-MESSAGE                                  AEA5LSR0
           end-if                                                       AEA5LSR0
           if ECH-SERVEUR-EN-ERREUR                                     AEA5LSR0
              move 'AAAPAAAAAAAACE000' to MESS-XCLER7                   AEA5LSR0
              move 'Q506' to TRAC-WABCOD                                AEA5LSR0
              perform ECH-TRACE-MESSAGE                                 AEA5LSR0
           end-if.                                                      AEA5LSR0
       ECH-LIRE-REPONSE-FN.                                             AEA5LSR0
           exit section.                                                AEA5LSR0
