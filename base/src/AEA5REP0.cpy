      *CONTROL NOSOURCE                                                 AEA5REP0
      *>****************************************************************AEA5REP0
      *> Programme Q/R : fonctions Répondeur                            AEA5REP0
      *>----------------------------------------------------------------AEA5REP0
      *> Paramètres REPLACING obligatoires :                            AEA5REP0
      *> - :ZCREP: : zone de communication Echanges Répondeur           AEA5REP0
      *> - :RR:    : préfixe des zones Message Réponse                  AEA5REP0
      *>----------------------------------------------------------------AEA5REP0
      *> Variables de compilation locales :                             AEA5REP0
      *>****************************************************************AEA5REP0
      *CONTROL SOURCE                                                   AEA5REP0
      *>                                                                AEA5REP0
      *>================================================================AEA5REP0
      *> L      EEEEE   CCC   TTTTT             QQQ    SSSS  TTTTT      AEA5REP0
      *> L      E      C   C    T              Q   Q  S        T        AEA5REP0
      *> L      EEEE   C        T              Q   Q   SSS     T        AEA5REP0
      *> L      E      C   C    T    ..        Q  QQ      S    T        AEA5REP0
      *> LLLLL  EEEEE   CCC     T    ..         QQ Q  SSSS     T        AEA5REP0
      *>================================================================AEA5REP0
      *>                                                                AEA5REP0
       LIRE-QUESTION SECTION.                                           AEA5REP0
           if DERNIERE-QUESTION                                         AEA5REP0
             set FIN-QUESTIONS to true                                  AEA5REP0
             exit section                                               AEA5REP0
           end-if                                                       AEA5REP0
           perform ECH-LIRE-QUESTION                                    AEA5REP0
           move :ZCREP:-ZCRC to W-AR00-ZCRC                             AEA5REP0
           if :ZCREP:-ZCRC = 100                                        AEA5REP0
             set DERNIERE-QUESTION to true                              AEA5REP0
             move 0 to :ZCREP:-ZCRC                                     AEA5REP0
           end-if                                                       AEA5REP0
           if W-AR00-ZCRC = 000 or 100                                  AEA5REP0
             set address of MESSAGE-RECU to :ZCREP:-ZCPTSQ              AEA5REP0
             move MESSAGE-RECU (1:MESSAGE-RECU-LENGTH)                  AEA5REP0
               to QUESTION-REP                                          AEA5REP0
           else                                                         AEA5REP0
             move 'AAAPAAAAAAAACA000' to MESS-XCLER7                    AEA5REP0
             move W-AR00-ZCRC to MESS-WLE80                             AEA5REP0
             move 'Q502' to TRAC-WABCOD                                 AEA5REP0
             move 'C' to TRAC-CVSTTR                                    AEA5REP0
             perform ECH-TRACE-MESSAGE                                  AEA5REP0
           end-if.                                                      AEA5REP0
       LIRE-QUESTION-FN.                                                AEA5REP0
           exit section.                                                AEA5REP0
      *>                                                                AEA5REP0
      *>================================================================AEA5REP0
      *> EEEEE   CCC   RRRR   III            RRRR   EEEEE  PPPP         AEA5REP0
      *> E      C   C  R   R   I             R   R  E      P   P        AEA5REP0
      *> EEEE   C      RRRR    I             RRRR   EEEE   PPPP         AEA5REP0
      *> E      C   C  R  R    I   ..        R  R   E      P            AEA5REP0
      *> EEEEE   CCC   R   R  III  ..        R   R  EEEEE  P            AEA5REP0
      *>================================================================AEA5REP0
      *>                                                                AEA5REP0
       ECRIRE-REPONSE SECTION.                                          AEA5REP0
       >>if AA-G-PACBASE                                                AEA5REP0
       F97BB.                                                           AEA5REP0
       >>end-if                                                         AEA5REP0
           perform ECH-ECRIRE-REPONSE.                                  AEA5REP0
       >>if AA-G-PACBASE                                                AEA5REP0
       F97BB-FN.                                                        AEA5REP0
           exit paragraph.                                              AEA5REP0
       >>end-if                                                         AEA5REP0
       ECRIRE-REPONSE-FN.                                               AEA5REP0
           exit section.                                                AEA5REP0
      *>                                                                AEA5REP0
      *> --- Ecrire une Réponse AISA06 avec clé libellé fournie         AEA5REP0
       ECRIRE-REPONSE-AISA06-CLE SECTION.                               AEA5REP0
       >>if AA-G-PACBASE                                                AEA5REP0
       F99AL.                                                           AEA5REP0
       >>end-if                                                         AEA5REP0
           perform ECH-MESSAGE-TEXTE                                    AEA5REP0
           perform ECRIRE-REPONSE-AISA06-TEXTE.                         AEA5REP0
       >>if AA-G-PACBASE                                                AEA5REP0
       F99AL-FN.                                                        AEA5REP0
           exit paragraph.                                              AEA5REP0
       >>end-if                                                         AEA5REP0
       ECRIRE-REPONSE-AISA06-CLE-FN.                                    AEA5REP0
           exit section.                                                AEA5REP0
      *>                                                                AEA5REP0
      *> --- Ecrire une Réponse AISA06 avec texte libellé fourni        AEA5REP0
       ECRIRE-REPONSE-AISA06-TEXTE SECTION.                             AEA5REP0
       >>if AA-G-PACBASE                                                AEA5REP0
       F99AR.                                                           AEA5REP0
       >>end-if                                                         AEA5REP0
           move 106 to :RR:00-WLGQR                                     AEA5REP0
           move 'RAISA06 ' to :RR:00-WLNQR                              AEA5REP0
           move MESS-XAPPLI to :RR:06-WCODM                             AEA5REP0
           move MESS-WLE80 to :RR:06-WLE80                              AEA5REP0
           if MESS-WCORE3 = 0 and                                       AEA5REP0
             (MESS-XGRAER = 'I' or 'W' or ' ' or                        AEA5REP0
             (MESS-XGRAER >= '0' and < '5'))                            AEA5REP0
             move 000 to :RR:06-WCORE3                                  AEA5REP0
           else                                                         AEA5REP0
             move 001 to :RR:06-WCORE3                                  AEA5REP0
           end-if                                                       AEA5REP0
           move MESS-WCOLE to :RR:06-WCOLE                              AEA5REP0
           perform ECRIRE-REPONSE.                                      AEA5REP0
       >>if AA-G-PACBASE                                                AEA5REP0
       F99AR-FN.                                                        AEA5REP0
           exit paragraph.                                              AEA5REP0
       >>end-if                                                         AEA5REP0
       ECRIRE-REPONSE-AISA06-TEXTE-FN.                                  AEA5REP0
           exit section.                                                AEA5REP0
