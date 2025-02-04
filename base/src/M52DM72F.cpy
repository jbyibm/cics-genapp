      *>****************************************************************M52DM72F
      *> TABLE DB2 M72F : Motif Intervention Forbearance                M52DM72F
      *>----------------------------------------------------------------M52DM72F
      *CONTROL NOSOURCE                                                 M52DM72F
      *> Auteur           :  P.Rolland     s3236                        M52DM72F
      *> Date de Création :  17/10/14                                   M52DM72F
      *> Origine Création :  FORBEARANCE 017431                         M52DM72F
      *>                                                                M52DM72F
      *> Modifié par :       Nicole TURCO                               M52DM72F
      *> Modifié le  :       10/12/14                                   M52DM72F
      *> Motif de Modif. :   Forbearance 017431 : Ajout rubriques       M52DM72F
      *>                     LDM5OM et LIM5OP                           M52DM72F
      *> Segment de description de la table M72F                        M52DM72F
      *>                                                                M52DM72F
      *> Cette table contient pour chaque étape d'un cycle de for-      M52DM72F
      *> bearance, les motifs qui sont intervenus depuis l'entrée       M52DM72F
      *> dans l'étape jusqu'à sa sortie.                                M52DM72F
      *> Chaque motif d'intervention est caractérisé par                M52DM72F
      *>     - un code motif intervention (impayé, note, avenant, à     M52DM72F
      *>          dire d'expert, fin de période probatoire, ...)        M52DM72F
      *>     - un type intervention (entrée étape, validation étape,    M52DM72F
      *>          refus étape, annulation étape, sortie forbearance)    M52DM72F
      *>     - un type opérateur (moteur de calcul, IHM, reprise)       M52DM72F
      *>     - une date effet de l'intervention                         M52DM72F
      *> Des données complémentaires associées à ce quadruplet          M52DM72F
      *> sont également stockées (commentaire IHM, code agent, ...)     M52DM72F
      *>----------------------------------------------------------------M52DM72F
      *> MOT CLES :                                                     M52DM72F
      *>                                                                M52DM72F
      *>----------------------------------------------------------------M52DM72F
      *CONTROL SOURCE                                                   M52DM72F
      *> Utilisation :                                                  M52DM72F
      *> copy M52DM72F replacing leading ==M72F== by ==prefix==         M52DM72F
      *>                         leading ==V-M72F== by ==V-prefix==.    M52DM72F
      *>****************************************************************M52DM72F
      *> -- 16/04/2024 18:14:21 BIB:M5B SESSION:9419  USER:USER         M52DM72F
      *>----------------------------------------------------------------M52DM72F
      *> Motif Intervention Forbearance                                 M52DM72F
       01               M72F.                                           M52DM72F
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72F-COCXBQ    PIC X(5).                        *00001
      *> Idt motif intervention Forbearance                             *00006
               10       M72F-NSM5FO    PIC S9(11) PACKED-DECIMAL.       *00006
      *> Code origine motif intervention                                *00012
               10       M72F-CMM5MI    PIC X(4).                        *00012
      *> Identifiant Contrat                                            *00016
               10       M72F-IDDIEP    PIC X(27).                       *00016
      *> Num cycle Forbearance                                          *00043
               10       M72F-NSM5CY    PIC S9(7) PACKED-DECIMAL.        *00043
      *> Num étape dans cycle Forb                                      *00047
               10       M72F-NSM5ET    PIC S9(7) PACKED-DECIMAL.        *00047
      *> Code motif interv Forb                                         *00051
               10       M72F-CMM5FO    PIC X(3).                        *00051
      *> Type intervention Forb                                         *00054
               10       M72F-CTM5FO    PIC X(2).                        *00054
      *> Type opérateur                                                 *00056
               10       M72F-CTM5OP    PIC X(2).                        *00056
      *> Date effet interv Forb (SSAA-MM-JJ)                            *00058
               10       M72F-DDM5FO    PIC X(10).                       *00058
      *> Date arrêté du motif (SSAA-MM-JJ)                              *00068
               10       M72F-DAM5MO    PIC X(10).                       *00068
      *> Commentaire IHM                                                *00078
               10       M72F-LRM5CO    PIC X(254).                      *00078
      *> Lib origine motif intervention                                 *00332
               10       M72F-LDM5OM    PIC X(30).                       *00332
      *> Lib référence piste audit                                      *00362
               10       M72F-LIM5PA    PIC X(30).                       *00362
      *> Référence externe agent                                        *00392
               10       M72F-NOCEAG    PIC S9(7) PACKED-DECIMAL.        *00392
      *> Idt trace IHM intervention                                     *00396
               10       M72F-NSM5TF    PIC S9(11) PACKED-DECIMAL.       *00396
      *> Code programme origine                                         *00402
               10       M72F-IDMRPO    PIC X(8).                        *00402
      *> Date traitement OPC création motif (SSAA-MM-JJ)                *00410
               10       M72F-DTM5CM    PIC X(10).                       *00410
      *> TS création élément (TIMESTAMP)                                *00420
               10       M72F-HDEHET    PIC X(26).                       *00420
      *>                                                                M52DM72F
       >>if AA-A-DB2NOIND not defined                                   M52DM72F
       01               V-M72F.                                         M52DM72F
               10       V-M72F-COCXBQ  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-NSM5FO  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-CMM5MI  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-IDDIEP  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-NSM5CY  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-NSM5ET  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-CMM5FO  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-CTM5FO  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-CTM5OP  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-DDM5FO  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-DAM5MO  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-LRM5CO  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-LDM5OM  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-LIM5PA  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-NOCEAG  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-NSM5TF  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-IDMRPO  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-DTM5CM  PIC S9(4) COMP-5.                M52DM72F
               10       V-M72F-HDEHET  PIC S9(4) COMP-5.                M52DM72F
       01               V-M72F-R       REDEFINES V-M72F.                M52DM72F
               10       V-M72F-A       PIC S9(4) COMP-5                 M52DM72F
                                       OCCURS 00019.                    M52DM72F
       >>end-if                                                         M52DM72F
       >>define AA-A-DB2NOIND off                                       M52DM72F
