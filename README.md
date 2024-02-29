# Task 1
[Source data](/data/restaurants.csv)
## Creating the restaurant table
````
create table restaurant
(
	ID INTEGER not null,
	food_Category TEXT not null,
	Price_tier TEXT not null,
	Neighborhood TEXT not null,
	Opening_hours time not null,
	Average_rating INTEGER not null,
	Good_for_kids boolean not null
);
````
## Creating the reviews table
````
create table reviews
(
	ID INTEGER not null,
	reviews TEXT
);
````
## import the practice CSV data files into the tables.
````
.mode csv
.import restaurants.csv restaurant
````
When importing data into a database, we can do the same with python，Below is the code for the Python import file
````
import sqlite3
import csv
# Connect to a SQLite database
conn = sqlite3.connect('/data/myDB.db')
cursor = conn.cursor()
with open('/data/restaurants.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)  # Skip the header line of the CSV file
    for row in csv_reader:
        cursor.execute('INSERT INTO restaurant VALUES (?,?,?,?,?,?,?)', row)
conn.commit()
conn.close()

````