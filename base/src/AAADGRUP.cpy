      *CONTROL NOSOURCE                                                 AAADGRUP
      *>****************************************************************AAADGRUP
      *> Gestion des ruptures au niveau global                          AAADGRUP
      *>----------------------------------------------------------------AAADGRUP
      *> Conditions d'utilisation :                                     AAADGRUP
      *> L'ensemble des ressources avec ruptures doivent avoir été      AAADGRUP
      *> déclarées au moyen du COPYBOOK "AAADACCE" avant appel au       AAADGRUP
      *> COPYBOOK "AAADGRUP".                                           AAADGRUP
      *>----------------------------------------------------------------AAADGRUP
      *> Paramètres obligatoires :                                      AAADGRUP
      *> - Néant                                                        AAADGRUP
      *> Paramètres facultatifs (selon contexte) :                      AAADGRUP
      *> - Néant                                                        AAADGRUP
      *> Variables de compilation :                                     AAADGRUP
      *> - AA-A-MAXNR : calculée, niveau de rupture maximum toutes      AAADGRUP
      *>   ressources                                                   AAADGRUP
      *>****************************************************************AAADGRUP
      *CONTROL SOURCE                                                   AAADGRUP
       >>if AA-A-MAXNR > 0                                              AAADGRUP
      *>                                                                AAADGRUP
      *> Niveau Rupture Première                                        AAADGRUP
       01               NRP           PIC 9 VALUE 0.                    AAADGRUP
      *> Ruptures Totales Premières                                     AAADGRUP
       01               RTP.                                            AAADGRUP
           05           RTP1          PIC X VALUE '1'.                  AAADGRUP
       >>if AA-A-MAXNR > 1                                              AAADGRUP
           05           RTP2          PIC X VALUE '1'.                  AAADGRUP
         >>if AA-A-MAXNR > 2                                            AAADGRUP
           05           RTP3          PIC X VALUE '1'.                  AAADGRUP
           >>if AA-A-MAXNR > 3                                          AAADGRUP
           05           RTP4          PIC X VALUE '1'.                  AAADGRUP
             >>if AA-A-MAXNR > 4                                        AAADGRUP
           05           RTP5          PIC X VALUE '1'.                  AAADGRUP
               >>if AA-A-MAXNR > 5                                      AAADGRUP
           05           RTP6          PIC X VALUE '1'.                  AAADGRUP
                 >>if AA-A-MAXNR > 6                                    AAADGRUP
           05           RTP7          PIC X VALUE '1'.                  AAADGRUP
                   >>if AA-A-MAXNR > 7                                  AAADGRUP
           05           RTP8          PIC X VALUE '1'.                  AAADGRUP
                     >>if AA-A-MAXNR > 8                                AAADGRUP
           05           RTP9          PIC X VALUE '1'.                  AAADGRUP
                     >>end-if                                           AAADGRUP
                   >>end-if                                             AAADGRUP
                 >>end-if                                               AAADGRUP
               >>end-if                                                 AAADGRUP
             >>end-if                                                   AAADGRUP
           >>end-if                                                     AAADGRUP
         >>end-if                                                       AAADGRUP
       >>end-if                                                         AAADGRUP
      *> Niveau Rupture Dernière                                        AAADGRUP
       01               NRD           PIC 9 VALUE 1.                    AAADGRUP
      *> Ruptures Totales Dernières                                     AAADGRUP
       01               RTD.                                            AAADGRUP
           05           RTD1          PIC X VALUE '1'.                  AAADGRUP
       >>if AA-A-MAXNR > 1                                              AAADGRUP
           05           RTD2          PIC X VALUE '1'.                  AAADGRUP
         >>if AA-A-MAXNR > 2                                            AAADGRUP
           05           RTD3          PIC X VALUE '1'.                  AAADGRUP
           >>if AA-A-MAXNR > 3                                          AAADGRUP
           05           RTD4          PIC X VALUE '1'.                  AAADGRUP
             >>if AA-A-MAXNR > 4                                        AAADGRUP
           05           RTD5          PIC X VALUE '1'.                  AAADGRUP
               >>if AA-A-MAXNR > 5                                      AAADGRUP
           05           RTD6          PIC X VALUE '1'.                  AAADGRUP
                 >>if AA-A-MAXNR > 6                                    AAADGRUP
           05           RTD7          PIC X VALUE '1'.                  AAADGRUP
                   >>if AA-A-MAXNR > 7                                  AAADGRUP
           05           RTD8          PIC X VALUE '1'.                  AAADGRUP
                     >>if AA-A-MAXNR > 8                                AAADGRUP
           05           RTD9          PIC X VALUE '1'.                  AAADGRUP
                     >>end-if                                           AAADGRUP
                   >>end-if                                             AAADGRUP
                 >>end-if                                               AAADGRUP
               >>end-if                                                 AAADGRUP
             >>end-if                                                   AAADGRUP
           >>end-if                                                     AAADGRUP
         >>end-if                                                       AAADGRUP
       >>end-if                                                         AAADGRUP
      *> Zones de travail                                               AAADGRUP
       01               NRD2          PIC 9(4) COMP-5.                  AAADGRUP
       01               IRTD          PIC 9(4) COMP-5.                  AAADGRUP
       >>end-if                                                         AAADGRUP
