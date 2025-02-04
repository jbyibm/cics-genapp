      *CONTROL NOSOURCE                                                 AGAVTPQR
      *>****************************************************************AGAVTPQR
      *> Déclaration des variables de compilation conditionnelle pour   AGAVTPQR
      *> un programme TP Q/R multi conversations (développement COBOL). AGAVTPQR
      *> Ce COPYBOOK fait référence aux COPYBOOKs suivants :            AGAVTPQR
      *> - AGAVINIT : variables d'architecture générale                 AGAVTPQR
      *> - AAAVACCE : variables associées aux accès aux ressources      AGAVTPQR
      *> - AEAVTPQR : variables associées aux fonctions Q/R             AGAVTPQR
      *>****************************************************************AGAVTPQR
      *CONTROL SOURCE                                                   AGAVTPQR
           copy AGAVINIT.                                               AGAVTPQR
       >>define AA-G-CICS as b'1' override                              AGAVTPQR
           copy AAAVACCE.                                               AGAVTPQR
           copy AEAVTPQR.                                               AGAVTPQR
