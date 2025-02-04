      *> Indicateur accès nouvel enregistrement lu                      AAA0L000
       01                              PIC X VALUE '0'.                 AAA0L000
                    88  :DD:-LU          VALUE '1'                      AAA0L000
                                       FALSE '0'.                       AAA0L000
       >>evaluate AA-A-MODE                                             AAA0L000
         >>when 'S'   *> Lecture séquentielle                           AAA0L000
           copy AAA0LS00.                                               AAA0L000
         >>when 'R'   *> Lecture directe                                AAA0L000
      *>   copy AAA0LR00.                                               AAA0L000
         >>when 'D'   *> Lecture dynamique                              AAA0L000
           copy AAA0LS00.                                               AAA0L000
         >>when other                                                   AAA0L000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA0L000
      *>>> La variable 'AA-A-MODE' doit être valorisée à :          <<< AAA0L000
      *>>> - 'S' : mode séquentiel                                  <<< AAA0L000
      *>>> - 'R' : mode direct (random)                             <<< AAA0L000
      *>>> - 'D' : mode dynamique                                   <<< AAA0L000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA0L000
       >>end-evaluate                                                   AAA0L000
