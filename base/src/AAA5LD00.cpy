       >>evaluate true                                                  AAA5LD00
         >>when AA-A-NR <= 0 and AA-A-NS = 0   *> sans Rupt ni Sync     AAA5LD00
           copy AAA5LSNN.                                               AAA5LD00
         >>when AA-A-NR >  0 and AA-A-NS = 0   *> avec Rupt sans Sync   AAA5LD00
           copy AAA5LSRU.                                               AAA5LD00
         >>when AA-A-NR =  0 and AA-A-NS > 0   *> sans Rupt avec Sync   AAA5LD00
           copy AAA5LSSY.                                               AAA5LD00
         >>when other                *> avec Ruptures et Synchro        AAA5LD00
           copy AAA5LSRS.                                               AAA5LD00
       >>end-evaluate                                                   AAA5LD00
      *>                                                                AAA5LD00
       POSITIONNER-:DD: SECTION.                                        AAA5LD00
           perform POSITIONNER-:DD:-PHYSIQUE.                           AAA5LD00
       POSITIONNER-:DD:-FN.                                             AAA5LD00
           exit section.                                                AAA5LD00
      *>                                                                AAA5LD00
       >>evaluate AA-A-ORG                                              AAA5LD00
         >>when '2'                  *> Accès Db2                       AAA5LD00
           copy AAA5LD20.                                               AAA5LD00
         >>when 'K'                  *> Fichier VSAM KSDS               AAA5LD00
           copy AAA5LDV0.                                               AAA5LD00
         >>when 'R'                  *> Fichier VSAM RRDS               AAA5LD00
           copy AAA5LDV0.                                               AAA5LD00
         >>when other                                                   AAA5LD00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5LD00
      *>>> La variable 'AA-A-ORG' doit être valorisée à :           <<< AAA5LD00
      *>>> - '2' : ressource Db2                                    <<< AAA5LD00
      *>>> - 'K' : fichier VSAM KSDS                                <<< AAA5LD00
      *>>> - 'R' : fichier VSAM RRDS                                <<< AAA5LD00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5LD00
       >>end-evaluate                                                   AAA5LD00
