      *CONTROL NOSOURCE                                                 AEA5ERR0
      *>****************************************************************AEA5ERR0
      *> Programme Q/R : gestion des erreurs                            AEA5ERR0
      *> ECH-HANDLE-ABEND : interception abend                          AEA5ERR0
      *> ECH-INIT-HANDLE-ABEND : initialisation interception abend      AEA5ERR0
      *> ECH-MESSAGE-INIT      : initialisation du module d'accès       AEA5ERR0
      *>                         libellés (S9MESS)                      AEA5ERR0
      *> ECH-MESSAGE-TEXTE     : recheche d'un libellé (S9MESS)ès       AEA5ERR0
      *> ECH-TRACE             : tracer une erreur                      AEA5ERR0
      *> ECH-TRACE-DB2         : tracer une erreur Db2 (avec abend)     AEA5ERR0
      *> ECH-TRACE-INIT        : initialisation du module de trace      AEA5ERR0
      *>                         (S9TRAC)                               AEA5ERR0
      *> ECH-TRACE-MESSAGE     : tracer une erreur avec recherche       AEA5ERR0
      *>                         de libellé                             AEA5ERR0
      *> ECH-TEST-DB2          : tester le résultat d'un accès Db2      AEA5ERR0
      *>----------------------------------------------------------------AEA5ERR0
      *> Paramètres REPLACING obligatoires :                            AEA5ERR0
      *> - :MESS-APP: : code application des libellés d'erreur          AEA5ERR0
      *> - :MESS-GRP: : groupe des libellés d'erreur                    AEA5ERR0
      *> - :ZCDEM: : zone de communication Echanges Demandeur           AEA5ERR0
      *> - :RR: : préfixe message Réponse Demandeur                     AEA5ERR0
      *> Paramètres REPLACING facultatifs (selon contexte) :            AEA5ERR0
      *> - leading TRAC : zone de communication du module de trace      AEA5ERR0
      *>                  xxTRAC (S9TRAC)                               AEA5ERR0
      *> - leading MESS : zone de communication recherche libellés      AEA5ERR0
      *>                  d'erreur xxMESS (S9MESS)                      AEA5ERR0
      *>----------------------------------------------------------------AEA5ERR0
      *> Variables de compilation locales :                             AEA5ERR0
      *>****************************************************************AEA5ERR0
      *CONTROL SOURCE                                                   AEA5ERR0
      *>                                                                AEA5ERR0
      *> --- Handle Abend                                               AEA5ERR0
       >>if AA-E-DEMANDEUR                                              AEA5ERR0
       ECH-HANDLE-ABEND SECTION.                                        AEA5ERR0
           if ECH-SERVEUR-EN-ERREUR or not ECH-MODE-SANS-ABEND          AEA5ERR0
             >>if AA-E-MULTICONV                                        AEA5ERR0
      *>     Purge des Messages Demandeurs                              AEA5ERR0
             set W-DEM0-SZCDEM to address of :ZCDEM:                    AEA5ERR0
             set W-DEM0-SWDEM0 to address of W-DEM0                     AEA5ERR0
             set W-DEM0-TRAVAIL to W-DEM0-SOMMET                        AEA5ERR0
             perform until W-DEM0-TRAVAIL = null                        AEA5ERR0
               set address of W-DEM0-ITEM to W-DEM0-TRAVAIL             AEA5ERR0
               set address of :ZCDEM: to W-DEM0-AZCDEM                  AEA5ERR0
               set address of W-DEM0  to W-DEM0-AWDEM0                  AEA5ERR0
               perform PURGER-REPONSES                                  AEA5ERR0
               set W-DEM0-TRAVAIL to W-DEM0-SUIVANT                     AEA5ERR0
             end-perform                                                AEA5ERR0
             set address of :ZCDEM: to W-DEM0-SZCDEM                    AEA5ERR0
             set address of W-DEM0  to W-DEM0-SWDEM0                    AEA5ERR0
             >>end-if                                                   AEA5ERR0
      *>     Appel routine Erreur Couche Echanges                       AEA5ERR0
             exec cics                                                  AEA5ERR0
               link program('SEPERR0') commarea(:ZCDEM:)                AEA5ERR0
             end-exec                                                   AEA5ERR0
             exec cics                                                  AEA5ERR0
               abend abcode('Q999') nodump                              AEA5ERR0
             end-exec                                                   AEA5ERR0
           end-if                                                       AEA5ERR0
      *>   Ce code ne devrait s'exécuter que si on est en mode no abend AEA5ERR0
           exec cics                                                    AEA5ERR0
             assign abcode(TRAC-WABCOD)                                 AEA5ERR0
           end-exec                                                     AEA5ERR0
           set TRAC-ACTION-ABEND to true                                AEA5ERR0
           perform ECH-TRACE.                                           AEA5ERR0
       ECH-HANDLE-ABEND-FN.                                             AEA5ERR0
           exit section.                                                AEA5ERR0
      *>                                                                AEA5ERR0
      *> --- Initialisation du module de trace (xxTRAC)                 AEA5ERR0
       ECH-INIT-HANDLE-ABEND SECTION.                                   AEA5ERR0
           exec cics                                                    AEA5ERR0
             handle abend label (ECH-HANDLE-ABEND)                      AEA5ERR0
           end-exec.                                                    AEA5ERR0
       ECH-INIT-HANDLE-ABEND-FN.                                        AEA5ERR0
           exit section.                                                AEA5ERR0
       >>end-if                                                         AEA5ERR0
      *>                                                                AEA5ERR0
      *> --- Initialisation de la recherche libellés                    AEA5ERR0
       ECH-MESSAGE-INIT SECTION.                                        AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99SR.                                                           AEA5ERR0
       >>end-if                                                         AEA5ERR0
           perform SERVICE-MESSAGE-INIT-PART.                           AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99SR-FN.                                                        AEA5ERR0
           exit paragraph.                                              AEA5ERR0
       >>end-if                                                         AEA5ERR0
       ECH-MESSAGE-INIT-FN.                                             AEA5ERR0
           exit section.                                                AEA5ERR0
      *>                                                                AEA5ERR0
      *> --- Recherche d'un libellé                                     AEA5ERR0
       ECH-MESSAGE-TEXTE SECTION.                                       AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99AM.                                                           AEA5ERR0
       >>end-if                                                         AEA5ERR0
           perform SERVICE-MESSAGE.                                     AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99AM-FN.                                                        AEA5ERR0
           exit paragraph.                                              AEA5ERR0
       >>end-if                                                         AEA5ERR0
       ECH-MESSAGE-TEXTE-FN.                                            AEA5ERR0
           exit section.                                                AEA5ERR0
      *>                                                                AEA5ERR0
      *> --- Vérifier si erreur Db2                                     AEA5ERR0
       >>if AA-A-DB2                                                    AEA5ERR0
       ECH-TEST-DB2 SECTION.                                            AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99EQ.                                                           AEA5ERR0
       >>end-if                                                         AEA5ERR0
           if SQLCODE < 0                                               AEA5ERR0
              perform ECH-TRACE-DB2                                     AEA5ERR0
           end-if.                                                      AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99EQ-FN.                                                        AEA5ERR0
           exit paragraph.                                              AEA5ERR0
       >>end-if                                                         AEA5ERR0
       ECH-TEST-DB2-FN.                                                 AEA5ERR0
           exit section.                                                AEA5ERR0
       >>end-if                                                         AEA5ERR0
      *>                                                                AEA5ERR0
      *> --- Ecrire trace                                               AEA5ERR0
       ECH-TRACE SECTION.                                               AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99ES.                                                           AEA5ERR0
       >>end-if                                                         AEA5ERR0
           move PROGE  to TRAC-IDSGPR                                   AEA5ERR0
           move COBASE to TRAC-IDSTPA                                   AEA5ERR0
           move APPLI  to TRAC-COSTBI                                   AEA5ERR0
           move NUGNA  to TRAC-IDSTSE                                   AEA5ERR0
           perform SERVICE-TRACE.                                       AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99ES-FN.                                                        AEA5ERR0
           exit paragraph.                                              AEA5ERR0
       >>end-if                                                         AEA5ERR0
       ECH-TRACE-FN.                                                    AEA5ERR0
           exit section.                                                AEA5ERR0
      *>                                                                AEA5ERR0
      *> --- Ecrire trace erreur Db2                                    AEA5ERR0
       >>if AA-A-DB2                                                    AEA5ERR0
       ECH-TRACE-DB2 SECTION.                                           AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99ER.                                                           AEA5ERR0
       >>end-if                                                         AEA5ERR0
           move SQLERRMC (1:SQLERRML) to TRAC-LLSTME                    AEA5ERR0
           move SQLCODE to W-TRAC-SQLCODE                               AEA5ERR0
           move W-TRAC-ABEND-DB2 to TRAC-WABCOD                         AEA5ERR0
           set TRAC-TRACE-DB2 to true                                   AEA5ERR0
           set TRAC-ACTION-ABEND to true                                AEA5ERR0
           perform ECH-TRACE.                                           AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99ER-FN.                                                        AEA5ERR0
           exit paragraph.                                              AEA5ERR0
       >>end-if                                                         AEA5ERR0
       ECH-TRACE-DB2-FN.                                                AEA5ERR0
           exit section.                                                AEA5ERR0
       >>end-if                                                         AEA5ERR0
      *>                                                                AEA5ERR0
      *> --- Initialisation de la trace                                 AEA5ERR0
       ECH-TRACE-INIT SECTION.                                          AEA5ERR0
           perform SERVICE-TRACE-INIT.                                  AEA5ERR0
       ECH-TRACE-INIT-FN.                                               AEA5ERR0
           exit section.                                                AEA5ERR0
      *>                                                                AEA5ERR0
      *> --- Ecrire trace avec recherche libellé erreur                 AEA5ERR0
       ECH-TRACE-MESSAGE SECTION.                                       AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99SP.                                                           AEA5ERR0
       >>end-if                                                         AEA5ERR0
           move MESS-XCLER7 to TRAC-XCLER7                              AEA5ERR0
           perform ECH-MESSAGE-TEXTE                                    AEA5ERR0
           move MESS-WLE80 to TRAC-LLSTME                               AEA5ERR0
           perform ECH-TRACE.                                           AEA5ERR0
       >>if AA-G-PACBASE                                                AEA5ERR0
       F99SP-FN.                                                        AEA5ERR0
           exit paragraph.                                              AEA5ERR0
       >>end-if                                                         AEA5ERR0
       ECH-TRACE-MESSAGE-FN.                                            AEA5ERR0
           exit section.                                                AEA5ERR0
