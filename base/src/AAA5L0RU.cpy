      *>                                                                AAA5L0RU
       CALCULER-RUPT-:DD: SECTION.                                      AAA5L0RU
      *> Calcul des indicateurs "Ruptures Dernières"                    AAA5L0RU
           move all '0' to :DD:-DE                                      AAA5L0RU
           move 0 to :DD:-NRD                                           AAA5L0RU
                     NRD                                                AAA5L0RU
           move RTD to RTP                                              AAA5L0RU
           move all '0' to RTD                                          AAA5L0RU
           evaluate true                                                AAA5L0RU
             when :DD:-FI = '1'                                         AAA5L0RU
             when :PREF:-:K1: not = 1-:PREF:-:K1:                       AAA5L0RU
               move 1 to :DD:-NRD                                       AAA5L0RU
                         NRD                                            AAA5L0RU
               move all '1' to :DD:-DE                                  AAA5L0RU
               move all '1' to RTD                                      AAA5L0RU
       >>if AA-A-NR > 1                                                 AAA5L0RU
             when :PREF:-:K2: not = 1-:PREF:-:K2:                       AAA5L0RU
               move 2 to :DD:-NRD                                       AAA5L0RU
                         NRD                                            AAA5L0RU
               move all '1' to :DD:-DE(2:)                              AAA5L0RU
               move all '1' to RTD(2:)                                  AAA5L0RU
         >>if AA-A-NR > 2                                               AAA5L0RU
             when :PREF:-:K3: not = 1-:PREF:-:K3:                       AAA5L0RU
               move 3 to :DD:-NRD                                       AAA5L0RU
                         NRD                                            AAA5L0RU
               move all '1' to :DD:-DE(3:)                              AAA5L0RU
               move all '1' to RTD(3:)                                  AAA5L0RU
           >>if AA-A-NR > 3                                             AAA5L0RU
             when :PREF:-:K4: not = 1-:PREF:-:K4:                       AAA5L0RU
               move 4 to :DD:-NRD                                       AAA5L0RU
                         NRD                                            AAA5L0RU
               move all '1' to :DD:-DE(4:)                              AAA5L0RU
               move all '1' to RTD(4:)                                  AAA5L0RU
             >>if AA-A-NR > 4                                           AAA5L0RU
             when :PREF:-:K5: not = 1-:PREF:-:K5:                       AAA5L0RU
               move 5 to :DD:-NRD                                       AAA5L0RU
                         NRD                                            AAA5L0RU
               move all '1' to :DD:-DE(5:)                              AAA5L0RU
               move all '1' to RTD(5:)                                  AAA5L0RU
               >>if AA-A-NR > 5                                         AAA5L0RU
             when :PREF:-:K6: not = 1-:PREF:-:K6:                       AAA5L0RU
               move 6 to :DD:-NRD                                       AAA5L0RU
                         NRD                                            AAA5L0RU
               move all '1' to :DD:-DE(6:)                              AAA5L0RU
               move all '1' to RTD(6:)                                  AAA5L0RU
                 >>if AA-A-NR > 6                                       AAA5L0RU
             when :PREF:-:K7: not = 1-:PREF:-:K7:                       AAA5L0RU
               move 7 to :DD:-NRD                                       AAA5L0RU
                         NRD                                            AAA5L0RU
               move all '1' to :DD:-DE(7:)                              AAA5L0RU
               move all '1' to RTD(7:)                                  AAA5L0RU
                   >>if AA-A-NR > 7                                     AAA5L0RU
             when :PREF:-:K8: not = 1-:PREF:-:K8:                       AAA5L0RU
               move 8 to :DD:-NRD                                       AAA5L0RU
                         NRD                                            AAA5L0RU
               move all '1' to :DD:-DE(8:)                              AAA5L0RU
               move all '1' to RTD(8:)                                  AAA5L0RU
                     >>if AA-A-NR > 8                                   AAA5L0RU
             when :PREF:-:K9: not = 1-:PREF:-:K9:                       AAA5L0RU
               move 9 to :DD:-NRD                                       AAA5L0RU
                         NRD                                            AAA5L0RU
               move all '1' to :DD:-DE(9:)                              AAA5L0RU
               move all '1' to RTD(9:)                                  AAA5L0RU
                     >>end-if                                           AAA5L0RU
                   >>end-if                                             AAA5L0RU
                 >>end-if                                               AAA5L0RU
               >>end-if                                                 AAA5L0RU
             >>end-if                                                   AAA5L0RU
           >>end-if                                                     AAA5L0RU
         >>end-if                                                       AAA5L0RU
       >>end-if                                                         AAA5L0RU
           end-evaluate.                                                AAA5L0RU
       CALCULER-RUPT-:DD:-FN.                                           AAA5L0RU
           exit section.                                                AAA5L0RU
