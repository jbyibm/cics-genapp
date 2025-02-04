      ******************************************************************M3ZDIN90
      * ZONE COMMUNICATION : SSP tranco.des référentiel                 M3ZDIN90
      *-----------------------------------------------------------------M3ZDIN90
      *CONTROL NOSOURCE                                                 M3ZDIN90
      * Auteur           :  Nadine PAGE                                 M3ZDIN90
      * Date de Création :  01/09/09                                    M3ZDIN90
      * Origine Création :  Projet 3470 Integration Bale 2 SI NOC       M3ZDIN90
      *                     Interpreteur GCE >> BCP                     M3ZDIN90
      * Ce sous-programme                                               M3ZDIN90
      * transcodifie des données des fichiers CONTRAT, CLIENT,          M3ZDIN90
      *            LIENS DIRIGEANT / ENTREPRISE.                        M3ZDIN90
      *                                                                 M3ZDIN90
      * Modifié par :       S.Bousquet-Vergely                          M3ZDIN90
      * Modifié le  :       26/04/10                                    M3ZDIN90
      * Motif de Modif. :   Modif acces MX7H et MX7C pour transco       M3ZDIN90
      *                     des garanties                               M3ZDIN90
      * Version V200 !!                                                 M3ZDIN90
      * Modifié par :       S.Bousquet-VERGELY                          M3ZDIN90
      * Modifié le  :       15/06/10                                    M3ZDIN90
      * Motif de Modif. :   Ajout Accès MX7U pour top eligibilite       M3ZDIN90
      *                     d'une garantie                              M3ZDIN90
      *                                                                 M3ZDIN90
      * Modifié par :       APSIDE (EL)                                 M3ZDIN90
      * Modifié le  :       02/08/10                                    M3ZDIN90
      * Motif de Modif. :   Ajout de la rubrique CDM3PM (code           M3ZDIN90
      *                     produit Mac Donough) de la table MX7B.      M3ZDIN90
      * Modifié par :       Jérôme ARNAUD                               M3ZDIN90
      * Modifié le  :       25/01/11                                    M3ZDIN90
      * Motif de Modif. :   Reprise des fonctionalités IDS -_RECO 58    M3ZDIN90
      *                     Ajout MX7A, MX7Z                            M3ZDIN90
      *                     Modif MX7B, MX7C, MX7H                      M3ZDIN90
      * Modifié par :       Julien Gay                                  M3ZDIN90
      * Modifié le  :       14/11/12                                    M3ZDIN90
      * Motif de Modif. :   Projet 11202 : evolution moteur V11         M3ZDIN90
      *                     Ajout table MX72                            M3ZDIN90
      * Modifié par :       Julien SOULIER                              M3ZDIN90
      * Modifié le  :       18/02/13                                    M3ZDIN90
      * Motif de Modif. :   Projet 13836 : Evol. notation NIE V10       M3ZDIN90
      *                     Modification MX7A - Ajout CDM3VA            M3ZDIN90
      * Récupération de CDM3VA en MX7A et alimentation ZC90-CDM3VA.     M3ZDIN90
      * Modifié par :       CANO H.                                     M3ZDIN90
      * Modifié le  :       09/04/13                                    M3ZDIN90
      * Motif de Modif. :   Projet 13428: Evolution rubrique QTSDAN.    M3ZDIN90
      *                     Cette rubrique sera alimentée par un nb     M3ZDIN90
      *                     de mois (au lieu d'un nb d'année)           M3ZDIN90
      * Afin de palier aux limitations de la macro de calcul de date    M3ZDIN90
      * SCALDA20 (nb mois ajoute max = 240 et 1900 > date > 2100),      M3ZDIN90
      * le calcul de date de revalo :                                   M3ZDIN90
      * WW00-DATGAR = IM13-DMFGVG + MX7U-QTSDAN                         M3ZDIN90
      * est effectué en décomposant le nb mois à ajouter comme suit:    M3ZDIN90
      * MX7U-QTSDAN / 12 = nb ANNEE + nb MOIS (RESTE de la DIVISION)    M3ZDIN90
      * On ajoute d'abord manuellement le nb annee à DMFGVG             M3ZDIN90
      * puis le nb de mois (reste de la DIVISION) en utilisant          M3ZDIN90
      * SCALDA20                                                        M3ZDIN90
      * IMPOSSIBILITE DE FAIRE AUTREMENT CAR PAS DE MACRO DISPO/!\      M3ZDIN90
      * Les dates < 1900 ou > 2100 sont traitées séparément             M3ZDIN90
      * Modifié par :       CANO H                                      M3ZDIN90
      * Modifié le  :       05/06/13                                    M3ZDIN90
      * Motif de Modif. :   INC1100656 : Correction incident            M3ZDIN90
      *                     appel sous pro SCALDA20                     M3ZDIN90
      * Les dates < 1900 ou > date arrêtée (et non plus 2100) ne        M3ZDIN90
      * seront pas traitées par le sous pro SCALDA20                    M3ZDIN90
      * Modifié par :       Julien Gay                                  M3ZDIN90
      * Modifié le  :       18/02/14                                    M3ZDIN90
      * Motif de Modif. :   Projet 13799 : PMUT CFF                     M3ZDIN90
      *                     Ajout des indicateurs dans la table MX7B    M3ZDIN90
      * des codes produits : CIM3PR, CIM3I3, CIM3R1 et CIM3BA.          M3ZDIN90
      *                                                                 M3ZDIN90
      * Modifié par :       P.Rolland   s3803                           M3ZDIN90
      * Modifié le  :       05/01/15                                    M3ZDIN90
      * Motif de Modif. :   Forbearance éligibilité : ajout récup       M3ZDIN90
      *                     indic éligibilité MX7B-CIM5PT en P77BC      M3ZDIN90
      *                     et P95BB.                                   M3ZDIN90
      *                                                                 M3ZDIN90
      * Modifié par :       O.HALLE                                     M3ZDIN90
      * Modifié le  :       01/12/15                                    M3ZDIN90
      * Motif de Modif. :   projet 018374-02 demontage accès MX7I       M3ZDIN90
      *                     l'appel M3IN90 pour accès MX7I est non      M3ZDIN90
      * utilisé                                                         M3ZDIN90
      * demontage en: -cd (II), -cp (macro AJDB20 ligne70),             M3ZDIN90
      * -p77II à -p77IM, -P95II                                         M3ZDIN90
      * Modifié par :       Emmanuel Dietrich                           M3ZDIN90
      * Modifié le  :       14/06/16                                    M3ZDIN90
      * Motif de Modif. :   18374-4 AQR Garantie Lot 4                  M3ZDIN90
      *                     Suppression accès table MX7A (CNMBGA)       M3ZDIN90
      *-----------------------------------------------------------------M3ZDIN90
      * MOT CLES :                                                      M3ZDIN90
      * NOC ITB2BPCE V100 INTERPRETEUR FORBEARANCE                      M3ZDIN90
      *-----------------------------------------------------------------M3ZDIN90
      *CONTROL SOURCE                                                   M3ZDIN90
      * Utilisation :                                                   M3ZDIN90
      * COPY M3ZDIN90 REPLACING LEADING ==IN90== BY ==prefix==.         M3ZDIN90
      ******************************************************************M3ZDIN90
      *-- 22/02/2023 13:57:48 BIB: M3C SESSION:       USER: J070188     M3ZDIN90
      *-----------------------------------------------------------------M3ZDIN90
      * Segment commarea M3IN90                                         M3ZDIN90
       01               IN90.                                           M3ZDIN90
      * Code retour Echanges                                            *00001
               10       IN90-WCORE3    PIC 9(3).                        *00001
      * CLE LIBELLE D'ERREUR  R7                                        *00004
               10       IN90-COM3AN    PIC X(17).                       *00004
      * Code Retour DB2              SQLCODE                            *00021
               10       IN90-VCSQLC    PIC S9(9) BINARY.                *00021
      * Nom Table DB2                                                   *00025
               10       IN90-WTABLE    PIC X(10).                       *00025
      * Nom du programme appelant                                       *00035
               10       IN90-WPROGA    PIC X(8).                        *00035
      * Nom du sous-programme appelé                                    *00043
               10       IN90-WPROGS    PIC X(8).                        *00043
      * Version de la livraison SSP                                     *00051
               10       IN90-LIM3VE    PIC X(13).                       *00051
      * Libellé anomalie                                                *00064
               10       IN90-LLM3AN    PIC X(100).                      *00064
      * Code Fonction/Sous-Fonction PACBASE                             *00164
               10       IN90-COM3FC    PIC X(4).                        *00164
      * Code ident. de la donnée référentiel                            *00168
               10       IN90-CDM3RE    PIC X(6).                        *00168
      * Sens de la transcodification                                    *00174
               10       IN90-CWM3TR    PIC X(6).                        *00174
      * Code Produit Service                                            *00180
               10       IN90-COEGPS    PIC X(6).                        *00180
      * Code produit groupe BPCE                                        *00186
               10       IN90-CDM3PR    PIC X(5).                        *00186
      * Code objet prêt                                                 *00191
               10       IN90-CDFCNI    PIC X(3).                        *00191
      * Code objet prêt BPCE                                            *00194
               10       IN90-CDM3NI    PIC X(4).                        *00194
      * Code CSP - Profession                                           *00198
               10       IN90-CODASP    PIC X(4).                        *00198
      * Code catégorie socio-prof BPCE                                  *00202
               10       IN90-COM3AC    PIC X(3).                        *00202
      * Code situation famille                                          *00205
               10       IN90-CODASI    PIC X.                           *00205
      * Code situation famille BPCE                                     *00206
               10       IN90-COM3SI    PIC X.                           *00206
      * Code nature occupation habitat                                  *00207
               10       IN90-CNDENH    PIC X(2).                        *00207
      * Code statut résidentiel BPCE                                    *00209
               10       IN90-CNM3NH    PIC X(1).                        *00209
      * Code catégorie juridique INSEE                                  *00210
               10       IN90-CODACJ    PIC X(4).                        *00210
      * Code catégorie juridique BPCE                                   *00214
               10       IN90-COM3CJ    PIC X(4).                        *00214
      * Code segment Risque Bâle2                                       *00218
               10       IN90-CDMBSR    PIC X(8).                        *00218
      * Code segment Mac Donough client                                 *00226
               10       IN90-CDM3MD    PIC X(4).                        *00226
      * Type garantie GCE                                               *00230
               10       IN90-CTFGGR    PIC X(5).                        *00230
      * Code produit garantie BPCE                                      *00235
               10       IN90-CDM3PD    PIC X(5).                        *00235
      * Code Etab Banque Entité Juridique                               *00240
               10       IN90-COCXBQ    PIC X(5).                        *00240
      * Code application                                                *00245
               10       IN90-CODMAP    PIC X(10).                       *00245
      * Indicateur éligibilité garantie                                 *00255
               10       IN90-CIFGEL    PIC X.                           *00255
      * Indicateur éligibilité garantie                                 *00256
               10       IN90-CIM3EL    PIC X.                           *00256
      * Type liens inter-personnes                                      *00257
               10       IN90-CTM3LI    PIC X(3).                        *00257
      * Type liens inter-personnes BPCE                                 *00260
               10       IN90-CTM3LB    PIC X(2).                        *00260
      * Numéro SIREN professionnel                                      *00262
               10       IN90-NODASR    PIC X(9).                        *00262
      * Code CARAT du garant                                            *00271
               10       IN90-CDM3CG    PIC X(8).                        *00271
      * Code objet financé - notation                                   *00279
               10       IN90-CGM3NI    PIC X(2).                        *00279
      * Code catégorie segment risque                                   *00281
               10       IN90-COMBSR    PIC X(4).                        *00281
      * Rang garantie                                                   *00285
               10       IN90-NOFGRA    PIC S9(2) PACKED-DECIMAL.        *00285
      * Alphanumérique Banalisée 008                                    *00287
               10       IN90-WX008A    PIC X(8).                        *00287
      * Alphanumérique Banalisée 008                                    *00295
               10       IN90-WX008B    PIC X(8).                        *00295
      * Code produit Mac Donough client                                 *00303
               10       IN90-CDM3PM    PIC X(4).                        *00303
      * Code nature garantie BPCE                                       *00307
               10       IN90-CNMBGA    PIC X(3).                        *00307
      * indicateur Mortgage                                             *00310
               10       IN90-CIMBMG    PIC X.                           *00310
      * Sous classe client                                              *00311
               10       IN90-CDM3SC    PIC X(6).                        *00311
      * Code priorité exposition risque                                 *00317
               10       IN90-CTM3ER    PIC X.                           *00317
      * Code sous-famille produit                                       *00318
               10       IN90-CDM3SF    PIC X(3).                        *00318
      * indicateur revolving                                            *00321
               10       IN90-CIMBRV    PIC X.                           *00321
      * Type objet                                                      *00322
               10       IN90-CIM3OP    PIC X.                           *00322
      * Code dest. autorisé objet MySys                                 *00323
               10       IN90-CDM3FO    PIC X(01).                       *00323
      * Code nature bien financé BPCE                                   *00324
               10       IN90-CDM3F2    PIC X(03).                       *00324
      * Code méthode valorisation garantie                              *00327
               10       IN90-CDM3VA    PIC X(2).                        *00327
      * Indic éligibilité Prêt Principal                                *00329
               10       IN90-CIM3PR    PIC X.                           *00329
      * Indic éligibilité infiné                                        *00330
               10       IN90-CIM3I3    PIC X.                           *00330
      * Indic éligibilité prêt relais                                   *00331
               10       IN90-CIM3R1    PIC X.                           *00331
      * Indic notation IRBA                                             *00332
               10       IN90-CIM3BA    PIC X.                           *00332
      * Indicateur éligibilité produit                                  *00333
               10       IN90-CIM5PT    PIC X(1).                        *00333
               10       IN90-FILLER    PIC X(45).                       *00334
