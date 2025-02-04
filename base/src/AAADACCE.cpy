      *CONTROL NOSOURCE                                                 AAADACCE
      *>****************************************************************AAADACCE
      *> Accès ressource externe.                                       AAADACCE
      *> Déclaration des variables de gestion de la ressource.          AAADACCE
      *> Cette COPY doit être appelée en Working-Storage Section pour   AAADACCE
      *> chaque accès à une ressource externe.                          AAADACCE
      *>----------------------------------------------------------------AAADACCE
      *> Paramètres REPLACING obligatoires :                            AAADACCE
      *> - :DD: : code logigue ressource, 2 caractères                  AAADACCE
      *> Paramètres facultatifs (selon contexte) :                      AAADACCE
      *> - :K<n>: : variable(s) clé(s) de rupture / synchro au rang n   AAADACCE
      *> - :P<n>: : picture(s) clé(s) de rupture / synchro au rang n    AAADACCE
      *>----------------------------------------------------------------AAADACCE
      *> Variables de compilation locales :                             AAADACCE
      *> - AA-A-ACCES : type d'accès, obligatoire                       AAADACCE
      *>   - 'L' : Lecture (défaut)                                     AAADACCE
      *>   - 'E' : Ecriture (un seul type d'écriture)                   AAADACCE
      *>   - 'M' : Modification (tous types d'écriture sans lecture)    AAADACCE
      *>   - 'X' : Lecture (L) et Modification (M)                      AAADACCE
      *>   - 'T' : Chargement en table mémoire                          AAADACCE
      *>   - 'I' : Impression (Edition)                                 AAAPACCE
      *>   - 'U' : Géré par l'Utilisateur                               AAADACCE
      *> - AA-A-MODE : mode d'accès, facultatif                         AAADACCE
      *>   - 'S' : Séquentiel (défaut)                                  AAADACCE
      *>   - 'R' : Direct                                               AAADACCE
      *>   - 'D' : Dynamique (réservé aux fichiers VSAM)                AAADACCE
      *> - AA-A-ORG : type d'organisation, facultatif                   AAADACCE
      *>   - 'F' : Fichier Séquentiel (défaut)                          AAADACCE
      *>   - 'K' : Fichier VSAM Indexé (KSDS)                           AAADACCE
      *>   - 'R' : Fichier VSAM Random (RRDS)                           AAADACCE
      *>   - 'E' : Fichier VSAM Entry  (ESDS)                           AAADACCE
      *>   - '2' : Accès Db2                                            AAADACCE
      *>   - 'I' : Document formaté (Mode Séquentiel)                   AAADACCE
      *>   - 'X' : Document XML (Mode Séquentiel)                       AAADACCE
      *>   - 'J' : Document JSON (Mode Séquentiel)                      AAADACCE
      *>   - 'P' : Procédure interne (Impressions)                      AAADACCE
      *>   - 'S' : Spooleur externe (Impressions)                       AAADACCE
      *> - AA-A-NR : niveau de Rupture, facultatif                      AAADACCE
      *>   - 0 : pas de Rupture (défaut)                                AAADACCE
      *>   - 1 à 9 : nombre de niveaux de Rupture                       AAADACCE
      *>   - < 0 : hors itération                                       AAADACCE
      *> - AA-A-NS : niveau de Synchronisation                          AAADACCE
      *>   - 0 : pas de Synchronisation                                 AAADACCE
      *>   - 1 à 9 : nombre de niveaux de Synchronisation               AAADACCE
      *>----------------------------------------------------------------AAADACCE
      *> Variables de compilations globales impactées :                 AAADACCE
      *> - AA-A-MAXNR : niveau maximum de Ruptures                      AAADACCE
      *> - AA-A-MAXNS : niveau maximum de Synchronisation               AAADACCE
      *> - AA-A-LECTURES-SANS-RUPT : traitement lectures sans Rupture   AAADACCE
      *> - AA-A-LECTURES-AVEC-RUPT : traitement lectures avec Ruptures  AAADACCE
      *> - AA-A-ECRITURES : traitement écritures                        AAADACCE
      *> - AA-A-DB2 : présence d'accès DB2                              AAADACCE
      *> - AA-A-VSAM : présence de fichiers VSAM                        AAADACCE
      *>****************************************************************AAADACCE
      *> --- Valeurs par défaut des variables conditionnelles           AAADACCE
       >>if AA-A-ACCES is not defined                                   AAADACCE
         >>define AA-A-ACCES as 'L'                                     AAADACCE
       >>end-if                                                         AAADACCE
       >>if AA-A-MODE is not defined                                    AAADACCE
         >>define AA-A-MODE as 'S'                                      AAADACCE
       >>end-if                                                         AAADACCE
       >>if AA-A-ORG is not defined                                     AAADACCE
         >>define AA-A-ORG as 'F'                                       AAADACCE
       >>end-if                                                         AAADACCE
       >>if AA-A-NR is not defined                                      AAADACCE
         >>define AA-A-NR as 0                                          AAADACCE
       >>end-if                                                         AAADACCE
       >>if AA-A-NS is not defined                                      AAADACCE
         >>define AA-A-NS as 0                                          AAADACCE
       >>end-if                                                         AAADACCE
      *CONTROL SOURCE                                                   AAADACCE
      *> --- Validation du contexte                                     AAADACCE
       >>if AA-A-NR < 0 and AA-A-NS > 0                                 AAADACCE
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAADACCE
      *>>> Un niveau de Synchronisation > 0 implique de participer  <<< AAADACCE
      *>>> à l'itération principale.                                <<< AAADACCE
      *>>> Si AA-A-NS > 0 alors AA-A-NR >= 0.                       <<< AAADACCE
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAADACCE
       >>end-if                                                         AAADACCE
       >>if AA-A-ORG = '2'                                              AAADACCE
           copy AAA00020.                                               AAADACCE
       >>end-if                                                         AAADACCE
       >>if AA-A-ORG = 'K' or AA-A-ORG = 'R' or AA-A-ORG = 'E'          AAADACCE
           copy AAA000V0.                                               AAADACCE
       >>end-if                                                         AAADACCE
       >>if AA-A-ACCES not = 'I' or AA-A-MODE not = 'E'                 AAADACCE
      *> Compteur d'accès                                               AAADACCE
       01               5-:DD:00-CPTENR PIC  S9(9) BINARY VALUE 0.      AAADACCE
       >>end-if                                                         AAADACCE
       >>evaluate AA-A-ACCES                                            AAADACCE
         >>when 'L'   *> Lecture seule                                  AAADACCE
           copy AAA0L000.                                               AAADACCE
         >>when 'E'   *> Ecriture seule                                 AAADACCE
           copy AAA0E000.                                               AAADACCE
         >>when 'M'   *> Modification seule                             AAADACCE
           copy AAA0M000.                                               AAADACCE
         >>when 'X'   *> Lecture et Modification                        AAADACCE
           copy AAA0X000.                                               AAADACCE
         >>when 'T'   *> Chargement en table mémoire                    AAADACCE
           copy AAA0T000.                                               AAADACCE
         >>when 'I'   *> Editions                                       AAADACCE
           copy AAA0I000.                                               AAADACCE
         >>when 'U'   *> Géré par l'Utilisateur                         AAADACCE
           copy AAA0U000.                                               AAADACCE
         >>when other                                                   AAADACCE
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAADACCE
      *>>> La variable 'AA-A-ACCES' doit être valorisée à :         <<< AAADACCE
      *>>> - 'L' : lecture                                          <<< AAADACCE
      *>>> - 'E' : écriture                                         <<< AAADACCE
      *>>> - 'M' : mise à jour                                      <<< AAADACCE
      *>>> - 'X' : lecture et mise à jour                           <<< AAADACCE
      *>>> - 'T' : chargement en table mémoire                      <<< AAADACCE
      *>>> - 'I' : Impression (Edition)                             <<< AAADACCE
      *>>> - 'U' : géré en code spécifique                          <<< AAADACCE
      *>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERREUR <<<<<<<<<<<<<<<<<<<<<<<<<<<< AAADACCE
       >>end-evaluate                                                   AAADACCE
      *CONTROL NOSOURCE                                                 AAADACCE
      *> --- Effacement des variables conditionnelles locales           AAADACCE
       >>define AA-A-ACCES off                                          AAADACCE
       >>define AA-A-MODE  off                                          AAADACCE
       >>define AA-A-ORG   off                                          AAADACCE
       >>define AA-A-NR    off                                          AAADACCE
       >>define AA-A-NS    off                                          AAADACCE
      *CONTROL SOURCE                                                   AAADACCE
