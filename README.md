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
### 1.1、Find all cheap restaurants in a particular neighborhood(Manhattan)
````
SELECT *
FROM restaurant
WHERE Neighborhood = 'Manhattan' AND Price_tier = 'cheap'
````
### 1.2、Find all restaurants in a particular genre (Western food) with 3 stars or more,ordered by the number of stars in descending order.
````
SELECT *
FROM restaurant
WHERE food_Category = 'Western food' AND Average_rating >= 3 ORDER BY Average_rating DESC
````
### 1.3、Find all restaurants that are open now.
````
SELECT *
FROM restaurant
WHERE Opening_hours <= strftime('%H:%M', 'now')
ORDER BY Opening_hours ASC;
````
### 1.4、The restaurant with ID 1 is selected for evaluation
````
insert into reviews
values (1,'This restaurant is very good and I recommend it')
````
### 1.5、Delete all restaurants that are not good for kids.
````
DELETE FROM restaurant
WHERE Good_for_kids = 'FALSE';
````
### 1.6、Find the number of restaurants in each NYC neighborhood.
````
SELECT Neighborhood, COUNT(*) AS Num_restaurants
FROM restaurant
GROUP BY Neighborhood;
````

# Task 2
[Source data-users](/data/users.csv)

[Source data-posts](/data/posts.csv)
## Creating the users table
````
create table users
(
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	username TEXT not null,
	password TEXT not null,
	email TEXT not null
);
````
## Creating the posts table
````
create table posts
(
	post_id  INTEGER PRIMARY KEY AUTOINCREMENT,
	sender_id INTEGER,
	receiver_id INTEGER,
	messages TEXT,
	stories TEXT,
	post_time DATE not null
);
````
## import the practice CSV data files into the tables.
````
.mode csv
.import users.csv users
````
````
.mode csv
.import posts.csv posts
````
When importing data into a database, we can do the same with python，Below is the code for the Python import file
````
import sqlite3
import csv
# Connect to a SQLite database
conn = sqlite3.connect('/data/myDB.db')
cursor = conn.cursor()
#import the users.csv file into the users table
with open('/data/users.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)  # Skip the header line of the CSV file
    for row in csv_reader:
        cursor.execute('INSERT INTO users VALUES (?,?,?,?)', row)
#import the users.csv file into the users table
with open('/data/posts.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    next(csv_reader)  # Skip the header line of the CSV file
    for row in csv_reader:
        cursor.execute('INSERT INTO posts VALUES (?,?,?,?,?,?)', row)
conn.commit()
conn.close()
````
### 2.1 Register a new User.
````
INSERT INTO Users (username, password, email)
VALUES ('bw2427', 'bw12345678', '12345678@example.com');
````
### 2.2 Create a new Message sent by a particular User to a particular User (pick any two Users for example).
````
INSERT INTO posts (sender_id, receiver_id, messages, post_time)
VALUES (1001, 1, 'This is a message from user 1001 to user 1.', DATETIME('now'));
````
### 2.3 Create a new Story by a particular User (pick any User for example).
````
INSERT INTO posts (sender_id, stories, post_time)
VALUES (1001, 'This is a new story posted by User 1001.', DATETIME('now'));
````
### 2.4 Show the 10 most recent visible Messages and Stories, in order of recency.
````
SELECT *
FROM posts
WHERE (messages IS NOT NULL OR stories IS NOT NULL)
AND post_time <= DATETIME('now')
ORDER BY post_time DESC
LIMIT 10;
````
### 2.5 Show the 10 most recent visible Messages sent by a particular User to a particular User (user:1001  1), in order of recency.
````
SELECT *
FROM posts
WHERE sender_id = 1001
AND receiver_id = 1
AND messages IS NOT NULL
AND post_time <= DATETIME('now')
ORDER BY post_time DESC
LIMIT 10;
````
### 2.6 Make all Stories that are more than 24 hours old invisible.
**Step 1: Add the new column to the table**
**Used to indicate whether it is visible or not;**
**the default is 1, indicating that it is visible**
````
ALTER TABLE posts
ADD COLUMN visible INTEGER DEFAULT 1;

UPDATE posts
SET visible = 0
WHERE stories IS NOT NULL
AND (JULIANDAY('now') - JULIANDAY(post_time)) * 24 > 24;
````

### 2.7 Show all invisible Messages and Stories, in order of recency.
````
SELECT *
FROM posts
WHERE visible = 0
ORDER BY post_time DESC;
````
### 2.8 Show the number of posts by each User.
````
SELECT sender_id, COUNT(*) AS num_posts
FROM posts
GROUP BY sender_id;
````
### 2.9 Show the post text and email address of all posts and the User who made them within the last 24 hours.
````
SELECT p.messages AS post_text, u.email AS user_email
FROM posts p
JOIN users u ON p.sender_id = u.user_id
WHERE p.post_time >= DATETIME('now', '-24 hours');
````
### 2.10 Show the email addresses of all Users who have not posted anything yet.
````
SELECT u.email
FROM users u
LEFT JOIN posts p ON u.user_id = p.sender_id
WHERE p.post_id IS NULL;
````