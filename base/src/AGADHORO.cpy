      *CONTROL NOSOURCE                                                 AGADHORO
      *>****************************************************************AGADHORO
      *> Horodatage des programmes.                                     AGADHORO
      *> Ce copybook reproduit les constantes de génération Pacbase     AGADHORO
      *> qui sont utilisées dans certaines fonctions du framework et    AGADHORO
      *> par des outillages historiques.                                AGADHORO
      *> Chaque programme COBOL doit appeler ce copybook avec une       AGADHORO
      *> clause replacing pour la majorité des variables présentes.     AGADHORO
      *> L'Assistant COBOL MoMa maintient automatiquement certaines     AGADHORO
      *> valeurs au moment de la sauvegarde du fichier sur disque.      AGADHORO
      *>----------------------------------------------------------------AGADHORO
      *> NUGNA  : à valoriser avec les 5 derniers caractères du Code    AGADHORO
      *>          Changement.                                           AGADHORO
      *> APPLI  : à valoriser soit avec l'ancien code Bibliothèque      AGADHORO
      *>          Pacbase pour les programmes migrés, soit avec les 3   AGADHORO
      *>          derniers caractères du code CIA du Bloc Applicatif    AGADHORO
      *>          pour les nouveaux programmes COBOL natif.             AGADHORO
      *>          Important : cette information est utilisée par le     AGADHORO
      *>          framework en particulier pour accéder aux libellés    AGADHORO
      *>          d'erreur et à l'aide en ligne.                        AGADHORO
      *> DATGN  : date de modification au format JJ/MM/AA.              AGADHORO
      *> PROGR  : nom interne du programme, limité à 6 caractères.      AGADHORO
      *> CODUTI : code utilisateur ayant modifié le programme en        AGADHORO
      *>          dernier.                                              AGADHORO
      *> TIMGN  : heure de modification au format HH:MM:SS.             AGADHORO
      *> PROGE  : nom externe du programme, égal au PROGRAM-ID.         AGADHORO
      *> COBASE : 3 derniers caractères du code CIA Application.        AGADHORO
      *> DATGNC : date de modification au format JJ/MM/AAAA.            AGADHORO
      *> RELEAS : identifiant du squelette programme.                   AGADHORO
      *> DATGE  : version du squelette programme.                       AGADHORO
      *> DATSQ  : date du mise à jour du squelette programme.           AGADHORO
      *>****************************************************************AGADHORO
      *CONTROL SOURCE                                                   AGADHORO
       01               CONSTANTES-PAC VOLATILE.                        AGADHORO
           05           PAC-CONSTANTES.                                 AGADHORO
             10         NUGNA         PIC X(5)  VALUE 'NUGNA'.          AGADHORO
             10         APPLI         PIC X(3)  VALUE 'APPLI'.          AGADHORO
             10         DATGN         PIC X(8)  VALUE 'DATGN'.          AGADHORO
             10         PROGR         PIC X(6)  VALUE 'PROGR'.          AGADHORO
             10         CODUTI        PIC X(8)  VALUE 'CODUTI'.         AGADHORO
             10         TIMGN         PIC X(8)  VALUE 'TIMGN'.          AGADHORO
             10         PROGE         PIC X(8)  VALUE 'PROGE'.          AGADHORO
             10         COBASE        PIC X(4)  VALUE 'COBASE'.         AGADHORO
             10         DATGNC        PIC X(10) VALUE 'DATGNC'.         AGADHORO
             10         RELEAS        PIC X(7)  VALUE 'RELEAS'.         AGADHORO
             10         DATGE         PIC X(10) VALUE 'DATGE'.          AGADHORO
             10         DATSQ         PIC X(10) VALUE 'DATSQ'.          AGADHORO
