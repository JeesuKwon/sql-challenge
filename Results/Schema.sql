-- Data Engineering
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS dept_emp CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS titles CASCADE;

CREATE TABLE "departments" (
    -- Department number is a primary key, and it is
    -- aslo found in department employees and department manager list
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "demp_no" INT   NOT NULL,
    "dept_name" VARCHAR   NOT NULL
);

-- Correction for my mistake :( --
ALTER TABLE "dept_emp"
RENAME COLUMN "dept_name" to "dept_no"

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);


CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
	"Salary" INT   NOT NULL
);
-- Correction bc it didn't work at Query :( --
ALTER TABLE "salaries"
RENAME COLUMN "Salary" to "salary"

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
	"title" VARCHAR   NOT NULL,
	CONSTRAINT "pk_titles" PRIMARY KEY (
    "title_id"
    )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
	"emp_title_id" VARCHAR   NOT NULL,
	"birth_date" DATE   NOT NULL,
	"first_name" VARCHAR   NOT NULL,
	"last_name" VARCHAR   NOT NULL,
	"sex" VARCHAR   NOT NULL,
	"hire_date" DATE   NOT NULL,
	CONSTRAINT "pk_employees" PRIMARY KEY (
    "emp_no"
    )
);



-- Forien Keys Setting up --
ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_detp_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_detp_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "demp_no" ADD CONSTRAINT "fk_dept_emp_demp_no" FOREIGN KEY("demp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE 

-- Viewing the tables 
SELECT * FROM departments;
SELECT * FROM titles;	
SELECT * FROM employees;	
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;	
SELECT * FROM salaries;