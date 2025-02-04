      *>****************************************************************AAA5LSRS
      *> Accès logiques Lecture Séquentielle avec Ruptures et Synchros  AAA5LSRS
      *>****************************************************************AAA5LSRS
      *>                                                                AAA5LSRS
       OUVRIR-:DD: SECTION.                                             AAA5LSRS
           perform OUVRIR-:DD:-PHYSIQUE                                 AAA5LSRS
           perform LIRE-:DD:-PHYSIQUE.                                  AAA5LSRS
       OUVRIR-:DD:-FN.                                                  AAA5LSRS
           exit section.                                                AAA5LSRS
      *>                                                                AAA5LSRS
       LIRE-:DD: SECTION.                                               AAA5LSRS
           set :DD:-LU to false                                         AAA5LSRS
       >>define L_ as b'1'                                              AAA5LSRS
       >>evaluate true                                                  AAA5LSRS
         >>when AA-A-MAXNR <= 0                                         AAA5LSRS
           >>define L_ as b'0' override                                 AAA5LSRS
         >>when AA-A-NS > AA-A-MAXNR                                    AAA5LSRS
           >>define L_ as b'0' override                                 AAA5LSRS
         >>when AA-A-NR >= AA-A-NS                                      AAA5LSRS
           >>define L_ as b'0' override                                 AAA5LSRS
       >>end-evaluate                                                   AAA5LSRS
      *>>if maxNR > 0 and NS <= maxNR and NR < NS                       AAA5LSRS
       >>if L_                                                          AAA5LSRS
           if RTD:NS: not = '1' or :DD:-CF:NS: not = '1'                AAA5LSRS
       >>else                                                           AAA5LSRS
           if :DD:-CF:NS: not = '1'                                     AAA5LSRS
       >>end-if                                                         AAA5LSRS
       >>define L_ off                                                  AAA5LSRS
             exit section                                               AAA5LSRS
           end-if                                                       AAA5LSRS
      *> Alimentation anticipée des indicateurs "Rupture Première"      AAA5LSRS
           move :DD:-DE to :DD:-PE                                      AAA5LSRS
           move :DD:-NRD to :DD:-NRP                                    AAA5LSRS
           if :DD:-FI = '1'                                             AAA5LSRS
             move high-value to :DD:IND                                 AAA5LSRS
             move '1' to :DD:-FT                                        AAA5LSRS
             exit section                                               AAA5LSRS
           end-if                                                       AAA5LSRS
           move :PREF: to 1-:PREF:                                      AAA5LSRS
           perform ALIMENTER-CLE-:DD:                                   AAA5LSRS
           add 1 to 5-:DD:00-CPTENR                                     AAA5LSRS
           perform LIRE-:DD:-PHYSIQUE.                                  AAA5LSRS
       LIRE-:DD:-FN.                                                    AAA5LSRS
           exit section.                                                AAA5LSRS
      *>                                                                AAA5LSRS
       FERMER-:DD: SECTION.                                             AAA5LSRS
           perform FERMER-:DD:-PHYSIQUE.                                AAA5LSRS
       FERMER-:DD:-FN.                                                  AAA5LSRS
           exit section.                                                AAA5LSRS
           copy AAA5L0RS.                                               AAA5LSRS
