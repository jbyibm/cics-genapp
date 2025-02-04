      *CONTROL NOSOURCE                                                 A2ADTIAR
      *>****************************************************************A2ADTIAR
      *> Zone message interface DSNTIAR                                 A2ADTIAR
      *> - DSNTIAR-LINE-LENGTH : longueur logique d'une ligne du        A2ADTIAR
      *>   message formaté par le module DSNTIAR                        A2ADTIAR
      *> - DSNTIAR-MESSAGE : zone contenant le messsage formaté par le  A2ADTIAR
      *>   module DSNTIAR                                               A2ADTIAR
      *> - DSNTIAR-MESSAGE-LENGTH : longueur de la zone message         A2ADTIAR
      *> - DSNTIAR-MESSAGE-LINE : ligne de message ; la première ligne  A2ADTIAR
      *>   entièrement à space indique la fin du message                A2ADTIAR
      *> - DSNTIAR-RC : code retour appel à DSNTIAR                     A2ADTIAR
      *> - DSNTIAR-ABEND : preparation du code abend avec valeur        A2ADTIAR
      *>   SQLCODE                                                      A2ADTIAR
      *>****************************************************************A2ADTIAR
      *CONTROL SOURCE                                                   A2ADTIAR
      *> --- Interface DSNTIAR                                          A2ADTIAR
       01               DSNTIAR-RC              PIC 9(2).               A2ADTIAR
                    88  DSNTIAR-OK              VALUE 00 THRU 04.       A2ADTIAR
       01               DSNTIAR-ABEND           PIC 9(8) COMP-5.        A2ADTIAR
       01               DSNTIAR-LINE-LENGTH     PIC 9(8) COMP-5         A2ADTIAR
                                                VALUE 72.               A2ADTIAR
       01               DSNTIAR-MESSAGE.                                A2ADTIAR
           05           DSNTIAR-MESSAGE-LENGTH  PIC 9(4) COMP-5         A2ADTIAR
                                                VALUE 720.              A2ADTIAR
           05           DSNTIAR-LINES.                                  A2ADTIAR
             10         DSNTIAR-LINE            PIC X(72) OCCURS 10     A2ADTIAR
                                                INDEXED BY XDSNTIAR.    A2ADTIAR
                    88  DSNTIAR-END             VALUE SPACES.           A2ADTIAR
