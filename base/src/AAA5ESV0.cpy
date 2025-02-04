      *CONTROL NOSOURCE                                                 AAA5ESV0
      *>****************************************************************AAA5ESV0
      *> Pour écrire dans un fichier multi-enregistrement, ajouter une  AAA5ESV0
      *> clause replacing comme :                                       AAA5ESV0
      *>   COPY AAAPACCE REPLACING ...                                  AAA5ESV0
      *>        ==write :DD::SS:== by ==                                AAA5ESV0
      *>      evaluate dd00-code-structure                              AAA5ESV0
      *>        when 'r1'                                               AAA5ESV0
      *>          write dd01                                            AAA5ESV0
      *>        when 'r2'                                               AAA5ESV0
      *>          write dd02                                            AAA5ESV0
      *>        ...                                                     AAA5ESV0
      *>      end-evalate                                               AAA5ESV0
      *>        ==                                                      AAA5ESV0
      *CONTROL SOURCE                                                   AAA5ESV0
      *>****************************************************************AAA5ESV0
      *> Accès physiques Ecriture Séquentielle Fichier VSAM             AAA5ESV0
      *>****************************************************************AAA5ESV0
      *>                                                                AAA5ESV0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5ESV0
           open output :DD:-FICHIER.                                    AAA5ESV0
           if 1-:DD:00-STATUS not = '00' and '97'                       AAA5ESV0
             perform FVSAM-ERREUR-:DD:                                  AAA5ESV0
           end-if.                                                      AAA5ESV0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5ESV0
           exit section.                                                AAA5ESV0
      *>                                                                AAA5ESV0
       ECRIRE-:DD:-PHYSIQUE SECTION.                                    AAA5ESV0
           write :DD::SS:                                               AAA5ESV0
           add 1 to 5-:DD:00-CPTENR.                                    AAA5ESV0
       ECRIRE-:DD:-PHYSIQUE-FN.                                         AAA5ESV0
           exit section.                                                AAA5ESV0
      *>                                                                AAA5ESV0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5ESV0
           close :DD:-FICHIER.                                          AAA5ESV0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5ESV0
           exit section.                                                AAA5ESV0
