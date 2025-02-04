      *>****************************************************************M52DM72D
      *> TABLE DB2 M72D : Cycle Forbearance Contrat                     M52DM72D
      *>----------------------------------------------------------------M52DM72D
      *CONTROL NOSOURCE                                                 M52DM72D
      *> Auteur           :  P.Rolland     s3236                        M52DM72D
      *> Date de Création :  17/10/14                                   M52DM72D
      *> Origine Création :  FORBEARANCE 017431                         M52DM72D
      *>                                                                M52DM72D
      *> Segment de description de la table M72D                        M52DM72D
      *>                                                                M52DM72D
      *> Cette table contient tous les cycles des contrats qui ont      M52DM72D
      *> eu sur les 5 dernières années un statut Forbearance.           M52DM72D
      *> Pour chaque contrat concerné, un cycle est créé pour           M52DM72D
      *> chaque période où il a été en forbearance  avec une date       M52DM72D
      *> d'entrée et une date de sortie du cycle forbearance.           M52DM72D
      *> Les évènements déclencheurs de l'entrée dans un cycle sont :   M52DM72D
      *>      - le client bénéficie d'une concession (avenant ou        M52DM72D
      *>             refinancement sur un contrat à son avantage)       M52DM72D
      *>        ET                                                      M52DM72D
      *>      - le client a eu des difficultés financières dans les     M52DM72D
      *>         3 mois qui précèdent la concession (note sensible,     M52DM72D
      *>         impayé > 30 j, dépassement autorisation de découvert   M52DM72D
      *>         > 60j, présence watchlist, ..).                        M52DM72D
      *>      OU                                                        M52DM72D
      *>      - une décision de la Direction des Risques                M52DM72D
      *> ************************************************************   M52DM72D
      *> Modifié par :       Laurent FERNANDEZ                          M52DM72D
      *> Modifié le  :       22/05/19                                   M52DM72D
      *> Motif de Modif. :   Projet 026818 Nouveau Défaut Lot 2         M52DM72D
      *>                     GECOCH P25577 - PSI 5506 - V19.11          M52DM72D
      *>                     Ajout de nouvelles rubriques :             M52DM72D
      *>                     - CEM5DF Code défaut Forbearance           M52DM72D
      *>                     - DGM5RF Date décision refus               M52DM72D
      *>                     - LRM5RF Commentaire refus                 M52DM72D
      *>                     - DHM5PE Date première échéance            M52DM72D
      *>----------------------------------------------------------------M52DM72D
      *> MOT CLES :                                                     M52DM72D
      *>                                                                M52DM72D
      *>----------------------------------------------------------------M52DM72D
      *CONTROL SOURCE                                                   M52DM72D
      *> Utilisation :                                                  M52DM72D
      *> copy M52DM72D replacing leading ==M72D== by ==prefix==         M52DM72D
      *>                         leading ==V-M72D== by ==V-prefix==.    M52DM72D
      *>****************************************************************M52DM72D
      *> -- 16/04/2024 18:14:17 BIB:M5B SESSION:9419  USER:USER         M52DM72D
      *>----------------------------------------------------------------M52DM72D
      *> Cycle Forbearance Contrat                                      M52DM72D
       01               M72D.                                           M52DM72D
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72D-COCXBQ    PIC X(5).                        *00001
      *> Identifiant Contrat                                            *00006
               10       M72D-IDDIEP    PIC X(27).                       *00006
      *> Num cycle Forbearance                                          *00033
               10       M72D-NSM5CY    PIC S9(7) PACKED-DECIMAL.        *00033
      *> Référence produit / service                                    *00037
               10       M72D-CODIRF    PIC X(11).                       *00037
      *> Code Guichet Interbancaire                                     *00048
               10       M72D-COCXGU    PIC X(5).                        *00048
      *> Code type produit service                                      *00053
               10       M72D-CODIPR    PIC X(4).                        *00053
      *> Date effet entrée cycle Forb (SSAA-MM-JJ)                      *00057
               10       M72D-DDM5CF    PIC X(10).                       *00057
      *> Date effet sortie cycle Forb (SSAA-MM-JJ)                      *00067
               10       M72D-DFM5CF    PIC X(10).                       *00067
      *> Date arrêté entrée cycle Forb (SSAA-MM-JJ)                     *00077
               10       M72D-DAM5EF    PIC X(10).                       *00077
      *> Date arrêté sortie cycle Forb (SSAA-MM-JJ)                     *00087
               10       M72D-DAM5SF    PIC X(10).                       *00087
      *> Code Produit National                                          *00097
               10       M72D-COEGPX    PIC X(6).                        *00097
      *> Date trait entrée cycle Forb (SSAA-MM-JJ)                      *00103
               10       M72D-DTM5EF    PIC X(10).                       *00103
      *> Date trait sortie cycle Forb (SSAA-MM-JJ)                      *00113
               10       M72D-DTM5SF    PIC X(10).                       *00113
      *> TS création élément (TIMESTAMP)                                *00123
               10       M72D-HDEHET    PIC X(26).                       *00123
      *> TS maj élément (TIMESTAMP)                                     *00149
               10       M72D-HMEHET    PIC X(26).                       *00149
      *> Code défaut Forbearance                                        *00175
               10       M72D-CEM5DF    PIC XX.                          *00175
      *> Date décision refus (SSAA-MM-JJ)                               *00177
               10       M72D-DGM5RF    PIC X(10).                       *00177
      *> Commentaire refus                                              *00187
               10       M72D-LRM5RF    PIC X(200).                      *00187
      *> Date première échéance (SSAA-MM-JJ)                            *00387
               10       M72D-DHM5PE    PIC X(10).                       *00387
      *>                                                                M52DM72D
       >>if AA-A-DB2NOIND not defined                                   M52DM72D
       01               V-M72D.                                         M52DM72D
               10       V-M72D-COCXBQ  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-IDDIEP  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-NSM5CY  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-CODIRF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-COCXGU  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-CODIPR  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-DDM5CF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-DFM5CF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-DAM5EF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-DAM5SF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-COEGPX  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-DTM5EF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-DTM5SF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-HDEHET  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-HMEHET  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-CEM5DF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-DGM5RF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-LRM5RF  PIC S9(4) COMP-5.                M52DM72D
               10       V-M72D-DHM5PE  PIC S9(4) COMP-5.                M52DM72D
       01               V-M72D-R       REDEFINES V-M72D.                M52DM72D
               10       V-M72D-A       PIC S9(4) COMP-5                 M52DM72D
                                       OCCURS 00019.                    M52DM72D
       >>end-if                                                         M52DM72D
       >>define AA-A-DB2NOIND off                                       M52DM72D
