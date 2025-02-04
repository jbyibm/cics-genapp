      *CONTROL NOSOURCE                                                 A9ZPDATX
      *>****************************************************************A9ZPDATX
      *> Appel du module Gestion des Dates                              A9ZPDATX
      *> Confer TMR 11 0068                                             A9ZPDATX
      *> - Module CICS  : SFDT03                                        A9ZPDATX
      *>   exec cics link program('SFDT03') commarea(ZS00) end-exec     A9ZPDATX
      *>----------------------------------------------------------------A9ZPDATX
      *> Paramètres obligatoires :                                      A9ZPDATX
      *> - Néant                                                        A9ZPDATX
      *> Paramètres facultatifs (selon contexte) :                      A9ZPDATX
      *> - leading ZS : préfixe des zones du service                    A9ZPDATX
      *>****************************************************************A9ZPDATX
      *CONTROL SOURCE                                                   A9ZPDATX
           exec cics link program ('SFDT03')                            A9ZPDATX
                          commarea (ZS00)                               A9ZPDATX
           end-exec                                                     A9ZPDATX
