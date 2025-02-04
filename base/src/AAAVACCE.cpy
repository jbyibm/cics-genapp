      *CONTROL NOSOURCE                                                 AAAVACCE
      *>****************************************************************AAAVACCE
      *> Initialisation des variables de compilation conditionne pour   AAAVACCE
      *> la gestion des accès aux ressources et de la cinématique       AAAVACCE
      *> programme.                                                     AAAVACCE
      *>----------------------------------------------------------------AAAVACCE
      *> - AA-A-CONTROLES          : présence lectures avec contrôles   AAAVACCE
      *> - AA-A-DB2                : présence accès Db2                 AAAVACCE
      *> - AA-A-DB2-TRACE          : trace Db2                          AAAVACCE
      *> - AA-A-ECRITURES          : présence écritures automatiques    AAAVACCE
      *> - AA-A-EDITIONS           : présence éditions                  AAAVACCE
      *> - AA-A-EDITIONS-AUTO      : présence éditions automatiques     AAAVACCE
      *> - AA-A-LECTURES           : présence lectures automatiques     AAAVACCE
      *> - AA-A-LECTURES-AVEC-RUPT : présence lectures avec ruptures    AAAVACCE
      *> - AA-A-LECTURES-AVEC-SYNC : présence lectures avec synchro     AAAVACCE
      *> - AA-A-LECTURES-SANS-RUPT : présence lectures sans ruptures    AAAVACCE
      *> - AA-A-MAJ                : présence mise à jour automatiques  AAAVACCE
      *> - AA-A-MAXNR              : niveau rupture maximum             AAAVACCE
      *> - AA-A-MAXNS              : niveau synchronisation maximum     AAAVACCE
      *> - AA-A-VSAM               : présence accès VSAM                AAAVACCE
      *>****************************************************************AAAVACCE
      *CONTROL SOURCE                                                   AAAVACCE
      *> --- Variables calculées automatiquement (ne pas modifier)      AAAVACCE
       >>define AA-A-CONTROLES as b'0'                                  AAAVACCE
       >>define AA-A-DB2 as b'0'                                        AAAVACCE
       >>define AA-A-DB2-TRACE as b'0'                                  AAAVACCE
       >>define AA-A-ECRITURES as b'0'                                  AAAVACCE
       >>define AA-A-EDITIONS as b'0'                                   AAAVACCE
       >>define AA-A-EDITIONS-AUTO as b'0'                              AAAVACCE
       >>define AA-A-LECTURES as b'0'                                   AAAVACCE
       >>define AA-A-LECTURES-AVEC-RUPT as b'0'                         AAAVACCE
       >>define AA-A-LECTURES-AVEC-SYNC as b'0'                         AAAVACCE
       >>define AA-A-LECTURES-SANS-RUPT as b'0'                         AAAVACCE
       >>define AA-A-MAJ as b'0'                                        AAAVACCE
       >>define AA-A-MAXNR as 0                                         AAAVACCE
       >>define AA-A-MAXNS as 0                                         AAAVACCE
       >>define AA-A-VSAM as b'0'                                       AAAVACCE
