       >>evaluate true                                                  AAA5LR00
         >>when AA-A-NR <= 0 and AA-A-NS = 0   *> sans Rupt ni Sync     AAA5LR00
           copy AAA5LRNN.                                               AAA5LR00
         >>when other                          *> avec Rupt et Sync     AAA5LR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5LR00
      *>>> Rupture ou synchro sur accès Direct.                     <<< AAA5LR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5LR00
       >>end-evaluate                                                   AAA5LR00
       >>evaluate AA-A-ORG                                              AAA5LR00
         >>when '2'                  *> Accès Db2                       AAA5LR00
           copy AAA5LR20.                                               AAA5LR00
         >>when 'K'                  *> Fichier VSAM KSDS               AAA5LR00
           copy AAA5LRV0.                                               AAA5LR00
         >>when 'R'                  *> Fichier VSAM RRDS               AAA5LR00
           copy AAA5LRV0.                                               AAA5LR00
         >>when other                                                   AAA5LR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5LR00
      *>>> La variable 'AA-A-ORG' doit être valorisée à :           <<< AAA5LR00
      *>>> - '2' : ressource Db2                                    <<< AAA5LR00
      *>>> - 'K' : fichier VSAM KSDS                                <<< AAA5LR00
      *>>> - 'R' : fichier VSAM RRDS                                <<< AAA5LR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5LR00
       >>end-evaluate                                                   AAA5LR00
