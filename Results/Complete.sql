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


-- Data Analysis --
-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no



-- 2. List employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT dept_emp.demp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.demp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;



-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name = 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name
SELECT dept_emp.demp_no, employees.last_name, employees.first_name
FROM dept_emp
JOIN employees
ON dept_emp.demp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name 
SELECT dept_emp.demp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.demp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name,
COUNT(last_name) as "frequency"
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;