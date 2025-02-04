      *CONTROL NOSOURCE                                                 AAA5ESJ0
      *>****************************************************************AAA5ESJ0
      *> Gestion de la sérialisation JSON par module 'SMJSNS'.          AAA5ESJ0
      *> En retour du module, l'indicateur W-XX00-XMLCODE indique si le AAA5ESJ0
      *> buffer de construction du fichier XML doit être enregistré sur AAA5ESJ0
      *> disque.                                                        AAA5ESJ0
      *CONTROL SOURCE                                                   AAA5ESJ0
      *>****************************************************************AAA5ESJ0
      *> Accès physiques Ecriture Document JSON                         AAA5ESJ0
      *>****************************************************************AAA5ESJ0
      *>                                                                AAA5ESJ0
       OUVRIR-:DD:-PHYSIQUE SECTION.                                    AAA5ESJ0
           open output :DD:-FICHIER.                                    AAA5ESJ0
       OUVRIR-:DD:-PHYSIQUE-FN.                                         AAA5ESJ0
           exit section.                                                AAA5ESJ0
      *>                                                                AAA5ESJ0
       ECRIRE-:DD:-PHYSIQUE SECTION.                                    AAA5ESJ0
           call W-:DD:00-SMJSNS using by reference W-:DD:00-JSNCODE     AAA5ESJ0
                                                 W-:DD:00-EVENT         AAA5ESJ0
                                                 W-:DD:00-TXTLEN        AAA5ESJ0
                                        by value W-:DD:00-TXTADR        AAA5ESJ0
                                    by reference W-:DD:00-MAXLEN        AAA5ESJ0
                                                 W-:DD:00-BUFLEN        AAA5ESJ0
                                                 W-:DD:00-BUFADR        AAA5ESJ0
                                                 W-:DD:00-OPTIONS       AAA5ESJ0
                                                 W-:DD:00-CTXADR        AAA5ESJ0
           end-call                                                     AAA5ESJ0
           if W-:DD:00-JSNCODE = 1   *> flush buffer                    AAA5ESJ0
             set address of L-:DD:00-BUFFER to W-:DD:00-BUFADR          AAA5ESJ0
             move L-:DD:00-BUFFER to :DD:00                             AAA5ESJ0
             move 0 to IK                                               AAA5ESJ0
             write :DD:00                                               AAA5ESJ0
             add 1 to 5-:DD:00-CPTENR                                   AAA5ESJ0
           end-if.                                                      AAA5ESJ0
       ECRIRE-:DD:-PHYSIQUE-FN.                                         AAA5ESJ0
           exit section.                                                AAA5ESJ0
      *>                                                                AAA5ESJ0
       FERMER-:DD:-PHYSIQUE SECTION.                                    AAA5ESJ0
           close :DD:-FICHIER.                                          AAA5ESJ0
       FERMER-:DD:-PHYSIQUE-FN.                                         AAA5ESJ0
           exit section.                                                AAA5ESJ0
