           copy AAA5ERNN.                                               AAA5ER00
       >>evaluate AA-A-ORG                                              AAA5ER00
         >>when '2'                  *> Accès Db2                       AAA5ER00
           copy AAA5ER20.                                               AAA5ER00
         >>when 'K'                  *> Fichier VSAM KSDS               AAA5ER00
           copy AAA5ERV0.                                               AAA5ER00
         >>when 'R'                  *> Fichier VSAM RRDS               AAA5ER00
           copy AAA5ERV0.                                               AAA5ER00
         >>when other                                                   AAA5ER00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5ER00
      *>>> La variable 'AA-A-ORG' doit être valorisée à :           <<< AAA5ER00
      *>>> - '2' : ressource Db2                                    <<< AAA5ER00
      *>>> - 'K' : fichier VSAM KSDS                                <<< AAA5ER00
      *>>> - 'R' : fichier VSAM RRDS                                <<< AAA5ER00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5ER00
       >>end-evaluate                                                   AAA5ER00
