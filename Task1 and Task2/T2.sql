-- create table users
create table users
(
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	username TEXT not null,
	password TEXT not null,
	email TEXT not null
);

-- create table posts
create table posts
(
	post_id  INTEGER PRIMARY KEY AUTOINCREMENT,
	sender_id INTEGER,
	receiver_id INTEGER,
	messages TEXT,
	stories TEXT,
	post_time DATE not null
);

/*
-- import csv file
.mode csv
.import users.csv users

*/

/*
-- import csv file
.mode csv
.import posts.csv posts

*/
--1.Register a new User.
INSERT INTO Users (username, password, email)
VALUES ('bw2427', 'bw12345678', '12345678@example.com');

-- 2.Create a new Message sent by a particular User to a particular User (pick any two Users for example).
INSERT INTO posts (sender_id, receiver_id, messages, post_time)
VALUES (1001, 1, 'This is a message from user 1001 to user 1.', DATETIME('now'));


--3.Create a new Story by a particular User (pick any User for example).
INSERT INTO posts (sender_id, stories, post_time)
VALUES (1001, 'This is a new story posted by User 1001.', DATETIME('now'));

-- 4.Show the 10 most recent visible Messages and Stories, in order of recency.
SELECT *
FROM posts
WHERE (messages IS NOT NULL OR stories IS NOT NULL)
AND post_time <= DATETIME('now')
ORDER BY post_time DESC
LIMIT 10;

-- 5.Show the 10 most recent visible Messages sent by a particular User to a particular User (pick any two Users for example), in order of recency.
SELECT *
FROM posts
WHERE sender_id = 1001
AND receiver_id = 1
AND messages IS NOT NULL
AND post_time <= DATETIME('now')
ORDER BY post_time DESC
LIMIT 10;

-- 6.Make all Stories that are more than 24 hours old invisible.
-- Step 1: Add the new column to the table
-- Used to indicate whether it is visible or not;
-- the default is 1, indicating that it is visible
ALTER TABLE posts
ADD COLUMN visible INTEGER DEFAULT 1;

UPDATE posts
SET visible = 0
WHERE stories IS NOT NULL
AND (JULIANDAY('now') - JULIANDAY(post_time)) * 24 > 24;


-- 7.Show all invisible Messages and Stories, in order of recency.
SELECT *
FROM posts
WHERE visible = 0
ORDER BY post_time DESC;

-- 8.Show the number of posts by each User.
SELECT sender_id, COUNT(*) AS num_posts
FROM posts
GROUP BY sender_id;

-- 9.Show the post text and email address of all posts and the User who made them within the last 24 hours.
SELECT p.messages AS post_text, u.email AS user_email
FROM posts p
JOIN users u ON p.sender_id = u.user_id
WHERE p.post_time >= DATETIME('now', '-24 hours');

-- 10.Show the email addresses of all Users who have not posted anything yet.
SELECT u.email
FROM users u
LEFT JOIN posts p ON u.user_id = p.sender_id
WHERE p.post_id IS NULL;
