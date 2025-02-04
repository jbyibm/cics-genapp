      *>****************************************************************AAA5XS20
      *> Accès physiques Lecture et MaJ Séquentielle (curseur) Db2.     AAA5XS20
      *> Les ordres SQL doivent être codés directement dans le          AAA5XS20
      *> programme :                                                    AAA5XS20
      *> - OUVRIR-<dd>-SQL    : ordre OPEN  CURSOR FOR UPDATE           AAA5XS20
      *> - LIRE-<dd>-SQL      : ordre FETCH CURSOR                      AAA5XS20
      *> - CREER-<dd>-SQL     : ordre INSERT                            AAA5XS20
      *> - MODIFIER-<dd>-SQL  : ordre UPDATE CURRENT CURSOR             AAA5XS20
      *> - SUPPRIMER-<dd>-SQL : ordre DELETE                            AAA5XS20
      *> - FERMER-<dd>-SQL    : ordre CLOSE CURSOR                      AAA5XS20
      *>****************************************************************AAA5XS20
      *>                                                                AAA5XS20
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5XS20
           move '1' to IK                                               AAA5XS20
           perform OUVRIR-:DD:-SQL                                      AAA5XS20
           move '0' to IK                                               AAA5XS20
           set :DD:-OUVERT to true                                      AAA5XS20
       >>evaluate true                                                  AAA5XS20
         >>when AA-A-NR = 0                                             AAA5XS20
           move '0' to :DD:-FT.                                         AAA5XS20
         >>when AA-A-NR > 0                                             AAA5XS20
           move '0' to :DD:-FI :DD:-FT.                                 AAA5XS20
         >>when other                                                   AAA5XS20
           move '0' to :DD:-FR.                                         AAA5XS20
       >>end-evaluate                                                   AAA5XS20
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5XS20
           exit section.                                                AAA5XS20
      *>                                                                AAA5XS20
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5XS20
           move '1' to IK                                               AAA5XS20
           perform LIRE-:DD:-SQL                                        AAA5XS20
           evaluate true                                                AAA5XS20
             when SQLCODE = +100                                        AAA5XS20
       >>evaluate true                                                  AAA5XS20
         >>when AA-A-NR = 0                                             AAA5XS20
               move '1' to :DD:-FT                                      AAA5XS20
         >>when AA-A-NR > 0                                             AAA5XS20
               move '1' to :DD:-FI                                      AAA5XS20
         >>when other                                                   AAA5XS20
               move '1' to :DD:-FR                                      AAA5XS20
       >>end-evaluate                                                   AAA5XS20
             when SQLCODE >= 0                                          AAA5XS20
               move '0' to IK                                           AAA5XS20
           end-evaluate.                                                AAA5XS20
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5XS20
           exit section.                                                AAA5XS20
      *>                                                                AAA5XS20
       CREER-:DD:-PHYSIQUE SECTION.                                     AAA5XS20
           move '1' to IK                                               AAA5XS20
           perform CREER-:DD:-SQL                                       AAA5XS20
           evaluate true                                                AAA5XS20
             when SQLCODE = +100                                        AAA5XS20
               continue                                                 AAA5XS20
             when SQLCODE >= 0                                          AAA5XS20
               move '0' to IK                                           AAA5XS20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5XS20
                                  5-:DD:C0-CPTENR                       AAA5XS20
           end-evaluate.                                                AAA5XS20
       CREER-:DD:-PHYSIQUE-FN.                                          AAA5XS20
           exit section.                                                AAA5XS20
      *>                                                                AAA5XS20
       MODIFIER-:DD:-PHYSIQUE SECTION.                                  AAA5XS20
           move '1' to IK                                               AAA5XS20
           perform MODIFIER-:DD:-SQL                                    AAA5XS20
           evaluate true                                                AAA5XS20
             when SQLCODE = +100                                        AAA5XS20
               continue                                                 AAA5XS20
             when SQLCODE >= 0                                          AAA5XS20
               move '0' to IK                                           AAA5XS20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5XS20
                                  5-:DD:M0-CPTENR                       AAA5XS20
           end-evaluate.                                                AAA5XS20
       MODIFIER-:DD:-PHYSIQUE-FN.                                       AAA5XS20
           exit section.                                                AAA5XS20
      *>                                                                AAA5XS20
       SUPPRIMER-:DD:-PHYSIQUE SECTION.                                 AAA5XS20
           move '1' to IK                                               AAA5XS20
           perform SUPPRIMER-:DD:-SQL                                   AAA5XS20
           evaluate true                                                AAA5XS20
             when SQLCODE = +100                                        AAA5XS20
               continue                                                 AAA5XS20
             when SQLCODE >= 0                                          AAA5XS20
               move '0' to IK                                           AAA5XS20
               add SQLERRD (3) to 5-:DD:00-CPTENR                       AAA5XS20
                                  5-:DD:S0-CPTENR                       AAA5XS20
           end-evaluate.                                                AAA5XS20
       SUPPRIMER-:DD:-PHYSIQUE-FN.                                      AAA5XS20
           exit section.                                                AAA5XS20
      *>                                                                AAA5XS20
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5XS20
           perform FERMER-:DD:-SQL                                      AAA5XS20
           set :DD:-OUVERT to false                                     AAA5XS20
       >>evaluate true                                                  AAA5XS20
         >>when AA-A-NR = 0                                             AAA5XS20
           move '1' to :DD:-FT.                                         AAA5XS20
         >>when AA-A-NR > 0                                             AAA5XS20
           move '1' to :DD:-FI.                                         AAA5XS20
         >>when other                                                   AAA5XS20
           move '1' to :DD:-FR.                                         AAA5XS20
       >>end-evaluate                                                   AAA5XS20
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5XS20
           exit section.                                                AAA5XS20
