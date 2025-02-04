      *>****************************************************************BRZDBC05
      *> LINKAGE BRBC05 : Gestion nouv réf. SUPRA                       BRZDBC05
      *>----------------------------------------------------------------BRZDBC05
      *CONTROL NOSOURCE                                                 BRZDBC05
      *> Le sous programme BATCH BRBC05 va effectuer la recherche ou    BRZDBC05
      *> détermination de la référence SIRIS depuis une référence       BRZDBC05
      *> SUPRA et vice versa.                                           BRZDBC05
      *> Utilisation meme en masse car pas d acces db2                  BRZDBC05
      *> Auteur           :  Denis FRANKOWSKI                           BRZDBC05
      *> Date de Création :  26/10/07                                   BRZDBC05
      *> Origine Création :  Création                                   BRZDBC05
      *>                                                                BRZDBC05
      *> Modifié par :       Christian boutin                           BRZDBC05
      *> Modifié le  :       12/02/08                                   BRZDBC05
      *> Motif de Modif. :   ajout code produit en mode RICE            BRZDBC05
      *>                     F78DB et F78HB                             BRZDBC05
      *> Modifié par :       C. Aldebert                                BRZDBC05
      *> Modifié le  :       13/10/08                                   BRZDBC05
      *> Motif de Modif. :   Ajout codes produits gérés en mode RICE    BRZDBC05
      *>                     IPRE, KCHE, N009, N010, N013, N015, PDMT   BRZDBC05
      *> PSVB, PSXP, PTPE, FCBX et FPRI                                 BRZDBC05
      *> + ajout code produit géré en mode Chèque KCHE                  BRZDBC05
      *> Modifié par :       Christian boutin                           BRZDBC05
      *> Modifié le  :       30/01/09                                   BRZDBC05
      *> Motif de Modif. :   ajout code pc00 -                          BRZDBC05
      *>                                                                BRZDBC05
      *> Modifié par :       Ludovic WEDLARSKI                          BRZDBC05
      *> Modifié le  :       15/06/09                                   BRZDBC05
      *> Motif de Modif. :   Ajout prise en compte produit PCSP         BRZDBC05
      *>                     Projet Cash Management                     BRZDBC05
      *> Modifié par :       J MARQUE + F OURIET                        BRZDBC05
      *> Modifié le  :       20/07/09                                   BRZDBC05
      *> Motif de Modif. :   prise en compte du projet carte DC et      BRZDBC05
      *>                     flux externe BDR lot 2                     BRZDBC05
      *> Modifié par :       C Boutin                                   BRZDBC05
      *> Modifié le  :       12/08/10                                   BRZDBC05
      *> Motif de Modif. :   Projet 6367 Nouveaux forfait lot 2.2       BRZDBC05
      *>                     NEW Codipr AEPJ-AEMO-AENO-AEEP-AUMO-AUNO   BRZDBC05
      *>                     AUEP a traiter comme 0027                  BRZDBC05
      *> Modifié par :       L WEDLARSKI                                BRZDBC05
      *> Modifié le  :       20/08/10                                   BRZDBC05
      *> Motif de Modif. :   Projet Flux Externes Lot 3                 BRZDBC05
      *>                     CODIPR PCAU                                BRZDBC05
      *> Modifié par :       C.ROHR                                     BRZDBC05
      *> Modifié le  :       27/01/11                                   BRZDBC05
      *> Motif de Modif. :   Ajout code produit CODIPR = '0088'         BRZDBC05
      *>                     géré en mode RICE (79DB - 79HB)            BRZDBC05
      *>                                                                BRZDBC05
      *> Modifié par :       Erwan THEPAUT                              BRZDBC05
      *> Modifié le  :       10/07/14                                   BRZDBC05
      *> Motif de Modif. :   P16791 V.ME: Ajout CODIPR    = 'VMEP'      BRZDBC05
      *>                     P16800 Logicash : Ajout      = 'LOGI'      BRZDBC05
      *>                     P15559 Espace unique : Ajout = 'UNIK'      BRZDBC05
      *>                     P14821 SEPAMAIL       = 'SRUR' et 'SRUE'   BRZDBC05
      *>                                                                BRZDBC05
      *> Modifié par :       Erwan THEPAUT                              BRZDBC05
      *> Modifié le  :       09/09/14                                   BRZDBC05
      *> Motif de Modif. :   P13792 : MUT CFF REPORTING INTERNE         BRZDBC05
      *>                     Ajout 'POFI'.                              BRZDBC05
      *>                                                                BRZDBC05
      *> Modifié par :       Erwan THEPAUT                              BRZDBC05
      *> Modifié le  :       04/12/14                                   BRZDBC05
      *> Motif de Modif. :   P17468 Assurement 2016 : Gestion distri-   BRZDBC05
      *>                     buteur des assurances NA.                  BRZDBC05
      *>                     Ajout 'NATV' et 'NATP' (P78EX-P78IX)       BRZDBC05
      *>                                                                BRZDBC05
      *> Modifié par :       Erwan THEPAUT                              BRZDBC05
      *> Modifié le  :       19/12/14                                   BRZDBC05
      *> Motif de Modif. :   P17092 fiabilisation OSC V15.05:           BRZDBC05
      *>                     Ajout 'XMON' (P78DB-P78HB).                BRZDBC05
      *>                     Ajout 'XDLZ' (P78DB-P78HB).                BRZDBC05
      *> Modifié par :       Hervé MARTIN                               BRZDBC05
      *> Modifié le  :       06/08/15                                   BRZDBC05
      *> Motif de Modif. :   P18544 IARD PRO : Ajout CODIPR = 'ASPR'    BRZDBC05
      *>                                                                BRZDBC05
      *> Modifié par :       J.BELLON                                   BRZDBC05
      *> Modifié le  :       12/09/16                                   BRZDBC05
      *> Motif de Modif. :   P20462 Domilis V17.01                      BRZDBC05
      *>                     Ajout 'XDOM' (P78DB-P78HB).                BRZDBC05
      *>                                                                BRZDBC05
      *> Modifié par :       Erwan THEPAUT                              BRZDBC05
      *> Modifié le  :       20/10/16                                   BRZDBC05
      *> Motif de Modif. :   Mise à niveau:                             BRZDBC05
      *>                     Ajout 'P002' (P78DB-P78HB).                BRZDBC05
      *>                     Ajout 'OCTA' (P78EX-P78IX).                BRZDBC05
      *>                     Ajout 'ACFF' (P78DB-P78HB).                BRZDBC05
      *>                                                                BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       24/01/17                                   BRZDBC05
      *> Motif de Modif. :   P20923 : MYSYSCOOP                         BRZDBC05
      *>                     Ajout 'ACC1-ACC5'(P79EX-P79IX).            BRZDBC05
      *>                     Ajout 'ACI1' (P78DB-P78HB).                BRZDBC05
      *> Modifié par :       Geneviève Guigue                           BRZDBC05
      *> Modifié le  :       17/05/17                                   BRZDBC05
      *> Motif de Modif. :   projet MySysCoop EPS Synchro               BRZDBC05
      *>                     les EPS de MySysCoop vont avoir un code    BRZDBC05
      *> produit P001 , mais vont avoir un identifiant sur 7 cars.      BRZDBC05
      *> il faudra donc les traiter comme des produits P000.            BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       23/04/18                                   BRZDBC05
      *> Motif de Modif. :   P023537 : Ajout gestion CODIPR FCGA        BRZDBC05
      *>                                                                BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       17/07/18                                   BRZDBC05
      *> Motif de Modif. :   P25341 : ajout codipr = 'FLOA'             BRZDBC05
      *>                     ENT-BAN Location avec Option d'Achat       BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       13/09/18                                   BRZDBC05
      *> Motif de Modif. :   P23537-02 : Gestion CODIPR = 'FLLD'        BRZDBC05
      *>                     P22926-03 : Modif CODIPR = '0029'          BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       22/11/18                                   BRZDBC05
      *> Motif de Modif. :   P25193 : poste de travail en mobilité      BRZDBC05
      *>                     Ajout 'N019' et 'N020'                     BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Auteur           :  Erwan Thepaut                              BRZDBC05
      *> Date de Création :  21/01/19                                   BRZDBC05
      *> Origine Création :  P025193 (Poste de travail en mobilite)     BRZDBC05
      *>                     ajout gestion CODIPR = 'NNPP'              BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       14/02/19                                   BRZDBC05
      *> Motif de Modif. :   P025193-03 : Poste de traval en mobilite   BRZDBC05
      *>                     Ajout (IGSC-N021-N016-IAMI-IAMR            BRZDBC05
      *>                            IAUP-PNUM-NR08-PREM-NAPP)           BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       07/08/19                                   BRZDBC05
      *> Motif de Modif. :   NATIXIS LIFE V20.01.                       BRZDBC05
      *>                     Ajout CODIPR = 'NLVI' comme 'NATV'         BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       10/03/20                                   BRZDBC05
      *> Motif de Modif. :   027162-05 : Mise en place 'DBOX'           BRZDBC05
      *>                                                                BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       09/04/20                                   BRZDBC05
      *> Motif de Modif. :   RITM345483 : Ajout N022 comme N019/20      BRZDBC05
      *>                                                                BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Erwan Thepaut                              BRZDBC05
      *> Modifié le  :       23/04/20                                   BRZDBC05
      *> Motif de Modif. :   Ajout CODIPR = 'PCEC' projet 28388         BRZDBC05
      *>                                                                BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       S.Marshall                                 BRZDBC05
      *> Modifié le  :       16/03/21                                   BRZDBC05
      *> Motif de Modif. :   Ajout des codipr XIZE et XPPG              BRZDBC05
      *>                     en -p78DB et -p78HB                        BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       S.Marshall                                 BRZDBC05
      *> Modifié le  :       17/06/21                                   BRZDBC05
      *> Motif de Modif. :   Ajout du codipr XONE                       BRZDBC05
      *>                     en -p78DB et -p78HB                        BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       Annick Lareau                              BRZDBC05
      *> Modifié le  :       05/08/21                                   BRZDBC05
      *> Motif de Modif. :   Projet INNOV2020 - 24647 : création PJV3   BRZDBC05
      *>                     avec violences Familiales                  BRZDBC05
      *>                     Ajout CODIPR PJV3 en -p78DB et -p78HB__    BRZDBC05
      *> ------------------------------------------------------------   BRZDBC05
      *> Modifié par :       S.Marshall                                 BRZDBC05
      *> Modifié le  :       21/06/22                                   BRZDBC05
      *> Motif de Modif. :   Ajout codipr FLLD en -p78DB                BRZDBC05
      *>                                                                BRZDBC05
      *>----------------------------------------------------------------BRZDBC05
      *> MOT CLES :                                                     BRZDBC05
      *> SUPRA ZB1H                                                     BRZDBC05
      *>----------------------------------------------------------------BRZDBC05
      *CONTROL SOURCE                                                   BRZDBC05
      *> Utilisation :                                                  BRZDBC05
      *> copy BRZDBC05 replacing leading ==BC05== by ==prefix==.        BRZDBC05
      *>****************************************************************BRZDBC05
      *>#GN 18/10/2024 11:37:06 BIB:CTRS.BRC SESSION:5519  USER:MOMA    BRZDBC05
      *>-------------------------------------------------- #SEG:ZB1H ---BRZDBC05
      *> commarea gestion nouv ref SUPRA                                BRZDBC05
       01               BC05.                                           BRZDBC05
      *> code action gestion référence SUPRA                            *00001
               10       BC05-CABRGU    PIC X(2).                        *00001
      *> Code retour Echanges                                           *00003
               10       BC05-WCORE3    PIC 9(3).                        *00003
      *> Code Etab Banque Entité Juridique                              *00006
               10       BC05-COCXBQ    PIC X(5).                        *00006
      *> Code type produit service                                      *00011
               10       BC05-CODIPR    PIC X(4).                        *00011
      *> Référence Produit MYSYS                                        *00015
               10       BC05-IDMZCS    PIC X(27).                       *00015
      *> Code format référence contrat MYSYS                            *00042
               10       BC05-COBRFT    PIC X(2).                        *00042
               10       BC05-FILLER    PIC X(27).                       *00044
      *> Numéro Caisse                                                  *00071
               10       BC05-COCXBB    PIC X(5).                        *00071
      *> Identifiant Contrat                                            *00076
               10       BC05-IDDIEP    PIC X(27).                       *00076
               10       BC05-FILLER    PIC X(28).                       *00103
      *> Longueur de la structure : 00130 octets                        *00130
