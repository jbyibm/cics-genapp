      *CONTROL NOSOURCE                                                 A8ZPDATX
      *>****************************************************************A8ZPDATX
      *> Appel du module Gestion des Dates                              A8ZPDATX
      *> Confer TMR 11 0068                                             A8ZPDATX
      *> - Module batch : SFDB05                                        A8ZPDATX
      *>   call 'SFDB05' using ZS00 end-call                            A8ZPDATX
      *>----------------------------------------------------------------A8ZPDATX
      *> Paramètres obligatoires :                                      A8ZPDATX
      *> - Néant                                                        A8ZPDATX
      *> Paramètres facultatifs (selon contexte) :                      A8ZPDATX
      *> - leading ZS : préfixe des zones du service                    A8ZPDATX
      *>****************************************************************A8ZPDATX
      *CONTROL SOURCE                                                   A8ZPDATX
           >>callinterface dynamic                                      A8ZPDATX
           call 'SFDB05' using ZS00                                     A8ZPDATX
           end-call                                                     A8ZPDATX
           >>callinterface                                              A8ZPDATX
