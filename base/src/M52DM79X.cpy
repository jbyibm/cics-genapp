      *>****************************************************************M52DM79X
      *> TABLE DB2 M79X : Param Anomalie NPE Forbearance                M52DM79X
      *>----------------------------------------------------------------M52DM79X
      *CONTROL NOSOURCE                                                 M52DM79X
      *> Auteur           :  Jacques Sernesi                            M52DM79X
      *> Date de Création :  08/01/15                                   M52DM79X
      *> Origine Création :  Projet 017431 : TOPS NPE / Forbearance     M52DM79X
      *>                                                                M52DM79X
      *>                                                                M52DM79X
      *> Segment de description de la table M79X.                       M52DM79X
      *>                                                                M52DM79X
      *> Table paramètre des codes anomalies référencés dans les        M52DM79X
      *> traitements NPE et Forbearance                                 M52DM79X
      *>----------------------------------------------------------------M52DM79X
      *> MOT CLES :                                                     M52DM79X
      *>                                                                M52DM79X
      *>----------------------------------------------------------------M52DM79X
      *CONTROL SOURCE                                                   M52DM79X
      *> Utilisation :                                                  M52DM79X
      *> copy M52DM79X replacing leading ==M79X== by ==prefix==         M52DM79X
      *>                         leading ==V-M79X== by ==V-prefix==.    M52DM79X
      *>****************************************************************M52DM79X
      *> -- 16/04/2024 18:15:08 BIB:M5B SESSION:9419  USER:USER         M52DM79X
      *>----------------------------------------------------------------M52DM79X
      *> Param anomalie NPE Forbearance                                 M52DM79X
       01               M79X.                                           M52DM79X
      *> Code anomalie NPE FORBEARANCE                                  *00001
               10       M79X-CDM5AN    PIC X(05).                       *00001
      *> Type anomalie                                                  *00006
               10       M79X-CTM5AN    PIC X(02).                       *00006
      *> Libelle message anomalie                                       *00008
               10       M79X-LLM5AN    PIC X(150).                      *00008
      *>                                                                M52DM79X
       >>if AA-A-DB2NOIND not defined                                   M52DM79X
       01               V-M79X.                                         M52DM79X
               10       V-M79X-CDM5AN  PIC S9(4) COMP-5.                M52DM79X
               10       V-M79X-CTM5AN  PIC S9(4) COMP-5.                M52DM79X
               10       V-M79X-LLM5AN  PIC S9(4) COMP-5.                M52DM79X
       01               V-M79X-R       REDEFINES V-M79X.                M52DM79X
               10       V-M79X-A       PIC S9(4) COMP-5                 M52DM79X
                                       OCCURS 00003.                    M52DM79X
       >>end-if                                                         M52DM79X
       >>define AA-A-DB2NOIND off                                       M52DM79X
