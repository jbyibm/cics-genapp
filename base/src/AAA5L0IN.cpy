      *>                                                                AAA5L0IN
       ALIMENTER-CLE-:DD: SECTION.                                      AAA5L0IN
           move :PREF:-:K1: to :DD:-IN-:K1:                             AAA5L0IN
       >>if AA-A-NS > 1                                                 AAA5L0IN
           move :PREF:-:K2: to :DD:-IN-:K2:                             AAA5L0IN
         >>if AA-A-NS > 2                                               AAA5L0IN
           move :PREF:-:K3: to :DD:-IN-:K3:                             AAA5L0IN
           >>if AA-A-NS > 3                                             AAA5L0IN
           move :PREF:-:K4: to :DD:-IN-:K4:                             AAA5L0IN
             >>if AA-A-NS > 4                                           AAA5L0IN
           move :PREF:-:K5: to :DD:-IN-:K5:                             AAA5L0IN
               >>if AA-A-NS > 5                                         AAA5L0IN
           move :PREF:-:K6: to :DD:-IN-:K6:                             AAA5L0IN
                 >>if AA-A-NS > 6                                       AAA5L0IN
           move :PREF:-:K7: to :DD:-IN-:K7:                             AAA5L0IN
                   >>if AA-A-NS > 7                                     AAA5L0IN
           move :PREF:-:K8: to :DD:-IN-:K8:                             AAA5L0IN
                     >>if AA-A-NS > 8                                   AAA5L0IN
           move :PREF:-:K9: to :DD:-IN-:K9:                             AAA5L0IN
                     >>end-if                                           AAA5L0IN
                   >>end-if                                             AAA5L0IN
                 >>end-if                                               AAA5L0IN
               >>end-if                                                 AAA5L0IN
             >>end-if                                                   AAA5L0IN
           >>end-if                                                     AAA5L0IN
         >>end-if                                                       AAA5L0IN
       >>end-if                                                         AAA5L0IN
           .                                                            AAA5L0IN
       ALIMENTER-CLE-:DD:-FN.                                           AAA5L0IN
           exit section.                                                AAA5L0IN
