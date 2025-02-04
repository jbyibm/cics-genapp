      *>****************************************************************M52DM79H
      *> TABLE DB2 M79H : Paramétrage délai probation                   M52DM79H
      *>----------------------------------------------------------------M52DM79H
      *CONTROL NOSOURCE                                                 M52DM79H
      *> Auteur           :  Nicole TURCO                               M52DM79H
      *> Date de Création :  13/11/14                                   M52DM79H
      *> Origine Création :  Projet 017431 : forbearance NPE            M52DM79H
      *>                                                                M52DM79H
      *>                                                                M52DM79H
      *> Segment de description de la table M79H.                       M52DM79H
      *>                                                                M52DM79H
      *> Cette table permet de paramétrer le délai de probation         M52DM79H
      *> d'un statut forbearance.                                       M52DM79H
      *>----------------------------------------------------------------M52DM79H
      *> MOT CLES :                                                     M52DM79H
      *>                                                                M52DM79H
      *>----------------------------------------------------------------M52DM79H
      *CONTROL SOURCE                                                   M52DM79H
      *> Utilisation :                                                  M52DM79H
      *> copy M52DM79H replacing leading ==M79H== by ==prefix==         M52DM79H
      *>                         leading ==V-M79H== by ==V-prefix==.    M52DM79H
      *>****************************************************************M52DM79H
      *> -- 16/04/2024 18:14:52 BIB:M5B SESSION:9419  USER:USER         M52DM79H
      *>----------------------------------------------------------------M52DM79H
      *> Param délai probation forbearance                              M52DM79H
       01               M79H.                                           M52DM79H
      *> Code statut Forbearance                                        *00001
               10       M79H-CEM5TF    PIC X(1).                        *00001
      *> Code surv étape Forbearance                                    *00002
               10       M79H-CEM5ET    PIC X(4).                        *00002
      *> Code statut PE/NPE contrat                                     *00006
               10       M79H-CEM5CT    PIC X(3).                        *00006
      *> Délai probation forbearance (mois)                             *00009
               10       M79H-PMM5PF    PIC S9(3) PACKED-DECIMAL.        *00009
      *> Date début validité (SSAA-MM-JJ)                               *00011
               10       M79H-DDEHVA    PIC X(10).                       *00011
      *> Date fin validité (SSAA-MM-JJ)                                 *00021
               10       M79H-DFEHVA    PIC X(10).                       *00021
      *>                                                                M52DM79H
       >>if AA-A-DB2NOIND not defined                                   M52DM79H
       01               V-M79H.                                         M52DM79H
               10       V-M79H-CEM5TF  PIC S9(4) COMP-5.                M52DM79H
               10       V-M79H-CEM5ET  PIC S9(4) COMP-5.                M52DM79H
               10       V-M79H-CEM5CT  PIC S9(4) COMP-5.                M52DM79H
               10       V-M79H-PMM5PF  PIC S9(4) COMP-5.                M52DM79H
               10       V-M79H-DDEHVA  PIC S9(4) COMP-5.                M52DM79H
               10       V-M79H-DFEHVA  PIC S9(4) COMP-5.                M52DM79H
       01               V-M79H-R       REDEFINES V-M79H.                M52DM79H
               10       V-M79H-A       PIC S9(4) COMP-5                 M52DM79H
                                       OCCURS 00006.                    M52DM79H
       >>end-if                                                         M52DM79H
       >>define AA-A-DB2NOIND off                                       M52DM79H
