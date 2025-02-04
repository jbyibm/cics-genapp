      *>****************************************************************AAA5ESNN
      *> Accès logiques Ecriture Séquentielle                           AAA5ESNN
      *>****************************************************************AAA5ESNN
      *>                                                                AAA5ESNN
       OUVRIR-:DD: SECTION.                                             AAA5ESNN
           perform OUVRIR-:DD:-PHYSIQUE.                                AAA5ESNN
       OUVRIR-:DD:-FN.                                                  AAA5ESNN
           exit section.                                                AAA5ESNN
      *>                                                                AAA5ESNN
       ECRIRE-:DD: SECTION.                                             AAA5ESNN
           perform ECRIRE-:DD:-PHYSIQUE.                                AAA5ESNN
       ECRIRE-:DD:-FN.                                                  AAA5ESNN
           exit section.                                                AAA5ESNN
      *>                                                                AAA5ESNN
       FERMER-:DD: SECTION.                                             AAA5ESNN
           perform FERMER-:DD:-PHYSIQUE.                                AAA5ESNN
       FERMER-:DD:-FN.                                                  AAA5ESNN
           exit section.                                                AAA5ESNN
