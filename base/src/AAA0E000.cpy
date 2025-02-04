       >>evaluate AA-A-MODE                                             AAA0E000
         >>when 'S'   *> Ecriture séquentielle                          AAA0E000
           copy AAA0ES00.                                               AAA0E000
         >>when 'R'   *> Ecriture directe                               AAA0E000
      *>    copy AAA0ER00.                                              AAA0E000
         >>when 'D'   *> Ecriture dynamique                             AAA0E000
      *>    copy AAA0ED00.                                              AAA0E000
         >>when other                                                   AAA0E000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA0E000
      *>>> La variable 'AA-A-MODE' doit être valorisée à :          <<< AAA0E000
      *>>> - 'S' : écriture accès séquentiel                        <<< AAA0E000
      *>>> - 'R' : écriture accès direct (random)                   <<< AAA0E000
      *>>> - 'D' : écriture accès dynamique                         <<< AAA0E000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA0E000
       >>end-evaluate                                                   AAA0E000
