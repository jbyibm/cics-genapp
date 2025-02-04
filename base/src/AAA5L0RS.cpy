      *>                                                                AAA5L0RS
       CALCULER-RUPT-:DD: SECTION.                                      AAA5L0RS
      *> Calcul des indicateurs "Ruptures Dernières"                    AAA5L0RS
           move all '0' to :DD:-DE                                      AAA5L0RS
           move 0 to :DD:-NRD                                           AAA5L0RS
           evaluate true                                                AAA5L0RS
             when :DD:-FI = '1'                                         AAA5L0RS
             when :PREF:-:K1: not = 1-:PREF:-:K1:                       AAA5L0RS
               move 1 to :DD:-NRD                                       AAA5L0RS
               move all '1' to :DD:-DE                                  AAA5L0RS
       >>if AA-A-NR > 1                                                 AAA5L0RS
             when :PREF:-:K2: not = 1-:PREF:-:K2:                       AAA5L0RS
               move 2 to :DD:-NRD                                       AAA5L0RS
               move all '1' to :DD:-DE(2:)                              AAA5L0RS
         >>if AA-A-NR > 2                                               AAA5L0RS
             when :PREF:-:K3: not = 1-:PREF:-:K3:                       AAA5L0RS
               move 3 to :DD:-NRD                                       AAA5L0RS
               move all '1' to :DD:-DE(3:)                              AAA5L0RS
           >>if AA-A-NR > 3                                             AAA5L0RS
             when :PREF:-:K4: not = 1-:PREF:-:K4:                       AAA5L0RS
               move 4 to :DD:-NRD                                       AAA5L0RS
               move all '1' to :DD:-DE(4:)                              AAA5L0RS
             >>if AA-A-NR > 4                                           AAA5L0RS
             when :PREF:-:K5: not = 1-:PREF:-:K5:                       AAA5L0RS
               move 5 to :DD:-NRD                                       AAA5L0RS
               move all '1' to :DD:-DE(5:)                              AAA5L0RS
               >>if AA-A-NR > 5                                         AAA5L0RS
             when :PREF:-:K6: not = 1-:PREF:-:K6:                       AAA5L0RS
               move 6 to :DD:-NRD                                       AAA5L0RS
               move all '1' to :DD:-DE(6:)                              AAA5L0RS
                 >>if AA-A-NR > 6                                       AAA5L0RS
             when :PREF:-:K7: not = 1-:PREF:-:K7:                       AAA5L0RS
               move 7 to :DD:-NRD                                       AAA5L0RS
               move all '1' to :DD:-DE(7:)                              AAA5L0RS
                   >>if AA-A-NR > 7                                     AAA5L0RS
             when :PREF:-:K8: not = 1-:PREF:-:K8:                       AAA5L0RS
               move 8 to :DD:-NRD                                       AAA5L0RS
               move all '1' to :DD:-DE(8:)                              AAA5L0RS
                     >>if AA-A-NR > 8                                   AAA5L0RS
             when :PREF:-:K9: not = 1-:PREF:-:K9:                       AAA5L0RS
               move 9 to :DD:-NRD                                       AAA5L0RS
               move all '1' to :DD:-DE(9:)                              AAA5L0RS
                     >>end-if                                           AAA5L0RS
                   >>end-if                                             AAA5L0RS
                 >>end-if                                               AAA5L0RS
               >>end-if                                                 AAA5L0RS
             >>end-if                                                   AAA5L0RS
           >>end-if                                                     AAA5L0RS
         >>end-if                                                       AAA5L0RS
       >>end-if                                                         AAA5L0RS
           end-evaluate.                                                AAA5L0RS
       CALCULER-RUPT-:DD:-FN.                                           AAA5L0RS
           exit section.                                                AAA5L0RS
      *>                                                                AAA5L0RS
       CALCULER-RTD-:DD: SECTION.                                       AAA5L0RS
           if NRD2 > 0                                                  AAA5L0RS
             perform varying IRTD from NRD2 by 1                        AAA5L0RS
               until IRTD > length of :DD:-DE                           AAA5L0RS
               if IRTD <= :NS:                                          AAA5L0RS
               and :DD:-CF (IRTD:1) = '1'                               AAA5L0RS
               and (:DD:-DE (IRTD:1) = '0'                              AAA5L0RS
               or :DD:-CF:NS: = '0')                                    AAA5L0RS
                 move '0' to RTD (IRTD:1)                               AAA5L0RS
                 if RTD = all '0'                                       AAA5L0RS
                   move 0 to NRD2 NRD                                   AAA5L0RS
                 else                                                   AAA5L0RS
                   add 1 to IRTD giving NRD2 NRD                        AAA5L0RS
                 end-if                                                 AAA5L0RS
               else                                                     AAA5L0RS
                 if IRTD > :NS:                                         AAA5L0RS
                 and :DD:-CF:NS: = '1'                                  AAA5L0RS
                 and :DD:-DE (IRTD:1) = '0'                             AAA5L0RS
                   move '0' to RTD (IRTD:1)                             AAA5L0RS
                   if RTD = all '0'                                     AAA5L0RS
                     move 0 to NRD2 NRD                                 AAA5L0RS
                   else                                                 AAA5L0RS
                     add 1 to IRTD giving NRD2 NRD                      AAA5L0RS
                   end-if                                               AAA5L0RS
                 end-if                                                 AAA5L0RS
               end-if                                                   AAA5L0RS
             end-perform                                                AAA5L0RS
           end-if.                                                      AAA5L0RS
       CALCULER-RTD-:DD:-FN.                                            AAA5L0RS
           exit section.                                                AAA5L0RS
      *> --- Routines de calcul des Synchros                            AAA5L0RS
           copy AAA5L0SY.                                               AAA5L0RS
