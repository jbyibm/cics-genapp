      *>****************************************************************AAA5ER20
      *> Accès physiques Ecriture Directe (random) Db2.                 AAA5ER20
      *> Les ordres SQL doivent être codés directement dans le          AAA5ER20
      *> programme :                                                    AAA5ER20
      *> - ECRIRE-<dd>-SQL : ordre INSERT | UPDATE | MERGE              AAA5ER20
      *>****************************************************************AAA5ER20
      *>                                                                AAA5ER20
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5ER20
           continue.                                                    AAA2LR20
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5ER20
           exit section.                                                AAA5ER20
      *>                                                                AAA5ER20
       ECRIRE-:DD:-PHYSIQUE SECTION.                                    AAA5ER20
           move '1' to IK                                               AAA5ER20
           perform ECRIRE-:DD:-SQL                                      AAA5ER20
           evaluate true                                                AAA5ER20
             when SQLCODE = +100                                        AAA5ER20
               continue                                                 AAA5ER20
             when SQLCODE >= 0                                          AAA5ER20
               move '0' to IK                                           AAA5ER20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5ER20
           end-evaluate.                                                AAA5ER20
       ECRIRE-:DD:-PHYSIQUE-FN.                                         AAA5ER20
           exit section.                                                AAA5ER20
      *>                                                                AAA5ER20
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5ER20
           continue.                                                    AAA5ER20
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5ER20
           exit section.                                                AAA5ER20
