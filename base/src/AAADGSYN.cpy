      *CONTROL NOSOURCE                                                 AAADGSYN
      *>****************************************************************AAADGSYN
      *> Gestion des Configurations au niveau global                    AAADGSYN
      *>----------------------------------------------------------------AAADGSYN
      *> Conditions d'utilisation :                                     AAADGSYN
      *> L'ensemble des ressources avec synchronisation doivent avoir   AAADGSYN
      *> été déclarées au moyen du COPYBOOK "AAADACCE" avant appel au   AAADGSYN
      *> COPYBOOK "AAADGSYN".                                           AAADGSYN
      *>----------------------------------------------------------------AAADGSYN
      *> Paramètres obligatoires :                                      AAADGSYN
      *> - Néant                                                        AAADGSYN
      *> Paramètres facultatifs (selon contexte) :                      AAADGSYN
      *> - Pn : PICture clé rang n, n de 1 à 9                          AAADGSYN
      *> Variables de compilation :                                     AAADGSYN
      *> - AA-A-MAXNS : calculée, niveau de synchro maximum toutes      AAADGSYN
      *>   ressources                                                   AAADGSYN
      *>****************************************************************AAADGSYN
      *CONTROL SOURCE                                                   AAADGSYN
       >>if AA-A-MAXNS > 0                                              AAADGSYN
      *>                                                                AAADGSYN
      *> Clés de Synchronisation                                        AAADGSYN
       01               IND.                                            AAADGSYN
           05           IND1.                                           AAADGSYN
               10                     PIC :P1:.                         AAADGSYN
       >>if AA-A-MAXNS > 1                                              AAADGSYN
           05           IND2.                                           AAADGSYN
               10                     PIC :P2:.                         AAADGSYN
         >>if AA-A-MAXNS > 2                                            AAADGSYN
           05           IND3.                                           AAADGSYN
               10                     PIC :P3:.                         AAADGSYN
           >>if AA-A-MAXNS > 3                                          AAADGSYN
           05           IND4.                                           AAADGSYN
               10                     PIC :P4:.                         AAADGSYN
             >>if AA-A-MAXNS > 4                                        AAADGSYN
           05           IND5.                                           AAADGSYN
               10                     PIC :P5:.                         AAADGSYN
               >>if AA-A-MAXNS > 5                                      AAADGSYN
           05           IND6.                                           AAADGSYN
               10                     PIC :P6:.                         AAADGSYN
                 >>if AA-A-MAXNS > 6                                    AAADGSYN
           05           IND7.                                           AAADGSYN
               10                     PIC :P7:.                         AAADGSYN
                   >>if AA-A-MAXNS > 7                                  AAADGSYN
           05           IND8.                                           AAADGSYN
               10                     PIC :P8:.                         AAADGSYN
                     >>if AA-A-MAXNS > 8                                AAADGSYN
           05           IND9.                                           AAADGSYN
               10                     PIC :P9:.                         AAADGSYN
                     >>end-if                                           AAADGSYN
                   >>end-if                                             AAADGSYN
                 >>end-if                                               AAADGSYN
               >>end-if                                                 AAADGSYN
             >>end-if                                                   AAADGSYN
           >>end-if                                                     AAADGSYN
         >>end-if                                                       AAADGSYN
       >>end-if                                                         AAADGSYN
       66               TIND1 RENAMES IND1.                             AAADGSYN
       >>if AA-A-MAXNS > 1                                              AAADGSYN
       66               TIND2 RENAMES IND1 THRU IND2.                   AAADGSYN
         >>if AA-A-MAXNS > 2                                            AAADGSYN
       66               TIND3 RENAMES IND1 THRU IND3.                   AAADGSYN
           >>if AA-A-MAXNS > 3                                          AAADGSYN
       66               TIND4 RENAMES IND1 THRU IND4.                   AAADGSYN
             >>if AA-A-MAXNS > 4                                        AAADGSYN
       66               TIND5 RENAMES IND1 THRU IND5.                   AAADGSYN
               >>if AA-A-MAXNS > 5                                      AAADGSYN
       66               TIND6 RENAMES IND1 THRU IND6.                   AAADGSYN
                 >>if AA-A-MAXNS > 6                                    AAADGSYN
       66               TIND7 RENAMES IND1 THRU IND7.                   AAADGSYN
                   >>if AA-A-MAXNS > 7                                  AAADGSYN
       66               TIND8 RENAMES IND1 THRU IND8.                   AAADGSYN
                     >>if AA-A-MAXNS > 8                                AAADGSYN
       66               TIND9 RENAMES IND1 THRU IND9.                   AAADGSYN
                     >>end-if                                           AAADGSYN
                   >>end-if                                             AAADGSYN
                 >>end-if                                               AAADGSYN
               >>end-if                                                 AAADGSYN
             >>end-if                                                   AAADGSYN
           >>end-if                                                     AAADGSYN
         >>end-if                                                       AAADGSYN
       >>end-if                                                         AAADGSYN
      *>                                                                AAADGSYN
      *> Niveau de Configuration maximum de l'itération courante        AAADGSYN
       01               MAX-CF        PIC 9(4) COMP-5.                  AAADGSYN
       >>end-if                                                         AAADGSYN
