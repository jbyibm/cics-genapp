      *CONTROL NOSOURCE                                                 AAA5XSV0
      *>****************************************************************AAA5XSV0
      *> Pour écrire dans un fichier multi-enregistrement, ajouter une  AAA5XSV0
      *> clause replacing comme :                                       AAA5XSV0
      *>   COPY AAAPACCE REPLACING ...                                  AAA5XSV0
      *>        ==write :DD::SS:== by ==                                AAA5XSV0
      *>      evaluate dd00-code-structure                              AAA5XSV0
      *>        when 'r1'                                               AAA5XSV0
      *>          write dd01                                            AAA5XSV0
      *>        when 'r2'                                               AAA5XSV0
      *>          write dd02                                            AAA5XSV0
      *>        ...                                                     AAA5XSV0
      *>      end-evalate                                               AAA5XSV0
      *>        ==                                                      AAA5XSV0
      *CONTROL SOURCE                                                   AAA5XSV0
      *>****************************************************************AAA5XSV0
      *> Accès physiques Lecture et MaJ Séquentielle Fichier VSAM       AAA5XSV0
      *>****************************************************************AAA5XSV0
      *>                                                                AAA5XSV0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5XSV0
           open i-o :DD:-FICHIER                                        AAA5XSV0
           if 1-:DD:00-STATUS not = '00' and '97'                       AAA5XSV0
             perform FVSAM-ERREUR-:DD:                                  AAA5XSV0
           end-if                                                       AAA5XSV0
           >>if AA-A-NR < 0                                             AAA5XSV0
           set :DD:-OUVERT to true                                      AAA5XSV0
           move '0' to :DD:-FR                                          AAA5XSV0
           >>end-if                                                     AAA5XSV0
           .                                                            AAA5XSV0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5XSV0
           exit section.                                                AAA5XSV0
      *>                                                                AAA5XSV0
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5XSV0
           read :DD:-FICHIER                                            AAA5XSV0
             at end                                                     AAA5XSV0
       >>evaluate true                                                  AAA5XSV0
         >>when AA-A-NR = 0                                             AAA5XSV0
               move '1' to :DD:-FT                                      AAA5XSV0
         >>when AA-A-NR > 0                                             AAA5XSV0
               move '1' to :DD:-FI                                      AAA5XSV0
         >>when other                                                   AAA5XSV0
               move '1' to :DD:-FR                                      AAA5XSV0
       >>end-evaluate                                                   AAA5XSV0
           end-read.                                                    AAA5XSV0
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5XSV0
           exit section.                                                AAA5XSV0
      *>                                                                AAA5XSV0
       CREER-:DD:-PHYSIQUE SECTION.                                     AAA5XSV0
           move '1' to IK                                               AAA5XSV0
           write :DD::SS:                                               AAA5XSV0
             not invalid key                                            AAA5XSV0
               move '0' to IK                                           AAA5XSV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5XSV0
                        5-:DD:C0-CPTENR                                 AAA5XSV0
           end-write.                                                   AAA5XSV0
       CREER-:DD:-PHYSIQUE-FN.                                          AAA5XSV0
           exit section.                                                AAA5XSV0
      *>                                                                AAA5XSV0
       MODIFIER-:DD:-PHYSIQUE SECTION.                                  AAA5XSV0
           move '1' to IK                                               AAA5XSV0
           rewrite :DD::SS:                                             AAA5XSV0
             not invalid key                                            AAA5XSV0
               move '0' to IK                                           AAA5XSV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5XSV0
                        5-:DD:M0-CPTENR                                 AAA5XSV0
           end-rewrite.                                                 AAA5XSV0
       MODIFIER-:DD:-PHYSIQUE-FN.                                       AAA5XSV0
           exit section.                                                AAA5XSV0
      *>                                                                AAA5XSV0
       SUPPRIMER-:DD:-PHYSIQUE SECTION.                                 AAA5XSV0
           move '1' to IK                                               AAA5XSV0
           delete :DD:-FICHIER                                          AAA5XSV0
             not invalid key                                            AAA5XSV0
               move '0' to IK                                           AAA5XSV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5XSV0
                        5-:DD:S0-CPTENR                                 AAA5XSV0
           end-delete.                                                  AAA5XSV0
       SUPPRIMER-:DD:-PHYSIQUE-FN.                                      AAA5XSV0
           exit section.                                                AAA5XSV0
      *>                                                                AAA5XSV0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5XSV0
           close :DD:-FICHIER                                           AAA5XSV0
           >>if AA-A-NR < 0                                             AAA5XSV0
           set :DD:-OUVERT to false                                     AAA5XSV0
           move '1' to :DD:-FR                                          AAA5XSV0
           >>end-if                                                     AAA5XSV0
           .                                                            AAA5XSV0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5XSV0
           exit section.                                                AAA5XSV0
