      *>****************************************************************M52DM72O
      *> TABLE DB2 M72O : Opérations Fiche                              M52DM72O
      *>----------------------------------------------------------------M52DM72O
      *CONTROL NOSOURCE                                                 M52DM72O
      *> Auteur           :  Muriel DI GIANNI                           M52DM72O
      *> Date de Création :  25/08/22                                   M52DM72O
      *> Origine Création :  31984 refonte qualification forbearance    M52DM72O
      *>                                                                M52DM72O
      *>                                                                M52DM72O
      *> Segment de description de la table M72O.                       M52DM72O
      *>                                                                M52DM72O
      *> Table permettant d'enregistrer les caractéristiques            M52DM72O
      *> d'une opération d'une fiche Forbearance                        M52DM72O
      *> Une opération décrit le type de réaménagement envisagé         M52DM72O
      *> sur un contrat éligible à la Forbearance                       M52DM72O
      *> Pour chaque opération, on enregistre les décisions             M52DM72O
      *> de passagfe en Forbearance et en défaut                        M52DM72O
      *>----------------------------------------------------------------M52DM72O
      *> MOT CLES :                                                     M52DM72O
      *>                                                                M52DM72O
      *>----------------------------------------------------------------M52DM72O
      *CONTROL SOURCE                                                   M52DM72O
      *> Utilisation :                                                  M52DM72O
      *> copy M52DM72O replacing leading ==M72O== by ==prefix==         M52DM72O
      *>                         leading ==V-M72O== by ==V-prefix==.    M52DM72O
      *>****************************************************************M52DM72O
      *> -- 16/04/2024 18:14:35 BIB:M5B SESSION:9419  USER:USER         M52DM72O
      *>----------------------------------------------------------------M52DM72O
      *> Opération Fiche Forbearan                                      M52DM72O
       01               M72O.                                           M52DM72O
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72O-COCXBQ    PIC X(5).                        *00001
      *> Identifiant personne                                           *00006
               10       M72O-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00006
      *> TS création enregistrement (TIMESTAMP)                         *00011
               10       M72O-HDEHEG    PIC X(26).                       *00011
      *> Code statut fiche                                              *00037
               10       M72O-CEM5SF    PIC X(3).                        *00037
      *> Numéro opération statut fiche                                  *00040
               10       M72O-NSM5OP    PIC S9(3) PACKED-DECIMAL.        *00040
      *> Identifiant Contrat                                            *00042
               10       M72O-IDDIEP    PIC X(27).                       *00042
      *> Code type opération qualification                              *00069
               10       M72O-CTM5OF    PIC X(2).                        *00069
      *> Code statut questions significatives                           *00071
               10       M72O-CEM5QS    PIC X(1).                        *00071
      *> Code statut exonération test perte                             *00072
               10       M72O-CEM5EX    PIC X(1).                        *00072
      *> Code statut test perte                                         *00073
               10       M72O-CEM5PE    PIC X(1).                        *00073
      *> Décision Forbearance opération                                 *00074
               10       M72O-CRM5FB    PIC X(1).                        *00074
      *> Code décision défaut                                           *00075
               10       M72O-CRM5DF    PIC X(2).                        *00075
      *> Indicateur de traitement                                       *00077
               10       M72O-CIM5TR    PIC X.                           *00077
      *> Description caraq nouveau contrat                              *00078
               10       M72O-LDM5NC    PIC X(50).                       *00078
      *>                                                                M52DM72O
       >>if AA-A-DB2NOIND not defined                                   M52DM72O
       01               V-M72O.                                         M52DM72O
               10       V-M72O-COCXBQ  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-NODAPE  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-HDEHEG  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-CEM5SF  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-NSM5OP  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-IDDIEP  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-CTM5OF  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-CEM5QS  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-CEM5EX  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-CEM5PE  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-CRM5FB  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-CRM5DF  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-CIM5TR  PIC S9(4) COMP-5.                M52DM72O
               10       V-M72O-LDM5NC  PIC S9(4) COMP-5.                M52DM72O
       01               V-M72O-R       REDEFINES V-M72O.                M52DM72O
               10       V-M72O-A       PIC S9(4) COMP-5                 M52DM72O
                                       OCCURS 00014.                    M52DM72O
       >>end-if                                                         M52DM72O
       >>define AA-A-DB2NOIND off                                       M52DM72O
