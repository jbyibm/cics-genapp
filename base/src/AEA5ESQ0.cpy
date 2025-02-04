      *CONTROL NOSOURCE                                                 AEA5ESQ0
      *>****************************************************************AEA5ESQ0
      *> Appel routine middleware Couche Echanges "SEPESQ0"             AEA5ESQ0
      *>----------------------------------------------------------------AEA5ESQ0
      *> Paramètres REPLACING obligatoires :                            AEA5ESQ0
      *> - :ZCDEM: : zone de communication Echanges Demandeur           AEA5ESQ0
      *>----------------------------------------------------------------AEA5ESQ0
      *> Variables de compilation locales :                             AEA5ESQ0
      *>****************************************************************AEA5ESQ0
      *CONTROL SOURCE                                                   AEA5ESQ0
      *> --- Middleware Couche Echanges - Ecrire Segment Question       AEA5ESQ0
      *>                                                                AEA5ESQ0
       ECH-ECRIRE-QUESTION SECTION.                                     AEA5ESQ0
           if ECH-MODE-SANS-ABEND                                       AEA5ESQ0
             exec cics                                                  AEA5ESQ0
               handle abend label (ECH-ECRIRE-QUESTION-HANDLE)          AEA5ESQ0
             end-exec                                                   AEA5ESQ0
             set ECH-SERVEUR-EN-ERREUR to true                          AEA5ESQ0
           end-if                                                       AEA5ESQ0
           exec cics                                                    AEA5ESQ0
             link program('SEPESQ0')                                    AEA5ESQ0
                  commarea(:ZCDEM:)                                     AEA5ESQ0
           end-exec                                                     AEA5ESQ0
           set ECH-SERVEUR-EN-ERREUR to false.                          AEA5ESQ0
       ECH-ECRIRE-QUESTION-HANDLE.                                      AEA5ESQ0
           if ECH-MODE-SANS-ABEND                                       AEA5ESQ0
             perform ECH-INIT-HANDLE-ABEND                              AEA5ESQ0
           end-if                                                       AEA5ESQ0
           if :ZCDEM:-ZCRC not = 000                                    AEA5ESQ0
      *>     Ecriture en SYSOUT                                         AEA5ESQ0
             move 'AAAPAAAAAAAACC000' to MESS-XCLER7                    AEA5ESQ0
             move spaces to MESS-WLE80                                  AEA5ESQ0
             move :ZCDEM:-ZCRC to MESS-WLE80                            AEA5ESQ0
             move 'Q504' to TRAC-WABCOD                                 AEA5ESQ0
             if not ECH-MODE-SANS-ABEND                                 AEA5ESQ0
               move 'C' to TRAC-CVSTTR                                  AEA5ESQ0
             end-if                                                     AEA5ESQ0
             perform ECH-TRACE-MESSAGE                                  AEA5ESQ0
           end-if                                                       AEA5ESQ0
           if ECH-SERVEUR-EN-ERREUR                                     AEA5ESQ0
              move 'AAAPAAAAAAAACE000' to MESS-XCLER7                   AEA5ESQ0
              move 'Q506' to TRAC-WABCOD                                AEA5ESQ0
              perform ECH-TRACE-MESSAGE                                 AEA5ESQ0
           end-if.                                                      AEA5ESQ0
       ECH-ECRIRE-QUESTION-FN.                                          AEA5ESQ0
           exit section.                                                AEA5ESQ0
