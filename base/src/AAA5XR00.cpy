       >>evaluate true                                                  AAA5XR00
         >>when AA-A-NR <= 0 and AA-A-NS = 0   *> sans Rupt ni Sync     AAA5XR00
           copy AAA5LRNN.                                               AAA5XR00
         >>when other                *> avec Ruptures et Synchro        AAA5XR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XR00
      *>>> Accès lecture et maj avec Rupt / Sync impossible.        <<< AAA5XR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XR00
       >>end-evaluate                                                   AAA5XR00
           copy AAA5XRNN.                                               AAA5XR00
       >>evaluate AA-A-ORG                                              AAA5XR00
         >>when '2'                  *> Accès Db2                       AAA5XR00
           copy AAA5XR20.                                               AAA5XR00
         >>when 'K'                  *> Fichier VSAM KSDS               AAA5XR00
           copy AAA5XRV0.                                               AAA5XR00
         >>when 'R'                  *> Fichier VSAM RRDS               AAA5XR00
           copy AAA5XRV0.                                               AAA5XR00
         >>when other                                                   AAA5XR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XR00
      *>>> La variable 'AA-A-ORG' doit être valorisée à :           <<< AAA5XR00
      *>>> - '2' : ressource Db2                                    <<< AAA5XR00
      *>>> - 'K' : fichier VSAM KSDS                                <<< AAA5XR00
      *>>> - 'R' : fichier VSAM RRDS                                <<< AAA5XR00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XR00
       >>end-evaluate                                                   AAA5XR00
