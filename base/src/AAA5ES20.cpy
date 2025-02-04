      *>****************************************************************AAA5ES20
      *> Accès physiques Ecriture Séquentielle Db2.                     AAA5ES20
      *> Les ordres SQL doivent être codés directement dans le          AAA5ES20
      *> programme :                                                    AAA5ES20
      *> - ECRIRE-<dd>-SQL : ordre INSERT | UPDATE | MERGE              AAA5ES20
      *>****************************************************************AAA5ES20
      *>                                                                AAA5ES20
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5ES20
           continue.                                                    AAA5ES20
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5ES20
           exit section.                                                AAA5ES20
      *>                                                                AAA5ES20
       ECRIRE-:DD:-PHYSIQUE SECTION.                                    AAA5ES20
           move '1' to IK                                               AAA5ES20
           perform ECRIRE-:DD:-SQL                                      AAA5ES20
           evaluate true                                                AAA5ES20
             when SQLCODE = +100                                        AAA5ES20
               continue                                                 AAA5ES20
             when SQLCODE >= 0                                          AAA5ES20
               move '0' to IK                                           AAA5ES20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5ES20
           end-evaluate.                                                AAA5ES20
       ECRIRE-:DD:-PHYSIQUE-FN.                                         AAA5ES20
           exit section.                                                AAA5ES20
      *>                                                                AAA5ES20
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5ES20
           continue.                                                    AAA5ES20
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5ES20
           exit section.                                                AAA5ES20
