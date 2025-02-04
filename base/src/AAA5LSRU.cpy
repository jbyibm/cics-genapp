      *>****************************************************************AAA5LSRU
      *> Accès logiques Lecture Séquentielle avec Ruptures sans Synchro AAA5LSRU
      *>****************************************************************AAA5LSRU
      *>                                                                AAA5LSRU
       OUVRIR-:DD: SECTION.                                             AAA5LSRU
           set :DD:-LU to false                                         AAA5LSRU
           perform OUVRIR-:DD:-PHYSIQUE                                 AAA5LSRU
           perform LIRE-:DD:-PHYSIQUE.                                  AAA5LSRU
       OUVRIR-:DD:-FN.                                                  AAA5LSRU
           exit section.                                                AAA5LSRU
      *>                                                                AAA5LSRU
       LIRE-:DD: SECTION.                                               AAA5LSRU
           set :DD:-LU to false                                         AAA5LSRU
      *> Alimentation anticipée des indicateurs "Rupture Première"      AAA5LSRU
           move :DD:-DE to :DD:-PE                                      AAA5LSRU
           move :DD:-NRD to :DD:-NRP                                    AAA5LSRU
           move NRD to NRP                                              AAA5LSRU
           if :DD:-FI = '1'                                             AAA5LSRU
             move '1' to :DD:-FT                                        AAA5LSRU
             exit section                                               AAA5LSRU
           end-if                                                       AAA5LSRU
           move :PREF: to 1-:PREF:                                      AAA5LSRU
           add 1 to 5-:DD:00-CPTENR                                     AAA5LSRU
           perform LIRE-:DD:-PHYSIQUE.                                  AAA5LSRU
       LIRE-:DD:-FN.                                                    AAA5LSRU
           exit section.                                                AAA5LSRU
      *>                                                                AAA5LSRU
       FERMER-:DD: SECTION.                                             AAA5LSRU
           perform FERMER-:DD:-PHYSIQUE.                                AAA5LSRU
       FERMER-:DD:-FN.                                                  AAA5LSRU
           exit section.                                                AAA5LSRU
           copy AAA5L0RU.                                               AAA5LSRU
