       >>define AA-A-LECTURES-AVEC-RUPT as b'1' override                AAA0LSRU
       >>if AA-A-MAXNR < AA-A-NR                                        AAA0LSRU
         >>define AA-A-MAXNR as AA-A-NR override                        AAA0LSRU
       >>end-if                                                         AAA0LSRU
      *> Niveau Rupture Première                                        AAA0LSRU
       01               :DD:-NRP         PIC 9(4) COMP-5 VALUE 1.       AAA0LSRU
      *> Ruptures Premières                                             AAA0LSRU
       01               :DD:-PE.                                        AAA0LSRU
           05           :DD:-PE1         PIC X VALUE '1'.               AAA0LSRU
       >>if AA-A-NR > 1                                                 AAA0LSRU
           05           :DD:-PE2         PIC X VALUE '1'.               AAA0LSRU
         >>if AA-A-NR > 2                                               AAA0LSRU
           05           :DD:-PE3         PIC X VALUE '1'.               AAA0LSRU
           >>if AA-A-NR > 3                                             AAA0LSRU
           05           :DD:-PE4         PIC X VALUE '1'.               AAA0LSRU
             >>if AA-A-NR > 4                                           AAA0LSRU
           05           :DD:-PE5         PIC X VALUE '1'.               AAA0LSRU
               >>if AA-A-NR > 5                                         AAA0LSRU
           05           :DD:-PE6         PIC X VALUE '1'.               AAA0LSRU
                 >>if AA-A-NR > 6                                       AAA0LSRU
           05           :DD:-PE7         PIC X VALUE '1'.               AAA0LSRU
                   >>if AA-A-NR > 7                                     AAA0LSRU
           05           :DD:-PE8         PIC X VALUE '1'.               AAA0LSRU
                     >>if AA-A-NR > 8                                   AAA0LSRU
           05           :DD:-PE9         PIC X VALUE '1'.               AAA0LSRU
                     >>end-if                                           AAA0LSRU
                   >>end-if                                             AAA0LSRU
                 >>end-if                                               AAA0LSRU
               >>end-if                                                 AAA0LSRU
             >>end-if                                                   AAA0LSRU
           >>end-if                                                     AAA0LSRU
         >>end-if                                                       AAA0LSRU
       >>end-if                                                         AAA0LSRU
      *> Niveau Rupture Dernière                                        AAA0LSRU
       01               :DD:-NRD         PIC 9(4) COMP-5 VALUE 1.       AAA0LSRU
      *> Ruptures Dernières                                             AAA0LSRU
       01               :DD:-DE.                                        AAA0LSRU
           05           :DD:-DE1         PIC X VALUE '1'.               AAA0LSRU
       >>if AA-A-NR > 1                                                 AAA0LSRU
           05           :DD:-DE2         PIC X VALUE '1'.               AAA0LSRU
         >>if AA-A-NR > 2                                               AAA0LSRU
           05           :DD:-DE3         PIC X VALUE '1'.               AAA0LSRU
           >>if AA-A-NR > 3                                             AAA0LSRU
           05           :DD:-DE4         PIC X VALUE '1'.               AAA0LSRU
             >>if AA-A-NR > 4                                           AAA0LSRU
           05           :DD:-DE5         PIC X VALUE '1'.               AAA0LSRU
               >>if AA-A-NR > 5                                         AAA0LSRU
           05           :DD:-DE6         PIC X VALUE '1'.               AAA0LSRU
                 >>if AA-A-NR > 6                                       AAA0LSRU
           05           :DD:-DE7         PIC X VALUE '1'.               AAA0LSRU
                   >>if AA-A-NR > 7                                     AAA0LSRU
           05           :DD:-DE8         PIC X VALUE '1'.               AAA0LSRU
                     >>if AA-A-NR > 8                                   AAA0LSRU
           05           :DD:-DE9         PIC X VALUE '1'.               AAA0LSRU
                     >>end-if                                           AAA0LSRU
                   >>end-if                                             AAA0LSRU
                 >>end-if                                               AAA0LSRU
               >>end-if                                                 AAA0LSRU
             >>end-if                                                   AAA0LSRU
           >>end-if                                                     AAA0LSRU
         >>end-if                                                       AAA0LSRU
       >>end-if                                                         AAA0LSRU
