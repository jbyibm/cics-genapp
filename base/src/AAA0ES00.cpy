       >>if AA-A-NR >= 0                                                AAA0ES00
         >>define AA-A-ECRITURES as b'1' override                       AAA0ES00
       >>end-if                                                         AAA0ES00
       >>evaluate AA-A-ORG                                              AAA0ES00
         >>when 'X'                  *> Document XML                    AAA5ES00
           copy AAA0ESX0.                                               AAA5ES00
         >>when 'J'                  *> Document JSON                   AAA5ES00
           copy AAA0ESJ0.                                               AAA5ES00
       >>end-evaluate                                                   AAA0ES00
