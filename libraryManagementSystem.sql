CREATE DATABASE IF NOT EXISTS library;
USE library ;

-- Table for books
CREATE TABLE IF NOT EXISTS books (
book_id INT NOT NULL , 
title VARCHAR(500) NOT NULL, 
author VARCHAR(100) NOT NULL, 
description BLOB(1000) NOT NULL, 
catagory_id INT PRIMARY KEY, 
added_by INT NOT NULL, 
added_at_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

-- Table for books catagories

CREATE TABLE IF NOT EXISTS books_categories (
id INT NOT NULL,
category VARCHAR(200) NOT NULL,
FOREIGN KEY (id) REFERENCES books(catagory_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

-- Table for books issue

CREATE TABLE IF NOT EXISTS books_issue(
id INT NOT NULL,
book_issue_id INT NOT NULL,
student_id INT NOT NULL,
issue_by VARCHAR(100) NOT NULL,
issue_at TIME NOT NULL,
return_time TIME NOT NULL,
time_stamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (student_id) REFERENCES students(student_id)
ON delete CASCADE
ON UPDATE CASCADE
);

-- Table for branches

CREATE TABLE IF NOT EXISTS branches(
id INT NOT NULL,
branch VARCHAR(100) NOT NULL
);

-- Table for students

CREATE TABLE IF NOT EXISTS students(
student_id INT NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100),
approved TINYINT NOT NULL DEFAULT 0,
rejected TINYINT NOT NULL DEFAULT 0,
category VARCHAR(200) NOT NULL,
roll_num INT NOT NULL,
branch VARCHAR(100) NOT NULL DEFAULT 'main',
year YEAR NOT NULL DEFAULT 2024,
email_id VARCHAR(100) NOT NULL,
FOREIGN KEY (category) REFERENCES books_categories(category)
ON delete CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (branch) REFERENCES branches(branch)
ON delete CASCADE
ON UPDATE CASCADE
);

-- Table for student_category

CREATE TABLE IF NOT EXISTS student_category(
cat_id INT NOT NULL,
category VARCHAR(100) NOT NULL,
max_allowed INT NOT NULL
);

-- Table for users

CREATE TABLE IF NOT EXISTS users(
id INT NOT NULL,
name VARCHAR(300) NOT NULL,
username VARCHAR(100) NOT NULL,
password VARCHAR(20) NOT NULL,
varification_status TINYINT NOT NULL DEFAULT 0,
remember_token TEXT NOT NULL
);

ALTER TABLE books
MODIFY book_id INT PRIMARY KEY;

ALTER TABLE books_categories
MODIFY id INT PRIMARY KEY;

ALTER TABLE branches
MODIFY id INT PRIMARY KEY;

ALTER TABLE books_issue
MODIFY book_issue_id INT PRIMARY KEY;

SELECT * FROM students as s
LEFT JOIN books_issue as b
ON s.book_id = b.id 
UNION
SELECT * FROM students as s 
RIGHT JOIN books_issue as b
on s.book_id = b.id ;
