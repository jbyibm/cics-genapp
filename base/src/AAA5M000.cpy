       >>evaluate AA-A-MODE                                             AAA5M000
         >>when 'S'   *> Modification séquentielle                      AAA0M000
      *>   copy AAA5MS00.                                               AAA5M000
         >>when 'R'   *> Modification directe                           AAA5M000
           copy AAA5MR00.    *> TODO : complétude accès ressources      AAA5M000
         >>when 'D'   *> Modification dynamique                         AAA5M000
      *>   copy AAA5MD00.    *> TODO : complétude accès ressources      AAA5M000
         >>when other                                                   AAA5M000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5M000
      *>>> La variable 'AA-A-MODE' doit être valorisée à :          <<< AAA5M000
      *>>> - 'S' : accès séquentiel                                 <<< AAA5M000
      *>>> - 'R' : accès direct (random)                            <<< AAA5M000
      *>>> - 'D' : accès dynamique                                  <<< AAA5M000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5M000
       >>end-evaluate                                                   AAA5M000
