/**********************************************************/
/* DECVAR - Copybook de déclarations communes             */
/* Equivalent du COPY en COBOL                            */
/**********************************************************/

/* Déclarations de structures de données */
   DCL 1 EMPLOYE,
      2 NUM_EMP    CHAR(6),
      2 NOM        CHAR(30),
      2 PRENOM     CHAR(20),
      2 SALAIRE    FIXED DEC(9,2),
      2 DATE_EMB   CHAR(10);

/* Déclarations de constantes */
   DCL TAUX_TVA     FIXED DEC(5,2) INIT(20.00);
   DCL MAX_RECORDS  FIXED BIN(31) INIT(10000);
   DCL SOCIETE      CHAR(40) INIT('MA SOCIETE S.A.');

/* Codes retour standards */
   DCL RC_OK        FIXED BIN(15) INIT(0);
   DCL RC_WARNING   FIXED BIN(15) INIT(4);
   DCL RC_ERROR     FIXED BIN(15) INIT(8);
   DCL RC_SEVERE    FIXED BIN(15) INIT(12);

/* Variables de travail communes */
   DCL WS_COMPTEUR  FIXED BIN(31) INIT(0);
   DCL WS_CODE_RET  FIXED BIN(15) INIT(0);
   DCL WS_MESSAGE   CHAR(80) INIT(' ');