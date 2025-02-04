      *>****************************************************************AAA5LR20
      *> Accès physiques Lecture Directe (random) Db2.                  AAA5LR20
      *> Les ordres SQL doivent être codés directement dans le          AAA5LR20
      *> programme :                                                    AAA5LR20
      *> - LIRE-<dd>-SQL : ordre SELECT                                 AAA5LR20
      *>****************************************************************AAA5LR20
      *>                                                                AAA5LR20
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5LR20
           continue.                                                    AAA2LR20
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5LR20
           exit section.                                                AAA5LR20
      *>                                                                AAA5LR20
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5LR20
           move '1' to IK                                               AAA5LR20
           perform LIRE-:DD:-SQL                                        AAA5LR20
           evaluate true                                                AAA5LR20
             when SQLCODE = +100                                        AAA5LR20
               continue                                                 AAA5LR20
             when SQLCODE >= 0                                          AAA5LR20
               set :DD:-LU to true                                      AAA5LR20
               move '0' to IK                                           AAA5LR20
           end-evaluate.                                                AAA5LR20
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5LR20
           exit section.                                                AAA5LR20
      *>                                                                AAA5LR20
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5LR20
           continue.                                                    AAA5LR20
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5LR20
           exit section.                                                AAA5LR20
