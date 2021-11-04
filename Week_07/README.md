Auto-increment allows a unique number to be generated automatically when a new record is inserted into a table.
A autoincremented field is often specified as a primary key field of the table.

JOIN combines each row of the left table with each row of the right table,keeping only the rows in which the join codition is true. A subquery is a query within another SQL query and embedded within the WHERE clause. The outer query is the main query.
Subquery may be used to compare values against multiple rows while JOIN keeps rows when the condition is true.
JOINs are faster than subquery

<img width="500" alt="Screen Shot 2021-11-03 at 11 53 42 PM" src="https://user-images.githubusercontent.com/20906514/140255341-30ad57ca-a9be-42db-9c82-ba14fbbc2bc7.png">

--------------------------------------------------------------------------------------------------------------------------
ClassWork

1. Create an account on lucidchart.com and create an ERD diagram for the following
scenario:
A grocery store owner would like to store all their data in a database. Some important
facts you need to include are
   1) The owner has multiple stores
   2) The owner has multiple employees and the managers report to him, but all other
   employees report to store managers
   3) The store has a membership program, but not all customers need to be members
   Aside from this, use what you know about grocery stores to create a logical data model.

<img width="500" alt="Screen Shot 2021-10-27 at 9 15 49 PM" src="https://user-images.githubusercontent.com/20906514/139514639-4ada838c-3ccc-4149-85c9-2dcbfb242a6e.png">


2.With your group, create a list of at least 5 and no more than 10 ways data can be “dirty”.
Perhaps think back to some data sets we have used that have had weird stuff in them. Discuss
how you would resolve each of these and briefly explain.

- Missing values: Many machine learninng algorithms do not support missing values.
We can drop rows with missing values, or impute the missing values by taking the mean,mode, etc. 

- Extra characters: Dollar signs, commas, spaces and other characters makes in data fields that make it diffcult to use the data readily. These extra character needs to be removed with the help of string's replace function. 

- Misspelled data/typos: It can lead to inaccurate analysis of the dataset since some data can be left out due to typo.
This involves manually decting the typos or using the like operator and then using string's replace function or regex function to fix the spelling.

- Duplicate data: It doesn't serve any purpose. Dropping duplicates is necessary to get accurate counts since you don't want to count everything twice. We can drop duplicates using Pandas drop_duplicates method.

- Incorret data types: It makes it diffcult to use the data readily. These data types need to converted using .astype() to do appropriate computations.

3. Look at the requirements for the exploratory data analysis project. List at least 2 APIs that
have data interesting to you. Please pick at least one API that’s not listed in the project
instructions.

   FBI Crime Data API - https://crime-data-explorer.fr.cloud.gov/api
   
   FDA Food Safery - https://open.fda.gov/data/caers/
   
   
   
   NYPD Hate Crimes: https://data.cityofnewyork.us/Public-Safety/NYPD-Hate-Crimes/bqiq-cu78
   
   Dataset containing confirmed hate crime incidents in NYC
   
