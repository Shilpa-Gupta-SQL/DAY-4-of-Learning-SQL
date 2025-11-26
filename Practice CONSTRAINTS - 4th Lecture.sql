-- REAL-WORLD SQL INTERVIEW PRACTICE QUESTIONS

-- SECTION 1: CONSTRAINTS (UNIQUE, CHECK, PRIMARY KEY)

-- Q1: Create a table with UNIQUE email and test inserting duplicate emails.
USE school;
CREATE TABLE Teachers (
Teacher_ID INT PRIMARY KEY AUTO_INCREMENT,
Teacher_name VARCHAR (80),
Teacher_email VARCHAR (100) ,
Teacher_Address VARCHAR (200),
Teacher_salary INT 
);

ALTER TABLE Teachers
MODIFY Teacher_email VARCHAR (100) UNIQUE;

-- Q2: Add a CHECK constraint on salary > 20000 and test invalid inserts.
ALTER TABLE  Teachers
MODIFY Teacher_salary INT CHECK (Teacher_salary > 20000);

INSERT INTO Teachers 
VALUES ('101','SHILPA','shilpa@gmail.com','DELHI','10000'),
('102','SHREESHA','shreesha@gmail.com','DELHI','22000'),
('103','SHREYA','shreya@gmail.com','DELHI','26000'),
('104','TARALI','tarali@gmail.com','DELHI','30000'),
('105','VYOM','vyom@gmail.com','DELHI','28000');

-- Q3: Try updating a row to violate CHECK and observe result.
UPDATE Teachers
SET Teacher_salary = 5000
WHERE Teacher_id = 105;

-- Q4: Create table with AUTO_INCREMENT + UNIQUE column. Insert duplicates and see behavior.
Create TABLE Subjects (
Subject_id INT AUTO_INCREMENT UNIQUE,
Subject_name VARCHAR (50)
);

INSERT INTO Subjects 
VALUES ('101','Physics'),
('101','Science');

-- SECTION 2: DDL COMMANDS (CREATE, ALTER, DROP, TRUNCATE, RENAME)

-- Q5: Create a table and alter multiple columns (add, modify, drop).
CREATE TABLE Department(
Department_ID INT,
Department_name VARCHAR (100),
Department_block VARCHAR (10)
);

ALTER TABLE Department
ADD Department_Address VARCHAR (90);

ALTER TABLE Department
MODIFY Department_name VARCHAR (200) UNIQUE;

ALTER TABLE Department
DROP column Department_block ;

DROP TABLE Department;

SELECT * FROM Departments;

-- Q6: Rename a table and verify if data remains intact.
RENAME TABLE Teachers to Indian_Teachers;
SELECT * FROM Indian_Teachers;

-- Q7: TRUNCATE a table and check auto_increment behavior.
DESCRIBE Indian_Teachers;
TRUNCATE TABLE Indian_Teachers;

-- Q8: Practice DROP TABLE IF EXISTS safely.
DROP TABLE IF EXISTS Subjects
;
-- SECTION 3: SHOW, USE, DATABASE CONTEXT

-- Q9: Switch between databases using USE and verify using SELECT DATABASE().
USE schooldb;
SELECT DATABASE ();

USE school;
SELECT DATABASE ();

-- Q10: Create 2 tables and list them using SHOW TABLES.
CREATE TABLE Department(
Department_ID INT,
Department_name VARCHAR (100),
Department_block VARCHAR (10)
);
Create TABLE Subjects (
Subject_id INT AUTO_INCREMENT UNIQUE,
Subject_name VARCHAR (50)
);

SHOW TABLES;

-- Q11: Display all available databases.
SHOW DATABASES;

-- SECTION 4: DELETE vs TRUNCATE

-- Q12: Insert rows, delete them with DELETE, and insert again. Check ID sequence.
INSERT INTO Subjects 
VALUES ('101','Physics'),
('102','Science');

DELETE FROM Subjects
WHERE Subject_ID = 101;

INSERT INTO Subjects 
VALUES ('101','Physics'),
('103','Science');

-- Q13: TRUNCATE the table and insert again. Compare ID reset behavior.
SELECT * FROM Subjects;

TRUNCATE TABLE Subjects;

INSERT INTO Subjects 
VALUES ('101','Physics'),
('103','Science');

-- Q14: Try TRUNCATE on a table with foreign keys and observe errors.
USE schooldb;

SELECT * FROM EMPLOYEES;
SELECT * FROM ORDERS;
SELECT * FROM Products;
SELECT * FROM Students;
ALTER TABLE Orders
ADD student_id INT;

ALTER TABLE Orders
ADD CONSTRAINT Student_d_fk
FOREIGN KEY Orders (student_id) REFERENCES Students (student_id);

TRUNCATE TABLE Orders;
DESCRIBE Orders;

-- SECTION 5: ALTER TABLE HANDS-ON

-- Q15: Add NOT NULL column to table with existing data. Try inserting NULL.
ALTER TABLE Students
ADD Behavioral_marks INT NOT NULL;

INSERT INTO Students(Behavioral_marks)
VALUES (NULL);

-- Q16: Change VARCHAR column to INT and observe failures on bad data.
ALTER TABLE Orders
MODIFY customer_name INT;

INSERT INTO Orders(customer_name)
VALUES ('DISHA');

-- Q17: Rename a column and query using old name to see error.
ALTER TABLE Orders
RENAME Column customer_name to Customers;

SELECT customer_name FROM Orders;

-- SECTION 6: REAL SCENARIO QUESTIONS

-- Q18: A table was created in wrong database. Recreate it correctly.
CREATE TABLE NASA LIKE Indian_Teachers;
CREATE TABLE NASA AS 
SELECT * FROM Indian_Teachers; -------------------------------------------------- error

-- Q19: Wrong datatype used for a column. Fix using ALTER.
ALTER TABLE orders
MODIFY Customers VARCHAR (70);

-- Q20: Accidentally dropped table. Explain recovery strategy.
------------------------------------------------------------------------------  error
-- Q21: Delete only data (not structure) using correct command.
TRUNCATE TABLE Orders;

-- Q22: Add CHECK constraint to existing table and test bad inserts.
DESCRIBE Employees;
ALTER TABLE Employees
MODIFY salary INT CHECK (salary > 30000);

INSERT INTO Employees
VALUES (109, 'meli', 'IT', 20000, 36, 'Surat');

/*------------------------------------------Q1. Create a table named students with these columns:
sid → INT, PRIMARY KEY, AUTO_INCREMENT
sname → VARCHAR(50), NOT NULL
semail → VARCHAR(50), UNIQUE
sage → INT, with CHECK (sage > 5)
*/
CREATE DATABASE School; 
USE school;   

CREATE TABLE students (
sid INT PRIMARY KEY AUTO_INCREMENT,
sname VARCHAR (50) NOT NULL,
semail VARCHAR (50) UNIQUE,
sage INT CHECK (sage > 5)
);

/* Can you write an SQL query to insert three new student records into the students table?
Each record should include the student’s name, email, and age.
Make sure at least one of the students has a NULL value for the email column.”
*/
INSERT INTO students (sname, semail, sage)                
VALUES ('TARALI', 'tarali@gmail.com', '55' ),
('SHILPA', 'shilpa@gmail.com', '14' ),
('RIYA', 'NULL','34' );

# Mistakes in your query:---------------
#Column names should NOT be inside quotes (' ')
#Age values should NOT be inside quotes (numbers don’t need quotes)

# -- “In your table, how would you update the email address of the student whose sid is 2?
UPDATE students 
SET semail = 'torali@gmail.com'
WHERE sid = 2;

#  “If you want to remove a specific student record from the students table — for example, the student whose sid is 3
DELETE FROM students
WHERE sid = 3;

# “Suppose your manager asks you to display all the records stored inside the students table.
SELECT * FROM students;
-- END OF QUESTIONS
