      *CONTROL NOSOURCE                                                 AEA5DEM0
      *>****************************************************************AEA5DEM0
      *> Programme Q/R : fonctions "Demandeur".                         AEA5DEM0
      *>                                                                AEA5DEM0
      *> Ce code est mutualisé pour l'ensemble des Q/R appelées.        AEA5DEM0
      *>----------------------------------------------------------------AEA5DEM0
      *> Paramètres REPLACING obligatoires :                            AEA5DEM0
      *> - :ZCDEM: : zone de communication Echanges Demandeur           AEA5DEM0
      *>----------------------------------------------------------------AEA5DEM0
      *> Variables de compilation locales :                             AEA5DEM0
      *>****************************************************************AEA5DEM0
      *CONTROL SOURCE                                                   AEA5DEM0
      *>                                                                AEA5DEM0
      *>================================================================AEA5DEM0
      *> III  N   N  III  TTTTT            DDDD   EEEEE  M   M          AEA5DEM0
      *>  I   NN  N   I     T              D   D  E      MM MM          AEA5DEM0
      *>  I   N N N   I     T              D   D  EEEE   M M M          AEA5DEM0
      *>  I   N  NN   I     T    ..        D   D  E      M   M          AEA5DEM0
      *> III  N   N  III    T    ..        DDDD   EEEEE  M   M          AEA5DEM0
      *>================================================================AEA5DEM0
      *>                                                                AEA5DEM0
       INITIALISER-DEMANDEUR SECTION.                                   AEA5DEM0
           move low-value to :ZCDEM:                                    AEA5DEM0
           set F-DEM0-INITIAL to true.                                  AEA5DEM0
           >>if AA-E-MULTICONV                                          AEA5DEM0
      *> --- Pile chainée des Demandeurs (gestion des abends)           AEA5DEM0
           exec cics                                                    AEA5DEM0
             getmain set(W-DEM0-TRAVAIL)                                AEA5DEM0
                     flength(length of W-DEM0-ITEM)                     AEA5DEM0
           end-exec                                                     AEA5DEM0
           set address of W-DEM0-ITEM to W-DEM0-TRAVAIL                 AEA5DEM0
           set W-DEM0-AZCDEM  to address of :ZCDEM:                     AEA5DEM0
           set W-DEM0-AWDEM0  to address of W-DEM0                      AEA5DEM0
           set W-DEM0-SUIVANT to W-DEM0-SOMMET                          AEA5DEM0
           set W-DEM0-SOMMET  to W-DEM0-TRAVAIL.                        AEA5DEM0
           >>end-if                                                     AEA5DEM0
       INITIALISER-DEMANDEUR-FN.                                        AEA5DEM0
           exit section.                                                AEA5DEM0
      *>                                                                AEA5DEM0
      *>================================================================AEA5DEM0
      *> EEEEE   CCC   RRRR   III             QQQ    SSSS  TTTTT        AEA5DEM0
      *> E      C   C  R   R   I             Q   Q  S        T          AEA5DEM0
      *> EEEE   C      RRRR    I             Q   Q   SSS     T          AEA5DEM0
      *> E      C   C  R  R    I   ..        Q  QQ      S    T          AEA5DEM0
      *> EEEEE   CCC   R   R  III  ..         QQ Q  SSSS     T          AEA5DEM0
      *>================================================================AEA5DEM0
      *>                                                                AEA5DEM0
       ECRIRE-QUESTION SECTION.                                         AEA5DEM0
       >>if AA-G-PACBASE                                                AEA5DEM0
       F97CB.                                                           AEA5DEM0
       >>end-if                                                         AEA5DEM0
           perform VERIFIER-LECTURE-REPONSES                            AEA5DEM0
           if F-DEM0-INITIAL or F-DEM0-PREMIERE-QUESTION                AEA5DEM0
             set F-DEM0-PREMIERE-QUESTION to true                       AEA5DEM0
           else                                                         AEA5DEM0
             set F-DEM0-QUESTION-SUIVANTE to true                       AEA5DEM0
           end-if                                                       AEA5DEM0
           set :ZCDEM:-ZCPTSQ to W-DEM0-ZCPTSQ                          AEA5DEM0
           perform ECH-ECRIRE-QUESTION.                                 AEA5DEM0
       >>if AA-G-PACBASE                                                AEA5DEM0
       F97CB-FN.                                                        AEA5DEM0
           exit paragraph.                                              AEA5DEM0
       >>end-if                                                         AEA5DEM0
       ECRIRE-QUESTION-FN.                                              AEA5DEM0
           exit section.                                                AEA5DEM0
      *>                                                                AEA5DEM0
      *>****************************************************************AEA5DEM0
      *> FFFFF  III  N   N    A    L           DDDD   EEEEE  M   M      AEA5DEM0
      *> F       I   NN  N   A A   L           D   D  E      MM MM      AEA5DEM0
      *> FFFF    I   N N N  A   A  L           D   D  EEEE   M M M      AEA5DEM0
      *> F       I   N  NN  AAAAA  L           D   D  E      M   M      AEA5DEM0
      *> F      III  N   N  A   A  LLLLL       DDDD   EEEEE  M   M      AEA5DEM0
      *>****************************************************************AEA5DEM0
      *>                                                                AEA5DEM0
       FINALISER-DEMANDEUR SECTION.                                     AEA5DEM0
           perform VERIFIER-LECTURE-REPONSES                            AEA5DEM0
           if F-DEM0-DERNIERE-REPONSE or F-DEM0-QUESTION-SUIVANTE       AEA5DEM0
             exec cics                                                  AEA5DEM0
               freemain datapointer (W-DEM0-ZCPTSR) nohandle            AEA5DEM0
             end-exec                                                   AEA5DEM0
             set W-DEM0-ZCPTSR to null                                  AEA5DEM0
           end-if.                                                      AEA5DEM0
       FINALISER-DEMANDEUR-FN.                                          AEA5DEM0
           exit section.                                                AEA5DEM0
      *>                                                                AEA5DEM0
      *>================================================================AEA5DEM0
      *> L      EEEEE   CCC   TTTTT            RRRR   EEEEE  PPPP       AEA5DEM0
      *> L      E      C   C    T              R   R  E      P   P      AEA5DEM0
      *> L      EEEE   C        T              RRRR   EEEE   PPPP       AEA5DEM0
      *> L      E      C   C    T    ..        R  R   E      P          AEA5DEM0
      *> LLLLL  EEEEE   CCC     T    ..        R   R  EEEEE  P          AEA5DEM0
      *>================================================================AEA5DEM0
      *>                                                                AEA5DEM0
       LIRE-REPONSE SECTION.                                            AEA5DEM0
       >>if AA-G-PACBASE                                                AEA5DEM0
       F97DB.                                                           AEA5DEM0
       >>end-if                                                         AEA5DEM0
           if F-DEM0-QUESTION-SUIVANTE                                  AEA5DEM0
             exec cics                                                  AEA5DEM0
               freemain datapointer (W-DEM0-ZCPTSR) nohandle            AEA5DEM0
             end-exec                                                   AEA5DEM0
             set W-DEM0-ZCPTSR to null                                  AEA5DEM0
           end-if                                                       AEA5DEM0
           perform ECH-LIRE-REPONSE                                     AEA5DEM0
           set address of MESSAGE-RECU to :ZCDEM:-ZCPTSR                AEA5DEM0
           set W-DEM0-ZCPTSR to :ZCDEM:-ZCPTSR                          AEA5DEM0
           evaluate :ZCDEM:-ZCRC                                        AEA5DEM0
             when 0                                                     AEA5DEM0
               set F-DEM0-REPONSES-A-LIRE to true                       AEA5DEM0
             when 500                                                   AEA5DEM0
               set F-DEM0-INITIAL to true                               AEA5DEM0
             when other                                                 AEA5DEM0
               set F-DEM0-DERNIERE-REPONSE to true                      AEA5DEM0
           end-evaluate.                                                AEA5DEM0
       >>if AA-G-PACBASE                                                AEA5DEM0
       F97DB-FN.                                                        AEA5DEM0
           exit paragraph.                                              AEA5DEM0
       >>end-if                                                         AEA5DEM0
       LIRE-REPONSE-FN.                                                 AEA5DEM0
           exit section.                                                AEA5DEM0
      *>                                                                AEA5DEM0
      *>================================================================AEA5DEM0
      *> PPPP   U   U  RRRR    GGG             RRRR   EEEEE  PPPP       AEA5DEM0
      *> P   P  U   U  R   R  G                R   R  E      P   P      AEA5DEM0
      *> PPPP   U   U  RRRR   G  GG            RRRR   EEEE   PPPP       AEA5DEM0
      *> P      U   U  R  R   G   G  ..        R  R   E      P          AEA5DEM0
      *> P       UUU   R   R   GGG   ..        R   R  EEEEE  P          AEA5DEM0
      *>================================================================AEA5DEM0
      *>                                                                AEA5DEM0
       PURGER-REPONSES SECTION.                                         AEA5DEM0
           perform until not F-DEM0-REPONSES-A-LIRE                     AEA5DEM0
             perform LIRE-REPONSE                                       AEA5DEM0
           end-perform.                                                 AEA5DEM0
       PURGER-REPONSES-FN.                                              AEA5DEM0
           exit section.                                                AEA5DEM0
      *>                                                                AEA5DEM0
      *>****************************************************************AEA5DEM0
      *> V   V  EEEEE  RRRR   III  FFFFF       RRRR   EEEEE  PPPP       AEA5DEM0
      *> V   V  E      R   R   I   F           R   R  E      P   P      AEA5DEM0
      *> V   V  EEEE   RRRR    I   FFFF        RRRR   EEEE   PPPP       AEA5DEM0
      *>  V V   E      R  R    I   F           R  R   E      P          AEA5DEM0
      *>   V    EEEEE  R   R  III  F           R   R  EEEEE  P          AEA5DEM0
      *>****************************************************************AEA5DEM0
      *>                                                                AEA5DEM0
       VERIFIER-LECTURE-REPONSES SECTION.                               AEA5DEM0
           if F-DEM0-REPONSES-A-LIRE                                    AEA5DEM0
             exec cics                                                  AEA5DEM0
               abend abcode('Q501')                                     AEA5DEM0
             end-exec                                                   AEA5DEM0
           end-if.                                                      AEA5DEM0
       VERIFIER-LECTURE-REPONSES-FN.                                    AEA5DEM0
           exit section.                                                AEA5DEM0
