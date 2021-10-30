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

3. FBI Crime Data API - https://crime-data-explorer.fr.cloud.gov/api
   FDA Food Safery - https://open.fda.gov/data/caers/
   
   NYPD Hate Crimes: https://data.cityofnewyork.us/Public-Safety/NYPD-Hate-Crimes/bqiq-cu78
   
   Dataset containing confirmed hate crime incidents in NYC
   