      *>****************************************************************AAA5LSF0
      *> Accès physiques Lecture Séquentielle Fichier Séquentiel        AAA5LSF0
      *>****************************************************************AAA5LSF0
      *>                                                                AAA5LSF0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5LSF0
           open input :DD:-FICHIER                                      AAA5LSF0
           >>if AA-A-NR < 0                                             AAA5LSF0
           set :DD:-OUVERT to true                                      AAA5LSF0
           move '0' to :DD:-FR                                          AAA5LSF0
           >>end-if                                                     AAA5LSF0
           .                                                            AAA5LSF0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5LSF0
           exit section.                                                AAA5LSF0
      *>                                                                AAA5LSF0
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5LSF0
           read :DD:-FICHIER                                            AAA5LSF0
             at end                                                     AAA5LSF0
       >>evaluate true                                                  AAA5LSF0
         >>when AA-A-NR = 0                                             AAA5LSF0
               move '1' to :DD:-FT                                      AAA5LSF0
         >>when AA-A-NR > 0                                             AAA5LSF0
               move '1' to :DD:-FI                                      AAA5LSF0
         >>when other                                                   AAA5LSF0
               move '1' to :DD:-FR                                      AAA5LSF0
       >>end-evaluate                                                   AAA5LSF0
             not at end                                                 AAA5LSF0
               set :DD:-LU to true                                      AAA5LSF0
           end-read.                                                    AAA5LSF0
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5LSF0
           exit section.                                                AAA5LSF0
      *>                                                                AAA5LSF0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5LSF0
           close :DD:-FICHIER                                           AAA5LSF0
           >>if AA-A-NR < 0                                             AAA5LSF0
           set :DD:-OUVERT to false                                     AAA5LSF0
           move '1' to :DD:-FR                                          AAA5LSF0
           >>end-if                                                     AAA5LSF0
           .                                                            AAA5LSF0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5LSF0
           exit section.                                                AAA5LSF0
