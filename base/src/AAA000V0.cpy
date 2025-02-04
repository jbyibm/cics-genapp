       >>define AA-A-VSAM as b'1' override                              AAA000V0
      *> File status Fichier                                            AAA000V0
       01               1-:DD:00-STATUS VALUE '00'.                     AAA000V0
                    88  1-:DD:00-STATUS-OK-VERIF  VALUE '97'.           AAA000V0
           10                            PIC X(1).                      AAA000V0
                    88  1-:DD:00-STATUS-OK        VALUE '0'.            AAA000V0
                    88  1-:DD:00-STATUS-EOF       VALUE '1'.            AAA000V0
                    88  1-:DD:00-STATUS-ERR-KEY   VALUE '2'.            AAA000V0
                    88  1-:DD:00-STATUS-ERR-PERM  VALUE '3'.            AAA000V0
                    88  1-:DD:00-STATUS-ERR-LOGIC VALUE '4'.            AAA000V0
                    88  1-:DD:00-STATUS-ERR-IMPL  VALUE '9'.            AAA000V0
           10                            PIC X(1).                      AAA000V0
