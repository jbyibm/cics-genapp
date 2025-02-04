      *>****************************************************************M52DM72R
      *> TABLE DB2 M72R : Détail opérations Fiche                       M52DM72R
      *>----------------------------------------------------------------M52DM72R
      *CONTROL NOSOURCE                                                 M52DM72R
      *> Auteur           :  Muriel DI GIANNI                           M52DM72R
      *> Date de Création :  11/08/22                                   M52DM72R
      *> Origine Création :  31984 refonte qualification forbearance    M52DM72R
      *>                                                                M52DM72R
      *>                                                                M52DM72R
      *> Segment de description de la table M72R.                       M52DM72R
      *>                                                                M52DM72R
      *> Table permettant d'enregistrer le détail d'une opération       M52DM72R
      *> d'une fiche Forbearance.                                       M52DM72R
      *> Une opération est associée à une ou plusieurs mesures.         M52DM72R
      *> Une opération est liée à plusieurs contrats en cas de          M52DM72R
      *> regroupement de crédits.                                       M52DM72R
      *>----------------------------------------------------------------M52DM72R
      *> MOT CLES :                                                     M52DM72R
      *>                                                                M52DM72R
      *>----------------------------------------------------------------M52DM72R
      *CONTROL SOURCE                                                   M52DM72R
      *> Utilisation :                                                  M52DM72R
      *> copy M52DM72R replacing leading ==M72R== by ==prefix==         M52DM72R
      *>                         leading ==V-M72R== by ==V-prefix==.    M52DM72R
      *>****************************************************************M52DM72R
      *> -- 16/04/2024 18:14:41 BIB:M5B SESSION:9419  USER:USER         M52DM72R
      *>----------------------------------------------------------------M52DM72R
      *> Détail Opération Fiche Forbearance                             M52DM72R
       01               M72R.                                           M52DM72R
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72R-COCXBQ    PIC X(5).                        *00001
      *> Identifiant personne                                           *00006
               10       M72R-NODAPE    PIC S9(9) PACKED-DECIMAL.        *00006
      *> TS création enregistrement (TIMESTAMP)                         *00011
               10       M72R-HDEHEG    PIC X(26).                       *00011
      *> Code statut fiche                                              *00037
               10       M72R-CEM5SF    PIC X(3).                        *00037
      *> Numéro opération statut fiche                                  *00040
               10       M72R-NSM5OP    PIC S9(3) PACKED-DECIMAL.        *00040
      *> Type détail opération                                          *00042
               10       M72R-CTM5DO    PIC X(2).                        *00042
      *> Valeur détail opération                                        *00044
               10       M72R-LVM5DO    PIC X(50).                       *00044
      *>                                                                M52DM72R
       >>if AA-A-DB2NOIND not defined                                   M52DM72R
       01               V-M72R.                                         M52DM72R
               10       V-M72R-COCXBQ  PIC S9(4) COMP-5.                M52DM72R
               10       V-M72R-NODAPE  PIC S9(4) COMP-5.                M52DM72R
               10       V-M72R-HDEHEG  PIC S9(4) COMP-5.                M52DM72R
               10       V-M72R-CEM5SF  PIC S9(4) COMP-5.                M52DM72R
               10       V-M72R-NSM5OP  PIC S9(4) COMP-5.                M52DM72R
               10       V-M72R-CTM5DO  PIC S9(4) COMP-5.                M52DM72R
               10       V-M72R-LVM5DO  PIC S9(4) COMP-5.                M52DM72R
       01               V-M72R-R       REDEFINES V-M72R.                M52DM72R
               10       V-M72R-A       PIC S9(4) COMP-5                 M52DM72R
                                       OCCURS 00007.                    M52DM72R
       >>end-if                                                         M52DM72R
       >>define AA-A-DB2NOIND off                                       M52DM72R
