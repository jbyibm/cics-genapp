      *>****************************************************************AAA5LRNN
      *> Accès logiques Lecture Directe (random)                        AAA5LRNN
      *>****************************************************************AAA5LRNN
      *>                                                                AAA5LRNN
       OUVRIR-:DD: SECTION.                                             AAA5LRNN
           perform OUVRIR-:DD:-PHYSIQUE.                                AAA5LRNN
       OUVRIR-:DD:-FN.                                                  AAA5LRNN
           exit section.                                                AAA5LRNN
      *>                                                                AAA5LRNN
       LIRE-:DD: SECTION.                                               AAA5LRNN
           set :DD:-LU to false                                         AAA5LRNN
           perform LIRE-:DD:-PHYSIQUE                                   AAA5LRNN
           if IK = '0'                                                  AAA5LRNN
             add 1 to 5-:DD:00-CPTENR                                   AAA5LRNN
           end-if.                                                      AAA5LRNN
       LIRE-:DD:-FN.                                                    AAA5LRNN
           exit section.                                                AAA5LRNN
      *>                                                                AAA5LRNN
       FERMER-:DD: SECTION.                                             AAA5LRNN
           perform FERMER-:DD:-PHYSIQUE.                                AAA5LRNN
       FERMER-:DD:-FN.                                                  AAA5LRNN
           exit section.                                                AAA5LRNN
