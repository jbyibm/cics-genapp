       copy AAA5L0IN.                                                   AAA5L0SY
      *>                                                                AAA5L0SY
       CALCULER-CLE-:DD: SECTION.                                       AAA5L0SY
           if :DD:IND < TIND:NS:                                        AAA5L0SY
             move high-value to IND                                     AAA5L0SY
             move :DD:IND to TIND:NS:                                   AAA5L0SY
           end-if.                                                      AAA5L0SY
       CALCULER-CLE-:DD:-FN.                                            AAA5L0SY
           exit section.                                                AAA5L0SY
      *>                                                                AAA5L0SY
       CALCULER-CONF-:DD: SECTION.                                      AAA5L0SY
           move all '0' to :DD:-CF                                      AAA5L0SY
           move 0 to :DD:-NCF                                           AAA5L0SY
           if :DD:IND1 = IND1                                           AAA5L0SY
             move '1' to :DD:-CF1                                       AAA5L0SY
             move 1 to :DD:-NCF                                         AAA5L0SY
       >>if AA-A-NS > 1                                                 AAA5L0SY
             if :DD:IND2 = IND2                                         AAA5L0SY
               move '1' to :DD:-CF2                                     AAA5L0SY
               move 2 to :DD:-NCF                                       AAA5L0SY
         >>if AA-A-NS > 2                                               AAA5L0SY
               if :DD:IND3 = IND3                                       AAA5L0SY
                 move '1' to :DD:-CF3                                   AAA5L0SY
                 move 3 to :DD:-NCF                                     AAA5L0SY
           >>if AA-A-NS > 3                                             AAA5L0SY
                 if :DD:IND4 = IND4                                     AAA5L0SY
                   move '1' to :DD:-CF4                                 AAA5L0SY
                   move 4 to :DD:-NCF                                   AAA5L0SY
             >>if AA-A-NS > 4                                           AAA5L0SY
                   if :DD:IND5 = IND5                                   AAA5L0SY
                     move '1' to :DD:-CF5                               AAA5L0SY
                     move 5 to :DD:-NCF                                 AAA5L0SY
               >>if AA-A-NS > 5                                         AAA5L0SY
                     if :DD:IND6 = IND6                                 AAA5L0SY
                       move '1' to :DD:-CF6                             AAA5L0SY
                       move 6 to :DD:-NCF                               AAA5L0SY
                 >>if AA-A-NS > 6                                       AAA5L0SY
                       if :DD:IND7 = IND7                               AAA5L0SY
                         move '1' to :DD:-CF7                           AAA5L0SY
                         move 7 to :DD:-NCF                             AAA5L0SY
                   >>if AA-A-NS > 7                                     AAA5L0SY
                         if :DD:IND8 = IND8                             AAA5L0SY
                           move '1' to :DD:-CF8                         AAA5L0SY
                           move 8 to :DD:-NCF                           AAA5L0SY
                     >>if AA-A-NS > 8                                   AAA5L0SY
                           if :DD:IND9 = IND9                           AAA5L0SY
                             move '1' to :DD:-CF9                       AAA5L0SY
                             move 9 to :DD:-NCF                         AAA5L0SY
                           end-if                                       AAA5L0SY
                     >>end-if                                           AAA5L0SY
                         end-if                                         AAA5L0SY
                   >>end-if                                             AAA5L0SY
                       end-if                                           AAA5L0SY
                 >>end-if                                               AAA5L0SY
                     end-if                                             AAA5L0SY
               >>end-if                                                 AAA5L0SY
                   end-if                                               AAA5L0SY
             >>end-if                                                   AAA5L0SY
                 end-if                                                 AAA5L0SY
           >>end-if                                                     AAA5L0SY
               end-if                                                   AAA5L0SY
         >>end-if                                                       AAA5L0SY
             end-if                                                     AAA5L0SY
       >>end-if                                                         AAA5L0SY
           end-if                                                       AAA5L0SY
           if :DD:-NCF > MAX-CF                                         AAA5L0SY
             move :DD:-NCF to MAX-CF                                    AAA5L0SY
           end-if.                                                      AAA5L0SY
       CALCULER-CONF-:DD:-FN.                                           AAA5L0SY
           exit section.                                                AAA5L0SY
