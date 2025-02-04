       >>evaluate true                                                  AAA5XS00
         >>when AA-A-NR <= 0 and AA-A-NS = 0   *> sans Rupt ni Sync     AAA5XS00
           copy AAA5LSNN.                                               AAA5XS00
         >>when AA-A-NR =  0 and AA-A-NS > 0   *> sans Rupt avec Sync   AAA5XS00
           copy AAA5LSSY.                                               AAA5XS00
         >>when other                          *> avec Rupt et Sync     AAA5XS00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XS00
      *>>> Accès lecture et maj avec Rupture impossible.            <<< AAA5XS00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XS00
       >>end-evaluate                                                   AAA5XS00
           copy AAA5XSNN.                                               AAA5XS00
       >>evaluate AA-A-ORG                                              AAA5XS00
         >>when 'F'                  *> Fichier Séquentiel              AAA5XS00
           copy AAA5XSF0.                                               AAA5XS00
         >>when '2'                  *> Accès Db2                       AAA5XS00
           copy AAA5XS20.                                               AAA5XS00
         >>when 'K'                  *> Fichier VSAM KSDS               AAA5XS00
           copy AAA5XSV0.                                               AAA5XS00
         >>when 'R'                  *> Fichier VSAM RRDS               AAA5XS00
           copy AAA5XSV0.                                               AAA5XS00
         >>when 'E'                  *> Fichier VSAM ESDS               AAA5XS00
           copy AAA5XSV0.                                               AAA5XS00
         >>when other                                                   AAA5XS00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XS00
      *>>> La variable 'AA-A-ORG' doit être valorisée à :           <<< AAA5XS00
      *>>> - 'F' : fichier séquentiel                               <<< AAA5XS00
      *>>> - '2' : ressource Db2                                    <<< AAA5XS00
      *>>> - 'K' : fichier VSAM KSDS                                <<< AAA5XS00
      *>>> - 'R' : fichier VSAM RRDS                                <<< AAA5XS00
      *>>> - 'E' : fichier VSAM ESDS                                <<< AAA5XS00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5XS00
       >>end-evaluate                                                   AAA5XS00
