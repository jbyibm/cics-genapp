      *>****************************************************************AAA5LRV0
      *> Accès physiques Lecture Directe (random) Fichier VSAM          AAA5LRV0
      *>****************************************************************AAA5LRV0
      *>                                                                AAA5LRV0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5LRV0
           open input :DD:-FICHIER                                      AAA5LRV0
           if 1-:DD:00-STATUS not = '00' and '97'                       AAA5LRV0
             perform FVSAM-ERREUR-:DD:                                  AAA5LRV0
           end-if.                                                      AAA5LRV0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5LRV0
           exit section.                                                AAA5LRV0
      *>                                                                AAA5LRV0
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5LRV0
           move '1' to IK                                               AAA5LRV0
           read :DD:-FICHIER                                            AAA5LRV0
             :KEYPOS:                                                   AAA5LRV0
             not invalid key                                            AAA5LRV0
               set :DD:-LU to true                                      AAA5LRV0
               move '0' to IK                                           AAA5LRV0
           end-read.                                                    AAA5LRV0
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5LRV0
           exit section.                                                AAA5LRV0
      *>                                                                AAA5LRV0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5LRV0
           close :DD:-FICHIER.                                          AAA5LRV0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5LRV0
           exit section.                                                AAA5LRV0
