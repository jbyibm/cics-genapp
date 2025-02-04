      *>****************************************************************FGFEH590
      *> FICHIER : Sous-total fichier Forbearance                       FGFEH590
      *>----------------------------------------------------------------FGFEH590
      *CONTROL NOSOURCE                                                 FGFEH590
      *> Auteur           :  Eric MAES                                  FGFEH590
      *> Date de Création :  04/02/15                                   FGFEH590
      *> Origine Création :  Projet 017431 - Forbearance                FGFEH590
      *>                                                                FGFEH590
      *> Fichier à destination de Forbearance                           FGFEH590
      *> Partie spécifique - Enregistrement sous-total par crédit       FGFEH590
      *>----------------------------------------------------------------FGFEH590
      *> MOT CLES :                                                     FGFEH590
      *> FORBEARANCE                                                    FGFEH590
      *>----------------------------------------------------------------FGFEH590
      *CONTROL SOURCE                                                   FGFEH590
      *> Utilisation :                                                  FGFEH590
      *> copy FGFEH590 replacing leading ==H590== by ==prefix==.        FGFEH590
      *>****************************************************************FGFEH590
      *> -- 27/05/2024 08:12:51 BIB:FCR SESSION:9171  USER:I990886      FGFEH590
      *>----------------------------------------------------------------FGFEH590
      *> Sous-total fichier Forbearance                                 FGFEH590
       01               H590.                                           FGFEH590
      *> Partie commune segments Forbearance                            *00001
               10       H590-H51C.                                      *00001
      *> Code enregistrement                                            *00001
                11      H590-COFAFB    PIC X(2).                        *00001
      *> Type d'évènement                                               *00003
                11      H590-CTFAFB    PIC X(2).                        *00003
      *> Code Etab Banque Entité Juridique                              *00005
                11      H590-COCXBQ    PIC X(5).                        *00005
      *> IDENTIFIANT CREDIT ELEMENTAIRE                                 *00010
                11      H590-IDCT      PIC X(7).                        *00010
      *> DATE D EFFET (JJMMSSAA)                                        *00017
                11      H590-DTEF      PIC X(8).                        *00017
      *> Date traitement (JJMMSSAA)                                     *00025
                11      H590-DTFAFB    PIC X(8).                        *00025
      *> CODE ORIGINE CREDIT OU DOSSIER                                 *00033
                11      H590-CDFAOR    PIC X(1).                        *00033
      *> Nombre d'enregistrements                                       *00034
               10       H590-QCFAFB    PIC 9(7).                        *00034
               10       H590-FILLER    PIC X(460).                      *00041
      *> Longueur de la structure : 00500 octets                        *00500
