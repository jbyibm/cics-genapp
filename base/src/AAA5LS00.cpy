       >>evaluate true                                                  AAA5LS00
         >>when AA-A-NR <= 0 and AA-A-NS = 0   *> sans Rupt ni Sync     AAA5LS00
           copy AAA5LSNN.                                               AAA5LS00
         >>when AA-A-NR >  0 and AA-A-NS = 0   *> avec Rupt sans Sync   AAA5LS00
           copy AAA5LSRU.                                               AAA5LS00
         >>when AA-A-NR =  0 and AA-A-NS > 0   *> sans Rupt avec Sync   AAA5LS00
           copy AAA5LSSY.                                               AAA5LS00
         >>when other                          *> avec Rupt et Sync     AAA5LS00
           copy AAA5LSRS.                                               AAA5LS00
       >>end-evaluate                                                   AAA5LS00
       >>evaluate AA-A-ORG                                              AAA5LS00
         >>when 'F'                  *> Fichier Séquentiel              AAA5LS00
           copy AAA5LSF0.                                               AAA5LS00
         >>when '2'                  *> Accès Db2                       AAA5LS00
           copy AAA5LS20.                                               AAA5LS00
         >>when 'K'                  *> Fichier VSAM KSDS               AAA5LS00
           copy AAA5LSV0.                                               AAA5LS00
         >>when 'R'                  *> Fichier VSAM RRDS               AAA5LS00
           copy AAA5LSV0.                                               AAA5LS00
         >>when 'E'                  *> Fichier VSAM ESDS               AAA5LS00
           copy AAA5LSV0.                                               AAA5LS00
         >>when other                                                   AAA5LS00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5LS00
      *>>> La variable 'AA-A-ORG' doit être valorisée à :           <<< AAA5LS00
      *>>> - 'F' : fichier séquentiel                               <<< AAA5LS00
      *>>> - '2' : ressource Db2                                    <<< AAA5LS00
      *>>> - 'K' : fichier VSAM KSDS                                <<< AAA5LS00
      *>>> - 'R' : fichier VSAM RRDS                                <<< AAA5LS00
      *>>> - 'E' : fichier VSAM ESDS                                <<< AAA5LS00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5LS00
       >>end-evaluate                                                   AAA5LS00
