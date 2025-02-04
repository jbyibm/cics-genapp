       >>evaluate true                                                  AAA5XD00
         >>when AA-A-NR <= 0 and AA-A-NS = 0   *> sans Rupt ni Sync     AAA5XD00
           copy AAA5LSNN.                                               AAA5XD00
         >>when AA-A-NR = 0  and AA-A-NS > 0   *> sans Rupt avec Sync   AAA5XD00
           copy AAA5LSSY.                                               AAA5XD00
         >>when other                          *> avec Rupt et Sync     AAA5XD00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XD00
      *>>> Accès lecture et maj avec Rupture impossible.            <<< AAA5XD00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XD00
       >>end-evaluate                                                   AAA5XD00
           copy AAA5XDNN.                                               AAA5XD00
       >>evaluate AA-A-ORG                                              AAA5XD00
         >>when '2'                  *> Accès Db2                       AAA5XD00
           copy AAA5XD20.                                               AAA5XD00
         >>when 'K'                  *> Fichier VSAM KSDS               AAA5XD00
           copy AAA5XDV0.                                               AAA5XD00
         >>when 'R'                  *> Fichier VSAM RRDS               AAA5XD00
           copy AAA5XDV0.                                               AAA5XD00
         >>when other                                                   AAA5XD00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XD00
      *>>> La variable 'AA-A-ORG' doit être valorisée à :           <<< AAA5XD00
      *>>> - '2' : ressource Db2                                    <<< AAA5XD00
      *>>> - 'K' : fichier VSAM KSDS                                <<< AAA5XD00
      *>>> - 'R' : fichier VSAM RRDS                                <<< AAA5XD00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XD00
       >>end-evaluate                                                   AAA5XD00
