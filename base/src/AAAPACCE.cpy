      *CONTROL NOSOURCE                                                 AAAPACCE
      *>****************************************************************AAAPACCE
      *> Accès ressource externe.                                       AAAPACCE
      *> Déclaration des accès à la ressource.                          AAAPACCE
      *> Cette COPY doit être appelée en Procedure Division pour chaque AAAPACCE
      *> accès à une ressource externe.                                 AAAPACCE
      *> Les accès sont des Sections à appeler par PERFORM depuis le    AAAPACCE
      *> corps du programme.                                            AAAPACCE
      *> L'emplacement normal pour appeler cette COPY est en fin de     AAAPACCE
      *> programme, dans une section "ACCES SECTION".                   AAAPACCE
      *>                                                                AAAPACCE
      *> Pour écrire dans un fichier multi-enregistrements, ajouter une AAAPACCE
      *> clause replacing comme :                                       AAAPACCE
      *>   COPY AAAPACCE REPLACING ...                                  AAAPACCE
      *>        ==write :PREF:== by                                     AAAPACCE
      *>        ==evaluate pref-code-structure                          AAAPACCE
      *>            when 'r1'                                           AAAPACCE
      *>              write dd01                                        AAAPACCE
      *>            when 'r2'                                           AAAPACCE
      *>              write dd02                                        AAAPACCE
      *>            ...                                                 AAAPACCE
      *>          end-evalate==                                         AAAPACCE
      *>        ... autres paramètres ...                               AAAPACCE
      *>        .                                                       AAAPACCE
      *> Si le fichier ne dispose pas d'un code structure, il faut      AAAPACCE
      *> déclarer un enregistrement banalisé constitué d'un             AAAPACCE
      *>   PIC X OCCURS <n> DEPENDING ON <length>                       AAAPACCE
      *> et l'utiliser pour l'écriture :                                AAAPACCE
      *>   COPY AAAPACCE REPLACING ...                                  AAAPACCE
      *>        ==write :PREF:== by                                     AAAPACCE
      *>        ==write dd-ENREG-VAR==                                  AAAPACCE
      *>        ... autres paramètres ...                               AAAPACCE
      *>        .                                                       AAAPACCE
      *>                                                                AAAPACCE
      *> Pour lire un fichier multi-enregistrements, avec gestion de    AAAPACCE
      *> ruptures, ajouter une clause replacing comme :                 AAAPACCE
      *> clause replacing comme :                                       AAAPACCE
      *>   COPY AAAPACCE REPLACING ...                                  AAAPACCE
      *>        ==move :PREF: to 1-:PREF:== by                          AAAPACCE
      *>        ==evaluate pref-code-structure                          AAAPACCE
      *>            when 'r1'                                           AAAPACCE
      *>              move dd01 to 1-dd01                               AAAPACCE
      *>            when 'r2'                                           AAAPACCE
      *>              move dd02 to 1-dd02                               AAAPACCE
      *>            ...                                                 AAAPACCE
      *>          end-evalate==                                         AAAPACCE
      *>        ... autres paramètres ...                               AAAPACCE
      *>        .                                                       AAAPACCE
      *> Si le fichier ne dispose pas d'un code structure, il faut      AAAPACCE
      *> déclarer un enregistrement banalisé constitué d'un             AAAPACCE
      *>   PIC X OCCURS AAAPACCE <n> DEPENDING ON <length>              AAAPACCE
      *> et l'utiliser pour le move entre la zone enregistrement lu et  AAAPACCE
      *> la zone de travail "1-" :                                      AAAPACCE
      *>   COPY AAAPACCE REPLACING ...                                  AAAPACCE
      *>        ==move :PREF: to 1-:PREF:== by                          AAAPACCE
      *>        ==move dd-ENREG-VAR to 1-:PREF:==                       AAAPACCE
      *>        ... autres paramètres ...                               AAAPACCE
      *>        .                                                       AAAPACCE
      *>----------------------------------------------------------------AAAPACCE
      *> Paramètres obligatoires :                                      AAAPACCE
      *> - :DD: : code logigue ressource                                AAAPACCE
      *> - :PREF: : prefixe zones et nom niveau 01 principal            AAAPACCE
      *> Paramètres facultatifs (selon contexte) :                      AAAPACCE
      *> - :NS: : niveau de synchronisation                             AAAPACCE
      *> - :K<n>: : variable(s) clé(s) de rupture / synchro au rang n   AAAPACCE
      *> - :KEYPOS: : expression de positionnement pour Fichiers VSAM   AAAPACCE
      *>   en accès Direct ou Dynamique                                 AAAPACCE
      *>----------------------------------------------------------------AAAPACCE
      *> Variables de compilation :                                     AAAPACCE
      *> - AA-A-ACCES : type d'accès                                    AAAPACCE
      *>   - 'L' : Lecture (défaut)                                     AAAPACCE
      *>   - 'E' : Ecriture (un seul type d'écriture)                   AAAPACCE
      *>   - 'M' : Modification (tous types d'écriture sans lecture)    AAAPACCE
      *>   - 'X' : Lecture (L) et Modification (M)                      AAAPACCE
      *>   - 'T' : Chargement en table mémoire                          AAAPACCE
      *>   - 'I' : Impression (Edition)                                 AAAPACCE
      *>   - 'U' : Géré par l'Utilisateur                               AAAPACCE
      *> - AA-A-MODE : AA-A-MODE d'accès                                AAAPACCE
      *>   - 'S' : Séquentiel (défaut)                                  AAAPACCE
      *>   - 'R' : Direct                                               AAAPACCE
      *>   - 'D' : Dynamique (réservé au fichiers VSAM)                 AAAPACCE
      *> - AA-A-ORG : type d'organisation                               AAAPACCE
      *>   - 'F' : Fichier Séquentiel (défaut)                          AAAPACCE
      *>   - 'K' : Fichier VSAM Indexé (KSDS)                           AAAPACCE
      *>   - 'R' : Fichier VSAM Random (RRDS)                           AAAPACCE
      *>   - 'E' : Fichier VSAM Entry  (ESDS)                           AAAPACCE
      *>   - '2' : Accès Db2                                            AAAPACCE
      *>   - 'I' : Document formaté (Mode Séquentiel)                   AAAPACCE
      *>   - 'X' : Document XML (Mode Séquentiel)                       AAAPACCE
      *>   - 'J' : Document JSON (Mode Séquentiel)                      AAAPACCE
      *>   - 'P' : Procédure interne (Impressions)                      AAAPACCE
      *>   - 'S' : Spooleur externe (Impressions)                       AAAPACCE
      *> - AA-A-NR : niveau de rupture, entier, 0 à 9, < 0 hors iter    AAAPACCE
      *> - AA-A-NS : niveau de synchronisation, entier, 0 à 9           AAAPACCE
      *>****************************************************************AAAPACCE
      *> --- Valeurs par défaut des variables conditionnelles           AAAPACCE
       >>if AA-A-ACCES is not defined                                   AAAPACCE
         >>define AA-A-ACCES as 'L'                                     AAAPACCE
       >>end-if                                                         AAAPACCE
       >>if AA-A-MODE is not defined                                    AAAPACCE
         >>define AA-A-MODE as 'S'                                      AAAPACCE
       >>end-if                                                         AAAPACCE
       >>if AA-A-ORG is not defined                                     AAAPACCE
         >>define AA-A-ORG as 'F'                                       AAAPACCE
       >>end-if                                                         AAAPACCE
       >>if AA-A-NR is not defined                                      AAAPACCE
         >>define AA-A-NR as 0                                          AAAPACCE
       >>end-if                                                         AAAPACCE
       >>if AA-A-NS is not defined                                      AAAPACCE
         >>define AA-A-NS as 0                                          AAAPACCE
       >>end-if                                                         AAAPACCE
      *CONTROL SOURCE                                                   AAAPACCE
       >>evaluate AA-A-ACCES                                            AAAPACCE
         >>when 'L'   *> Lecture seule                                  AAAPACCE
           copy AAA5L000.                                               AAAPACCE
         >>when 'E'   *> Ecriture seule                                 AAAPACCE
           copy AAA5E000.                                               AAAPACCE
         >>when 'M'   *> Création Modification Suppression              AAAPACCE
           copy AAA5M000.                                               AAAPACCE
         >>when 'X'   *> Lecture Création Modification Suppression      AAAPACCE
           copy AAA5X000.                                               AAAPACCE
         >>when 'T'   *> Chargement en table mémoire                    AAAPACCE
           copy AAA5T000.                                               AAAPACCE
         >>when 'I'   *> Editions                                       AAAPACCE
           copy AAA5I000.                                               AAAPACCE
         >>when 'U'   *> Géré par l'Utilisateur                         AAAPACCE
           copy AAA5U000.                                               AAAPACCE
         >>when other                                                   AAAPACCE
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAAPACCE
      *>>> La variable 'AA-A-ACCES' doit être valorisée à :         <<< AAAPACCE
      *>>> - 'L' : lecture                                          <<< AAAPACCE
      *>>> - 'E' : écriture                                         <<< AAAPACCE
      *>>> - 'M' : mise à jour                                      <<< AAAPACCE
      *>>> - 'X' : lecture et mise à jour                           <<< AAAPACCE
      *>>> - 'T' : chargement en table mémoire                      <<< AAAPACCE
      *>>> - 'I' : Impression (Edition)                             <<< AAADACCE
      *>>> - 'U' : géré en code spécifique                          <<< AAAPACCE
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAAPACCE
       >>end-evaluate                                                   AAAPACCE
      *CONTROL NOSOURCE                                                 AAAPACCE
      *> --- Effacement des variables conditionnelles locales           AAAPACCE
       >>define AA-A-ACCES off                                          AAAPACCE
       >>define AA-A-MODE  off                                          AAAPACCE
       >>define AA-A-ORG   off                                          AAAPACCE
       >>define AA-A-NR    off                                          AAAPACCE
       >>define AA-A-NS    off                                          AAAPACCE
      *CONTROL SOURCE                                                   AAAPACCE
