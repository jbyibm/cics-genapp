      *>****************************************************************AAA5LSSY
      *> Accès logiques Lecture Séquentielle sans Rupture avec Synchro  AAA5LSSY
      *>****************************************************************AAA5LSSY
      *>                                                                AAA5LSSY
       OUVRIR-:DD: SECTION.                                             AAA5LSSY
           perform OUVRIR-:DD:-PHYSIQUE.                                AAA5LSSY
       OUVRIR-:DD:-FN.                                                  AAA5LSSY
           exit section.                                                AAA5LSSY
      *>                                                                AAA5LSSY
       LIRE-:DD: SECTION.                                               AAA5LSSY
           set :DD:-LU to false                                         AAA5LSSY
       >>define L_ as b'1'                                              AAA5LSSY
       >>evaluate true                                                  AAA5LSSY
         >>when AA-A-MAXNR <= 0                                         AAA5LSSY
           >>define L_ as b'0' override                                 AAA5LSSY
         >>when AA-A-NS > AA-A-MAXNR                                    AAA5LSSY
           >>define L_ as b'0' override                                 AAA5LSSY
         >>when AA-A-NR >= AA-A-NS                                      AAA5LSSY
           >>define L_ as b'0' override                                 AAA5LSSY
       >>end-evaluate                                                   AAA5LSSY
      *>>if maxNR > 0 and NS <= maxNR and NR < NS                       AAA5LSSY
       >>if L_                                                          AAA5LSSY
           if RTD:NS: not = '1' or :DD:-CF:NS: not = '1'                AAA5LSSY
       >>else                                                           AAA5LSSY
           if :DD:-CF:NS: not = '1'                                     AAA5LSSY
       >>end-if                                                         AAA5LSSY
       >>define L_ off                                                  AAA5LSSY
             exit section                                               AAA5LSSY
           end-if                                                       AAA5LSSY
           perform LIRE-:DD:-PHYSIQUE                                   AAA5LSSY
           if :DD:-FT = '1'                                             AAA5LSSY
             move high-value to :DD:IND                                 AAA5LSSY
             exit section                                               AAA5LSSY
           end-if                                                       AAA5LSSY
           perform ALIMENTER-CLE-:DD:                                   AAA5LSSY
           add 1 to 5-:DD:00-CPTENR.                                    AAA5LSSY
       LIRE-:DD:-FN.                                                    AAA5LSSY
           exit section.                                                AAA5LSSY
      *>                                                                AAA5LSSY
       FERMER-:DD: SECTION.                                             AAA5LSSY
           perform FERMER-:DD:-PHYSIQUE.                                AAA5LSSY
       FERMER-:DD:-FN.                                                  AAA5LSSY
           exit section.                                                AAA5LSSY
           copy AAA5L0SY.                                               AAA5LSSY
