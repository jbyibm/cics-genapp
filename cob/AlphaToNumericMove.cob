       IDENTIFICATION DIVISION.
       PROGRAM-ID. ALPHANUMTEST.
      *****************************************************************
      * Test program for AlphaToNumericMoveRule                       *
      * Tests various scenarios of alphanumeric to numeric moves      *
      *****************************************************************

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Basic field definitions
       01 ALPHA-FIELD          PIC X(10).
       01 NUMERIC-FIELD        PIC 9(10).
       01 SIGNED-NUMERIC       PIC S9(5) COMP-3.
       01 EDITED-NUMERIC       PIC Z,ZZZ,ZZ9.99.
       01 ALPHA-NUMERIC-FIELD  PIC A(20).

      * Group items
       01 GROUP-ITEM.
          05 GROUP-ALPHA       PIC X(5).
          05 GROUP-NUM         PIC 9(5).

      * Nested group items
       01 OUTER-GROUP.
          05 INNER-GROUP.
             10 INNER-ALPHA    PIC X(3).
             10 INNER-NUM      PIC 9(3).
          05 OUTER-NUM         PIC 9(4).

      * Group item whose sub-fields are all numeric
       01 ALL-NUMERIC-GROUP.
          05 NUM-SUB-1         PIC 9(4).
          05 NUM-SUB-2         PIC 9(4).

      * Group target field for group-to-group tests
       01 TARGET-GROUP.
          05 TARGET-ALPHA      PIC X(5).
          05 TARGET-NUM        PIC 9(5).

      * REDEFINES scenarios
       01 ORIGINAL-FIELD       PIC X(10).
       01 REDEFINED-NUM REDEFINES ORIGINAL-FIELD
                               PIC 9(10).

      * External input fields
       01 INPUT-FIELD          PIC X(10).
       01 FILE-FIELD           PIC X(10).

      * Computational fields
       01 COMP-FIELD           PIC 9(5) COMP.
       01 COMP3-FIELD          PIC 9(7) COMP-3.
       01 BINARY-FIELD         PIC 9(4) BINARY.

      * LENGTH OF test target fields
       01 LEN-RESULT-NUM       PIC 9(4) COMP.
       01 LEN-RESULT-ALPHA     PIC X(4).
       01 SHORT-NUM            PIC 9(3).
       01 LONG-ALPHA           PIC X(50).

      * Condition names
       01 STATUS-CODE          PIC X(2).
          88 VALID-STATUS                       VALUE '00'.

       PROCEDURE DIVISION.

      * Test 1: Basic alphanumeric to numeric (SHOULD FLAG)
           MOVE ALPHA-FIELD TO NUMERIC-FIELD.

      * Test 2: String literal to numeric (SHOULD FLAG)
           MOVE 'ABC123' TO NUMERIC-FIELD.

      * Test 3: Numeric literal to numeric (SHOULD NOT FLAG)
           MOVE '12345' TO NUMERIC-FIELD.

      * Test 4: Group item to numeric (SHOULD FLAG)
           MOVE GROUP-ITEM TO NUMERIC-FIELD.

      * Test 5: Numeric-edited to pure numeric (SHOULD FLAG)
           MOVE EDITED-NUMERIC TO NUMERIC-FIELD.

      * Test 6: Numeric to numeric (SHOULD NOT FLAG)
           MOVE COMP-FIELD TO NUMERIC-FIELD.

      * Test 7: Multiple targets (SHOULD FLAG)
           MOVE ALPHA-FIELD TO NUMERIC-FIELD COMP-FIELD.

      * Test 8: REDEFINES scenario (SHOULD FLAG)
           MOVE 'ABCDEFGHIJ' TO ORIGINAL-FIELD.
           MOVE REDEFINED-NUM TO NUMERIC-FIELD.

      * Test 9: With IS NUMERIC validation (SHOULD NOT FLAG)
           IF INPUT-FIELD IS NUMERIC
              MOVE INPUT-FIELD TO NUMERIC-FIELD
           END-IF.

      * Test 10: Without validation (SHOULD FLAG)
           MOVE INPUT-FIELD TO NUMERIC-FIELD.


      * Test 11: Arithmetic with alphanumeric (SHOULD FLAG)
           COMPUTE NUMERIC-FIELD = ALPHA-FIELD + 10.

      * Test 12: ADD with alphanumeric (SHOULD FLAG)
           ADD ALPHA-FIELD TO NUMERIC-FIELD.

      * Test 13: SUBTRACT with alphanumeric (SHOULD FLAG)
           SUBTRACT ALPHA-FIELD FROM NUMERIC-FIELD.

      * Test 14: MULTIPLY with alphanumeric (SHOULD FLAG)
           MULTIPLY NUMERIC-FIELD BY ALPHA-FIELD.

      * Test 15: DIVIDE with alphanumeric (SHOULD FLAG)
           DIVIDE ALPHA-FIELD INTO NUMERIC-FIELD.

      * Test 16: External input without validation (SHOULD FLAG)
           ACCEPT INPUT-FIELD FROM CONSOLE.
           MOVE INPUT-FIELD TO NUMERIC-FIELD.

      * Test 17: COMP-3 to COMP (SHOULD NOT FLAG)
           MOVE COMP3-FIELD TO COMP-FIELD.

      * Test 18: Alphanumeric to numeric with length difference (SHOULD FLAG)
      * This is flagged for TYPE conversion (X to 9), not length mismatch
           MOVE ALPHA-FIELD TO COMP-FIELD.

      * Test 19: Alphanumeric with validated content (SHOULD NOT FLAG)
           IF ALPHA-FIELD IS NUMERIC
              COMPUTE COMP-FIELD = ALPHA-FIELD * 2
           END-IF.

      * Test 20: Special registers (SHOULD FLAG)
           MOVE SPACES TO NUMERIC-FIELD.

      * -------------------------------------------------------
      * LENGTH OF special register tests
      * -------------------------------------------------------

      * Test 31: MOVE LENGTH OF numeric field to numeric (SHOULD NOT FLAG)
      * LENGTH OF returns a numeric integer value
           MOVE LENGTH OF NUMERIC-FIELD TO LEN-RESULT-NUM.

      * Test 32: MOVE LENGTH OF alphanumeric field to numeric (SHOULD NOT FLAG)
      * LENGTH OF is always numeric regardless of the source field type
           MOVE LENGTH OF ALPHA-FIELD TO LEN-RESULT-NUM.

      * Test 33: MOVE LENGTH OF group item to numeric (SHOULD NOT FLAG)
      * LENGTH OF a group item is still a numeric integer
           MOVE LENGTH OF GROUP-ITEM TO LEN-RESULT-NUM.

      * Test 34: MOVE LENGTH OF field to alphanumeric target (SHOULD NOT FLAG)
      * Destination is X, source is numeric integer — no alpha-to-numeric move
           MOVE LENGTH OF NUMERIC-FIELD TO LEN-RESULT-ALPHA.

      * Test 35: MOVE LENGTH OF short field to numeric (SHOULD NOT FLAG)
           MOVE LENGTH OF SHORT-NUM TO LEN-RESULT-NUM.

      * Test 36: MOVE LENGTH OF long alphanumeric to numeric (SHOULD NOT FLAG)
           MOVE LENGTH OF LONG-ALPHA TO LEN-RESULT-NUM.

      * -------------------------------------------------------
      * Additional group move tests
      * -------------------------------------------------------

      * Test 21: Move nested sub-group (mixed X/9) to numeric (SHOULD FLAG)
           MOVE INNER-GROUP TO NUMERIC-FIELD.

      * Test 22: Move outer group (mixed X/9) to numeric (SHOULD FLAG)
           MOVE OUTER-GROUP TO NUMERIC-FIELD.

      * Test 23: Move all-numeric group to numeric (SHOULD FLAG)
      * A group item has no PICTURE of its own and is treated as
      * alphanumeric at the group level, so the rule should still flag it.
           MOVE ALL-NUMERIC-GROUP TO NUMERIC-FIELD.

      * Test 24: Move group to group (SHOULD NOT FLAG)
      * Both sides are group items — no numeric destination at the
      * elementary level; this move is legal and must not be flagged.
           MOVE GROUP-ITEM TO TARGET-GROUP.

      * Test 25: Move group sub-item (alphanumeric) to numeric (SHOULD FLAG)
           MOVE GROUP-ALPHA TO NUMERIC-FIELD.

      * Test 26: Move group sub-item (numeric) to numeric (SHOULD NOT FLAG)
           MOVE GROUP-NUM TO NUMERIC-FIELD.

      * Test 27: Move group to signed numeric (SHOULD FLAG)
           MOVE GROUP-ITEM TO SIGNED-NUMERIC.

      * Test 28: Move group to COMP field (SHOULD FLAG)
           MOVE GROUP-ITEM TO COMP-FIELD.

      * Test 29: Move nested INNER-GROUP to COMP-3 field (SHOULD FLAG)
           MOVE INNER-GROUP TO COMP3-FIELD.

      * Test 30: Move OUTER-NUM (pure numeric sub-item) to numeric (SHOULD NOT FLAG)
           MOVE OUTER-NUM TO NUMERIC-FIELD.

           STOP RUN.

      *> Made with Bob