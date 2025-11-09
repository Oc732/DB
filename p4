Title:

Unnamed PL/SQL code block: Use of Control structure and Exception handling is mandatory. Write a PL/SQL
block of code for the following requirements:- Schema:
1. Borrower(Roll_no, Name, DOI, NameofBook, Status)
2. Fine(Roll_no, sDate, Amt)
 Accept roll_no & name of book from user
 Check the number of days (from date of issue), if days are between 15 to 30 then fine will be
Rs 5per day.  If no. of days>30, per day fine will be Rs 50 per day & for days less than 30, Rs. 5 per day
 After submitting the book, status will change from I to R.  If the condition of fine is true, then details will be stored into a fine table.

Solution:

mysql> create database Prac4;
Query OK, 1 row affected (0.01 sec)
mysql> use Prac4;
Database changed
mysql> CREATE TABLE IF NOT EXISTS Borrower (
-> Roll_no INT,
-> Name VARCHAR(100),
-> DOI DATE,
-> NameofBook VARCHAR(100),
-> Status CHAR(1)
-> );
Query OK, 0 rows affected (0.03 sec)
mysql>
mysql> CREATE TABLE IF NOT EXISTS Fine (
-> Roll_no INT,
-> sDate DATE,
-> Amt DECIMAL(10,2)
-> );
Query OK, 0 rows affected (0.01 sec)
mysql> select *from Borrower;
Empty set (0.01 sec)
mysql> INSERT INTO Borrower (Roll_no, Name, DOI, NameofBook, Status)
-> VALUES (101, 'Alice', '2025-08-20', 'Learn SQL', 'I');
Query OK, 1 row affected (0.00 sec)

mysql>
mysql> INSERT INTO Borrower (Roll_no, Name, DOI, NameofBook, Status)
-> VALUES (102, 'Bob', '2025-09-01', 'Database Systems', 'I');
Query OK, 1 row affected (0.00 sec)
mysql> select *from Borrower;
+---------+-------+------------+------------------+--------+
| Roll_no | Name | DOI | NameofBook | Status |
+---------+-------+------------+------------------+--------+
| 101 | Alice | 2025-08-20 | Learn SQL | I |
| 102 | Bob | 2025-09-01 | Database Systems | I |
+---------+-------+------------+------------------+--------+
2 rows in set (0.00 sec)
mysql> DROP PROCEDURE IF EXISTS p_fine;
Query OK, 0 rows affected, 1 warning (0.01 sec)
mysql>
mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE p_fine(IN rno INT, IN bname VARCHAR(20))
-> BEGIN
-> DECLARE d1 DATE;
-> DECLARE daycnt INT;
-> DECLARE fine_amt INT;
->
-> SELECT DOI INTO d1
-> FROM Borrower
-> WHERE Roll_no = rno AND NameofBook = bname
-> LIMIT 1;
->
-> SELECT DATEDIFF(NOW(), d1) INTO daycnt;
->
-> IF (daycnt >= 15 AND daycnt <= 30) THEN
-> SET fine_amt = daycnt * 5;
-> INSERT INTO Fine(Roll_no, sDate, Amt) VALUES (rno, NOW(), fine_amt);
-> UPDATE Borrower SET Status = 'R' WHERE Roll_no = rno;
-> ELSEIF (daycnt > 30) THEN
-> SET fine_amt = daycnt * 50;
-> INSERT INTO Fine(Roll_no, sDate, Amt) VALUES (rno, NOW(), fine_amt);
-> UPDATE Borrower SET Status = 'R' WHERE Roll_no = rno;
-> ELSE
-> UPDATE Borrower SET Status = 'R' WHERE Roll_no = rno;
-> END IF;
-> END;
-> //
Query OK, 0 rows affected (0.00 sec)
mysql>

mysql> DELIMITER ;
mysql> call p_fine(101,"Learn SQL");
Query OK, 1 row affected (0.01 sec)
mysql> select *from Borrower;
+---------+-------+------------+------------------+--------+
| Roll_no | Name | DOI | NameofBook | Status |
+---------+-------+------------+------------------+--------+
| 101 | Alice | 2025-08-20 | Learn SQL | R |
| 102 | Bob | 2025-09-01 | Database Systems | I |
+---------+-------+------------+------------------+--------+
2 rows in set (0.00 sec)
mysql> select *from Fine;
+---------+------------+--------+
| Roll_no | sDate | Amt |
+---------+------------+--------+
| 101 | 2025-09-11 | 110.00 |
+---------+------------+--------+
1 row in set (0.00 sec)
