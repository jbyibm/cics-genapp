      *CONTROL NOSOURCE                                                 AGAVBATC
      *>****************************************************************AGAVBATC
      *> Déclaration des variables de compilation conditionnelle pour   AGAVBATC
      *> un programme batch.                                            AGAVBATC
      *> Ce COPYBOOK fait référence aux COPYBOOKs suivants :            AGAVBATC
      *> - AGAVINIT : variables d'architecture générale                 AGAVBATC
      *> - AAAVACCE : variables associées aux accès aux ressources      AGAVBATC
      ******************************************************************AGAVBATC
      *CONTROL SOURCE                                                   AGAVBATC
           copy AGAVINIT.                                               AGAVBATC
       >>define AA-G-BATCH as b'1' override                             AGAVBATC
           copy AAAVACCE.                                               AGAVBATC
