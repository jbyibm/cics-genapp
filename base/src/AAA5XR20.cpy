      *>****************************************************************AAA5XR20
      *> Accès physiques Lecture et MaJ Directe accès Db2.              AAA5XR20
      *> Les ordres SQL doivent être codés directement dans le          AAA5XR20
      *> programme :                                                    AAA5XR20
      *> - LIRE-<dd>-SQL      : ordre SELECT                            AAA5XR20
      *> - CREER-<dd>-SQL     : ordre INSERT                            AAA5XR20
      *> - MODIFIER-<dd>-SQL  : ordre UPDATE | MERGE                    AAA5XR20
      *> - SUPPRIMER-<dd>-SQL : ordre DELETE                            AAA5XR20
      *>****************************************************************AAA5XR20
      *>                                                                AAA5XR20
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5XR20
           continue.                                                    AAA5XR20
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5XR20
           exit section.                                                AAA5XR20
      *>                                                                AAA5XR20
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5XR20
           move '1' to IK                                               AAA5XR20
           perform LIRE-:DD:-SQL                                        AAA5XR20
           evaluate true                                                AAA5XR20
             when SQLCODE = +100                                        AAA5XR20
               continue                                                 AAA5XR20
             when SQLCODE >= 0                                          AAA5XR20
               move '0' to IK                                           AAA5XR20
               add 1 to 5-:DD:00-CPTENR                                 AAA5XR20
           end-evaluate.                                                AAA5XR20
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5XR20
           exit section.                                                AAA5XR20
      *>                                                                AAA5XR20
       CREER-:DD:-PHYSIQUE SECTION.                                     AAA5XR20
           move '1' to IK                                               AAA5XR20
           perform CREER-:DD:-SQL                                       AAA5XR20
           evaluate true                                                AAA5XR20
             when SQLCODE = +100                                        AAA5XR20
               continue                                                 AAA5XR20
             when SQLCODE >= 0                                          AAA5XR20
               move '0' to IK                                           AAA5XR20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5XR20
                                  5-:DD:C0-CPTENR                       AAA5XR20
           end-evaluate.                                                AAA5XR20
       CREER-:DD:-PHYSIQUE-FN.                                          AAA5XR20
           exit section.                                                AAA5XR20
      *>                                                                AAA5XR20
       MODIFIER-:DD:-PHYSIQUE SECTION.                                  AAA5XR20
           move '1' to IK                                               AAA5XR20
           perform MODIFIER-:DD:-SQL                                    AAA5XR20
           evaluate true                                                AAA5XR20
             when SQLCODE = +100                                        AAA5XR20
               continue                                                 AAA5XR20
             when SQLCODE >= 0                                          AAA5XR20
               move '0' to IK                                           AAA5XR20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5XR20
                                  5-:DD:M0-CPTENR                       AAA5XR20
           end-evaluate.                                                AAA5XR20
       MODIFIER-:DD:-PHYSIQUE-FN.                                       AAA5XR20
           exit section.                                                AAA5XR20
      *>                                                                AAA5XR20
       SUPPRIMER-:DD:-PHYSIQUE SECTION.                                 AAA5XR20
           move '1' to IK                                               AAA5XR20
           perform SUPPRIMER-:DD:-SQL                                   AAA5XR20
           evaluate true                                                AAA5XR20
             when SQLCODE = +100                                        AAA5XR20
               continue                                                 AAA5XR20
             when SQLCODE >= 0                                          AAA5XR20
               move '0' to IK                                           AAA5XR20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5XR20
                                  5-:DD:S0-CPTENR                       AAA5XR20
           end-evaluate.                                                AAA5XR20
       SUPPRIMER-:DD:-PHYSIQUE-FN.                                      AAA5XR20
           exit section.                                                AAA5XR20
      *>                                                                AAA5XR20
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5XR20
           continue.                                                    AAA5XR20
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5XR20
           exit section.                                                AAA5XR20
