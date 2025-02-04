      *>****************************************************************M5VES194
      *> WORKING : Q POST Etape Concession Forbearance                  M5VES194
      *>----------------------------------------------------------------M5VES194
      *CONTROL NOSOURCE                                                 M5VES194
      *> Auteur           :  Muriel DI GIANNI                           M5VES194
      *> Date de Création :  03/10/23                                   M5VES194
      *> Origine Création :  PR005967 Forbearance PROF                  M5VES194
      *>                                                                M5VES194
      *> Cette question permet de créer une forbearance manuelle        M5VES194
      *> CASETR = C Création                                            M5VES194
      *>----------------------------------------------------------------M5VES194
      *> MOT CLES :                                                     M5VES194
      *> QST M-5 QM5S194 M175S00 M5QS                                   M5VES194
      *>----------------------------------------------------------------M5VES194
      *CONTROL SOURCE                                                   M5VES194
      *> Utilisation :                                                  M5VES194
      *> copy M5VES194 replacing leading ==S194== by ==prefix==.        M5VES194
      *>****************************************************************M5VES194
      *>#GN 17/07/2024 09:07:12 BIB:CTRS.M5B SESSION:9584  USER:USER    M5VES194
      *>--- CODE=WLNQR6 ---------------------------------- #SEG:S100 ---M5VES194
      *> QR Partie commune niveau Application                           M5VES194
       01               S100.                                           M5VES194
      *> QR ADT Standard Inter-Domaine                                  *00001
               10       S100-SA00.                                      *00001
      *> QR Longueur Segment Question/Réponse                           *00001
                11      S100-WLGQR     PIC 9(4)                         *00001
                                       VALUE ZERO.                      *00001
      *> LONGUEUR FLUX                                                  *00001
                11      S100-XZ3LNG    REDEFINES S100-WLGQR             *00001
                                       PIC 9(4).                        *00001
      *> QR Code Segment Question/Réponse                               *00005
                11      S100-WLNQR.                                     *00005
      *> QR Type de Segment ECHANGES                                    *00005
                 12     S100-CTSEQR    PIC X                            *00005
                                       VALUE SPACE.                     *00005
      *> QR Code Structure Question/Réponse                             *00006
                 12     S100-WLNQR6    PIC X(6)                         *00006
                                       VALUE SPACE.                     *00006
      *> QR Nature d'un Segment ECHANGES                                *00012
                 12     S100-CNSEQR    PIC X                            *00012
                                       VALUE SPACE.                     *00012
      *> CODE STRUCTURE DONNEES                                         *00005
                11      S100-XZ3SGE    REDEFINES S100-WLNQR             *00005
                                       PIC X(8).                        *00005
      *> Longueur de la structure : 00012 octets                        *00012
      *>--- ID='M5S194' ---------------------------------- #SEG:S194 ---M5VES194
      *> Q POST Etape Concession Forbearance                            M5VES194
       01               S194.                                           M5VES194
      *> Code action                                                    *00001
               10       S194-CASETR    PIC X                            *00001
                                       VALUE SPACE.                     *00001
      *> Code Etab Banque Entité Juridique                              *00002
               10       S194-COCXBQ    PIC X(5)                         *00002
                                       VALUE SPACE.                     *00002
      *> Identifiant Contrat                                            *00007
               10       S194-IDDIEP    PIC X(27)                        *00007
                                       VALUE SPACE.                     *00007
      *> Code statut PE/NPE contrat                                     *00034
               10       S194-CEM5CT    PIC X(3)                         *00034
                                       VALUE SPACE.                     *00034
      *> Type concession                                                *00037
               10       S194-CTM5CS    PIC X(1)                         *00037
                                       VALUE SPACE.                     *00037
      *> libellé motif intervention Forb                                *00038
               10       S194-LDM5FO    PIC X(64)                        *00038
                                       VALUE SPACE.                     *00038
      *> Lib origine motif intervention                                 *00102
               10       S194-LDM5OM    PIC X(30)                        *00102
                                       VALUE SPACE.                     *00102
      *> Lib référence piste audit                                      *00132
               10       S194-LIM5PA    PIC X(30)                        *00132
                                       VALUE SPACE.                     *00132
      *> Date effet interv Forb (SSAAMMJJ)                              *00162
               10       S194-DDM5FO    PIC X(8)                         *00162
                                       VALUE SPACE.                     *00162
      *> Décision Forbearance opération                                 *00170
               10       S194-CRM5FB    PIC X(1)                         *00170
                                       VALUE SPACE.                     *00170
      *> Indic evt défaut RAD forbearance                               *00171
               10       S194-CIM5DF    PIC X(1)                         *00171
                                       VALUE SPACE.                     *00171
      *> Commentaire IHM                                                *00172
               10       S194-LRM5CO    PIC X(254)                       *00172
                                       VALUE SPACE.                     *00172
      *> Date décision refus (SSAAMMJJ)                                 *00426
               10       S194-DGM5RF    PIC X(8)                         *00426
                                       VALUE SPACE.                     *00426
      *> Commentaire refus                                              *00434
               10       S194-LRM5RF    PIC X(200)                       *00434
                                       VALUE SPACE.                     *00434
      *> Date première échéance (SSAAMMJJ)                              *00634
               10       S194-DHM5PE    PIC X(8)                         *00634
                                       VALUE SPACE.                     *00634
      *> Indic note défaut fin de mois                                  *00642
               10       S194-CIM5W5    PIC X(1)                         *00642
                                       VALUE SPACE.                     *00642
      *> Type opérateur                                                 *00643
               10       S194-CTM5OP    PIC X(2)                         *00643
                                       VALUE SPACE.                     *00643
      *> Référence externe agent                                        *00645
               10       S194-NOCEAG    PIC 9(7)                         *00645
                                       VALUE ZERO.                      *00645
      *> Code Produit National                                          *00652
               10       S194-COEGPX    PIC X(6)                         *00652
                                       VALUE SPACE.                     *00652
      *> Code origine concession                                        *00658
               10       S194-CMM5CS    PIC X(1)                         *00658
                                       VALUE SPACE.                     *00658
      *> Longueur de la structure : 00658 octets                        *00658
