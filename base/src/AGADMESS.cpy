      *CONTROL NOSOURCE                                                 AGADMESS
      *>****************************************************************AGADMESS
      *> Recherche libellés et aide.                                    AGADMESS
      *> Déclaration de la zone de communications avec le module xxMESS AGADMESS
      *> - A8ZDMESS : module batch S8MESS                               AGADMESS
      *> - A9ZDMESS : module CICS S9MESS                                AGADMESS
      *>----------------------------------------------------------------AGADMESS
      *> Les modules xxMESS permettent d'accéder aux libellés d'erreurs AGADMESS
      *> automatiques et à la documentation générés par Pacbase, ainsi  AGADMESS
      *> qu'aux libellés et à la documentation explicites gérés dans    AGADMESS
      *> les entités $GM de Pacbase.                                    AGADMESS
      *> Dans le cadre de la migration Pacbase, ces fonctionnalités     AGADMESS
      *> sont maintenues pour les développements COBOL natif.           AGADMESS
      *>                                                                AGADMESS
      *> Il est nécessaire de fournir une clé de 17 caractèrs pour      AGADMESS
      *> accéder aux informations, décomposée en :                      AGADMESS
      *> - code Application, X(3) : code Bibliothèque Pacbase           AGADMESS
      *> - type de Message, X(1) : normalisé                            AGADMESS
      *>   - 'A' : info automatique entité S (Segment)                  AGADMESS
      *>   - 'H' : info automatique entité O (Ecran)                    AGADMESS
      *>   - 'I' : info automatique entité O (Ecran) - Index            AGADMESS
      *>   - 'E' : info explicite entité $GM pour Prise Supra TP        AGADMESS
      *>   - 'F' : info explicite entité $GM pour Prise Supra Batch     AGADMESS
      *>   - 'H' : info explicite entite $GM pour Ecran                 AGADMESS
      *>   - 'P' : info explicite entité $GM pour Programme TP          AGADMESS
      *>   - 'Q' : info explicite entité $GM pour Programme Batch       AGADMESS
      *> - code Entité, X(6) : code Segment, code Ecran                 AGADMESS
      *> - code Erreur, X(3) : libre                                    AGADMESS
      *> - type d'Erreur, X(1) : normalisé                              AGADMESS
      *>   - 'I', 'W', ' ' , '0' à '4' : information                    AGADMESS
      *>   - autre : erreur                                             AGADMESS
      *> - numéro de ligne, X(3) : '000' pour un libellé                AGADMESS
      *>                                                                AGADMESS
      *> Les éléments automatiques sont stockés en fichier VSAM KSDS,   AGADMESS
      *> ddname PBPBEM.                                                 AGADMESS
      *> Les éléments explicites sont stockés dans les tables Db2 SA01  AGADMESS
      *> (libellés) et SA04 (documentation).                            AGADMESS
      *>                                                                AGADMESS
      *> Les libellés explicites peuvent gérés jusqu'à 9 paramètres $1, AGADMESS
      *> à $9. Les valeurs de ces paramètres doivent être transmises    AGADMESS
      *> par la zone WLE80 lors de l'appel.                             AGADMESS
      *>                                                                AGADMESS
      *> Voir TMR 02 0093.                                              AGADMESS
      *>----------------------------------------------------------------AGADMESS
      *> Paramètres REPLACING facultatifs :                             AGADMESS
      *> - leading ==MESS== : préfixe des zones de communication        AGADMESS
      *>****************************************************************AGADMESS
      *CONTROL SOURCE                                                   AGADMESS
       >>evaluate true                                                  AGADMESS
         >>when AA-G-BATCH                                              AGADMESS
           copy A8ZDMESS.                                               AGADMESS
         >>when AA-G-CICS                                               AGADMESS
           copy A9ZDMESS.                                               AGADMESS
         >>when other                                                   AGADMESS
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AGADMESS
      *>>> Le service d'accès messages n'est disponible qu'en BATCH <<< AGADMESS
      *>>> et en CICS. Contacter le support.                        <<< AGADMESS
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AGADMESS
       >>end-evaluate                                                   AGADMESS
