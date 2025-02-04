      *CONTROL NOSOURCE                                                 AAA5MRV0
      *>****************************************************************AAA5MRV0
      *> Pour écrire dans un fichier multi-enregistrement, ajouter une  AAA5MRV0
      *> clause replacing comme :                                       AAA5MRV0
      *>   COPY AAAPACCE REPLACING ...                                  AAA5MRV0
      *>        ==write :PREF:== by ==                                  AAA5MRV0
      *>      evaluate dd00-code-structure                              AAA5MRV0
      *>        when 'r1'                                               AAA5MRV0
      *>          write dd01                                            AAA5MRV0
      *>        when 'r2'                                               AAA5MRV0
      *>          write dd02                                            AAA5MRV0
      *>        ...                                                     AAA5MRV0
      *>      end-evaluate==                                            AAA5MRV0
      *CONTROL SOURCE                                                   AAA5MRV0
      *>****************************************************************AAA5MRV0
      *> Accès physiques Lecture Directe (random) Fichier VSAM          AAA5MRV0
      *>****************************************************************AAA5MRV0
      *>                                                                AAA5MRV0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5MRV0
           open i-o :DD:-FICHIER                                        AAA5MRV0
           if 1-:DD:00-STATUS not = '00' and '97'                       AAA5MRV0
             perform FVSAM-ERREUR-:DD:                                  AAA5MRV0
           end-if.                                                      AAA5MRV0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5MRV0
           exit section.                                                AAA5MRV0
      *>                                                                AAA5MRV0
       CREER-:DD:-PHYSIQUE SECTION.                                     AAA5MRV0
           move '1' to IK                                               AAA5MRV0
           write :PREF:                                                 AAA5MRV0
             not invalid key                                            AAA5MRV0
               move '0' to IK                                           AAA5MRV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5MRV0
                        5-:DD:C0-CPTENR                                 AAA5MRV0
           end-write.                                                   AAA5MRV0
       CREER-:DD:-PHYSIQUE-FN.                                          AAA5MRV0
           exit section.                                                AAA5MRV0
      *>                                                                AAA5MRV0
       MODIFIER-:DD:-PHYSIQUE SECTION.                                  AAA5MRV0
           move '1' to IK                                               AAA5MRV0
           rewrite :PREF:                                               AAA5MRV0
             not invalid key                                            AAA5MRV0
               move '0' to IK                                           AAA5MRV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5MRV0
                        5-:DD:M0-CPTENR                                 AAA5MRV0
           end-rewrite.                                                 AAA5MRV0
       MODIFIER-:DD:-PHYSIQUE-FN.                                       AAA5MRV0
           exit section.                                                AAA5MRV0
      *>                                                                AAA5MRV0
       SUPPRIMER-:DD:-PHYSIQUE SECTION.                                 AAA5MRV0
           move '1' to IK                                               AAA5MRV0
           delete :DD:-FICHIER                                          AAA5MRV0
             not invalid key                                            AAA5MRV0
               move '0' to IK                                           AAA5MRV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5MRV0
                        5-:DD:S0-CPTENR                                 AAA5MRV0
           end-delete.                                                  AAA5MRV0
       SUPPRIMER-:DD:-PHYSIQUE-FN.                                      AAA5MRV0
           exit section.                                                AAA5MRV0
      *>                                                                AAA5MRV0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5MRV0
           close :DD:-FICHIER.                                          AAA5MRV0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5MRV0
           exit section.                                                AAA5MRV0
