       IDENTIFICATION DIVISION.
       PROGRAM-ID. WHERE.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-EMP-ID PIC 9(5).
       01 WS-EMP-NAME PIC X(20).
       01 WS-EMP-SALARY PIC 9(7)V99.
       EXEC SQL INCLUDE SQLCA END-EXEC.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Executing SQL Operations".
           EXEC SQL
               SELECT EMP_ID, EMP_NAME, EMP_SALARY
               INTO :WS-EMP-ID, :WS-EMP-NAME, :WS-EMP-SALARY
               FROM EMPLOYEE
               WHERE  EMP_ID=1
           END-EXEC.
           DISPLAY "Employee ID: " WS-EMP-ID.
           DISPLAY "Employee Name: " WS-EMP-NAME.
           DISPLAY "Employee Salary: " WS-EMP-SALARY.
           EXEC SQL
               DELETE FROM EMPLOYEE
           END-EXEC.
           DISPLAY "Deleted Employee with ID 1002".
           EXEC SQL
               UPDATE EMPLOYEE
               SET EMP_SALARY = EMP_SALARY + 500
               WHERE  EMP_ID=1
           END-EXEC.
           DISPLAY "Updated Salary for Employee with ID 1003".
           STOP RUN.