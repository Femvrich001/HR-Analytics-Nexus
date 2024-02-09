# HR-Analytics-Nexus
Unlock the power of HR data with our Nexus. Featuring over 22,000 rows spanning from 2000 to 2020, meticulously cleaned and analyzed using MySQL Workbench. Visualize trends and insights effortlessly with PowerBI. Streamline your HR analytics journey today!

![Screenshot (126)](https://github.com/Femvrich001/HR-Analytics-Nexus/assets/117773133/7c531f5d-21a7-4126-8db9-73449f7c6d4e)

# Questions
1.What is the gender breakdown of employees in the company?
2.What is the race/ethnicity breakdown of employees in the company?
3.What is the age distribution of employees in the company?
4.How many employees work at headquarters versus remote locations?
5.What is the average length of employment for employees who have been terminated?
6.How does the gender distribution vary across departments and job titles?
7.What is the distribution of job titles across the company?
8.Which department has the highest turnover rate?
9.What is the distribution of employees across locations by state?
10.How has the company's employee count changed over time based on hire and term dates?
11.What is the tenure distribution for each department?

# Summary of Findings

## Demographics
- **Gender Distribution:** There are more male employees than female employees.
- **Race Distribution:** White race is the most dominant, while Native Hawaiian and American Indian are the least dominant.
- **Age Distribution:** The youngest employee is 20 years old, and the oldest is 57 years old. Age groups were created (18-24, 25-34, 35-44, 45-54, 55-64). A large number of employees were between 25-34 followed by 35-44, while the smallest group was 55-64.

## Work Environment
- **Work Location:** A large number of employees work at the headquarters versus remotely.
- **Tenure:** The average length of employment for terminated employees is around 7 years. The average tenure for each department is about 8 years.

## Department Insights
- **Gender Distribution by Department:** Gender distribution across departments is fairly balanced, but there are generally more male than female employees.
- **Turnover Rate:** The Marketing department has the highest turnover rate followed by Training. The least turnover rates are in the Research and Development, Support, and Legal departments.
- **Tenure by Department:** Legal and Auditing have the highest tenure, while Services, Sales, and Marketing have the lowest.

## Geographic Distribution
- **State Distribution:** A large number of employees come from the state of Ohio.
- **Net Change in Employees:** The net change in employees has increased over the years.

## Limitations
- Some records had negative ages and these were excluded during querying (967 records). Ages used were 18 years and above.
- Some term dates were far into the future and were not included in the analysis (1599 records). The only term dates used were those less than or equal to the current date.

