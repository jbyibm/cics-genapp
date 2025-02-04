      *CONTROL NOSOURCE                                                 AAA5T000
      *>****************************************************************AAA5T000
      *> Le chargement en table mémoire est une simplification de la    AAA5T000
      *> lecture séquentielle.                                          AAA5T000
      *>----------------------------------------------------------------AAA5T000
      *> Le programme doit déclarer les éléments suivants en Data       AAA5T000
      *> Division :                                                     AAA5T000
      *> - I:PREF:M  : indice initialisé avec le nombre maxi de postes  AAA5T000
      *>               de la table mémoire.                             AAA5T000
      *> - I:PREF:L  : indice initialisé avec le nombre de postes déjà  AAA5T000
      *>               chargés dans la table mémoire, 0 par défaut.     AAA5T000
      *> - I:PREF:R  : indice de travail, sans valeur particulière.     AAA5T000
      *> - 1-:PREF:T : zone occursée correspondant à 1 poste de la      AAA5T000
      *>               table mémoire.                                   AAA5T000
      *> Les indices doivent être déclarés en Working-Storage Section.  AAA5T000
      *> La zone occursée 1-:PREF:T peut être déclarée dans n'importe   AAA5T000
      *> quelle Section de la Data Division.                            AAA5T000
      *>****************************************************************AAA5T000
       >>define AA-A-MODE as 'S' override                               AAA5T000
       >>define AA-A-NR   as 0   override                               AAA5T000
       >>define AA-A-NS   as 0   override                               AAA5T000
      *CONTROL SOURCE                                                   AAA5T000
      *>****************************************************************AAA5T000
      *> Chargement en table mémoire                                    AAA5T000
      *>****************************************************************AAA5T000
      *>                                                                AAA5T000
       CHARGER-:DD: SECTION.                                            AAA5T000
           set FIN-LECTURE-:DD: to false                                AAA5T000
           move I:PREF:L to I:PREF:R                                    AAA5T000
           perform OUVRIR-:DD:                                          AAA5T000
           perform LIRE-:DD:                                            AAA5T000
           perform until FIN-LECTURE-:DD:                               AAA5T000
             add 1 to I:PREF:R                                          AAA5T000
             if I:PREF:R <= I:PREF:M                                    AAA5T000
               move I:PREF:R to I:PREF:L                                AAA5T000
               move :PREF: to 1-:PREF:T (I:PREF:L)                      AAA5T000
             end-if                                                     AAA5T000
             perform LIRE-:DD:                                          AAA5T000
           end-perform                                                  AAA5T000
           perform FERMER-:DD:.                                         AAA5T000
       CHARGER-:DD:-FN.                                                 AAA5T000
           exit section.                                                AAA5T000
           copy AAA5LS00.                                               AAA5T000
