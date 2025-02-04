           copy AAA5MRNN.                                               AAA5MR00
       >>evaluate AA-A-ORG                                              AAA5MR00
         >>when '2'                  *> Accès Db2                       AAA5MR00
           copy AAA5MR20.                                               AAA5MR00
         >>when 'K'                  *> Fichier VSAM KSDS               AAA5MR00
           copy AAA5MRV0.                                               AAA5MR00
         >>when 'R'                  *> Fichier VSAM RRDS               AAA5MR00
           copy AAA5MRV0.                                               AAA5MR00
         >>when other                                                   AAA5MR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5MR00
      *>>> La variable 'AA-A-ORG' doit être valorisée à :           <<< AAA5MR00
      *>>> - '2' : ressource Db2                                    <<< AAA5MR00
      *>>> - 'K' : fichier VSAM KSDS                                <<< AAA5MR00
      *>>> - 'R' : fichier VSAM RRDS                                <<< AAA5MR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5MR00
       >>end-evaluate                                                   AAA5MR00
