      *>****************************************************************AAA5MR20
      *> Accès physiques Modification Directe (random) Db2.             AAA5MR20
      *> Les ordres SQL doivent être codés directement dans le          AAA5MR20
      *> programme :                                                    AAA5MR20
      *> - CREER-<dd>-SQL     : ordre INSERT                            AAA5MR20
      *> - MODIFIER-<dd>-SQL  : ordre UPDATE | MERGE                    AAA5MR20
      *> - SUPPRIMER-<dd>-SQL : ordre DELETE                            AAA5MR20
      *>****************************************************************AAA5MR20
      *>                                                                AAA5MR20
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5MR20
           continue.                                                    AAA2LR20
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5MR20
           exit section.                                                AAA5MR20
      *>                                                                AAA5MR20
       CREER-:DD:-PHYSIQUE SECTION.                                     AAA5MR20
           move '1' to IK                                               AAA5MR20
           perform CREER-:DD:-SQL                                       AAA5MR20
           evaluate true                                                AAA5MR20
             when SQLCODE = +100                                        AAA5MR20
               continue                                                 AAA5MR20
             when SQLCODE >= 0                                          AAA5MR20
               move '0' to IK                                           AAA5MR20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5MR20
                                  5-:DD:C0-CPTENR                       AAA5MR20
           end-evaluate.                                                AAA5MR20
       CREER-:DD:-PHYSIQUE-FN.                                          AAA5MR20
           exit section.                                                AAA5MR20
      *>                                                                AAA5MR20
       MODIFIER-:DD:-PHYSIQUE SECTION.                                  AAA5MR20
           move '1' to IK                                               AAA5MR20
           perform MODIFIER-:DD:-SQL                                    AAA5MR20
           evaluate true                                                AAA5MR20
             when SQLCODE = +100                                        AAA5MR20
               continue                                                 AAA5MR20
             when SQLCODE >= 0                                          AAA5MR20
               move '0' to IK                                           AAA5MR20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5MR20
                                  5-:DD:M0-CPTENR                       AAA5MR20
           end-evaluate.                                                AAA5MR20
       MODIFIER-:DD:-PHYSIQUE-FN.                                       AAA5MR20
           exit section.                                                AAA5MR20
      *>                                                                AAA5MR20
       SUPPRIMER-:DD:-PHYSIQUE SECTION.                                 AAA5MR20
           move '1' to IK                                               AAA5MR20
           perform SUPPRIMER-:DD:-SQL                                   AAA5MR20
           evaluate true                                                AAA5MR20
             when SQLCODE = +100                                        AAA5MR20
               continue                                                 AAA5MR20
             when SQLCODE >= 0                                          AAA5MR20
               move '0' to IK                                           AAA5MR20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5MR20
                                  5-:DD:S0-CPTENR                       AAA5MR20
           end-evaluate.                                                AAA5MR20
       SUPPRIMER-:DD:-PHYSIQUE-FN.                                      AAA5MR20
           exit section.                                                AAA5MR20
      *>                                                                AAA5MR20
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5MR20
           continue.                                                    AAA5MR20
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5MR20
           exit section.                                                AAA5MR20
