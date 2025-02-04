      *>****************************************************************M52DM72M
      *> TABLE DB2 M72M : Histo Viabilité Forbearance                   M52DM72M
      *>----------------------------------------------------------------M52DM72M
      *CONTROL NOSOURCE                                                 M52DM72M
      *> Auteur           :  P.Lafitte                                  M52DM72M
      *> Date de Création :  08/10/20                                   M52DM72M
      *> Origine Création :  Projet Nouveau Defaut : 026818             M52DM72M
      *>                                                                M52DM72M
      *>                                                                M52DM72M
      *> Segment de description de la table M72M.                       M52DM72M
      *>                                                                M52DM72M
      *> Table historique permettant d'enregistrer les changements de   M52DM72M
      *> statut de chaque forbearance. Elle est initialisée avec le     M52DM72M
      *> dernier numéro de cycle de chaque forbearance et par défaut    M52DM72M
      *> la viabilité sera mise à oui.                                  M52DM72M
      *>                                                                M52DM72M
      *> Par l'IHM, un agent peut décider qu'une forbearance n'est      M52DM72M
      *> plus viable et en ce cas, il sera obligé de compléter un       M52DM72M
      *> champ commentaire pour justifier le changement de statut.      M52DM72M
      *> La date son identifiant seront automatiquement complétés.      M52DM72M
      *> Le nombre de forbearances passant à non viable devrait être    M52DM72M
      *> faible, et parmi celles-ci celles repassant à viables le       M52DM72M
      *> seront en très faible nombre.                                  M52DM72M
      *> Aucune purge n'est prévue à ce jour.                           M52DM72M
      *>                                                                M52DM72M
      *> Modifié par :       BOISTOT                                    M52DM72M
      *> Modifié le  :       21/05/21                                   M52DM72M
      *> Motif de Modif. :   Complétion du -gc avec les éléments        M52DM72M
      *>                     fournis par Philippe LAFITTE               M52DM72M
      *>----------------------------------------------------------------M52DM72M
      *> MOT CLES :                                                     M52DM72M
      *>                                                                M52DM72M
      *>----------------------------------------------------------------M52DM72M
      *CONTROL SOURCE                                                   M52DM72M
      *> Utilisation :                                                  M52DM72M
      *> copy M52DM72M replacing leading ==M72M== by ==prefix==         M52DM72M
      *>                         leading ==V-M72M== by ==V-prefix==.    M52DM72M
      *>****************************************************************M52DM72M
      *> -- 16/04/2024 18:14:31 BIB:M5B SESSION:9419  USER:USER         M52DM72M
      *>----------------------------------------------------------------M52DM72M
      *> Histo Viabilité Forbearance                                    M52DM72M
       01               M72M.                                           M52DM72M
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72M-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       M72M-IDDIEP    PIC X(27).                       *00006
      *> Num cycle Forbearance                                          *00033
               10       M72M-NSM5CY    PIC S9(7) PACKED-DECIMAL.        *00033
      *> Indicateur statut viabilité                                    *00037
               10       M72M-CIM5VI    PIC X(1).                        *00037
      *> Date début statut viabilité (SSAA-MM-JJ)                       *00038
               10       M72M-DDM5VI    PIC X(10).                       *00038
      *> Date de fin statut viabilité (SSAA-MM-JJ)                      *00048
               10       M72M-DFM5VI    PIC X(10).                       *00048
      *> Date dernière mise à jour viabilité (SSAA-MM-JJ)               *00058
               10       M72M-DLM5VI    PIC X(10).                       *00058
      *> Commentaire viabilité IHM                                      *00068
               10       M72M-LRM5VI    PIC X(254).                      *00068
      *> Référence externe agent                                        *00322
               10       M72M-NOCEAG    PIC S9(7) PACKED-DECIMAL.        *00322
      *> Code externe programme                                         *00326
               10       M72M-CDSGPR    PIC X(8).                        *00326
      *>                                                                M52DM72M
       >>if AA-A-DB2NOIND not defined                                   M52DM72M
       01               V-M72M.                                         M52DM72M
               10       V-M72M-COCXBQ  PIC S9(4) COMP-5.                M52DM72M
               10       V-M72M-IDDIEP  PIC S9(4) COMP-5.                M52DM72M
               10       V-M72M-NSM5CY  PIC S9(4) COMP-5.                M52DM72M
               10       V-M72M-CIM5VI  PIC S9(4) COMP-5.                M52DM72M
               10       V-M72M-DDM5VI  PIC S9(4) COMP-5.                M52DM72M
               10       V-M72M-DFM5VI  PIC S9(4) COMP-5.                M52DM72M
               10       V-M72M-DLM5VI  PIC S9(4) COMP-5.                M52DM72M
               10       V-M72M-LRM5VI  PIC S9(4) COMP-5.                M52DM72M
               10       V-M72M-NOCEAG  PIC S9(4) COMP-5.                M52DM72M
               10       V-M72M-CDSGPR  PIC S9(4) COMP-5.                M52DM72M
       01               V-M72M-R       REDEFINES V-M72M.                M52DM72M
               10       V-M72M-A       PIC S9(4) COMP-5                 M52DM72M
                                       OCCURS 00010.                    M52DM72M
       >>end-if                                                         M52DM72M
       >>define AA-A-DB2NOIND off                                       M52DM72M
