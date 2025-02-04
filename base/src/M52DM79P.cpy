      *>****************************************************************M52DM79P
      *> TABLE DB2 M79P : Param Seuils acceptabilité                    M52DM79P
      *>----------------------------------------------------------------M52DM79P
      *CONTROL NOSOURCE                                                 M52DM79P
      *> Auteur           :  Muriel DI GIANNI                           M52DM79P
      *> Date de Création :  25/08/22                                   M52DM79P
      *> Origine Création :  31984 refonte qualification forbearance    M52DM79P
      *>                                                                M52DM79P
      *>                                                                M52DM79P
      *> Segment de description de la table M79P.                       M52DM79P
      *>                                                                M52DM79P
      *> Table permettant d'enregistrer les seuils d'acceptabilité      M52DM79P
      *> des ratios Bilan pour la fiche Forbearance                     M52DM79P
      *>                                                                M52DM79P
      *>                                                                M52DM79P
      *>----------------------------------------------------------------M52DM79P
      *> MOT CLES :                                                     M52DM79P
      *>                                                                M52DM79P
      *>----------------------------------------------------------------M52DM79P
      *CONTROL SOURCE                                                   M52DM79P
      *> Utilisation :                                                  M52DM79P
      *> copy M52DM79P replacing leading ==M79P== by ==prefix==         M52DM79P
      *>                         leading ==V-M79P== by ==V-prefix==.    M52DM79P
      *>****************************************************************M52DM79P
      *> -- 16/04/2024 18:15:05 BIB:M5B SESSION:9419  USER:USER         M52DM79P
      *>----------------------------------------------------------------M52DM79P
      *> Param Seuils acceptabilité                                     M52DM79P
       01               M79P.                                           M52DM79P
      *> Type données Bilan                                             *00001
               10       M79P-CTM5BI    PIC X(6).                        *00001
      *> Date début validité (SSAA-MM-JJ)                               *00007
               10       M79P-DDEHVA    PIC X(10).                       *00007
      *> Date fin validité (SSAA-MM-JJ)                                 *00017
               10       M79P-DFEHVA    PIC X(10).                       *00017
      *> Taux seuil acceptabilité                                       *00027
               10       M79P-TXM5SE    PIC S9(3)V99 PACKED-DECIMAL.     *00027
      *>                                                                M52DM79P
       >>if AA-A-DB2NOIND not defined                                   M52DM79P
       01               V-M79P.                                         M52DM79P
               10       V-M79P-CTM5BI  PIC S9(4) COMP-5.                M52DM79P
               10       V-M79P-DDEHVA  PIC S9(4) COMP-5.                M52DM79P
               10       V-M79P-DFEHVA  PIC S9(4) COMP-5.                M52DM79P
               10       V-M79P-TXM5SE  PIC S9(4) COMP-5.                M52DM79P
       01               V-M79P-R       REDEFINES V-M79P.                M52DM79P
               10       V-M79P-A       PIC S9(4) COMP-5                 M52DM79P
                                       OCCURS 00004.                    M52DM79P
       >>end-if                                                         M52DM79P
       >>define AA-A-DB2NOIND off                                       M52DM79P
