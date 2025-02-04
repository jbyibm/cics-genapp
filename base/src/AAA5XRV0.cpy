      *CONTROL NOSOURCE                                                 AAA5XRV0
      *>****************************************************************AAA5XRV0
      *> Pour écrire dans un fichier multi-enregistrement, ajouter une  AAA5XRV0
      *> clause replacing comme :                                       AAA5XRV0
      *>   COPY AAAPACCE REPLACING ...                                  AAA5XRV0
      *>        ==write :PREF:== by ==                                  AAA5XRV0
      *>      evaluate dd00-code-structure                              AAA5XRV0
      *>        when 'r1'                                               AAA5XRV0
      *>          write dd01                                            AAA5XRV0
      *>        when 'r2'                                               AAA5XRV0
      *>          write dd02                                            AAA5XRV0
      *>        ...                                                     AAA5XRV0
      *>      end-evaluate==                                            AAA5XRV0
      *CONTROL SOURCE                                                   AAA5XRV0
      *>****************************************************************AAA5XRV0
      *> Accès physiques Lecture & Maj Directe (random) Fichier VSAM    AAA5XRV0
      *>****************************************************************AAA5XRV0
      *>                                                                AAA5XRV0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5XRV0
           open i-o :DD:-FICHIER                                        AAA5XRV0
           if 1-:DD:00-STATUS not = '00' and '97'                       AAA5XRV0
             perform FVSAM-ERREUR-:DD:                                  AAA5XRV0
           end-if.                                                      AAA5XRV0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5XRV0
           exit section.                                                AAA5XRV0
      *>                                                                AAA5XRV0
       LIRE-:DD:-PHYSIQUE SECTION.                                      AAA5XRV0
           move '1' to IK                                               AAA5XRV0
           read :DD:-FICHIER                                            AAA5XRV0
             :KEYPOS:                                                   AAA5XRV0
             not invalid key                                            AAA5XRV0
               move '0' to IK                                           AAA5XRV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5XRV0
           end-read.                                                    AAA5XRV0
       LIRE-:DD:-PHYSIQUE-FN.                                           AAA5XRV0
           exit section.                                                AAA5XRV0
      *>                                                                AAA5XRV0
       CREER-:DD:-PHYSIQUE SECTION.                                     AAA5XRV0
           move '1' to IK                                               AAA5XRV0
           write :PREF:                                                 AAA5XRV0
             not invalid key                                            AAA5XRV0
               move '0' to IK                                           AAA5XRV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5XRV0
                        5-:DD:C0-CPTENR                                 AAA5XRV0
           end-write.                                                   AAA5XRV0
       CREER-:DD:-PHYSIQUE-FN.                                          AAA5XRV0
           exit section.                                                AAA5XRV0
      *>                                                                AAA5XRV0
       MODIFIER-:DD:-PHYSIQUE SECTION.                                  AAA5XRV0
           move '1' to IK                                               AAA5XRV0
           rewrite :PREF:                                               AAA5XRV0
             not invalid key                                            AAA5XRV0
               move '0' to IK                                           AAA5XRV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5XRV0
                        5-:DD:M0-CPTENR                                 AAA5XRV0
           end-rewrite.                                                 AAA5XRV0
       MODIFIER-:DD:-PHYSIQUE-FN.                                       AAA5XRV0
           exit section.                                                AAA5XRV0
      *>                                                                AAA5XRV0
       SUPPRIMER-:DD:-PHYSIQUE SECTION.                                 AAA5XRV0
           move '1' to IK                                               AAA5XRV0
           delete :DD:-FICHIER                                          AAA5XRV0
             not invalid key                                            AAA5XRV0
               move '0' to IK                                           AAA5XRV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5XRV0
                        5-:DD:S0-CPTENR                                 AAA5XRV0
           end-delete.                                                  AAA5XRV0
       SUPPRIMER-:DD:-PHYSIQUE-FN.                                      AAA5XRV0
           exit section.                                                AAA5XRV0
      *>                                                                AAA5XRV0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5XRV0
           close :DD:-FICHIER.                                          AAA5XRV0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5XRV0
           exit section.                                                AAA5XRV0
