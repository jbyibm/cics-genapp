      *CONTROL NOSOURCE                                                 AJZSJSNS
      *>****************************************************************AJZSJSNS
      *> Variables nécessaires au fonctionnement du module 'SMJSNS' de  AJZSJSNS
      *> sérialisation d'un flux JSON.                                  AJZSJSNS
      *> A déclarer en Working-Storage Section.                         AJZSJSNS
      *>----------------------------------------------------------------AJZSJSNS
      *> Paramètres REPLACING obligatoires :                            AJZSJSNS
      *> - :JS: : code structure du Document JSON, 2 caractères         AJZSJSNS
      *> - :LENGTH: : longueur de ligne maximum du Document XML         AJZSJSNS
      *>****************************************************************AJZSJSNS
      *CONTROL SOURCE                                                   AJZSJSNS
      *>                                                                AJZSJSNS
      *> Zone de communication du module de sérialisation JSON 'SMJSNS' AJZSJSNS
      *>                                                                AJZSJSNS
       01               W-:JS:00-SMJSNS  PIC X(8) VALUE 'SMJSNS  '.     AJZSJSNS
       01               W-:JS:00-JSNCODE PIC S9(9) BINARY.              AJZSJSNS
       01               FILLER REDEFINES W-:JS:00-JSNCODE.              AJZSJSNS
               10       W-:JS:00-JSNRC   PIC 9(2) BINARY.               AJZSJSNS
               10       W-:JS:00-JSNRSN  PIC 9(4) COMP-5.               AJZSJSNS
       01               W-:JS:00-TXTLEN  PIC 9(8) COMP-5.               AJZSJSNS
       01               W-:JS:00-TXTADR  POINTER.                       AJZSJSNS
       01               W-:JS:00-MAXLEN  PIC 9(8) COMP-5 VALUE :LENGTH:.AJZSJSNS
       01               W-:JS:00-BUFLEN  PIC 9(8) COMP-5.               AJZSJSNS
       01               W-:JS:00-BUFADR  POINTER.                       AJZSJSNS
       01               W-:JS:00-CTXADR  POINTER VALUE NULL.            AJZSJSNS
       01               W-:JS:00-EVENT   PIC X(30).                     AJZSJSNS
                    88  F-:JS:00-MEMBER                                 AJZSJSNS
                        VALUE 'MEMBER                        '.         AJZSJSNS
                    88  F-:JS:00-START-OF-DOCUMENT                      AJZSJSNS
                        VALUE 'START-OF-DOCUMENT             '.         AJZSJSNS
                    88  F-:JS:00-END-OF-DOCUMENT                        AJZSJSNS
                        VALUE 'END-OF-DOCUMENT               '.         AJZSJSNS
                    88  F-:JS:00-START-OF-OBJECT                        AJZSJSNS
                        VALUE 'START-OF-OBJECT               '.         AJZSJSNS
                    88  F-:JS:00-END-OF-OBJECT                          AJZSJSNS
                        VALUE 'END-OF-OBJECT                 '.         AJZSJSNS
                    88  F-:JS:00-START-OF-ARRAY                         AJZSJSNS
                        VALUE 'START-OF-ARRAY                '.         AJZSJSNS
                    88  F-:JS:00-END-OF-ARRAY                           AJZSJSNS
                        VALUE 'END-OF-ARRAY                  '.         AJZSJSNS
                    88  F-:JS:00-BOOLEAN                                AJZSJSNS
                        VALUE 'BOOLEAN                       '.         AJZSJSNS
                    88  F-:JS:00-NULL                                   AJZSJSNS
                        VALUE 'NULL                          '.         AJZSJSNS
                    88  F-:JS:00-NUMBER                                 AJZSJSNS
                        VALUE 'NUMBER                        '.         AJZSJSNS
                    88  F-:JS:00-STRING                                 AJZSJSNS
                        VALUE 'STRING                        '.         AJZSJSNS
                    88  F-:JS:00-START-OF-STRING                        AJZSJSNS
                        VALUE 'START-OF-STRING               '.         AJZSJSNS
                    88  F-:JS:00-STRING-FRAGMENT                        AJZSJSNS
                        VALUE 'STRING-FRAGMENT               '.         AJZSJSNS
                    88  F-:JS:00-END-OF-STRING                          AJZSJSNS
                        VALUE 'END-OF-STRING                 '.         AJZSJSNS
      *>                                                                AJZSJSNS
      *> OPTIONS DE TRAITEMENT (module SMJSNS)                          AJZSJSNS
      *>                                                                AJZSJSNS
       01               W-:JS:00-OPTIONS.                               AJZSJSNS
               10       W-:JS:00-LENGTH  PIC S9(4) BINARY VALUE 16.     AJZSJSNS
               10       W-:JS:00-EYE     PIC X(4) VALUE 'JSNO'.         AJZSJSNS
               10       W-:JS:00-CCSID   PIC 9(4) VALUE 1147.           AJZSJSNS
               10       W-:JS:00-INDENT  PIC S9(4) BINARY VALUE -1.     AJZSJSNS
               10       W-:JS:00-TRIMLS  PIC X(1) VALUE '0'.            AJZSJSNS
                    88  F-:JS:00-TRIMLS           VALUE '1'.            AJZSJSNS
               10       W-:JS:00-TRIMTS  PIC X(1) VALUE '1'.            AJZSJSNS
                    88  F-:JS:00-TRIMTS           VALUE '1'.            AJZSJSNS
               10       W-:JS:00-TRIMLZ  PIC X(1) VALUE '1'.            AJZSJSNS
                    88  F-:JS:00-TRIMLZ           VALUE '1'.            AJZSJSNS
               10       W-:JS:00-TRIMTZ  PIC X(1) VALUE '0'.            AJZSJSNS
                    88  F-:JS:00-TRIMTZ           VALUE '1'.            AJZSJSNS
