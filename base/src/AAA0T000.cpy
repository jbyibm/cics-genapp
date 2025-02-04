      *CONTROL NOSOURCE                                                 AAA0T000
      *>****************************************************************AAA0T000
      *> Le chargement en table mémoire est une simplification de la    AAA0T000
      *> lecture séquentielle.                                          AAA0T000
      *>----------------------------------------------------------------AAA0T000
      *> Le programme doit déclarer les éléments suivants en Data       AAA0T000
      *> Division :                                                     AAA0T000
      *> - I:PREF:M  : indice initialisé avec le nombre maxi de postes  AAA0T000
      *>               de la table mémoire.                             AAA0T000
      *> - I:PREF:L  : indice initialisé avec le nombre de postes déjà  AAA0T000
      *>               chargés dans la table mémoire, 0 par défaut.     AAA0T000
      *> - I:PREF:R  : indice de travail, sans valeur particulière.     AAA0T000
      *> - 1-:PREF:T : zone occursée correspondant à 1 poste de la      AAA0T000
      *>               tablemémoire.                                    AAA0T000
      *> Les indices doivent être déclarés en Working-Storage Section.  AAA0T000
      *> La zone occursée 1-:PREF:T peut être déclarée dans n'importe   AAA0T000
      *> quelle Section de la Data Division.                            AAA0T000
      *>****************************************************************AAA0T000
       >>define AA-A-MODE     as 'S' override                           AAA0T000
       >>define AA-A-NR       as 0   override                           AAA0T000
       >>define AA-A-NS       as 0   override                           AAA0T000
       >>define AA-A-DB2NOIND as b'1'                                   AAA0T000
      *CONTROL SOURCE                                                   AAA0T000
       >>if AA-A-ORG = '2'                                              AAA0T000
           copy AAA0LS20.                                               AAA0T000
       >>end-if                                                         AAA0T000
      *> Indicateur de fin de lecture                                   AAA0T000
       01               :DD:-FT          PIC X(1).                      AAA0T000
                    88  FIN-LECTURE-:DD: VALUE '1'                      AAA0T000
                                       FALSE '0'.                       AAA0T000
      *> Indicateur accès nouvel enregistrement lu                      AAA0T000
       01                              PIC X VALUE '0'.                 AAA0T000
                    88  :DD:-LU          VALUE '1'                      AAA0T000
                                       FALSE '0'.                       AAA0T000
