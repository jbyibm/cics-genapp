      * CBL SERVICE('CEH60 P38059 2024-06-12 19:18:52 J070515')
sqi    IDENTIFICATION DIVISION.
sqi    PROGRAM-ID. M5ES01.
      *> ***************************************************************
#code *> Programme : M5ES01
#name *> Intitulé  : Contrôle comptage par contrat SYNCHRO
#kwrd *> Mots clés : NPE FORBEARANCE 017431
#git  *> Workspace : ceac4-forbenpe-risques-central
      *> ---------------------------------------------------------------
      *>
      *> <fonction du programme>

      *>    Etape de contrôle de l'integrité du flux reçu de SYNCHRO
      *>    et production d'un fichier des contrats en anomalie.
      *>    Pour chacun de ces contrats en anomalie, on ecrit dans le
      *>    fichier anomalie I79X.
      *>
      *>
sqihm *> ---------------------------------------------------------------
sqihm *> Historique des modifications :
sqihm *>
sqihm *> Date        User      Motif
sqihm *> ----------  --------  -----------------------------------------
      *> 2024-06-06  J070515   Création du programme!
      *>>>>>   remplacement I52X par H501
      *>   I52X        H501
      *>   ------      --------
      *>   CDM5IN      COFAFB
      *>   CTM5TT      CTFAFB
      *>   COCXBQ      COCXBQ
      *>   IDMCCT      IDCT
      *>   DTF9EF      DTEF
      *>   DTM5CM      DTFAFB
      *>   CDFAOR      CDFAOR
      *>>>>>   remplacement I52A par H501
      *>   I52A                                      H501
      *>--------------------------------------------------------------
      *>    ZGRP01 ----- Partie commune              H51C
      *>    CDM5IN Code type information             COFAFB
      *>    CTM5TT Code aiguillage traitement syn    CTFAFB
      *>    COCXBQ Code Etab Banque Entité Juridi    COCXBQ
      *>    IDMCCT Identifiant crédit                IDCT
      *>    DTF9EF Date effet contrat crédit         DTEF
      *>    DTM5CM Date traitement OPC création m    DTFAFB
      *>    CDFAOR Code origine crédit / dossier     CDFAOR
      *>    ZGRP02 ----- Partie spécifique           H52A
      *>    IDTIEM Identifiant emprunteur            IDTIEM
      *>    CDFARE Code réaménagement                CDFARE
      *>    DFM5PF Date fin de préfinancement        DFPF
      *>    DFF9FI Date de fin du crédit             DFFACR
      *>    MTM5I1 Mt impayé Synchro                 MTIMPR
      *>    COEGPS Code Produit Service              CDFCB4
      *>    CODIPR Code type produit service         COFAPS
      *>    DTFBVS Date premier versement au clie    DTVE1
      *>    MTCT   MONTANT ACTUALISE CREDIT          MTCT
      *>                                             H52B
      *>    IDFPEE Identifiant emprunteur            IDFPAN
      *>    CDM5RE Code réaménagement                CDFAR5
      *>    DFM5FI Date de fin du crédit avant mo    DFFAC3
      *>    DFM5PG Date fin de préfinancement        DFPF1
      *>    CDM5MO Code type de modification du c    CDTM
      *>    CDM5HI Code type d'historisation du c    CDTHIS
      *>    DDM5HI Date d'historisation du crédit    DTHIS
      *>    DDM5CR Date création de modif du créd    DTCR
      *>    MTM5E1 Mt échéances avant                MEFHAO
      *>    MTM5E2 Mt échéances après                MEFDRA
      *>    MTOGCT MONTANT ORIGINE CREDIT            MTCT1
      *>    DHM5PE Date première échéance            DTEHPR
      *>                                             H52C
      *>    CTM5AV Code type avenant                 CTFCAV
      *>    CEM5FI Code état branche financière      CEFAFI
      *>    DDM5CA Date création de l'avenant        DTFACR
      *>    TXM5AV Quotient Echéance induit par a    TXFDAV
      *>                                             H52D
      *>    IDFAPE identifiant Personne              IDFPPE
      *>    CDFATE Code type d'acte                  CDFATE
      *>                                             H52E
      *>    MTFNAR MONTANT ARRIERES INCORPORES       MTFNAR
      *>    CTFDEA Code type échéance aménagée       CTFDAM
      *>    CCFDIT Code type calcul intérêts         CCFDIT
      *>                                             H52F
      *>    MTEHRC MONTANT ECHEANCE MER              MTEHRC
      *>    MTEHRD Montant échéance MER              MTEHRD
      *>    NBM5NF Nombre mois franchises            NPRBFA
      *>    MTM5EC Mt échéances cumulé               MTEHR3
      *>
      *>
      *>>>>>   remplacement I52E par H590
      *>   I52E                                     H590
      *>   CDM5IN Code type information             COFAFB
      *>   CTM5TT Code aiguillage traitement syn    CTFAFB
      *>   COCXBQ Code Etab Banque Entité Juridi    COCXBQ
      *>   IDMCCT Identifiant crédit                IDCT
      *>   DTF9EF Date effet contrat crédit         DTEF
      *>   DTM5CM Date traitement OPC création m    DTFAFB
      *>   CDFAOR Code origine crédit / dossier     CDFAOR
      *>   ZGRP02 ----- Partie spécifique
      *>   QCM5ER Compteur Enregistrements          QCFAFB
sqihm9*>
sqir  *> ---------------------------------------------------------------
sqirsd*> Ressources :
cdEA00*> - Structure EA00 : org=F, copybook=FGFEH501, fichier=EI52X1
cdSX00*> - Structure SX00 : org=F, copybook=M5FII79X, fichier=SI79X1
cdSY00*> - Structure SY00 : org=F, copybook=M5FEI52Z, fichier=SI52Z1
cdTX9X*> - Structure TX9X : org=2, copybook=M52DM79X, table=M79X
sqirsf*>
sqirld*> Accès en lecture :
cdEA00*> - EA : org=F, nr=5, ns=0, fichier=EI52X1, accès=LSA
cdTX9X*> - TX : org=2, nr=0, ns=0, table=M79X , accès=LRP
sqirlf*>
sqired*> Accès en écriture :
cdSX00*> - SX : org=F, fichier=SI79X1, accès=ESP
cdSY00*> - SY : org=F, fichier=SI52Z1, accès=ESP
sqiref*>
sqir99*> ***************************************************************
sqivc *> Variables globales pour la compilation conditionnelle
sqivc      copy AGAVBATC.
sqisqa*> ***************************************************************
sqisqa*> * * Squelette : COBPC - Batch avec cinématique <* <*
sqisqa*> * * Version   : COBPC - 6.0.0 <* <*
sqisqd*> * * Squelette : Tag trace Injection <* <*
cdEA00*Inj*|dd:EA|noseg:00|copy:FGFEH501|repl:H501|ddname:EI52X1|recfm:F
cdEA00*Inj*|nrupt:5|nsync:0|org:F|struc:N|mode:S|acces:LSA|cles:DTFAFB;C
cdEA00*Inj*OCXBQ;IDCT;DTEF;CTFAFB|picts:X(10);X(5);X(11);X(8);X(2)
cdSX00*Inj*|dd:SX|noseg:00|copy:M5FII79X|repl:I79X|ddname:SI79X1|recfm:F
cdSX00*Inj*|org:F|struc:N|mode:S|acces:ESP
cdSY00*Inj*|dd:SY|noseg:00|copy:M5FEI52Z|repl:I52Z|ddname:SI52Z1|recfm:F
cdSY00*Inj*|org:F|struc:N|mode:S|acces:ESP
cdTX9X*Inj*|dd:TX|noseg:9X|copy:M52DM79X|repl:M79X|ddname:M79X|org:2|mod
cdTX9X*Inj*e:S|acces:LRP
ce0001*Inj*|noligne:0001|dd:EA|noseg:00|libelle:lues........|libcomplt:C
ce0001*Inj*ontrats SYNCHRO
ce0002*Inj*|noligne:0002|dd:SY|noseg:00|libelle:écrites.....|libcomplt:C
ce0002*Inj*ontrats en commun
ce0003*Inj*|noligne:0003|dd:SX|noseg:00|libelle:écrites.....|libcomplt:C
ce0003*Inj*ontrats en ano
zwW12A*Inj*|sd:W1|nx:2A|repl:H501|copy:FGFEH501|empl:V
zwW92E*Inj*|sd:W9|nx:2E|repl:H590|copy:FGFEH590|empl:V
sqisqf*> * * Squelette : Tag trace Injection <* <*
sqid   DATE-COMPILED.
sqe    ENVIRONMENT DIVISION.
sqec   CONFIGURATION SECTION.
sqesc  SOURCE-COMPUTER.
           IBM-370.
sqeoc  OBJECT-COMPUTER.
           IBM-370.
sqesn  SPECIAL-NAMES.
sqesnd*> *>  zone injection debut <* <*
sqesnf*> *>  zone injection fin <* <*
           DECIMAL-POINT IS COMMA
           .
sqero  REPOSITORY.
           FUNCTION ALL INTRINSIC
           .
sqei   INPUT-OUTPUT SECTION.
sqeif  FILE-CONTROL.
sqeifd*> *>  zone injection debut <* <*
cdEA00      select EA-FICHIER assign to UT-S-EI52X1.
cdSX00      select SX-FICHIER assign to UT-S-SI79X1.
cdSY00      select SY-FICHIER assign to UT-S-SI52Z1.
sqeiff*> *>  zone injection fin <* <*
sqeifs*> Insérer ci-dessous les fichiers gérés en spécifique

sqeii  I-O-CONTROL.
sqeiid*> *>  zone injection debut <* <*
sqeiif*> *>  zone injection fin <* <*
sqeiis*> Insérer ci-dessous les clauses gérées en spécifique
sqeii9     .
sqsd  *>
sqsd  *> ***************************************************************
sqsd  *>  DDDD    AAA   TTTTT   AAA          DDDD   IIIII  V   V
sqsd  *>  D   D  A   A    T    A   A         D   D    I    V   V
sqsd  *>  D   D  AAAAA    T    AAAAA         D   D    I    V   V   ...
sqsd  *>  D   D  A   A    T    A   A         D   D    I     V V   .....
sqsd  *>  DDDD   A   A    T    A   A         DDDD   IIIII    V     ...
sqsd  *> ***************************************************************
sqsd   DATA DIVISION.
sqsdf *>
sqsdf *> ===============================================================
sqsdf *>  FFFFF  IIIII  L      EEEEE        SSSS  EEEEE   CCC   TTTTT
sqsdf *>  F        I    L      E           S      E      C   C    T
sqsdf *>  FFFF     I    L      EEEE         SSS   EEEE   C        T
sqsdf *>  F        I    L      E               S  E      C   C    T
sqsdf *>  F      IIIII  LLLLL  EEEEE       SSSS   EEEEE   CCC     T
sqsdf *> ===============================================================
sqsdf  FILE SECTION.
sqsdfd*> *>  zone injection debut <* <*
cdEA00 FD  EA-FICHIER
cdEA00     block contains 0 records
cdEA00     recording mode is F.
cdEA00     copy FGFEH501 replacing
cdEA00*^^repl1     * compléter ci-dessous *
cdEA00          ==REDEFINES H500.== by ==.==
cdEA00          leading ==H501== by ==EA00==
cdEA00          .
cdSX00 FD  SX-FICHIER
cdSX00     block contains 0 records
cdSX00     recording mode is F.
cdSX00     copy M5FII79X replacing
cdSX00*^^repl1     * compléter ci-dessous *
cdSX00          ==REDEFINES I700.== by ==.==
cdSX00          leading ==I79X== by ==SX00==
cdSX00          .
cdSY00 FD  SY-FICHIER
cdSY00     block contains 0 records
cdSY00     recording mode is F.
cdSY00     copy M5FEI52Z replacing
cdSY00*^^repl1     * compléter ci-dessous *
cdSY00          ==REDEFINES I500.== by ==.==
cdSY00          leading ==I52Z== by ==SY00==
cdSY00          .
sqsdff*> *>  zone injection fin <* <*
sqsds *> Insérer ci-dessous les fichiers gérés en spécifique

sqsw  *>
sqsw  *> ===============================================================
sqsw  *>  W   W        SSSS        SSSS  EEEEE   CCC   TTTTT
sqsw  *>  W   W       S           S      E      C   C    T
sqsw  *>  W W W  ===   SSS         SSS   EEEE   C        T
sqsw  *>  W W W           S           S  E      C   C    T
sqsw  *>   W W        SSSS        SSSS   EEEEE   CCC     T
sqsw  *> ===============================================================
sqsw   WORKING-STORAGE SECTION.
sqsw  *> --- Marqueur pour faciliter l'analyse des dumps
sqsw   01               DEBUT-WSS VOLATILE.
sqsw       05           FILLER        PIC X(7) VALUE 'WORKING'.
sqswp *> --- Horodatage code source
sqswp      copy AGADHORO replacing
sqswp *> --- Informations à mettre à jour à la création du programme
                =='COBASE'== by =='H60'==
                =='APPLI'==  by =='AC4'==
                =='PROGR'==  by =='M5ES01'==
                =='PROGE'==  by =='M5ES01  '==
      *> --- Informations variables à mettre à jour
                =='NUGNA'==  by =='38059'==
                =='DATGN'==  by =='12/06/24'==
                =='DATGNC'== by =='12/06/2024'==
                =='TIMGN'==  by =='19:18:52'==
                =='CODUTI'== by =='J070515 '==
sqswpf          .
sqw2  *>
sqw2  *> ---------------------------------------------------------------
sqw2  *>  H   H   OOO    SSSS  TTTTT  V   V       DDDD   BBBB    222
sqw2  *>  H   H  O   O  S        T    V   V       D   D  B   B  2   2
sqw2  *>  HHHHH  O   O   SSS     T    V   V       D   D  BBBB      2
sqw2  *>  H   H  O   O      S    T     V V        D   D  B   B   22
sqw2  *>  H   H   OOO   SSSS     T      V         DDDD   BBBB   22222
sqw2  *> ---------------------------------------------------------------
sqw2d *> *>  zone injection debut <* <*
cdTX9X*>
cdTX9X*> --- Ressource TX9X - Table M79X
cdTX9X*^^hstavcp   * compléter ci-dessous *
cdTX9X     copy M52DM79X replacing
cdTX9X*^^repl1     * compléter ci-dessous *
cdTX9X          leading ==M79X== by ==TX9X==
cdTX9X          leading ==V-M79X== by ==V-TX9X==
cdTX9X          .
sqw2f *> *>  zone injection fin <* <*
sqw2s *> Insérer ci-dessous les hots-variables gérées en code spécfique

sqwa  *>
sqwa  *> ---------------------------------------------------------------
sqwa  *>  W   W  RRRR   K   K        AAA    CCC    CCC   EEEEE   SSSS
sqwa  *>  W   W  R   R  K KK        A   A  C   C  C   C  E      S
sqwa  *>  W W W  RRRR   KK          AAAAA  C      C      EEEE    SSS
sqwa  *>  W W W  R  R   K KK        A   A  C   C  C   C  E          S
sqwa  *>   W W   R   R  K   K       A   A   CCC    CCC   EEEEE  SSSS
sqwa  *> ---------------------------------------------------------------
sqwad *> *>  zone injection debut <* <*
cdEA00*>
cdEA00*> --- Gestion Accès EA
cdEA00     >>define AA-A-ACCES as 'L'
cdEA00     >>define AA-A-MODE  as 'S'
cdEA00     >>define AA-A-ORG   as 'F'
cdEA00     >>define AA-A-NR    as 5
cdEA00     >>define AA-A-NS    as 0
cdEA00     >>if AA-A-NR > 0
cdEA00     copy FGFEH501 replacing
cdEA00*^^repl2     * compléter ci-dessous *
cdEA00          leading ==H501== by ==1-EA00==
cdEA00          leading ==V-H501== by ==V-1-EA00==
cdEA00          .
cdEA00     >>end-if
cdEA00*^^accavad   * compléter ci-dessous *
cdEA00     copy AAADACCE replacing
cdEA00          ==:DD:== by ==EA==
cdEA00          ==:K1:== by ==DTFAFB==
cdEA00          ==:P1:== by ==X(10)==
cdEA00          ==:K2:== by ==COCXBQ==
cdEA00          ==:P2:== by ==X(5)==
cdEA00          ==:K3:== by ==IDCT==
cdEA00          ==:P3:== by ==X(11)==
cdEA00          ==:K4:== by ==DTEF==
cdEA00          ==:P4:== by ==X(8)==
cdEA00          ==:K5:== by ==CTFAFB==
cdEA00          ==:P5:== by ==X(2)==
cdEA00          .
cdSX00*>
cdSX00*> --- Gestion Accès SX
cdSX00     >>define AA-A-ACCES as 'E'
cdSX00     >>define AA-A-MODE  as 'S'
cdSX00     >>define AA-A-ORG   as 'F'
cdSX00     >>define AA-A-NR    as 0
cdSX00     >>define AA-A-NS    as 0
cdSX00     >>if AA-A-NR > 0
cdSX00     copy M5FII79X replacing
cdSX00*^^repl2     * compléter ci-dessous *
cdSX00          leading ==I79X== by ==1-SX00==
cdSX00          leading ==V-I79X== by ==V-1-SX00==
cdSX00          .
cdSX00     >>end-if
cdSX00*^^accavad   * compléter ci-dessous *
cdSX00     copy AAADACCE replacing
cdSX00          ==:DD:== by ==SX==
cdSX00          .
cdSY00*>
cdSY00*> --- Gestion Accès SY
cdSY00     >>define AA-A-ACCES as 'E'
cdSY00     >>define AA-A-MODE  as 'S'
cdSY00     >>define AA-A-ORG   as 'F'
cdSY00     >>define AA-A-NR    as 0
cdSY00     >>define AA-A-NS    as 0
cdSY00     >>if AA-A-NR > 0
cdSY00     copy M5FEI52Z replacing
cdSY00*^^repl2     * compléter ci-dessous *
cdSY00          leading ==I52Z== by ==1-SY00==
cdSY00          leading ==V-I52Z== by ==V-1-SY00==
cdSY00          .
cdSY00     >>end-if
cdSY00*^^accavad   * compléter ci-dessous *
cdSY00     copy AAADACCE replacing
cdSY00          ==:DD:== by ==SY==
cdSY00          .
cdTX9X*>
cdTX9X*> --- Gestion Accès TX
cdTX9X     >>define AA-A-ACCES as 'L'
cdTX9X     >>define AA-A-MODE  as 'R'
cdTX9X     >>define AA-A-ORG   as '2'
cdTX9X     >>define AA-A-NR    as 0
cdTX9X     >>define AA-A-NS    as 0
cdTX9X     >>if AA-A-NR > 0
cdTX9X*^^accavcp   * compléter ci-dessous *
cdTX9X     copy M52DM79X replacing
cdTX9X*^^repl2     * compléter ci-dessous *
cdTX9X          leading ==M79X== by ==1-TX9X==
cdTX9X          leading ==V-M79X== by ==V-1-TX9X==
cdTX9X          .
cdTX9X     >>end-if
cdTX9X*^^accavad   * compléter ci-dessous *
cdTX9X     copy AAADACCE replacing
cdTX9X          ==:DD:== by ==TX==
cdTX9X          .
sqwaf *> *>  zone injection fin <* <*
sqwafs*> Insérer ci-dessous les working des accès gérés en spécifique

sqwa2  >>if AA-A-DB2
sqwa2 *> --- Interface accès Db2
sqwa2      exec sql include SQLCA end-exec.
sqwa2  >>end-if
sqwa3  >>if AA-A-VSAM
sqwa3 *> --- Interface accès VSAM
sqwa3      copy AAADVSTA.
sqwa3  >>end-if
sqwac  >>if AA-A-LECTURES-AVEC-RUPT
sqwac *> --- Ruptures Globales
sqwac      copy AAADGRUP.
sqwac  >>end-if
sqwac  >>if AA-A-LECTURES-AVEC-SYNC
sqwac *> --- Configurations Globales
sqwac      copy AAADGSYN
sqwacd*> *>  zone injection debut <* <*
sqwacf*> *>  zone injection fin <* <*
sqwacf          .
sqwacf >>end-if
sqwft *> --- Indicateurs de fin de lecture
sqwft  01               FT.
sqwft               88  FIN-LECTURES         VALUE ALL '1'
sqwft                                        FALSE ALL '0'.
sqwftd*> *>  zone injection debut <* <*
cdEA00     05           EA-FT          PIC X VALUE '0'.
cdEA00              88  FIN-LECTURE-EA       VALUE '1'
cdEA00                                       FALSE '0'.
sqwftf*> *>  zone injection fin <* <*
sqwftf >>if not AA-A-LECTURES
sqwftf     05                          PIC X VALUE '0'.
sqwftf >>end-if
sqwfi  >>if AA-A-LECTURES-AVEC-RUPT
sqwfi *> --- Indicateurs de dernier enregistrement avec rupture
sqwfi  01               FI.
sqwfi               88  DERNIERE-ITERATION   VALUE ALL '1'
sqwfi                                        FALSE ALL '0'.
sqwfid*> *>  zone injection debut <* <*
cdEA00     05           EA-FI          PIC X VALUE '0'.
cdEA00              88  DERNIERE-LECTURE-EA  VALUE '1'
cdEA00                                       FALSE '0'.
sqwfif*> *>  zone injection fin <* <*
sqwfif >>end-if
sqwsv *>
sqwsv *> ---------------------------------------------------------------
sqwsv *>  W   W  RRRR   K   K        SSSS  EEEEE  RRRR   V   V
sqwsv *>  W   W  R   R  K KK        S      E      R   R  V   V
sqwsv *>  W W W  RRRR   KK           SSS   EEEE   RRRR   V   V
sqwsv *>  W W W  R  R   K KK            S  E      R  R    V V   ..
sqwsv *>   W W   R   R  K   K       SSSS   EEEEE  R   R    V    ..
sqwsv *> ---------------------------------------------------------------
sqwsvp*> --- Variables de travail du framework compatible Pacbase
sqwsvp     copy AGADPAC0.
sqwsvc*> --- Gestion des opérations sur Dates et Heures
sqwsvc     copy ADADDATE.
sqwsva*> --- Traçabilité programme (reco audit)
sqwsva     copy AGADAUDT.
sqwsv2 >>if AA-A-DB2
sqwsv2*> --- Erreur Db2
sqwsv2     copy A2ADTIAR.
sqwsv2 >>end-if
sqwsvb*> --- Erreur abend volontaire (U4000 par défaut)
sqwsvb 01               CODE-ABEND     PIC 9(8) COMP-5 VALUE 4000.
sqwvsd*> --- Workings des Services insérées par l'Assistant
sqwvsd*> *>  zone injection debut <* <*
sqwvsf*> *>  zone injection fin <* <*
sqwvv *>
sqwvv *> ---------------------------------------------------------------
sqwvv *>  W   W  RRRR   K   K        CCC   TTTTT  RRRR   L
sqwvv *>  W   W  R   R  K KK        C   C    T    R   R  L
sqwvv *>  W W W  RRRR   KK          C        T    RRRR   L
sqwvv *>  W W W  R  R   K KK        C   C    T    R  R   L      ..
sqwvv *>   W W   R   R  K   K        CCC     T    R   R  LLLLL  ..
sqwvv *> ---------------------------------------------------------------
sqwvv *> --- Variables pour contrôles automatiques
sqwvvd*> *>  zone injection début <* <*
sqwvvf*> *>  zone injection fin  <* <*
sqwe  *>
sqwe  *> ---------------------------------------------------------------
sqwe  *>  W   W  RRRR   K   K       EEEEE  TTTTT    A    TTTTT
sqwe  *>  W   W  R   R  K KK        E        T     A A     T
sqwe  *>  W W W  RRRR   KK          EEEE     T    A   A    T
sqwe  *>  W W W  R  R   K KK        E        T    AAAAA    T
sqwe  *>   W W   R   R  K   K       EEEEE    T    A   A    T
sqwe  *> ---------------------------------------------------------------
sqwel *> --- Libellés des Etats
sqwel0*> *>  zone injection début <* <*
sqwel1*> *>  zone injection fin  <* <*
sqweld*> *>  zone injection début <* <*
sqwelf*> *>  zone injection fin  <* <*
sqwes *>
sqwes *> --- Structures et zones techniques des Etats
sqwes0*> *>  zone injection début <* <*
sqwes1*> *>  zone injection fin  <* <*
sqwesd*> *>  zone injection début <* <*
sqwesf*> *>  zone injection fin  <* <*
sqwk  *>
sqwk  *> ---------------------------------------------------------------
sqwk  *>  W   W  RRRR   K   K        SSSS  PPPP   EEEEE   CCC
sqwk  *>  W   W  R   R  K KK        S      P   P  E      C   C
sqwk  *>  W W W  RRRR   KK           SSS   PPPP   EEEE   C
sqwk  *>  W W W  R  R   K KK            S  P      E      C   C  ..
sqwk  *>   W W   R   R  K   K       SSSS   P      EEEEE   CCC   ..
sqwk  *> ---------------------------------------------------------------
sqwk  *> Insérer ci-dessous les variables spécifiques du programme

      *ZONE DE RECUPERATION CARTE SYSIN
       01 WW4Y-SYSIN.
            05 WW4Y-DAM3TR     PICTURE X(8).
            05 WW4Y-CDM3JO     PICTURE X(8).

      *COMPTEURS
      *->  ENREG TYPE 01
       01  W001-QCM5ER VALUE ZERO  PICTURE 9(7).
      *->  ENREG TYPE 02
       01  W002-QCM5ER VALUE ZERO  PICTURE 9(7).
      *->  ENREG TYPE 03
       01  W003-QCM5ER VALUE ZERO   PICTURE 9(7).
      *-> ENREG TYPE 04
       01  W004-QCM5ER VALUE ZERO  PICTURE S9(7)  COMPUTATIONAL-3.
      *->  NOMBRE TOTAL D'ENREGS 01+02+03+04
       01  WTOT-QCM5ER VALUE ZERO PICTURE S9(7) COMPUTATIONAL-3.
      *
      * compteurs contrats écratés pas en ano
       01  WW00-QCM3CR VALUE ZERO   PICTURE S9(10).

      *TOP ECRITURE FICHIER EN SORTIE DES CONTRATS EN ANOMALIES
       01  WW00-WX001A VALUE 'N'  PICTURE X.
      *TABLE M79X :
      *SAUVEGARDE LIBELLE ANOMALIE
       01  WW00-LLM5AN VALUE SPACES    PICTURE X(150).
      *SAUVEGARDE CODE    ANOMALIE
       01  WW00-CDM5AN VALUE SPACES    PICTURE X(05).
      *SAUVEGARDE TYPE    ANOMALIE
       01  WW00-CTM5AN VALUE SPACES    PICTURE X(02).
      *COMPTEUR OCURRENCE
       01  WW00-W9030 VALUE ZERO       PICTURE 999.

sqwka *> --- Workings structurées insérées par l'Assistant
sqwka  01                              PIC X(1) VALUE '0'.
sqwka               88  WORKING-INITIALISEES    VALUE '1'
sqwka                                           FALSE '0'.
sqwkd *> *>  zone injection debut <* <*
zwW12A*>
zwW12A*> --- Zone de travail W12A
zwW12A*^^avcopy    * compléter ci-dessous *
zwW12A     copy FGFEH501 replacing
zwW12A*^^repl1     * compléter ci-dessous *
zwW12A          leading ==H501== by ==W12A==
zwW12A          leading ==V-H501== by ==V-W12A==
zwW12A          .
zwW12A*^^apcopy    * compléter ci-dessous *
zwW12A*>
zwW92E*>
zwW92E*> --- Zone de travail W92E
zwW92E*^^avcopy    * compléter ci-dessous *
zwW92E     copy FGFEH590 replacing
zwW92E*^^repl1     * compléter ci-dessous *
zwW92E          leading ==H590== by ==W92E==
zwW92E          leading ==V-H590== by ==V-W92E==
zwW92E          .
zwW92E*^^apcopy    * compléter ci-dessous *
zwW92E*>
sqwkf *> *>  zone injection fin <* <*
sqlk   LINKAGE SECTION.
sqlk  *> ===============================================================
sqlk  *>  L      N   N  K   K        SSSS  EEEEE   CCC   TTTTT
sqlk  *>  L      NN  N  K KK        S      E      C   C    T
sqlk  *>  L      N N N  KK           SSS   EEEE   C        T
sqlk  *>  L      N  NN  K KK            S  E      C   C    T
sqlk  *>  LLLLL  N   N  K   K       SSSS   EEEEE   CCC     T
sqlk  *> ===============================================================
sqlkd *> *>  zone injection debut <* <*
sqlkf *> *>  zone injection fin <* <*
sqlkf *> Insérer ci-dessous les variables spécifiques du programme

sqp   *>
sqp   *> ***************************************************************
sqp   *>  PPPP   RRRR    OOO    CCC   EEEEE  DDDD   U   U  RRRR   EEEEE
sqp   *>  P   P  R   R  O   O  C   C  E      D   D  U   U  R   R  E
sqp   *>  PPPP   RRRR   O   O  C      EEE    D   D  U   U  RRRR   EEEE
sqp   *>  P      R  R   O   O  C   C  E      D   D  U   U  R  R   E
sqp   *>  P      R   R   OOO    CCC   EEEEE  DDDD    UUU   R   R  EEEEE
sqp   *> ***************************************************************
sqp    PROCEDURE DIVISION
      *>   USING ... .
sqpuf9           .
sqp2d      >>if AA-A-DB2
sqp2d *> --- Gestion des erreurs Db2
           exec sql whenever NOT FOUND   continue            end-exec.
           exec sql whenever SQLWARNING  continue            end-exec.
           exec sql whenever SQLERROR    continue            end-exec.
sqp2f      >>end-if
sqpdd *> --- Réservé declaratives
sqpdf *> --- Réservé end declaratives
sqpp  *> === Cinematique principale ====================================
sqpp   PRINCIPAL SECTION.
sqppa *> --- Initialisations
sqppa      perform   INITIALISATIONS-WORKING
sqppa                with test before until WORKING-INITIALISEES
sqppa      perform S-DEBUT
sqppa      perform   INITIALISATIONS
sqppa      perform S-AVANT-OUVERTURES
sqppa      perform   OUVERTURES
sqppa      perform S-AVANT-ITERATION
sqppa *> --- Boucle principale
sqppa      perform   ITERATION until FIN-LECTURES
sqppa      .
sqppa  FIN-TRAITEMENT.
sqppa *> --- Finalisations
sqppa      perform S-AVANT-FERMETURES
sqppa      perform   FERMETURES
sqppa      perform S-AVANT-FINALISATION
sqppa      perform   FINALISATION
sqppaz*> --- Sortie du programme
           goback
sqppa9     .
sqppi *>
sqppi *> === Décomposition de la boucle principale =====================
sqppi  ITERATION SECTION.
sqppil     perform S-AVANT-LECTURES
sqppil     >>if AA-A-LECTURES
sqppil*> --- Lectures
sqppil     perform   LECTURES
sqppil     >>end-if
sqppil     if not FIN-LECTURES
sqppil       perform S-APRES-LECTURES
sqppir       >>if AA-A-LECTURES-AVEC-RUPT or AA-A-LECTURES-AVEC-SYNC
sqppir*> --- Calcul des Ruptures et des Synchronisations
sqppir       perform   RUPTURES-SYNCHROS
sqppir       >>end-if
sqppic       perform S-AVANT-CONTROLES
sqppic       >>if AA-A-CONTROLES
sqppic*> --- Contrôle automatiques
sqppic       perform   CONTROLES
sqppic       >>end-if
sqppim       perform S-AVANT-MAJ
sqppim       >>if AA-A-MAJ
sqppim*> --- Mises à jour automatiques
sqppim       perform   MISES-A-JOUR
sqppim       >>end-if
sqppit*> --- Taitement applicatif principal
sqppit       perform S-TRAITEMENT
sqppie       >>if AA-A-EDITIONS-AUTO
sqppie*> --- Editions
sqppie       perform   EDITIONS
sqppie       >>end-if
sqppiw       perform S-AVANT-ECRITURES
sqppiw       >>if AA-A-ECRITURES
sqppiw*> --- Ecritures
sqppiw       perform   ECRITURES
sqppiw       >>end-if
sqppiw       perform S-APRES-ECRITURES
sqppix     end-if
sqppix     .
sqppiz ITERATION-SUIVANTE.
sqppiz     continue.
sqppi9 ITERATION-FN.
sqppi9     exit section.
sqpz  *>
sqpz  *> ===============================================================
sqpz  *>   CCC    OOO   DDDD   EEEEE        SSSS  PPPP   EEEEE
sqpz  *>  C   C  O   O  D   D  E           S      P   P  E
sqpz  *>  C      O   O  D   D  EEEE         SSS   PPPP   EEEE
sqpz  *>  C   C  O   O  D   D  E               S  P      E
sqpz  *>   CCC    OOO   DDDD   EEEEE       SSSS   P      EEEEE
sqpz  *> ===============================================================
sqpz0a*>
sqpz0a*> ===============================================================
sqpz0a*> Début de programme, avant tout autre traitement
sqpz0a*> ===============================================================
sqpz0a S-DEBUT SECTION.
sqpz0a*>??? Insérer ci-dessous le code spécifique début de programme


           ACCEPT WW4Y-SYSIN FROM SYSIN
*snip *!DID DE1=WW4Y-DAM3TR DF1=S:AAAAMMJJ
*snip      set 5-DATE-SIECLE-DEF to true
*snip      move WW4Y-DAM3TR to 5-DATE-S
*snip      perform CONVERTIR-DE-DATE-S
*snip      perform CONVERTIR-VERS-DATE-S
*snip      perform VALIDER-DATE
*snip      if 5-DATE-INVALIDE then
*snip          DISPLAY ' Date OPC invalide : '  WW4Y-DAM3TR
               PERFORM  ERREUR-ABEND
*snip      end-if

           IF WW4Y-CDM3JO = SPACES
           OR WW4Y-CDM3JO = LOW-VALUE
           THEN
           DISPLAY     'NOM JOB FICHIER PARAMETRE NON RENSEIGNE / '
              WW4Y-CDM3JO
           END-IF

            DISPLAY  '====> CARTE PARAMETRE : '
            DISPLAY  '         - NOM DU JCL : '   WW4Y-CDM3JO
            DISPLAY  '         - DATE OPC   : '   WW4Y-DAM3TR


sqpz0z*> --- Fin début de programme
sqpz0z     continue.
sqpz0z S-DEBUT-FN.
sqpz0z     exit section.
sqpz0z*>
sqpz0z*> --- Routines locales performées depuis S-DEBUT
sqpz0z*> Insérer ci-dessous le code spécifique du programme

sqpz1a*>
sqpz1a*> ===============================================================
sqpz1a*> Avant ouvertures des ressources
sqpz1a*> ===============================================================
sqpz1a S-AVANT-OUVERTURES SECTION.
sqpz1a*>??? Insérer ci-dessous le code spécifique avant ouvertures

sqpz1z*> --- Fin avant ouverture des ressources
sqpz1z     continue.
sqpz1z S-AVANT-OUVERTURES-FN.
sqpz1z     exit section.
sqpz1z*>
sqpz1z*> --- Routines locales performées depuis S-AVANT-OUVERTURES
sqpz1z*> Insérer ci-dessous le code spécifique du programme

sqpz2a*>
sqpz2a*> ===============================================================
sqpz2a*> Avant itération principale
sqpz2a*> ===============================================================
sqpz2a S-AVANT-ITERATION SECTION.
sqpz2a*>??? Insérer ci-dessous le code spécifique avant itération

      *  alimentation par défaut SX00
           MOVE ALL SPACES   TO SX00
*snip *!AD DE1=WW4Y-DAM3TR DF1=S:AAAAMMJJ
*snip *    DE2=SX00-DAMKTR DF2=G:AAAA-MM-JJ
*snip      move CENTUR to 5-DATE-SIECLE
*snip      set 5-DATE-SIECLE-DEF to true
*snip      move    WW4Y-DAM3TR        to 5-DATE-S
*snip      perform CONVERTIR-DE-DATE-S
*snip      perform CONVERTIR-VERS-DATE-G
*snip      move 5-DATE-G              to SX00-DAMKTR
           MOVE   'SYNCHRO'           TO SX00-IDM5TT
           MOVE   'Q'                 TO SX00-PTM5PE
           MOVE   'M5ES01'            TO SX00-CDSGPR
           MOVE   'CONTROLE COMPTAGE PAR CONTRAT' TO  SX00-LNSGPR
           MOVE    WW00-CTM5AN        TO SX00-CTM5AN
           MOVE    WW00-LLM5AN        TO SX00-LLM5AN
           MOVE    WW00-CDM5AN        TO SX00-CDM5AN


sqpz2z*> --- Fin avant itération
sqpz2z     continue.
sqpz2z S-AVANT-ITERATION-FN.
sqpz2z     exit section.
sqpz2z*>
sqpz2z*> --- Routines locales performées depuis S-AVANT-ITERATION
sqpz2z*> Insérer ci-dessous le code spécifique du programme

sqpz3a*>
sqpz3a*> ===============================================================
sqpz3a*> Avant lectures des ressources
sqpz3a*> ===============================================================
sqpz3a S-AVANT-LECTURES SECTION.
sqpz3a*>??? Insérer ci-dessous le code spécifique avant lectures

sqpz3z*> --- Fin avant lectures des ressources
sqpz3z     continue.
sqpz3z S-AVANT-LECTURES-FN.
sqpz3z     exit section.
sqpz3z*>
sqpz3z*> --- Routines locales performées depuis S-AVANT-LECTURES
sqpz3z*> Insérer ci-dessous le code spécifique du programme

sqpz4a*>
sqpz4a*> ===============================================================
sqpz4a*> Après lectures des ressources
sqpz4a*> ===============================================================
sqpz4a S-APRES-LECTURES SECTION.
sqpz4a*>??? Insérer ci-dessous le code spécifique après lectures



sqpz4z*> --- Fin après lectures des ressources
sqpz4z     continue.
sqpz4z S-APRES-LECTURES-FN.
sqpz4z     exit section.
sqpz4z*>
sqpz4z*> --- Routines locales performées depuis S-APRES-LECTURES
sqpz4z*> Insérer ci-dessous le code spécifique du programme

sqpzca*>
sqpzca*> ===============================================================
sqpzca*> Avant contrôles des ressources
sqpzca*> ===============================================================
sqpzca S-AVANT-CONTROLES SECTION.
sqpzca*>??? Insérer ci-dessous le code spécifique avant contrôles

sqpzcz*> --- Fin avant contrôle des ressources
sqpzcz     continue.
sqpzcz S-AVANT-CONTROLES-FN.
sqpzcz     exit section.
sqpzcz*>
sqpzcz*> --- Routines locales performées depuis S-AVANT-CONTROLES
sqpzcz*> Insérer ci-dessous le code spécifique du programme

sqpzma*>
sqpzma*> ===============================================================
sqpzma*> Avant mise à jour des ressources
sqpzma*> ===============================================================
sqpzma S-AVANT-MAJ SECTION.
sqpzma*>??? Insérer ci-dessous le code spécifique avant mises à jour

sqpzmz*> --- Fin avant mise à jour des ressources
sqpzmz     continue.
sqpzmz S-AVANT-MAJ-FN.
sqpzmz     exit section.
sqpzmz*>
sqpzmz*> --- Routines locales performées depuis S-AVANT-MAJ
sqpzmz*> Insérer ci-dessous le code spécifique du programme

sqpz5a*>
sqpz5a*> ===============================================================
sqpz5a*> Traitement applicatif principal
sqpz5a*> ===============================================================
sqpz5a S-TRAITEMENT SECTION.
sqpz5a*>??? Insérer ci-dessous le code spécifique traitement principal

      * init compteurs en rupt premiere
           IF    RTP5 = '1'
           THEN
            MOVE        ZERO TO  W001-QCM5ER
                                 W002-QCM5ER
                                 W003-QCM5ER
                                 W004-QCM5ER
            MOVE        'N'  TO  WW00-WX001A
           END-IF

      * généralités contrat
      * SAUVEGARDE ENREG POUR ECR SORTIE
           IF 1-EA00-COFAFB = '01'
           THEN
              ADD         1 TO W001-QCM5ER
              MOVE        1-EA00 TO W12A
           END-IF

      * enreg 02 , phase après
           IF 1-EA00-COFAFB = '02'
           THEN
              ADD         1 TO W002-QCM5ER
           END-IF

      * enreg 03 , phase avant
           IF 1-EA00-COFAFB = '03'
           THEN
              ADD         1 TO W003-QCM5ER
           END-IF

      * enreg 04 , crédits rattachés
           IF 1-EA00-COFAFB = '04'
           THEN
              ADD         1 TO W004-QCM5ER
           END-IF

      * si ENREG. TYPE 90 PAS EN DERNIER
           IF    RTD5 = '1'
           AND 1-EA00-COFAFB not = '90'
           THEN
             MOVE 'SY001'  TO  TX9X-CDM5AN
             PERFORM U-ECRIRE-ANO
           END-IF

      *
           IF    RTD5 = '1'
           AND 1-EA00-COFAFB not = '99'
           AND 1-EA00-COFAFB not = '00'
           THEN
             PERFORM U-CONTROLES
           END-IF


sqpz5z*> --- Fin traitement applicatif principal
sqpz5z     continue.
sqpz5z S-TRAITEMENT-FN.
sqpz5z     exit section.
sqpz5z*>
sqpz5z*> --- Routines locales performées depuis S-TRAITEMENT
sqpz5z*> Insérer ci-dessous le code spécifique du programme


      * Alimentation anomalie dans fichier M79X
       U-ECRIRE-ANO.

           MOVE  'O'         TO  WW00-WX001A
           PERFORM  U-LIBELLE-ANO
           MOVE ALL SPACES   TO SX00
      *initialisations sortie
*snip *!AD DE1=WW4Y-DAM3TR DF1=S:AAAAMMJJ
*snip *    DE2=SX00-DAMKTR DF2=G:AAAA-MM-JJ
*snip      move CENTUR to 5-DATE-SIECLE
*snip      set 5-DATE-SIECLE-DEF to true
*snip      move    WW4Y-DAM3TR        to 5-DATE-S
*snip      perform CONVERTIR-DE-DATE-S
*snip      perform CONVERTIR-VERS-DATE-G
*snip      move 5-DATE-G              to SX00-DAMKTR
           MOVE   'SYNCHRO'           TO SX00-IDM5TT
           MOVE   'Q'                 TO SX00-PTM5PE
           MOVE   'M5ES01'            TO SX00-CDSGPR
           MOVE   'CONTROLE COMPTAGE PAR CONTRAT' TO  SX00-LNSGPR
           MOVE    WW00-CTM5AN        TO SX00-CTM5AN
           MOVE    WW00-LLM5AN        TO SX00-LLM5AN
           MOVE    WW00-CDM5AN        TO SX00-CDM5AN
           MOVE 'ANOMALIE RENCONTREE SUR CAISSE: '
                                      TO SX00-GRM5DA (1:33)
           MOVE 1-EA00-COCXBQ         TO SX00-GRM5DA (34:5)
           MOVE ' - CONTRAT : '       TO SX00-GRM5DA (39:13)
           MOVE 1-EA00-IDCT           TO SX00-GRM5DA (52:07)
           MOVE ' - DATE EFFET : '    TO SX00-GRM5DA (59:16)
*snip *!AD DE1=1-EA00-DTEF DF1=S:AAAAMMJJ
*snip *    DE2=SX00-GRM5DA(75:10) DF2=G:AAAA-MM-JJ
*snip      move CENTUR to 5-DATE-SIECLE
*snip      set 5-DATE-SIECLE-DEF to true
*snip      move        1-EA00-DTEF    to 5-DATE-S
*snip      perform CONVERTIR-DE-DATE-S
*snip      perform CONVERTIR-VERS-DATE-G
*snip      move        5-DATE-G       to SX00-GRM5DA(75:10)

           MOVE ' - TYPE MODIF : '    TO SX00-GRM5DA (85:16)
           MOVE 1-EA00-CTFAFB         TO SX00-GRM5DA (101:2)
           MOVE ' - TYPE ENREG : '    TO SX00-GRM5DA (103:16)
           MOVE 1-EA00-COFAFB         TO SX00-GRM5DA (119:2)

      * ENREG 90 DOIT ETRE EN DERNIER
           IF    WW00-CDM5AN = 'SY001'
           THEN

              MOVE  'A NOTER QUE LE TYPE ENREG 90 PERMET DE CONTROLER LE
      -       ' NOMBRE ENREG TOTAL ENVOYE POUR LE CONTRAT EN QUESTION'
                                      TO SX00-GRM5D1 (1:105)
           END-IF

      * anomalie NC (nouveau contrat)
           IF    WW00-CDM5AN = 'SY002'
           THEN
            MOVE   'COMPTEUR TYPE ENREG 01 : ' TO  SX00-GRM5D1(01:25)
            MOVE   W001-QCM5ER   TO  SX00-GRM5D1(26:07)
            MOVE   ' - COMPTEUR TYPE ENREG 02 : ' TO  SX00-GRM5D1(33:28)
            MOVE   W002-QCM5ER   TO  SX00-GRM5D1(61:07)
            MOVE   ' - COMPTEUR TYPE ENREG 03 : '  TO SX00-GRM5D1(68:28)
            MOVE   W003-QCM5ER   TO  SX00-GRM5D1(96:07)
           END-IF

      * anomalie PO (prise d'option) ou anomalie AV (avenant)
           IF    WW00-CDM5AN = 'SY003'
           OR    WW00-CDM5AN = 'SY004'
           THEN
            MOVE 'COMPTEUR TYPE ENREG 01 : ' TO  SX00-GRM5D1(01:25)
            MOVE W001-QCM5ER   TO  SX00-GRM5D1(26:07)
            MOVE ' - COMPTEUR TYPE ENREG 02 : ' TO  SX00-GRM5D1(33:28)
            MOVE W002-QCM5ER   TO  SX00-GRM5D1(61:07)
            MOVE ' - COMPTEUR TYPE ENREG 03 : '  TO SX00-GRM5D1(68:28)
            MOVE W003-QCM5ER   TO  SX00-GRM5D1(96:07)
            MOVE ' - COMPTEUR TYPE ENREG 04 : '  TO SX00-GRM5D1(103:28)
            MOVE W004-QCM5ER   TO  SX00-GRM5D1(131:07)
           END-IF

      * anomalie type 90
           IF    WW00-CDM5AN = 'SY005'
           THEN
              MOVE   'COMPTEUR TYPE ENREG 01 + 02 + 03 + 04 = '
                                      TO   SX00-GRM5D1(01:40)
              COMPUTE  WTOT-QCM5ER =   W001-QCM5ER +
                                       W002-QCM5ER +
                                       W003-QCM5ER +
                                       W004-QCM5ER
              MOVE   WTOT-QCM5ER       TO   SX00-GRM5D1(41:07)
              MOVE   ' - COMPTEUR ATTENDU : '  TO  SX00-GRM5D1(48:22)
              MOVE   W92E-QCFAFB       TO  SX00-GRM5D1(70:07)
           END-IF

           PERFORM ECRIRE-SX

           continue.


      * Recherche libellé anomalie dans M79X
       U-LIBELLE-ANO.

           MOVE  'O'    TO  WW00-WX001A

           IF TX9X-CDM5AN NOT = WW00-CDM5AN
           THEN
              MOVE   TX9X-CDM5AN   TO    WW00-CDM5AN
              MOVE   SPACES        TO    WW00-CTM5AN
              MOVE   SPACES        TO    WW00-LLM5AN
              PERFORM LIRE-TX
              IF SQLCODE not = 0
              THEN
                 MOVE 'Libellé code anomalie non trouvé - Vérifier la ta
      -          'ble M79X et faire le nécessaire '   TO WW00-LLM5AN
                 MOVE '02'   TO  WW00-CTM5AN
                 Display  'Libellé code anomalie non trouvé - Vérifier '
                 'la table M79X et faire le nécessaire sqlcode '
                 SQLCODE   ' CDM5AN : '  TX9X-CDM5AN
              ELSE
                 MOVE   TX9X-LLM5AN   TO    WW00-LLM5AN
                 MOVE   TX9X-CTM5AN   TO    WW00-CTM5AN
              END-IF

           END-IF
           continue.


       U-CONTROLES.

      * type nouveau contrat doit avoir un enreg 01 et pas de 02 ni 03
           IF   1-EA00-CTFAFB = 'NC'
           AND (W001-QCM5ER NOT = 1
           OR   W002-QCM5ER NOT = 0
           OR   W003-QCM5ER NOT = 0)
           THEN
             MOVE 'SY002'  TO  TX9X-CDM5AN
             PERFORM U-ECRIRE-ANO
           end-if

      * prise d'option doit avoir un enreg 01 et pas de 02 ni 03 ni 04
           IF   1-EA00-CTFAFB = 'PO'
           AND (W001-QCM5ER NOT = 1
           OR   W002-QCM5ER NOT = 0
           OR   W003-QCM5ER NOT = 0
           OR   W004-QCM5ER NOT = 0)
           THEN
             MOVE 'SY003'  TO  TX9X-CDM5AN
             PERFORM U-ECRIRE-ANO
           end-if

      * type avenant doit avoir un enreg 01, 1 ou plusieurs 02 ou 03
      * et pas de 04
           IF     1-EA00-CTFAFB = 'AV'
           AND  ( W001-QCM5ER NOT = 1
           OR   ( W002-QCM5ER    = 0 AND  W12A-CDTM NOT = 'PR')
           OR   ( W003-QCM5ER    = 0 AND  W12A-CDTM NOT = 'PR')
           OR    W004-QCM5ER NOT = 0)
           THEN
             MOVE 'SY004'  TO  TX9X-CDM5AN
             PERFORM U-ECRIRE-ANO
           end-if

      * comptage par contrat sauvegarde
           IF     1-EA00-COFAFB = '90'
           THEN
              MOVE  1-EA00    TO  W92E
      * LE NOMBRE TOTAL D'ENREGS RECUS POUR LE CONTRAT EST <> DE CELUI
      * DU COMPTEUR DE L'ENREG 90
              iF  W92E-QCFAFB NOT =
              W001-QCM5ER  + W002-QCM5ER + W003-QCM5ER + W004-QCM5ER
              then
                 MOVE 'SY005'  TO  TX9X-CDM5AN
                 PERFORM U-ECRIRE-ANO
              end-if
           end-if

      * Ecriture anomalie
           iF WW00-WX001A = 'O'
              then
               MOVE  W12A  TO  SY00
               PERFORM ECRIRE-SY
           else
               add 1   to    WW00-QCM3CR
           end-if

           continue.


sqpzwa*>
sqpzwa*> ===============================================================
sqpzwa*> Avant écriture des ressources
sqpzwa*> ===============================================================
sqpzwa S-AVANT-ECRITURES SECTION.
sqpzwa*>??? Insérer ci-dessous le code spécifique avant écritures

sqpzwf*> --- Fin avant écritures des ressources
sqpzwf     continue.
sqpzwf S-AVANT-ECRITURES-FN.
sqpzwf     exit section.
sqpzwf*>
sqpzwf*> --- Routines locales performées depuis S-AVANT-ECRITURES
sqpzwf*> Insérer ci-dessous le code spécifique du programme

sqpzwl*>
sqpzwl*> ===============================================================
sqpzwl*> Après écriture des ressources
sqpzwl*> ===============================================================
sqpzwl S-APRES-ECRITURES SECTION.
sqpzwl*>??? Insérer ci-dessous le code spécifique après écritures

sqpzwz*> --- Fin après écritures des ressources
sqpzwz     continue.
sqpzwz S-APRES-ECRITURES-FN.
sqpzwz     exit section.
sqpzwz*>
sqpzwz*> --- Routines locales performées depuis S-APRES-ECRITURES
sqpzwz*> Insérer ci-dessous le code spécifique du programme

sqpz6a*>
sqpz6a*> ===============================================================
sqpz6a*> Avant fermeture des ressources
sqpz6a*> ===============================================================
sqpz6a S-AVANT-FERMETURES SECTION.
sqpz6a*>??? Insérer ci-dessous le code spécifique avant fermetures

sqpz6z*> --- Fin avant fermeture des ressources
sqpz6z     continue.
sqpz6z S-AVANT-FERMETURES-FN.
sqpz6z     exit section.
sqpz6z*>
sqpz6z*> --- Routines locales performées depuis S-AVANT-FERMETURES
sqpz6z*> Insérer ci-dessous le code spécifique du programme

sqpz7a*>
sqpz7a*> ===============================================================
sqpz7a*> Avant sortie du programme
sqpz7a*> ===============================================================
sqpz7a S-AVANT-FINALISATION SECTION.
sqpz7a*>??? Insérer ci-dessous le code spécifique avant finalisation

      *> --- Display du compteur des contrats écratésSZ
           display PROGE
                ' - XXXX - Nombre de contrats sans ano .: '
                WW00-qcm3cr

sqpz7z*> --- Fin avant sortie du programme
sqpz7z     continue.
sqpz7z S-AVANT-FINALISATION-FN.
sqpz7z     exit section.
sqpz7z*>
sqpz7z*> --- Routines locales performées depuis S-AVANT-FINALISATION
sqpz7z*> Insérer ci-dessous le code spécifique du programme

sqpz9a*>
sqpz9a*> ===============================================================
sqpz9a*>  RRRR    OOO   U   U  TTTTT  IIIII  N   N  EEEEE   SSS
sqpz9a*>  R   R  O   O  U   u    T      I    NN  N  E      S
sqpz9a*>  RRRR   O   O  U   U    T      I    N N N  EEE     SSS
sqpz9a*>  R  R   O   O  U   U    T      I    N  NN  E          S
sqpz9a*>  R   R   OOO    UUU     T    IIIII  N   N  EEEEE   SSS
sqpz9a*> ===============================================================
sqpz9a*>??? Insérer ci-dessous le code spécifique des routines globales

sqpa  *>
sqpa  *> ===============================================================
sqpa  *>   AAA    CCC    CCC   EEEEE   SSSS
sqpa  *>  A   A  C   C  C   C  E      S
sqpa  *>  AAAAA  C      C      EEEE    SSS
sqpa  *>  A   A  C   C  C   C  E          S
sqpa  *>  A   A   CCC    CCC   EEEEE  SSSS
sqpa  *> ===============================================================
sqpad *> *>  zone injection debut <* <*
cdEA00*>
cdEA00*> --- Gestion Accès EA
cdEA00     >>define AA-A-ACCES as 'L'
cdEA00     >>define AA-A-MODE  as 'S'
cdEA00     >>define AA-A-ORG   as 'F'
cdEA00     >>define AA-A-NR    as 5
cdEA00     >>define AA-A-NS    as 0
cdEA00*^^accavap   * compléter ci-dessous *
cdEA00     copy AAAPACCE replacing
cdEA00          ==:DD:== by ==EA==
cdEA00          ==:PREF:== by ==EA00==
cdEA00          ==:NS:== by ==0==
cdEA00          ==:K1:== by ==DTFAFB==
cdEA00          ==:K2:== by ==COCXBQ==
cdEA00          ==:K3:== by ==IDCT==
cdEA00          ==:K4:== by ==DTEF==
cdEA00          ==:K5:== by ==CTFAFB==
cdEA00          .
cdSX00*>
cdSX00*> --- Gestion Accès SX
cdSX00     >>define AA-A-ACCES as 'E'
cdSX00     >>define AA-A-MODE  as 'S'
cdSX00     >>define AA-A-ORG   as 'F'
cdSX00     >>define AA-A-NR    as 0
cdSX00     >>define AA-A-NS    as 0
cdSX00*^^accavap   * compléter ci-dessous *
cdSX00     copy AAAPACCE replacing
cdSX00          ==:DD:== by ==SX==
cdSX00          ==:PREF:== by ==SX00==
cdSX00          ==:NS:== by ==0==
cdSX00          .
cdSY00*>
cdSY00*> --- Gestion Accès SY
cdSY00     >>define AA-A-ACCES as 'E'
cdSY00     >>define AA-A-MODE  as 'S'
cdSY00     >>define AA-A-ORG   as 'F'
cdSY00     >>define AA-A-NR    as 0
cdSY00     >>define AA-A-NS    as 0
cdSY00*^^accavap   * compléter ci-dessous *
cdSY00     copy AAAPACCE replacing
cdSY00          ==:DD:== by ==SY==
cdSY00          ==:PREF:== by ==SY00==
cdSY00          ==:NS:== by ==0==
cdSY00          .
cdTX9X*>
cdTX9X*> --- Gestion Accès TX
cdTX9X     >>define AA-A-ACCES as 'L'
cdTX9X     >>define AA-A-MODE  as 'R'
cdTX9X     >>define AA-A-ORG   as '2'
cdTX9X     >>define AA-A-NR    as 0
cdTX9X     >>define AA-A-NS    as 0
cdTX9X*^^accavap   * compléter ci-dessous *
cdTX9X     copy AAAPACCE replacing
cdTX9X          ==:DD:== by ==TX==
cdTX9X          ==:PREF:== by ==TX9X==
cdTX9X          ==:NS:== by ==0==
cdTX9X          .
cdTX9X*>
cdTX9X*> --- Lecture directe Table M79X  - Ressource TX
cdTX9X*>
cdTX9X*>^^^ Ne pas accéder directement à ce code, utiliser LIRE-TX
cdTX9X LIRE-TX-SQL SECTION.
cdTX9X*^^sqlavlec  * compléter ci-dessous *
cdTX9X     exec sql
cdTX9X --^^select  *>!!! Ecrire l'ordre SELECT ci-dessous
              SELECT
                 LLM5AN,
                 CTM5AN
              INTO
                 :TX9X-LLM5AN,
                 :TX9X-CTM5AN
              FROM M79X
              WHERE
                CDM5AN = :TX9X-CDM5AN
cdTX9X     end-exec
cdTX9X*^^sqlaplec  * compléter ci-dessous *
cdTX9X     continue.
cdTX9X LIRE-TX-SQL-FN.
cdTX9X     exit section.
sqpaf *> *>  zone injection fin <* <*
sqpafs*> Insérer ci-dessous les routines des accès gérés en spécifique

sqpv  *>
sqpv  *> ===============================================================
sqpv  *>   SSSS  EEEEE  RRRR   V   V  IIIII   CCC   EEEEE   SSSS
sqpv  *>  S      E      R   R  V   V    I    C   C  E      S
sqpv  *>   SSS   EEEE   RRRR   V   V    I    C      EEEE    SSS
sqpv  *>      S  E      R  R    V V     I    C   C  E          S
sqpv  *>  SSSS   EEEEE  R   R    V    IIIII   CCC   EEEEE  SSSS
sqpv  *> ===============================================================
sqpvda*> --- Gestion des opérations sur dates et heures
sqpvda     copy ADAPDATE.
sqpvd *> *>  zone injection debut <* <*
sqpvf *> *>  zone injection fin <* <*
sqpi  *>
sqpi  *> ===============================================================
sqpi  *>  IIIII  N   N  IIIII  TTTTT  IIIII   AAA   L      IIIII   SSS
sqpi  *>    I    NN  N    I      T      I    A   A  L        I    S
sqpi  *>    I    N N N    I      T      I    AAAAA  L        I     SSS
sqpi  *>    I    N  NN    I      T      I    A   A  L        I        S
sqpi  *>  IIIII  N   N  IIIII    T    IIIII  A   A  LLLLL  IIIII   SSS
sqpi  *> ===============================================================
sqpi   INITIALISATIONS SECTION.
sqpid *> *>  zone injection debut <* <*
sqpif *> *>  zone injection fin <* <*
sqpiq *> --- Fin initialisations
sqpiq      continue.
sqpiq  INITIALISATIONS-FN.
sqpiq      exit section.
sqpiw *> --- Initialisation des Workings insérées par l'Assistant
sqpiw  INITIALISATIONS-WORKING SECTION.
sqpiw      set WORKING-INITIALISEES to true
sqpiwa*> --- Trace reco audit
sqpiwa     copy AGAPAUD1.
sqpiwd*> *>  zone injection debut <* <*
zwW12A*> --- initialisation de la zone de travail W12A
zwW12A     initialize W12A with FILLER
zwW12A*^^apinit    * compléter ci-dessous *
zwW12A*>
zwW92E*> --- initialisation de la zone de travail W92E
zwW92E     initialize W92E with FILLER
zwW92E*^^apinit    * compléter ci-dessous *
zwW92E*>
sqpiwf*> *>  zone injection fin <* <*
sqpiws*> Insérer ci-dessous les initialisations gérées en spécifique

sqpi99*> --- Fin initialisations
sqpi99     continue.
sqpi99 INITIALISATIONS-WORKING-FN.
sqpi99     exit section.
sqpo  *>
sqpo  *> ===============================================================
sqpo  *>   OOO   U   U  V   V  EEEEE  RRRR   TTTTT  U   U  RRRR   EEEEE
sqpo  *>  O   O  U   U  V   V  E      R   R    T    U   U  R   R  E
sqpo  *>  O   O  U   U  V   V  EEEE   RRRR     T    U   U  RRRR   EEEE
sqpo  *>  O   O  U   U   V V   E      R  R     T    U   U  R  R   E
sqpo  *>   OOO    UUU     V    EEEEE  R   R    T     UUU   R   R  EEEEE
sqpo  *> ===============================================================
sqpo   OUVERTURES SECTION.
sqpod *> *>  zone injection debut <* <*
cdEA00*> --- Ouverture ressource EA
cdEA00*^^ouvavt    * compléter ci-dessous *
cdEA00     perform OUVRIR-EA
cdEA00*^^ouvapr    * compléter ci-dessous *
cdEA00*>
cdSX00*> --- Ouverture ressource SX
cdSX00*^^ouvavt    * compléter ci-dessous *
cdSX00     perform OUVRIR-SX
cdSX00*^^ouvapr    * compléter ci-dessous *
cdSX00*>
cdSY00*> --- Ouverture ressource SY
cdSY00*^^ouvavt    * compléter ci-dessous *
cdSY00     perform OUVRIR-SY
cdSY00*^^ouvapr    * compléter ci-dessous *
cdSY00*>
sqpof *> *>  zone injection fin <* <*
sqpofs*> Insérer ci-dessous l'ouverture des accès gérés en spécifique

sqpo99*> --- Fin ouvertures ressources
sqpo99     continue.
sqpo99 OUVERTURES-FN.
sqpo99     exit section.
sqpl   >>if AA-A-LECTURES
sqpl  *>
sqpl  *> ===============================================================
sqpl  *>  L      EEEEE   CCC   TTTTT  U   U  RRRR   EEEEE   SSS
sqpl  *>  L      E      C   C    T    U   U  R   R  E      S
sqpl  *>  L      EEE    C        T    U   U  RRRR   EEEE    SSS
sqpl  *>  L      E      C   C    T    U   U  R  R   E          S
sqpl  *>  LLLLL  EEEEE   CCC     T     UUU   R   R  EEEEE   SSS
sqpl  *> ===============================================================
sqpl   LECTURES SECTION.
sqpls *> --- Lectures sans rupture
sqplsd*> *>  zone injection debut <* <*
sqplsf*> *>  zone injection fin <* <*
sqplr *> --- Lectures avec ruptures
sqplrd*> *>  zone injection debut <* <*
cdEA00*> --- Lecture ressource EA avec ruptures
cdEA00*^^liravt    * compléter ci-dessous *
cdEA00     perform LIRE-EA
cdEA00*^^lirapr    * compléter ci-dessous *
cdEA00*>
sqplrf*> *>  zone injection fin <* <*
sqpl8s*> Insérer ci-dessous la lecture des accès gérés en spécifique

sqpl99*> --- Fin lectures ressources
sqpl99     continue.
sqpl99 LECTURES-FN.
sqpl99     exit section.
sqpl99 >>end-if
sqpf  *>
sqpf  *> ===============================================================
sqpf  *>  FFFFF  EEEEE  RRRR   M   M  EEEEE  TTTTT  U   U  RRRR   EEEEE
sqpf  *>  F      E      R   R  MM MM  E        T    U   U  R   R  E
sqpf  *>  FFFF   EEEE   RRRR   M M M  EEEE     T    U   U  RRRR   EEEE
sqpf  *>  F      E      R  R   M   M  E        T    U   U  R  R   E
sqpf  *>  F      EEEEE  R   R  M   M  EEEEE    T     UUU   R   R  EEEEE
sqpf  *> ===============================================================
sqpf   FERMETURES SECTION.
sqpfd *> *>  zone injection debut <* <*
cdEA00*> --- Fermeture ressource EA
cdEA00*^^feravt    * compléter ci-dessous *
cdEA00     perform FERMER-EA
cdEA00*^^ferapr    * compléter ci-dessous *
cdEA00*>
cdSX00*> --- Fermeture ressource SX
cdSX00*^^feravt    * compléter ci-dessous *
cdSX00     perform FERMER-SX
cdSX00*^^ferapr    * compléter ci-dessous *
cdSX00*>
cdSY00*> --- Fermeture ressource SY
cdSY00*^^feravt    * compléter ci-dessous *
cdSY00     perform FERMER-SY
cdSY00*^^ferapr    * compléter ci-dessous *
cdSY00*>
ce0001*> --- Display du compteur EA
ce0001     display PROGE
ce0001          ' - EA00 - Nombre de lignes lues........: '
ce0001          5-EA00-CPTENR
ce0001          ' Contrats SYNCHRO'
ce0002*> --- Display du compteur SY
ce0002     display PROGE
ce0002          ' - SY00 - Nombre de lignes écrites.....: '
ce0002          5-SY00-CPTENR
ce0002          ' Contrats en commun'
ce0003*> --- Display du compteur SX
ce0003     display PROGE
ce0003          ' - SX00 - Nombre de lignes écrites.....: '
ce0003          5-SX00-CPTENR
ce0003          ' Contrats en ano'
sqpff *> *>  zone injection fin <* <*
sqpffs*> Insérer ci-dessous la fermeture des accès gérés en spécifique

sqpf99*> --- Fin fermetures ressources
sqpf99     continue.
sqpf99 FERMETURES-FN.
sqpf99     exit section.
sqpq  *>
sqpq  *> ===============================================================
sqpq  *>  FFFFF  IIIII  N   N   AAA   L      IIIII   SSSS
sqpq  *>  F        I    NN  N  A   A  L        I    S
sqpq  *>  FFFF     I    N N N  AAAAA  L        I     SSS
sqpq  *>  F        I    N  NN  A   A  L        I        S  ..
sqpq  *>  F      IIIII  N   N  A   A  LLLLL  IIIII  SSSS   ..
sqpq  *> ===============================================================
sqpq   FINALISATION SECTION.
sqpqd *> *>  zone injection debut <* <*
sqpqf *> *>  zone injection fin <* <*
sqpqt *> --- Traçabilité programme (reco audit)
sqpqt      copy AGAPAUD2.
sqpq99*> --- Fin finalisation
sqpq99     continue.
sqpq99 FINALISATION-FN.
sqpq99     exit section.
sqpr   >>if AA-A-LECTURES-AVEC-RUPT or AA-A-LECTURES-AVEC-SYNC
sqpr  *>
sqpr  *> ===============================================================
sqpr  *>  RRRR   U   U  PPPP   TTTTT        SSSS  Y   Y  N   N   CCC
sqpr  *>  R   R  U   U  P   P    T         S       Y Y   NN  N  C   C
sqpr  *>  RRRR   U   U  PPPP     T          SSS     Y    N N N  C
sqpr  *>  R  R   U   U  P        T             S    Y    N  NN  C   C
sqpr  *>  R   R   UUU   P        T         SSSS     Y    N   N   CCC
sqpr  *> ===============================================================
sqpr   RUPTURES-SYNCHROS SECTION.
sqpr2  >>if AA-A-LECTURES-AVEC-RUPT
sqpr2 *> --- Calcul des Ruptures
sqpr2d*> *>  zone injection debut <* <*
cdEA00*> --- Ruptures ressource EA
cdEA00     perform CALCULER-RUPT-EA
sqpr2f*> *>  zone injection fin <* <*
sqpr2s*> Insérer ci-dessous les calculs de rupture gérés en spécifique

sqpr29 >>end-if
sqpr4  >>if AA-A-LECTURES-AVEC-SYNC
sqpr4 *> --- Calcul des Synchronisations
sqpr4 *> Initialisations
sqpr4      copy AAAPGSYN.
sqpr4 *> Phase 1 - Calcul des clés de Synchronisation
sqpr4d*> *>  zone injection debut <* <*
sqpr4f*> *>  zone injection fin <* <*
sqpr4s*> Insérer ci-dessous les calculs des clés gérés en spécifique

sqpr5 *> Phase 2 - Calcul des Configurations
sqpr5d*> *>  zone injection debut <* <*
sqpr5f*> *>  zone injection fin <* <*
sqpr5s*> Insérer ci-dessous les calculs des config. gérés en spécifique

sqpr59 >>end-if
sqpr6  >>if AA-A-LECTURES-AVEC-RUPT and AA-A-LECTURES-AVEC-SYNC
sqpr6 *> --- Calcul des Ruptures totales
sqpr6 *> Initialisations
sqpr6      copy AAAPGRTD.
sqpr6d*> *>  zone injection debut <* <*
sqpr6f*> *>  zone injection fin <* <*
sqpr6s*> Insérer ci-dessous les calculs de rupture gérés en spécifique

sqpr69 >>end-if
sqpr99*> --- Fin Ruptures et Synchronisations
sqpr99     continue.
sqpr99 RUPTURES-SYNCHROS-FN.
sqpr99     exit section.
sqpr99 >>end-if
sqpc   >>if AA-A-CONTROLES
sqpc  *>
sqpc  *> ===============================================================
sqpc  *>   CCC    OOO   N   N  TTTTT  RRRR    OOO   L      EEEEE   SSSS
sqpc  *>  C   C  O   O  NN  N    T    R   R  O   O  L      E      S
sqpc  *>  C      O   O  N N N    T    RRRR   O   O  L      EEEE    SSS
sqpc  *>  C   C  O   O  N  NN    T    R  R   O   O  L      E          S
sqpc  *>   CCC    OOO   N   N    T    R   R   OOO   LLLLL  EEEEE  SSSS
sqpc  *> ===============================================================
sqpc   CONTROLES SECTION.
sqpcd *> *>  zone injection debut <* <*
sqpcf *> *>  zone injection fin <* <*
sqpc99*> --- Fin contrôles
sqpc99     continue.
sqpc99 CONTROLES-FN.
sqpc99     exit section.
sqpc99 >>end-if
sqpm   >>if AA-A-MAJ
sqpm  *>
sqpm  *> ===============================================================
sqpm  *>  M   M   AAA   JJJJJ        AAA   U   U  TTTTT   OOO
sqpm  *>  MM MM  A   A    J         A   A  U   U    T    O   O
sqpm  *>  M M M  AAAAA    J         AAAAA  U   U    T    O   O
sqpm  *>  M   M  A   A  J J         A   A  U   U    T    O   O
sqpm  *>  M   M  A   A   J          A   A   UUU     T     OOO
sqpm  *> ===============================================================
sqpm   MISES-A-JOUR SECTION.
sqpmd *> *>  zone injection debut <* <*
sqpmf *> *>  zone injection fin <* <*
sqpm99*> --- Fin maj auto
sqpm99     continue.
sqpm99 MISES-A-JOUR-FN.
sqpm99     exit section.
sqpm99 >>end-if
sqpe   >>if AA-A-EDITIONS
sqpe  *>
sqpe  *> ===============================================================
sqpe  *>  EEEEE  DDDD   IIIII  TTTTT  IIIII   OOO   N   N   SSSS
sqpe  *>  E      D   D    I      T      I    O   O  NN  N  S
sqpe  *>  EEEE   D   D    I      T      I    O   O  N N N   SSS
sqpe  *>  E      D   D    I      T      I    O   O  N  NN      S
sqpe  *>  EEEEE  DDDD   IIIII    T    IIIII   OOO   N   N  SSSS
sqpe  *> ===============================================================
sqpe   >>if AA-A-EDITIONS-AUTO
sqpe   EDITIONS SECTION.
sqpepd*> *>  zone injection debut <* <*
sqpepf*> *>  zone injection fin <* <*
sqpep9  *> --- Fin éditions
sqpep9     continue.
sqpep9 EDITIONS-FN.
sqpep9     exit section.
sqpep9 >>end-if
sqpecd*> *>  zone injection debut <* <*
sqpecf*> *>  zone injection fin <* <*
sqpe99 >>end-if
sqps   >>if AA-A-ECRITURES
sqps  *>
sqps  *> ===============================================================
sqps  *>  EEEEE   CCC   RRRR   IIIII  TTTTT  U   U  RRRR   EEEEE   SSSS
sqps  *>  E      C   C  R   R    I      T    U   U  R   R  E      S
sqps  *>  EEEE   C      RRRR     I      T    U   U  RRRR   EEEE    SSS
sqps  *>  E      C   C  R  R     I      T    U   U  R  R   E          S
sqps  *>  EEEEE   CCC   R   R  IIIII    T     UUU   R   R  EEEEE  SSSS
sqps  *> ===============================================================
sqps   ECRITURES SECTION.
sqpsd *> *>  zone injection debut <* <*
sqpsf *> *>  zone injection fin <* <*
sqpss *> Insérer ci-dessous les écritures des accès gérés en spécifique

sqps99*> --- Fin écritures
sqps99     continue.
sqps99 ECRITURES-FN.
sqps99     exit section.
sqps99 >>end-if
sqpko *>
sqpko *> ===============================================================
sqpko *>  EEEEE  RRRR   RRRR   EEEEE  U   U  RRRR    SSSS
sqpko *>  E      R   R  R   R  E      U   U  R   R  S
sqpko *>  EEEE   RRRR   RRRR   EEEE   U   U  RRRR    SSS
sqpko *>  E      R  R   R  R   E      U   U  R  R       S
sqpko *>  EEEEE  R   R  R   R  EEEEE   UUU   R   R  SSSS
sqpko *> ===============================================================
sqpka *> --- Abend volontaire
sqpka  ERREUR-ABEND SECTION.
sqpka      call 'CEE3ABD' using CODE-ABEND
sqpka                     by content X'00000001'
sqpka      end-call
sqpka9     .
sqpka9 ERREUR-ABEND-FN.
sqpka9     exit section.
sqpkd *> *>  zone injection debut <* <*
sqpkf *> *>  zone injection fin <* <*
sqpk2  >>if AA-A-DB2
sqpk2 *> --- Gestion des erreurs DB2
sqpk2  ERREUR-DB2 SECTION.
sqpk2      copy A2APTIAR.
sqpk2      if DSNTIAR-OK
sqpk2        display '*******************************'
sqpk2        display '****  E R R E U R   D B 2  ****'
sqpk2        display '*******************************'
sqpk2        perform varying XDSNTIAR from 1 by 1
sqpk2        until XDSNTIAR > 10
sqpk2           or DSNTIAR-END (XDSNTIAR)
sqpk2          display DSNTIAR-LINE (XDSNTIAR)
sqpk2        end-perform
sqpk2      end-if
sqpk2      move SQLCODE to DSNTIAR-ABEND
sqpk2a     call 'CEE3ABD' using DSNTIAR-ABEND
sqpk2a                    by content X'00000001'
sqpk2a     end-call
sqpk29     .
sqpk29 ERREUR-DB2-FN.
sqpk29     exit section.
sqpk29 >>end-if
sqq999*>
sqq999*> ===============================================================
sqq999*> === That's all folks ! ========================================
sqq999*> ===============================================================
sqq999 End program M5ES01.
