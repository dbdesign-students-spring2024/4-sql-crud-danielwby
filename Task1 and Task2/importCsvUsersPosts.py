import sqlite3
import csv

# Connect to a SQLite database
conn = sqlite3.connect('/data/myDB.db')
cursor = conn.cursor()
with open('users.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)  # Skip the header line of the CSV file
    for row in csv_reader:
        cursor.execute('INSERT INTO users VALUES (?,?,?,?)', row)

with open('posts.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)  # Skip the header line of the CSV file
    for row in csv_reader:
        cursor.execute('INSERT INTO posts VALUES (?,?,?,?,?,?)', row)


conn.commit()
conn.close()
