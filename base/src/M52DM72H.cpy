      *>****************************************************************M52DM72H
      *> TABLE DB2 M72H : Complément Motif concession Contrat           M52DM72H
      *>----------------------------------------------------------------M52DM72H
      *CONTROL NOSOURCE                                                 M52DM72H
      *> Auteur           :  P.Rolland     s3236                        M52DM72H
      *> Date de Création :  17/10/14                                   M52DM72H
      *> Origine Création :  FORBEARANCE 017431                         M52DM72H
      *>                                                                M52DM72H
      *> Modifié par :       Nicole TURCO                               M52DM72H
      *> Modifié le  :       10/12/14                                   M52DM72H
      *> Motif de Modif. :   Forbearance 017431 : ajout de rubriques    M52DM72H
      *>                     vario (NOMKDO-IDMKCE-CDMKTQ-CEMKPA...)     M52DM72H
      *> Modifié par :       Nicole TURCO                               M52DM72H
      *> Modifié le  :       26/01/15                                   M52DM72H
      *> Motif de Modif. :   Forbearance 017431 : ajout de rubriques    M52DM72H
      *>                     VARIO(CDMKFA)- NAFI (CTFMEN - IDFMSM -     M52DM72H
      *>                     IDMHIN)-SYNCHRO (CDFARE-CTM5TT-CDM5MC-     M52DM72H
      *>                     LIM5MC)                                    M52DM72H
      *> Segment de description de la table M72H                        M52DM72H
      *>                                                                M52DM72H
      *> Cette table contient pour chaque motif d'intervention lié à    M52DM72H
      *> une concession un complément d'information.                    M52DM72H
      *> Les données complémentaires sont liées aux remettants :        M52DM72H
      *>   - type de concession (avenant,refinancement)                 M52DM72H
      *>   - origine de la concession (Synchro, Nafi, Vario)            M52DM72H
      *>----------------------------------------------------------------M52DM72H
      *> MOT CLES :                                                     M52DM72H
      *>                                                                M52DM72H
      *>----------------------------------------------------------------M52DM72H
      *CONTROL SOURCE                                                   M52DM72H
      *> Utilisation :                                                  M52DM72H
      *> copy M52DM72H replacing leading ==M72H== by ==prefix==         M52DM72H
      *>                         leading ==V-M72H== by ==V-prefix==.    M52DM72H
      *>****************************************************************M52DM72H
      *> -- 16/04/2024 18:14:24 BIB:M5B SESSION:9419  USER:USER         M52DM72H
      *>----------------------------------------------------------------M52DM72H
      *> Complément Motif concession Contrat                            M52DM72H
       01               M72H.                                           M52DM72H
      *> Code Etab Banque Entité Juridique                              *00001
               10       M72H-COCXBQ    PIC X(5).                        *00001
      *> Idt motif intervention Forbearance                             *00006
               10       M72H-NSM5FO    PIC S9(11) PACKED-DECIMAL.       *00006
      *> Type concession                                                *00012
               10       M72H-CTM5CS    PIC X(1).                        *00012
      *> Code origine concession                                        *00013
               10       M72H-CMM5CS    PIC X(1).                        *00013
      *> Numéro dossier contentieux                                     *00014
               10       M72H-NOMKDO    PIC S9(7) PACKED-DECIMAL.        *00014
      *> Identifiant créance CTX                                        *00018
               10       M72H-IDMKCE    PIC X(12).                       *00018
      *> Code type plan recouvrement                                    *00030
               10       M72H-CDMKTQ    PIC X.                           *00030
      *> Code état plan apurement                                       *00031
               10       M72H-CEMKPA    PIC X.                           *00031
      *> Code déchéance terme                                           *00032
               10       M72H-COMEDT    PIC X.                           *00032
      *> CODE INDICATEUR PLAN NEIERTZ                                   *00033
               10       M72H-CIMKNE    PIC X.                           *00033
      *> Code famille dossier                                           *00034
               10       M72H-CDMKFA    PIC X(2).                        *00034
      *> Code réaménagement                                             *00036
               10       M72H-CDFARE    PIC X.                           *00036
      *> Code aiguillage traitement synchro                             *00037
               10       M72H-CTM5TT    PIC XX.                          *00037
      *> Code motif Concession Synchro                                  *00039
               10       M72H-CDM5MC    PIC XX.                          *00039
      *> Libellé Motif concession                                       *00041
               10       M72H-LIM5MC    PIC X(30).                       *00041
      *> Type évènement CRE crédit CEFI                                 *00071
               10       M72H-CTFMEN    PIC X(2).                        *00071
      *> Identifiant contrat CEFI                                       *00073
               10       M72H-IDFMSM    PIC X(27).                       *00073
      *> Identifiant incident                                           *00100
               10       M72H-IDMIIN    PIC X(25).                       *00100
      *> TS création élément (TIMESTAMP)                                *00125
               10       M72H-HDEHET    PIC X(26).                       *00125
      *>                                                                M52DM72H
       >>if AA-A-DB2NOIND not defined                                   M52DM72H
       01               V-M72H.                                         M52DM72H
               10       V-M72H-COCXBQ  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-NSM5FO  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CTM5CS  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CMM5CS  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-NOMKDO  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-IDMKCE  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CDMKTQ  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CEMKPA  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-COMEDT  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CIMKNE  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CDMKFA  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CDFARE  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CTM5TT  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CDM5MC  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-LIM5MC  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-CTFMEN  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-IDFMSM  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-IDMIIN  PIC S9(4) COMP-5.                M52DM72H
               10       V-M72H-HDEHET  PIC S9(4) COMP-5.                M52DM72H
       01               V-M72H-R       REDEFINES V-M72H.                M52DM72H
               10       V-M72H-A       PIC S9(4) COMP-5                 M52DM72H
                                       OCCURS 00019.                    M52DM72H
       >>end-if                                                         M52DM72H
       >>define AA-A-DB2NOIND off                                       M52DM72H
