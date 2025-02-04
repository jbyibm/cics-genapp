      *CONTROL NOSOURCE                                                 A2APTIAR
      *>****************************************************************A2APTIAR
      *> Appel au module DSNTIAR                                        A2APTIAR
      *>----------------------------------------------------------------A2APTIAR
      *> Code retour :                                                  A2APTIAR
      *> - 00 : ok                                                      A2APTIAR
      *> - 04 : zone message trop petite, perte d'informations          A2APTIAR
      *> - 08 : longueur de ligne de dehors de l'intervalle 72 à 240    A2APTIAR
      *> - 12 : longueur zone message inférieure à 240                  A2APTIAR
      *> - 16 : erreur dans la routine TSO                              A2APTIAR
      *> - 20 : module DSNTIA1 non chargeable                           A2APTIAR
      *> - 24 : structure SQLCA invalide                                A2APTIAR
      ******************************************************************A2APTIAR
      *CONTROL SOURCE                                                   A2APTIAR
      *> --- Interface DSNTIAR                                          A2APTIAR
           >>callinterface dynamic                                      A2APTIAR
           call 'DSNTIAR' using SQLCA                                   A2APTIAR
                                DSNTIAR-MESSAGE                         A2APTIAR
                                DSNTIAR-LINE-LENGTH                     A2APTIAR
             on exception                                               A2APTIAR
               move 20 to DSNTIAR-RC                                    A2APTIAR
             not on exception                                           A2APTIAR
               move return-code to DSNTIAR-RC                           A2APTIAR
           end-call                                                     A2APTIAR
           >>callinterface                                              A2APTIAR
