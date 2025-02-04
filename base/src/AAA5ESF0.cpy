      *CONTROL NOSOURCE                                                 AAA5ESF0
      *>****************************************************************AAA5ESF0
      *> Pour écrire dans un fichier multi-enregistrement, ajouter une  AAA5ESF0
      *> clause replacing comme :                                       AAA5ESF0
      *>    COPY AAAPACCE REPLACING                                     AAA5ESF0
      *>         ==write :PREF:== by ==                                 AAA5ESF0
      *>         ==evaluate dd00-code-structure                         AAA5ESF0
      *>           when 'r1'                                            AAA5ESF0
      *>             write dd01                                         AAA5ESF0
      *>           when 'r2'                                            AAA5ESF0
      *>             write dd02                                         AAA5ESF0
      *>           ...                                                  AAA5ESF0
      *>           when other                                           AAA5ESF0
      *>             ...                                                AAA5ESF0
      *>         end-evalate==                                          AAA5ESF0
      *>         ==:DD:== by ==FI==                                     AAA5ESF0
      *>         .                                                      AAA5ESF0
      *> Le replacing de l'ordre write doit être placé avant le         AAA5ESF0
      *> replacing des paramètres.                                      AAA5ESF0
      *CONTROL SOURCE                                                   AAA5ESF0
      *>****************************************************************AAA5ESF0
      *> Accès physiques Ecriture Séquentielle Fichier Séquentiel       AAA5ESF0
      *>****************************************************************AAA5ESF0
      *>                                                                AAA5ESF0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5ESF0
           open output :DD:-FICHIER.                                    AAA5ESF0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5ESF0
           exit section.                                                AAA5ESF0
      *>                                                                AAA5ESF0
       ECRIRE-:DD:-PHYSIQUE SECTION.                                    AAA5ESF0
           write :PREF:                                                 AAA5ESF0
           add 1 to 5-:DD:00-CPTENR.                                    AAA5ESF0
       ECRIRE-:DD:-PHYSIQUE-FN.                                         AAA5ESF0
           exit section.                                                AAA5ESF0
      *>                                                                AAA5ESF0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5ESF0
           close :DD:-FICHIER.                                          AAA5ESF0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5ESF0
           exit section.                                                AAA5ESF0
