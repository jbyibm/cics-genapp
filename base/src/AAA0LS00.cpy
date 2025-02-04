       >>if AA-A-ORG = '2'                                              AAA0LS00
           copy AAA0LS20.                                               AAA0LS00
       >>end-if                                                         AAA0LS00
       >>evaluate true                                                  AAA0LS00
         >>when AA-A-NR < 0   *> Accès séquentiel hors itération        AAA0LS00
      *> Indicateur de fin de lecture                                   AAA0LS00
       01               :DD:-FR          PIC X VALUE '0'.               AAA0LS00
                    88  FIN-LECTURE-:DD:       VALUE '1'                AAA0LS00
                                             FALSE '0'.                 AAA0LS00
         >>if AA-A-ORG not = '2'                                        AAA0LS00
      *> Témoins état ouverture de la ressource                         AAA0LS00
       01                              PIC X VALUE '0'.                 AAA0LS00
                    88  :DD:-OUVERT            VALUE '1'                AAA0LS00
                                             FALSE '0'.                 AAA0LS00
         >>end-if                                                       AAA0LS00
         >>when AA-A-NR = 0   *> Accès séquentiel sans Rupture          AAA0LS00
           >>define AA-A-LECTURES           as b'1' override            AAA0LS00
           >>define AA-A-LECTURES-SANS-RUPT as b'1' override            AAA0LS00
         >>when other         *> Accès séquentiel avec Rupture          AAA0LS00
           >>define AA-A-LECTURES           as b'1' override            AAA0LS00
           copy AAA0LSRU.                                               AAA0LS00
       >>end-evaluate                                                   AAA0LS00
       >>if AA-A-NS > 0       *> Accès séquentiel avec Synchro          AAA0LS00
           copy AAA0LSSY.                                               AAA0LS00
       >>end-if                                                         AAA0LS00
