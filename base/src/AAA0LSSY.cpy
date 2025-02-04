       >>define AA-A-LECTURES-AVEC-SYNC as b'1' override                AAA0LSSY
       >>if AA-A-MAXNS < AA-A-NS                                        AAA0LSSY
         >>define AA-A-MAXNS as AA-A-NS override                        AAA0LSSY
       >>end-if                                                         AAA0LSSY
      *> Niveau maximum de Configuration (Synchronisation)              AAA0LSSY
       01               :DD:-NCF         PIC 9(4) COMP-5.               AAA0LSSY
      *> Indicateurs de Configuration (Synchronisation)                 AAA0LSSY
       01               :DD:-CF.                                        AAA0LSSY
           05           :DD:-CF1         PIC X VALUE '1'.               AAA0LSSY
       >>if AA-A-NS > 1                                                 AAA0LSSY
           05           :DD:-CF2         PIC X VALUE '1'.               AAA0LSSY
         >>if AA-A-NS > 2                                               AAA0LSSY
           05           :DD:-CF3         PIC X VALUE '1'.               AAA0LSSY
           >>if AA-A-NS > 3                                             AAA0LSSY
           05           :DD:-CF4         PIC X VALUE '1'.               AAA0LSSY
             >>if AA-A-NS > 4                                           AAA0LSSY
           05           :DD:-CF5         PIC X VALUE '1'.               AAA0LSSY
               >>if AA-A-NS > 5                                         AAA0LSSY
           05           :DD:-CF6         PIC X VALUE '1'.               AAA0LSSY
                 >>if AA-A-NS > 6                                       AAA0LSSY
           05           :DD:-CF7         PIC X VALUE '1'.               AAA0LSSY
                   >>if AA-A-NS > 7                                     AAA0LSSY
           05           :DD:-CF8         PIC X VALUE '1'.               AAA0LSSY
                     >>if AA-A-NS > 8                                   AAA0LSSY
           05           :DD:-CF9         PIC X VALUE '1'.               AAA0LSSY
                     >>end-if                                           AAA0LSSY
                   >>end-if                                             AAA0LSSY
                 >>end-if                                               AAA0LSSY
               >>end-if                                                 AAA0LSSY
             >>end-if                                                   AAA0LSSY
           >>end-if                                                     AAA0LSSY
         >>end-if                                                       AAA0LSSY
       >>end-if                                                         AAA0LSSY
      *> Clés de Configuration (Synchronisation)                        AAA0LSSY
       01               :DD:IND.                                        AAA0LSSY
           05           :DD:IND1.                                       AAA0LSSY
               10       :DD:-IN-:K1:       PIC  :P1:.                   AAA0LSSY
       >>if AA-A-NS > 1                                                 AAA0LSSY
           05           :DD:IND2.                                       AAA0LSSY
               10       :DD:-IN-:K2:       PIC  :P2:.                   AAA0LSSY
         >>if AA-A-NS > 2                                               AAA0LSSY
           05           :DD:IND3.                                       AAA0LSSY
               10       :DD:-IN-:K3:       PIC  :P3:.                   AAA0LSSY
           >>if AA-A-NS > 3                                             AAA0LSSY
           05           :DD:IND4.                                       AAA0LSSY
               10       :DD:-IN-:K4:       PIC  :P4:.                   AAA0LSSY
             >>if AA-A-NS > 4                                           AAA0LSSY
           05           :DD:IND5.                                       AAA0LSSY
               10       :DD:-IN-:K5:       PIC  :P5:.                   AAA0LSSY
               >>if AA-A-NS > 5                                         AAA0LSSY
           05           :DD:IND6.                                       AAA0LSSY
               10       :DD:-IN-:K6:       PIC  :P6:.                   AAA0LSSY
                 >>if AA-A-NS > 6                                       AAA0LSSY
           05           :DD:IND7.                                       AAA0LSSY
               10       :DD:-IN-:K7:       PIC  :P7:.                   AAA0LSSY
                   >>if AA-A-NS > 7                                     AAA0LSSY
           05           :DD:IND8.                                       AAA0LSSY
               10       :DD:-IN-:K8:       PIC  :P8:.                   AAA0LSSY
                     >>if AA-A-NS > 8                                   AAA0LSSY
           05           :DD:IND9.                                       AAA0LSSY
               10       :DD:-IN-:K9:       PIC  :P9:.                   AAA0LSSY
                     >>end-if                                           AAA0LSSY
                   >>end-if                                             AAA0LSSY
                 >>end-if                                               AAA0LSSY
               >>end-if                                                 AAA0LSSY
             >>end-if                                                   AAA0LSSY
           >>end-if                                                     AAA0LSSY
         >>end-if                                                       AAA0LSSY
       >>end-if                                                         AAA0LSSY
