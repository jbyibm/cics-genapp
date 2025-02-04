      *>****************************************************************AAA5LSV0
      *> Accès physiques Lecture Séquentielle Fichier VSAM              AAA5LSV0
      *>****************************************************************AAA5LSV0
      *>                                                                AAA5LSV0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5LSV0
           open input :DD:-FICHIER                                      AAA5LSV0
           if 1-:DD:00-STATUS not = '00' and '97'                       AAA5LSV0
             perform FVSAM-ERREUR-:DD:                                  AAA5LSV0
           end-if.                                                      AAA5LSV0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5LSV0
           exit section.                                                AAA5LSV0
      *>                                                                AAA5LSV0
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5LSV0
           read :DD:-FICHIER                                            AAA5LSV0
             at end                                                     AAA5LSV0
       >>evaluate true                                                  AAA5LSV0
         >>when AA-A-NR = 0                                             AAA5LSV0
               move '1' to :DD:-FT                                      AAA5LSV0
         >>when AA-A-NR > 0                                             AAA5LSV0
               move '1' to :DD:-FI                                      AAA5LSV0
         >>when other                                                   AAA5LSV0
               move '1' to :DD:-FR                                      AAA5LSV0
       >>end-evaluate                                                   AAA5LSV0
             not at end                                                 AAA5LSV0
               set :DD:-LU to true                                      AAA5LSV0
           end-read.                                                    AAA5LSV0
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5LSV0
           exit section.                                                AAA5LSV0
      *>                                                                AAA5LSV0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5LSV0
           close :DD:-FICHIER.                                          AAA5LSV0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5LSV0
           exit section.                                                AAA5LSV0
