      *CONTROL NOSOURCE                                                 AEAVTPQR
      *>****************************************************************AEAVTPQR
      *> Déclaration des variables de compilation conditionnelle pour   AEAVTPQR
      *> un programme TP Q/R multi conversations (développement COBOL). AEAVTPQR
      *> ---------------------------------------------------------------AEAVTPQR
      *> - AA-E-REPONDEUR : présence fonction Répondeur (serveur)       AEAVTPQR
      *> - AA-E-DEMANDEUR : présence fonction Demandeur (client)        AEAVTPQR
      *> - AA-E-MULTICONV : support plusieurs appels Q/R en parallèle   AEAVTPQR
      *>****************************************************************AEAVTPQR
      *CONTROL SOURCE                                                   AEAVTPQR
      *> --- Variables calculées automatiquement (ne pas modifier)      AEAVTPQR
       >>define AA-E-REPONDEUR as b'0'                                  AEAVTPQR
       >>define AA-E-DEMANDEUR as b'0'                                  AEAVTPQR
       >>define AA-E-MULTICONV as b'1'                                  AEAVTPQR
