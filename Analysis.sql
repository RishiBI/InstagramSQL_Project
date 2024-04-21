use ig_clone;

/*1.Task:ER Diagram for ig_clone Database*/
/*2.Task:identify the top 5 oldest instagram users.*/
select * from users
order by created_at asc limit 5;

/*3.Task: To understand when to run the ad campaign, figure out the day of the week most users register on? */
SELECT DAYNAME(created_at) AS Day_Name, COUNT(*) AS Day_count
FROM users
GROUP BY Day_Name
LIMIT 2;

/*4.Task: To target inactive users in an email ad campaign, find the users who have never posted a photo.*/
SELECT *
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

/*5.Task: Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?*/
SELECT 
    username,
    photos.image_url,
    COUNT(*) AS total_no_of_likes
FROM photos
JOIN likes
    ON likes.photo_id = photos.id
JOIN users 
  ON users.id = photos.user_id	
GROUP BY photo_id
ORDER BY total_no_of_likes DESC 
LIMIT 1;

/*6.Task: The investors want to know how many times does the average user post.*/
SELECT ROUND((SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users), 2) AS avg_user_post;

/*7.Task: A brand wants to know which hashtag to use on a post and find the top 5 most used hashtags.*/
SELECT tags.tag_name, COUNT(*) AS tag_count
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY tag_count DESC
LIMIT 5;

/*8.Task: To find out if there are bots, find users who have liked every single photo on the site.*/
SELECT 
	username,
    COUNT(*) as num_likes
FROM users
JOIN likes
	ON likes.user_id = users.id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);

/*9.Task: To know who the celebrities are, find users who have never commented on a photo.*/
SELECT *
FROM users
LEFT JOIN comments ON users.id = comments.user_id
WHERE comments.id IS NULL;

/*10.Task: Now it's time to find both of them together, find the users who have never commented on any photo or have commented on every photo.*/
SELECT *
FROM users
LEFT JOIN comments ON users.id = comments.user_id
WHERE comments.id IS NULL
UNION ALL
SELECT *
FROM users
LEFT JOIN comments ON users.id = comments.user_id;

/*11.Task: Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.*/
SELECT u.username, COUNT(p.id) as post_count
FROM users u
JOIN photos p ON u.id = p.user_id
GROUP BY p.user_id
HAVING post_count BETWEEN 3 AND 5
ORDER BY post_count DESC
LIMIT 30;

/*12.Task: Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?*/
SELECT DISTINCT username, users.id
FROM users
JOIN photos ON photos.user_id = users.id
JOIN likes ON likes.photo_id = photos.id
WHERE username REGEXP '^c' AND username REGEXP '[0-9]$';

/*13.Task: Find the users who have created instagramid in may and select top 5 newest joinees from it?*/
SELECT username, created_at
FROM users
WHERE MONTH(created_at) = 5
ORDER BY created_at DESC
LIMIT 5;