      *>****************************************************************AAA5ERV0
      *> Accès physiques Ecriture directe (random) Fichier VSAM         AAA5ERV0
      *>****************************************************************AAA5ERV0
      *>                                                                AAA5ERV0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5ERV0
           open output :DD:-FICHIER                                     AAA5ERV0
           if 1-:DD:00-STATUS not = '00' and '97'                       AAA5ERV0
             perform FVSAM-ERREUR-:DD:                                  AAA5ERV0
           end-if.                                                      AAA5ERV0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5ERV0
           exit section.                                                AAA5ERV0
      *>                                                                AAA5ERV0
       ECRIRE-:DD:-PHYSIQUE SECTION.                                    AAA5ERV0
           move '1' to IK                                               AAA5ERV0
           write :PREF:                                                 AAA5ERV0
             not invalid key                                            AAA5ERV0
               move '0' to IK                                           AAA5ERV0
               add 1 to 5-:DD:00-CPTENR                                 AAA5ERV0
           end-write.                                                   AAA5ERV0
       ECRIRE-:DD:-PHYSIQUE-FN.                                         AAA5ERV0
           exit section.                                                AAA5ERV0
      *>                                                                AAA5ERV0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5ERV0
           close :DD:-FICHIER.                                          AAA5ERV0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5ERV0
           exit section.                                                AAA5ERV0
