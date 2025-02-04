      *>****************************************************************AAA5LDV0
      *> Accès physiques Lecture Dynamique Fichier VSAM                 AAA5LDV0
      *>****************************************************************AAA5LDV0
      *>                                                                AAA5LDV0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5LDV0
           open input :DD:-FICHIER                                      AAA5LDV0
           if 1-:DD:00-STATUS not = '00' and '97'                       AAA5LDV0
             perform FVSAM-ERREUR-:DD:                                  AAA5LDV0
           end-if                                                       AAA5LDV0
           >>if AA-A-NR < 0                                             AAA5LDV0
           set :DD:-OUVERT to true                                      AAA5LDV0
           move '0' to :DD:-FR                                          AAA5LDV0
           >>end-if                                                     AAA5LDV0
           .                                                            AAA5LDV0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5LDV0
           exit section.                                                AAA5LDV0
      *>                                                                AAA5LDV0
       POSITIONNER-:DD:-PHYSIQUE SECTION.                               AAA5LDV0
           move '1' to IK                                               AAA5LDV0
           start :DD:-FICHIER                                           AAA5LDV0
             :KEYPOS:                                                   AAA5LDV0
             not invalid key                                            AAA5LDV0
               move '0' to IK                                           AAA5LDV0
           end-start.                                                   AAA5LDV0
       POSITIONNER-:DD:-PHYSIQUE-FN.                                    AAA5LDV0
           exit section.                                                AAA5LDV0
      *>                                                                AAA5LDV0
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5LDV0
           move '1' to IK                                               AAA5LDV0
           read :DD:-FICHIER next record                                AAA5LDV0
             at end                                                     AAA5LDV0
       >>evaluate true                                                  AAA5LDV0
         >>when AA-A-NR = 0                                             AAA5LDV0
               move '1' to :DD:-FT                                      AAA5LDV0
         >>when AA-A-NR > 0                                             AAA5LDV0
               move '1' to :DD:-FI                                      AAA5LDV0
         >>when other                                                   AAA5LDV0
               move '1' to :DD:-FR                                      AAA5LDV0
       >>end-evaluate                                                   AAA5LDV0
             not at end                                                 AAA5LDV0
               set :DD:-LU to true                                      AAA5LDV0
               move '0' to IK                                           AAA5LDV0
           end-read.                                                    AAA5LDV0
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5LDV0
           exit section.                                                AAA5LDV0
      *>                                                                AAA5LDV0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5LDV0
           close :DD:-FICHIER                                           AAA5LDV0
           >>if AA-A-NR < 0                                             AAA5LDV0
           set :DD:-OUVERT to false                                     AAA5LDV0
           move '1' to :DD:-FR                                          AAA5LDV0
           >>end-if                                                     AAA5LDV0
           .                                                            AAA5LDV0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5LDV0
           exit section.                                                AAA5LDV0
