      *>****************************************************************AAA5LD20
      *> Accès physiques Lecture Dynamique (curseur) Db2.               AAA5LD20
      *> Les ordres SQL doivent être codés directement dans le          AAA5LD20
      *> programme :                                                    AAA5LD20
      *> - OUVRIR-<dd>-SQL      : ordre OPEN  CURSOR                    AAA5LD20
      *> - POSITIONNER-<dd>-SQL : ordre FETCH BEFORE                    AAA5LD20
      *> - LIRE-<dd>-SQL        : ordre FETCH [NEXT]                    AAA5LD20
      *> - FERMER-<dd>-SQL      : ordre CLOSE CURSOR                    AAA5LD20
      *>****************************************************************AAA5LD20
      *>                                                                AAA5LD20
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5LD20
           move '1' to IK                                               AAA5LD20
           perform OUVRIR-:DD:-SQL                                      AAA5LD20
           move '0' to IK                                               AAA5LD20
           set :DD:-OUVERT to true                                      AAA5LD20
       >>evaluate true                                                  AAA5LD20
         >>when AA-A-NR = 0                                             AAA5LD20
           move '0' to :DD:-FT.                                         AAA5LD20
         >>when AA-A-NR > 0                                             AAA5LD20
           move '0' to :DD:-FI :DD:-FT.                                 AAA5LD20
         >>when other                                                   AAA5LD20
           move '0' to :DD:-FR.                                         AAA5LD20
       >>end-evaluate                                                   AAA5LD20
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5LD20
           exit section.                                                AAA5LD20
      *>                                                                AAA5LD20
       POSITIONNER-:DD:-PHYSIQUE SECTION.                               AAA5LD20
           move '1' to IK                                               AAA5LD20
           perform POSITIONNER-:DD:-SQL                                 AAA5LD20
           evaluate true                                                AAA5LD20
             when SQLCODE = +100                                        AAA5LD20
       >>evaluate true                                                  AAA5LD20
         >>when AA-A-NR = 0                                             AAA5LD20
               move '1' to :DD:-FT                                      AAA5LD20
         >>when AA-A-NR > 0                                             AAA5LD20
               move '1' to :DD:-FI                                      AAA5LD20
         >>when other                                                   AAA5LD20
               move '1' to :DD:-FR                                      AAA5LD20
       >>end-evaluate                                                   AAA5LD20
             when SQLCODE >= 0                                          AAA5LD20
               move '0' to IK                                           AAA5LD20
           end-evaluate.                                                AAA5LD20
       POSITIONNER-:DD:-PHYSIQUE-FN.                                    AAA5LD20
           exit section.                                                AAA5LD20
      *>                                                                AAA5LD20
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5LD20
           move '1' to IK                                               AAA5LD20
           perform LIRE-:DD:-SQL                                        AAA5LD20
           evaluate true                                                AAA5LD20
             when SQLCODE = +100                                        AAA5LD20
       >>evaluate true                                                  AAA5LD20
         >>when AA-A-NR = 0                                             AAA5LD20
               move '1' to :DD:-FT                                      AAA5LD20
         >>when AA-A-NR > 0                                             AAA5LD20
               move '1' to :DD:-FI                                      AAA5LD20
         >>when other                                                   AAA5LD20
               move '1' to :DD:-FR                                      AAA5LD20
       >>end-evaluate                                                   AAA5LD20
             when SQLCODE >= 0                                          AAA5LD20
               set :DD:-LU to true                                      AAA5LD20
               move '0' to IK                                           AAA5LD20
           end-evaluate.                                                AAA5LD20
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5LD20
           exit section.                                                AAA5LD20
      *>                                                                AAA5LD20
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5LD20
           perform FERMER-:DD:-SQL                                      AAA5LD20
           set :DD:-OUVERT to false                                     AAA5LD20
       >>evaluate true                                                  AAA5LD20
         >>when AA-ANR = 0                                              AAA5LD20
           move '1' to :DD:-FT.                                         AAA5LD20
         >>when AA-ANR > 0                                              AAA5LD20
           move '1' to :DD:-FI.                                         AAA5LD20
         >>when other                                                   AAA5LD20
           move '1' to :DD:-FR.                                         AAA5LD20
       >>end-evaluate                                                   AAA5LD20
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5LD20
           exit section.                                                AAA5LD20
