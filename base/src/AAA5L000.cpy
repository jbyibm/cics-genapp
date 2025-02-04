       >>evaluate AA-A-MODE                                             AAA5L000
         >>when 'S'   *> Lecture séquentielle                           AAA5L000
           copy AAA5LS00.                                               AAA5L000
         >>when 'R'   *> Lecture directe                                AAA5L000
           copy AAA5LR00.                                               AAA5L000
         >>when 'D'   *> Lecture dynamique                              AAA5L000
           copy AAA5LD00.                                               AAA5L000
         >>when other                                                   AAA5L000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5L000
      *>>> La variable 'AA-A-MODE' doit être valorisée à :          <<< AAA5L000
      *>>> - 'S' : accès séquentiel                                 <<< AAA5L000
      *>>> - 'R' : accès direct (random)                            <<< AAA5L000
      *>>> - 'D' : accès dynamique                                  <<< AAA5L000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5L000
       >>end-evaluate                                                   AAA5L000
