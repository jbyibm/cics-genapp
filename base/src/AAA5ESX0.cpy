      *CONTROL NOSOURCE                                                 AAA5ESX0
      *>****************************************************************AAA5ESX0
      *> Gestion de la sérialisation XML par module 'SMXLMS'.           AAA5ESX0
      *> En retour du module, l'indicateur W-XX00-XMLCODE indique si le AAA5ESX0
      *> buffer de construction du fichier XML doit être enregistré sur AAA5ESX0
      *> disque.                                                        AAA5ESX0
      *CONTROL SOURCE                                                   AAA5ESX0
      *>****************************************************************AAA5ESX0
      *> Accès physiques Ecriture Document XML                          AAA5ESX0
      *>****************************************************************AAA5ESX0
      *>                                                                AAA5ESX0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5ESX0
           open output :DD:-FICHIER.                                    AAA5ESX0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5ESX0
           exit section.                                                AAA5ESX0
      *>                                                                AAA5ESX0
       ECRIRE-:DD:-PHYSIQUE SECTION.                                    AAA5ESX0
           call W-:DD:00-SMXMLS using by reference W-:DD:00-XMLCODE     AAA5ESX0
                                                 W-:DD:00-EVENT         AAA5ESX0
                                                 W-:DD:00-TXTLEN        AAA5ESX0
                                        by value W-:DD:00-TXTADR        AAA5ESX0
                                    by reference W-:DD:00-PFXLEN        AAA5ESX0
                                        by value W-:DD:00-PFXADR        AAA5ESX0
                                    by reference W-:DD:00-MAXLEN        AAA5ESX0
                                                 W-:DD:00-BUFLEN        AAA5ESX0
                                                 W-:DD:00-BUFADR        AAA5ESX0
                                                 W-:DD:00-OPTIONS       AAA5ESX0
                                                 W-:DD:00-CTXADR        AAA5ESX0
           end-call                                                     AAA5ESX0
           if W-:DD:00-XMLCODE = 1   *> flush buffer                    AAA5ESX0
             set address of L-:DD:00-BUFFER to W-:DD:00-BUFADR          AAA5ESX0
             move L-:DD:00-BUFFER to :DD:00                             AAA5ESX0
             move 0 to IK                                               AAA5ESX0
             write :DD:00                                               AAA5ESX0
             add 1 to 5-:DD:00-CPTENR                                   AAA5ESX0
           end-if.                                                      AAA5ESX0
       ECRIRE-:DD:-PHYSIQUE-FN.                                         AAA5ESX0
           exit section.                                                AAA5ESX0
      *>                                                                AAA5ESX0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5ESX0
           close :DD:-FICHIER.                                          AAA5ESX0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5ESX0
           exit section.                                                AAA5ESX0
