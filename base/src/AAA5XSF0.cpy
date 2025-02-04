      *>****************************************************************AAA5XSF0
      *> Accès physiques Lecture et MaJ Séquentielle Fichier Séquentiel AAA5XSF0
      *>****************************************************************AAA5XSF0
      *>                                                                AAA5XSF0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5XSF0
           open i-o :DD:-FICHIER                                        AAA5XSF0
           if 1-:DD:00-STATUS not = '00' and '97'                       AAA5XSF0
             perform FVSAM-ERREUR-:DD:                                  AAA5XSF0
           end-if                                                       AAA5XSF0
           >>if AA-A-NR < 0                                             AAA5XSF0
           set :DD:-OUVERT to true                                      AAA5XSF0
           move '0' to :DD:-FR                                          AAA5XSF0
           >>end-if                                                     AAA5XSF0
           .                                                            AAA5XSF0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5XSF0
           exit section.                                                AAA5XSF0
      *>                                                                AAA5XSF0
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5XSF0
           read :DD:-FICHIER                                            AAA5XSF0
             at end                                                     AAA5XSF0
       >>evaluate true                                                  AAA5XSF0
         >>when AA-A-NR = 0                                             AAA5XSF0
               move '1' to :DD:-FT                                      AAA5XSF0
         >>when AA-A-NR > 0                                             AAA5XSF0
               move '1' to :DD:-FI                                      AAA5XSF0
         >>when other                                                   AAA5XSF0
               move '1' to :DD:-FR                                      AAA5XSF0
       >>end-evaluate                                                   AAA5XSF0
           end-read.                                                    AAA5XSF0
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5XSF0
           exit section.                                                AAA5XSF0
      *>                                                                AAA5XSF0
       MODIFIER-:DD:-PHYSIQUE SECTION.                                  AAA5XSF0
           move '1' to IK                                               AAA5XSF0
           rewrite :DD::SS:                                             AAA5XSF0
           move '0' to IK                                               AAA5XSF0
           add 1 to 5-:DD:00-CPTENR                                     AAA5XSF0
                    5-:DD:M0-CPTENR                                     AAA5XSF0
       MODIFIER-:DD:-PHYSIQUE-FN.                                       AAA5XSF0
           exit section.                                                AAA5XSF0
      *>                                                                AAA5XSF0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5XSF0
           close :DD:-FICHIER                                           AAA5XSF0
           >>if AA-A-NR < 0                                             AAA5XSF0
           set :DD:-OUVERT to false                                     AAA5XSF0
           move '1' to :DD:-FR                                          AAA5XSF0
           >>end-if                                                     AAA5XSF0
           .                                                            AAA5XSF0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5XSF0
           exit section.                                                AAA5XSF0
