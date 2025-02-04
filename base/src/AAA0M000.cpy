      *> - Créations                                                    AAA0M000
       01               5-:DD:C0-CPTENR PIC  S9(9) binary value 0.      AAA0M000
      *> - Modifications                                                AAA0M000
       01               5-:DD:M0-CPTENR PIC  S9(9) binary value 0.      AAA0M000
      *> - Suppressions                                                 AAA0M000
       01               5-:DD:S0-CPTENR PIC  S9(9) binary value 0.      AAA0M000
       >>evaluate AA-A-MODE                                             AAA0M000
         >>when 'S'   *> Modification séquentielle                      AAA0M000
           copy AAA0ES00.                                               AAA0M000
         >>when 'R'   *> Modification directe                           AAA0M000
      *>   copy AAA0MR00.    *> TODO : complétude accès ressources      AAA0M000
         >>when 'D'   *> Modification dynamique                         AAA0M000
      *>   copy AAA0MD00.    *> TODO : complétude accès ressources      AAA0M000
         >>when other                                                   AAA0M000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA0M000
      *>>> La variable 'AA-A-MODE' doit être valorisée à :          <<< AAA0M000
      *>>> - 'S' : accès séquentiel                                 <<< AAA0M000
      *>>> - 'R' : accès direct (random)                            <<< AAA0M000
      *>>> - 'D' : accès dynamique                                  <<< AAA0M000
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA0M000
       >>end-evaluate                                                   AAA0M000
