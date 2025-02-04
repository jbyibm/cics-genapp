      *>****************************************************************AAA5LS20
      *> Accès physiques Lecture Séquentielle (curseur) Db2.            AAA5LS20
      *> Les ordres SQL doivent être codés directement dans le          AAA5LS20
      *> programme :                                                    AAA5LS20
      *> - OUVRIR-<dd>-SQL : ordre OPEN  CURSOR                         AAA5LS20
      *> - LIRE-<dd>-SQL   : ordre FETCH CURSOR                         AAA5LS20
      *> - FERMER-<dd>-SQL : ordre CLOSE CURSOR                         AAA5LS20
      *>****************************************************************AAA5LS20
      *>                                                                AAA5LS20
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5LS20
           move '1' to IK                                               AAA5LS20
           perform OUVRIR-:DD:-SQL                                      AAA5LS20
           move '0' to IK                                               AAA5LS20
           set :DD:-OUVERT to true                                      AAA5LS20
       >>evaluate true                                                  AAA5LS20
         >>when AA-A-NR = 0                                             AAA5LS20
           move '0' to :DD:-FT.                                         AAA5LS20
         >>when AA-A-NR > 0                                             AAA5LS20
           move '0' to :DD:-FI :DD:-FT.                                 AAA5LS20
         >>when other                                                   AAA5LS20
           move '0' to :DD:-FR.                                         AAA5LS20
       >>end-evaluate                                                   AAA5LS20
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5LS20
           exit section.                                                AAA5LS20
      *>                                                                AAA5LS20
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5LS20
           move '1' to IK                                               AAA5LS20
           perform LIRE-:DD:-SQL                                        AAA5LS20
           evaluate true                                                AAA5LS20
             when SQLCODE = +100                                        AAA5LS20
       >>evaluate true                                                  AAA5LS20
         >>when AA-A-NR = 0                                             AAA5LS20
               move '1' to :DD:-FT                                      AAA5LS20
         >>when AA-A-NR > 0                                             AAA5LS20
               move '1' to :DD:-FI                                      AAA5LS20
         >>when other                                                   AAA5LS20
               move '1' to :DD:-FR                                      AAA5LS20
       >>end-evaluate                                                   AAA5LS20
             when SQLCODE >= 0                                          AAA5LS20
               set :DD:-LU to true                                      AAA5LS20
               move '0' to IK                                           AAA5LS20
           end-evaluate.                                                AAA5LS20
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5LS20
           exit section.                                                AAA5LS20
      *>                                                                AAA5LS20
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5LS20
           perform FERMER-:DD:-SQL                                      AAA5LS20
           set :DD:-OUVERT to false                                     AAA5LS20
       >>evaluate true                                                  AAA5LS20
         >>when AA-A-NR = 0                                             AAA5LS20
           move '1' to :DD:-FT.                                         AAA5LS20
         >>when AA-A-NR > 0                                             AAA5LS20
           move '1' to :DD:-FI.                                         AAA5LS20
         >>when other                                                   AAA5LS20
           move '1' to :DD:-FR.                                         AAA5LS20
       >>end-evaluate                                                   AAA5LS20
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5LS20
           exit section.                                                AAA5LS20
