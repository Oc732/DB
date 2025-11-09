Title:
Named PL/SQL Block: PL/SQL Stored Procedure and Stored Function.Write a Stored
Procedure namely proc_Grade for the categorization of student. If marks scored by
students in examination is <=1500 and marks>=990 then student will be placed in
distinction category if marks scored are between 989 and900 category is first class, if
marks899and 825 category is Higher Second Class.Write a PL/SQLblock to use
procedure created with above requirement. Stud_Marks(Rollno,name, total_marks)
Result(Rollno,Name, Class)

Solution:


mysql> create database p6;
Query OK, 1 row affected (0.11 sec)
mysql> use p6;
Database changed
mysql> CREATE TABLE stud_marks (
-> rollno INT PRIMARY KEY,
-> name VARCHAR(30),
-> marks INT
-> );
Query OK, 0 rows affected (0.42 sec)
mysql> CREATE TABLE Result (
-> rollno INT,
-> name VARCHAR(30),
-> class VARCHAR(30)
-> );
Query OK, 0 rows affected (0.45 sec)
mysql> INSERT INTO stud_marks VALUES
-> (1, 'John', 850),
-> (2, Rus, 1250),
-> (3, 'Alice',1450),
-> (4, 'Bob', 950),
-> (5, 'Steve', 750);
Query OK, 5 rows affected (0.11 sec)
Records: 5 Duplicates: 0 Warnings: 0
mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE proc_Grade()
-> BEGIN
-> DECLARE done INT DEFAULT 0;
->
-> DECLARE s_marks INT;
-> DECLARE s_rollno INT;
-> DECLARE s_name VARCHAR(30);
-> DECLARE s_class VARCHAR(30);
->
-> DECLARE s_student CURSOR FOR
-> SELECT rollno, name, marks FROM stud_marks;

->
-> DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
->
-> OPEN s_student;
->
-> read_loop: LOOP
-> FETCH s_student INTO s_rollno, s_name, s_marks;
->
-> IF done = 1 THEN
-> LEAVE read_loop;
-> END IF;
->
-> IF (s_marks BETWEEN 990 AND 1500) THEN
-> SET s_class = 'Distinction';
-> ELSEIF (s_marks BETWEEN 900 AND 989) THEN
-> SET s_class = 'First Class';
-> ELSEIF (s_marks BETWEEN 825 AND 899) THEN
-> SET s_class = 'Higher Second Class';
-> ELSE
-> SET s_class = 'Pass';
-> END IF;
->
-> INSERT INTO Result(rollno, name, class)
-> VALUES (s_rollno, s_name, s_class);
-> END LOOP;
->
-> CLOSE s_student;
-> END;
-> //
Query OK, 0 rows affected (0.12 sec)
mysql>
mysql> DELIMITER ;
mysql> CALL proc_Grade();
Query OK, 0 rows affected (0.42 sec)
mysql> select *from Result;
+ + + +
| rollno | name | class |
+ + + +
| 1 | John | Higher Second Class |
| 2 | Rus | Distinction |
| 3 | Alice | Distinction |
| 4 | Bob | First Class |
| 5 | Steve | Pass |
+ + + +
5 rows in set (0.00 sec)
mysql> select *from Stud_Marks;
+ + + +
| rollno | name | marks |
+ + + +
| 1 | John | 850 |
| 2 | Rus | 1250 |
| 3 | Alice | 1450 |
| 4 | Bob | 950 |
| 5 | Steve | 750 |
+ + + +
5 rows in set (0.01 sec)
