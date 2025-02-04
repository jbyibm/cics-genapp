      *>****************************************************************M52DM72L
      *> TABLE DB2 M72L : Etapes Forbearance et mesures                 M52DM72L
      *>----------------------------------------------------------------M52DM72L
      *CONTROL NOSOURCE                                                 M52DM72L
      *> Auteur           :  P.Lafitte                                  M52DM72L
      *> Date de Création :  08/10/20                                   M52DM72L
      *> Origine Création :  Projet Nouveau Defaut : 026818             M52DM72L
      *>                                                                M52DM72L
      *> Segment de description de la table M72L                        M52DM72L
      *>                                                                M52DM72L
      *> Cette table contient pour chaque contrat en Forbearance        M52DM72L
      *> la liste des mesures associées à chaque étape de concession    M52DM72L
      *> de la Forbearance.                                             M52DM72L
      *> Donc pas d'enregistrement pour chaque étape mais uniquement    M52DM72L
      *> les étapes de concession.                                      M52DM72L
      *>----------------------------------------------------------------M52DM72L
      *> MOT CLES :                                                     M52DM72L
      *>                                                                M52DM72L
      *>----------------------------------------------------------------M52DM72L
      *CONTROL SOURCE                                                   M52DM72L
      *> Utilisation :                                                  M52DM72L
      *> copy M52DM72L replacing leading ==M72L== by ==prefix==         M52DM72L
      *>                         leading ==V-M72L== by ==V-prefix==.    M52DM72L
      *>****************************************************************M52DM72L
      *> -- 16/04/2024 18:14:30 BIB:M5B SESSION:9419  USER:USER         M52DM72L
      *>----------------------------------------------------------------M52DM72L
      *> Etapes Forbearance et mesures                                  M52DM72L
       01               M72L.                                           M52DM72L
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72L-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       M72L-IDDIEP    PIC X(27).                       *00006
      *> Num cycle Forbearance                                          *00033
               10       M72L-NSM5CY    PIC S9(7) PACKED-DECIMAL.        *00033
      *> Num étape dans cycle Forb                                      *00037
               10       M72L-NSM5ET    PIC S9(7) PACKED-DECIMAL.        *00037
      *> Code mesure Forbearance                                        *00041
               10       M72L-CDM5ME    PIC XX.                          *00041
      *> Date début effet mesure sur FB (SSAA-MM-JJ)                    *00043
               10       M72L-DDM5MF    PIC X(10).                       *00043
      *> Date fin effet mesure sur FB (SSAA-MM-JJ)                      *00053
               10       M72L-DFM5MF    PIC X(10).                       *00053
      *> Référence externe agent                                        *00063
               10       M72L-NOCEAG    PIC S9(7) PACKED-DECIMAL.        *00063
      *> Code externe programme                                         *00067
               10       M72L-CDSGPR    PIC X(8).                        *00067
      *>                                                                M52DM72L
       >>if AA-A-DB2NOIND not defined                                   M52DM72L
       01               V-M72L.                                         M52DM72L
               10       V-M72L-COCXBQ  PIC S9(4) COMP-5.                M52DM72L
               10       V-M72L-IDDIEP  PIC S9(4) COMP-5.                M52DM72L
               10       V-M72L-NSM5CY  PIC S9(4) COMP-5.                M52DM72L
               10       V-M72L-NSM5ET  PIC S9(4) COMP-5.                M52DM72L
               10       V-M72L-CDM5ME  PIC S9(4) COMP-5.                M52DM72L
               10       V-M72L-DDM5MF  PIC S9(4) COMP-5.                M52DM72L
               10       V-M72L-DFM5MF  PIC S9(4) COMP-5.                M52DM72L
               10       V-M72L-NOCEAG  PIC S9(4) COMP-5.                M52DM72L
               10       V-M72L-CDSGPR  PIC S9(4) COMP-5.                M52DM72L
       01               V-M72L-R       REDEFINES V-M72L.                M52DM72L
               10       V-M72L-A       PIC S9(4) COMP-5                 M52DM72L
                                       OCCURS 00009.                    M52DM72L
       >>end-if                                                         M52DM72L
       >>define AA-A-DB2NOIND off                                       M52DM72L
