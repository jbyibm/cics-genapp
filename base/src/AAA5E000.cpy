       >>evaluate AA-A-MODE                                             AAA5E000
         >>when 'S'   *> Ecriture séquentielle                          AAA5E000
           copy AAA5ES00.                                               AAA5E000
         >>when 'R'   *> Ecriture directe                               AAA5E000
           copy AAA5ER00.                                               AAA5E000
         >>when 'D'   *> Ecriture dynamique                             AAA5E000
           copy AAA5ED00.                                               AAA5E000
         >>when other                                                   AAA5E000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5E000
      *>>> La variable 'AA-A-MODE' doit être valorisée à :          <<< AAA5E000
      *>>> - 'S' : écriture accès séquentiel                        <<< AAA5E000
      *>>> - 'R' : écriture accès direct (random)                   <<< AAA5E000
      *>>> - 'D' : écriture accès dynamique                         <<< AAA5E000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5E000
       >>end-evaluate                                                   AAA5E000
