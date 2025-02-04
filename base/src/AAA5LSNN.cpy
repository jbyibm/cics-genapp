      *>****************************************************************AAA5LSNN
      *> Accès logiques Lecture Séquentielle sans Rupture ni Synchro    AAA5LSNN
      *>****************************************************************AAA5LSNN
      *>                                                                AAA5LSNN
       OUVRIR-:DD: SECTION.                                             AAA5LSNN
           perform OUVRIR-:DD:-PHYSIQUE.                                AAA5LSNN
       OUVRIR-:DD:-FN.                                                  AAA5LSNN
           exit section.                                                AAA5LSNN
      *>                                                                AAA5LSNN
       LIRE-:DD: SECTION.                                               AAA5LSNN
           set :DD:-LU to false                                         AAA5LSNN
       >>evaluate true                                                  AAA5LSNN
         >>when AA-A-NR = 0                                             AAA5LSNN
           if :DD:-FT = '0'                                             AAA5LSNN
         >>when other                                                   AAA5LSNN
           if :DD:-FR = '0'                                             AAA5LSNN
       >>end-evaluate                                                   AAA5LSNN
             perform LIRE-:DD:-PHYSIQUE                                 AAA5LSNN
       >>evaluate true                                                  AAA5LSNN
         >>when AA-A-NR = 0                                             AAA5LSNN
             if :DD:-FT not = '1'                                       AAA5LSNN
         >>when other                                                   AAA5LSNN
             if :DD:-FR not = '1'                                       AAA5LSNN
       >>end-evaluate                                                   AAA5LSNN
               add 1 to 5-:DD:00-CPTENR                                 AAA5LSNN
             end-if                                                     AAA5LSNN
           end-if.                                                      AAA5LSNN
       LIRE-:DD:-FN.                                                    AAA5LSNN
           exit section.                                                AAA5LSNN
      *>                                                                AAA5LSNN
       FERMER-:DD: SECTION.                                             AAA5LSNN
           perform FERMER-:DD:-PHYSIQUE.                                AAA5LSNN
       FERMER-:DD:-FN.                                                  AAA5LSNN
           exit section.                                                AAA5LSNN
