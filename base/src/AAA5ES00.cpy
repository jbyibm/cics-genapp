           copy AAA5ESNN.                                               AAA5ES00
       >>evaluate AA-A-ORG                                              AAA5ES00
         >>when 'F'                  *> Fichier Séquentiel              AAA5ES00
           copy AAA5ESF0.                                               AAA5ES00
         >>when '2'                  *> Accès Db2                       AAA5ES00
           copy AAA5ES20.                                               AAA5ES00
         >>when 'K'                  *> Fichier VSAM KSDS               AAA5ES00
           copy AAA5ESV0.                                               AAA5ES00
         >>when 'R'                  *> Fichier VSAM RRDS               AAA5ES00
           copy AAA5ESV0.                                               AAA5ES00
         >>when 'E'                  *> Fichier VSAM ESDS               AAA5ES00
           copy AAA5ESV0.                                               AAA5ES00
         >>when 'X'                  *> Document XML                    AAA5ES00
           copy AAA5ESX0.                                               AAA5ES00
         >>when 'J'                  *> Document JSON                   AAA5ES00
           copy AAA5ESJ0.                                               AAA5ES00
         >>when other                                                   AAA5ES00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5ES00
      *>>> La variable 'AA-A-ORG' doit être valorisée à :           <<< AAA5ES00
      *>>> - 'F' : fichier séquentiel                               <<< AAA5ES00
      *>>> - '2' : ressource Db2                                    <<< AAA5ES00
      *>>> - 'K' : fichier VSAM KSDS                                <<< AAA5ES00
      *>>> - 'R' : fichier VSAM RRDS                                <<< AAA5ES00
      *>>> - 'E' : fichier VSAM ESDS                                <<< AAA5ES00
      *>>> - 'X' : document XML                                     <<< AAA5ES00
      *>>> - 'J' : document JSON                                    <<< AAA5ES00
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAA5ES00
       >>end-evaluate                                                   AAA5ES00
