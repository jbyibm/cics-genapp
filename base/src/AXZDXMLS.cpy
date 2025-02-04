      *CONTROL NOSOURCE                                                 AXZDXMLS
      ******************************************************************AXZDXMLS
      * Variables nécessaires au fonctionnement du module 'SMXMLS' de   AXZDXMLS
      * sérialisation d'un flux XML.                                    AXZDXMLS
      * A déclarer en Working-Storage Section.                          AXZDXMLS
      * ----------------------------------------------------------------AXZDXMLS
      * Paramètres REPLACING obligatoires :                             AXZDXMLS
      * - :XM: : code structure du Document XML, 2 caractères           AXZDXMLS
      * - :LENGTH: : longueur de ligne maximum du Document XML          AXZDXMLS
      ******************************************************************AXZDXMLS
      *CONTROL SOURCE                                                   AXZDXMLS
      *                                                                 AXZDXMLS
      * Zone de communication du module de sérialisation XML 'SMXMLS'   AXZDXMLS
      *                                                                 AXZDXMLS
       01               W-:XM:00-SMXMLS  PIC X(8) VALUE 'SMXMLS  '.     AXZDXMLS
       01               W-:XM:00-XMLCODE PIC S9(9) BINARY.              AXZDXMLS
       01               FILLER REDEFINES W-:XM:00-XMLCODE.              AXZDXMLS
               10       W-:XM:00-XRC     PIC 9(2) BINARY.               AXZDXMLS
               10       W-:XM:00-XRSN    PIC 9(4) COMP-5.               AXZDXMLS
       01               W-:XM:00-TXTLEN  PIC 9(8) COMP-5.               AXZDXMLS
       01               W-:XM:00-TXTADR  POINTER.                       AXZDXMLS
       01               W-:XM:00-PFXLEN  PIC 9(8) COMP-5.               AXZDXMLS
       01               W-:XM:00-PFXADR  POINTER.                       AXZDXMLS
       01               W-:XM:00-MAXLEN  PIC 9(8) COMP-5 VALUE :LENGTH:.AXZDXMLS
       01               W-:XM:00-BUFLEN  PIC 9(8) COMP-5.               AXZDXMLS
       01               W-:XM:00-BUFADR  POINTER.                       AXZDXMLS
       01               W-:XM:00-CTXADR  POINTER VALUE NULL.            AXZDXMLS
       01               W-:XM:00-EVENT   PIC X(30).                     AXZDXMLS
                    88  F-:XM:00-ATTRIBUTE-CHARACTERS                   AXZDXMLS
                        VALUE 'ATTRIBUTE-CHARACTERS'.                   AXZDXMLS
                    88  F-:XM:00-ATTRIBUTE-NAME                         AXZDXMLS
                        VALUE 'ATTRIBUTE-NAME'.                         AXZDXMLS
                    88  F-:XM:00-COMMENT                                AXZDXMLS
                        VALUE 'COMMENT'.                                AXZDXMLS
                    88  F-:XM:00-CONTENT-CHARACTERS                     AXZDXMLS
                        VALUE 'CONTENT-CHARACTERS'.                     AXZDXMLS
                    88  F-:XM:00-DTD                                    AXZDXMLS
                        VALUE 'DOCUMENT-TYPE-DECLARATION'.              AXZDXMLS
                    88  F-:XM:00-ENCODING-DECLARATION                   AXZDXMLS
                        VALUE 'ENCODING-DECLARATION'.                   AXZDXMLS
                    88  F-:XM:00-END-OF-CDATA-SECTION                   AXZDXMLS
                        VALUE 'END-OF-CDATA-SECTION'.                   AXZDXMLS
                    88  F-:XM:00-END-OF-DOCUMENT                        AXZDXMLS
                        VALUE 'END-OF-DOCUMENT'.                        AXZDXMLS
                    88  F-:XM:00-END-OF-ELEMENT                         AXZDXMLS
                        VALUE 'END-OF-ELEMENT'.                         AXZDXMLS
                    88  F-:XM:00-END-OF-INPUT                           AXZDXMLS
                        VALUE 'END-OF-INPUT'.                           AXZDXMLS
                    88  F-:XM:00-EXCEPTION                              AXZDXMLS
                        VALUE 'EXCEPTION'.                              AXZDXMLS
                    88  F-:XM:00-NAMESPACE-DECLARATION                  AXZDXMLS
                        VALUE 'NAMESPACE-DECLARATION'.                  AXZDXMLS
                    88  F-:XM:00-PI-DATA                                AXZDXMLS
                        VALUE 'PROCESSING-INSTRUCTION-DATA'.            AXZDXMLS
                    88  F-:XM:00-PI-TARGET                              AXZDXMLS
                        VALUE 'PROCESSING-INSTRUCTION-TARGET'.          AXZDXMLS
                    88  F-:XM:00-STANDALONE-DECLARATION                 AXZDXMLS
                        VALUE 'STANDALONE-DECLARATION'.                 AXZDXMLS
                    88  F-:XM:00-START-OF-CDATA-SECTION                 AXZDXMLS
                        VALUE 'START-OF-CDATA-SECTION'.                 AXZDXMLS
                    88  F-:XM:00-START-OF-DOCUMENT                      AXZDXMLS
                        VALUE 'START-OF-DOCUMENT'.                      AXZDXMLS
                    88  F-:XM:00-START-OF-ELEMENT                       AXZDXMLS
                        VALUE 'START-OF-ELEMENT'.                       AXZDXMLS
                    88  F-:XM:00-UNRESOLVED-REFERENCE                   AXZDXMLS
                        VALUE 'UNRESOLVED-REFERENCE'.                   AXZDXMLS
                    88  F-:XM:00-VERSION-INFORMATION                    AXZDXMLS
                        VALUE 'VERSION-INFORMATION'.                    AXZDXMLS
                    88  F-:XM:00-IGNORABLE-WHITESPACE                   AXZDXMLS
                        VALUE 'IGNORABLE-WHITESPACE'.                   AXZDXMLS
                    88  F-:XM:00-START-OF-COMMENT                       AXZDXMLS
                        VALUE 'START-OF-COMMENT'.                       AXZDXMLS
                    88  F-:XM:00-COMMENT-CHARACTERS                     AXZDXMLS
                        VALUE 'COMMENT-CHARACTERS'.                     AXZDXMLS
                    88  F-:XM:00-END-OF-COMMENT                         AXZDXMLS
                        VALUE 'END-OF-COMMENT'.                         AXZDXMLS
      *                                                                 AXZDXMLS
      * OPTIONS DE TRAITEMENT (module SMXMLS)                           AXZDXMLS
      *                                                                 AXZDXMLS
       01               W-:XM:00-OPTIONS.                               AXZDXMLS
               10       W-:XM:00-LENGTH  PIC S9(4) BINARY VALUE 17.     AXZDXMLS
               10       W-:XM:00-EYE     PIC X(4) VALUE 'XMLO'.         AXZDXMLS
               10       W-:XM:00-CCSID   PIC 9(4) VALUE 1147.           AXZDXMLS
               10       W-:XM:00-INDENT  PIC S9(4) BINARY VALUE -1.     AXZDXMLS
               10       W-:XM:00-TRIMLS  PIC X(1) VALUE '0'.            AXZDXMLS
                    88  F-:XM:00-TRIMLS           VALUE '1'.            AXZDXMLS
                    88  F-:XM:00-TRIMLS-CDATA     VALUE '2'.            AXZDXMLS
                    88  F-:XM:00-TRIMLS-ALL       VALUE '3'.            AXZDXMLS
               10       W-:XM:00-TRIMTS  PIC X(1) VALUE '1'.            AXZDXMLS
                    88  F-:XM:00-TRIMTS           VALUE '1'.            AXZDXMLS
                    88  F-:XM:00-TRIMTS-CDATA     VALUE '2'.            AXZDXMLS
                    88  F-:XM:00-TRIMTS-ALL       VALUE '3'.            AXZDXMLS
               10       W-:XM:00-TRIMLZ  PIC X(1) VALUE '0'.            AXZDXMLS
                    88  F-:XM:00-TRIMLZ           VALUE '1'.            AXZDXMLS
                    88  F-:XM:00-TRIMLZ-CDATA     VALUE '2'.            AXZDXMLS
                    88  F-:XM:00-TRIMLZ-ALL       VALUE '3'.            AXZDXMLS
               10       W-:XM:00-TRIMTZ  PIC X(1) VALUE '0'.            AXZDXMLS
                    88  F-:XM:00-TRIMTZ           VALUE '1'.            AXZDXMLS
                    88  F-:XM:00-TRIMTZ-CDATA     VALUE '2'.            AXZDXMLS
                    88  F-:XM:00-TRIMTZ-ALL       VALUE '3'.            AXZDXMLS
               10       W-:XM:00-NEWLINE PIC X(1) VALUE '0'.            AXZDXMLS
                    88  F-:XM:00-NEWLINE          VALUE '1'.            AXZDXMLS
