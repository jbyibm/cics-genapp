       >>evaluate AA-A-MODE                                             AAA5X000
         >>when 'S'   *> Lecture séquentielle                           AAA5X000
           copy AAA5XS00.                                               AAA5X000
         >>when 'R'   *> Lecture directe                                AAA5X000
           copy AAA5XR00.                                               AAA5X000
         >>when 'D'   *> Lecture dynamique                              AAA5X000
           copy AAA5XD00.                                               AAA5X000
         >>when other                                                   AAA5X000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5X000
      *>>> La variable 'AA-A-MODE' doit être valorisée à :          <<< AAA5X000
      *>>> - 'S' : accès séquentiel                                 <<< AAA5X000
      *>>> - 'R' : accès direct (random)                            <<< AAA5X000
      *>>> - 'D' : accès dynamique                                  <<< AAA5X000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5X000
       >>end-evaluate                                                   AAA5X000
