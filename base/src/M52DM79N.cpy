      *>****************************************************************M52DM79N
      *> TABLE DB2 M79N : Param Référentiel Mesures                     M52DM79N
      *>----------------------------------------------------------------M52DM79N
      *CONTROL NOSOURCE                                                 M52DM79N
      *> Auteur           :  P.Lafitte                                  M52DM79N
      *> Date de Création :  08/10/20                                   M52DM79N
      *> Origine Création :  Projet Nouveau Defaut : 026818             M52DM79N
      *>                                                                M52DM79N
      *>                                                                M52DM79N
      *> Segment de description de la table M79N.                       M52DM79N
      *>                                                                M52DM79N
      *> Cette table paramètre liste les mesures pouvant être           M52DM79N
      *> appliquées à une Forbearance.                                  M52DM79N
      *>                                                                M52DM79N
      *> Elle indique également le code mesure associée, la date de     M52DM79N
      *> validité de la mesure, sa temporalité et son mode de           M52DM79N
      *> détermination.                                                 M52DM79N
      *>----------------------------------------------------------------M52DM79N
      *> MOT CLES :                                                     M52DM79N
      *>                                                                M52DM79N
      *>----------------------------------------------------------------M52DM79N
      *CONTROL SOURCE                                                   M52DM79N
      *> Utilisation :                                                  M52DM79N
      *> copy M52DM79N replacing leading ==M79N== by ==prefix==         M52DM79N
      *>                         leading ==V-M79N== by ==V-prefix==.    M52DM79N
      *>****************************************************************M52DM79N
      *> -- 16/04/2024 18:14:58 BIB:M5B SESSION:9419  USER:USER         M52DM79N
      *>----------------------------------------------------------------M52DM79N
      *> Param réferentiel mesures                                      M52DM79N
       01               M79N.                                           M52DM79N
      *> Code mesure Forbearance                                        *00001
               10       M79N-CDM5ME    PIC XX.                          *00001
      *> Libellé mesure Forbearance                                     *00003
               10       M79N-LBM5ME    PIC X(80).                       *00003
      *> Date début validité mesure (SSAA-MM-JJ)                        *00083
               10       M79N-DDM5ME    PIC X(10).                       *00083
      *> Date fin validité mesure (SSAA-MM-JJ)                          *00093
               10       M79N-DFM5ME    PIC X(10).                       *00093
      *> Code de temporalité de la mesure                               *00103
               10       M79N-CDM5TP    PIC X(1).                        *00103
      *> Ind détection auto mesure FB                                   *00104
               10       M79N-CIM5MD    PIC X(1).                        *00104
      *> Libellé long mesure Forbearance                                *00105
               10       M79N-LLM5ME    PIC X(200).                      *00105
      *>                                                                M52DM79N
       >>if AA-A-DB2NOIND not defined                                   M52DM79N
       01               V-M79N.                                         M52DM79N
               10       V-M79N-CDM5ME  PIC S9(4) COMP-5.                M52DM79N
               10       V-M79N-LBM5ME  PIC S9(4) COMP-5.                M52DM79N
               10       V-M79N-DDM5ME  PIC S9(4) COMP-5.                M52DM79N
               10       V-M79N-DFM5ME  PIC S9(4) COMP-5.                M52DM79N
               10       V-M79N-CDM5TP  PIC S9(4) COMP-5.                M52DM79N
               10       V-M79N-CIM5MD  PIC S9(4) COMP-5.                M52DM79N
               10       V-M79N-LLM5ME  PIC S9(4) COMP-5.                M52DM79N
       01               V-M79N-R       REDEFINES V-M79N.                M52DM79N
               10       V-M79N-A       PIC S9(4) COMP-5                 M52DM79N
                                       OCCURS 00007.                    M52DM79N
       >>end-if                                                         M52DM79N
       >>define AA-A-DB2NOIND off                                       M52DM79N
