-- Instagram User Analysis
-- Description:
-- User analysis is the process by which we track how users engage and interact with 
-- our digital product (software of mobile application)in an attempt to derive business
-- insights for marketing, product & development teams.


use ig_clone;

-- 1. Find the top 5 oldest users of Instagarm from the database provided?

SELECT * FROM users;
SELECT * FROM users ORDER BY created_at LIMIT 5;

-- 2. Find the users who have never posted a single photo on Instagram?
 SELECT * FROM photos;
 SELECT * FROM users;

SELECT username FROM users LEFT JOIN
photos
ON photos.user_id=users.id WHERE image_url IS NULL ORDER BY username;

-- 3. Identity the winner of the contest and provide their details to the team?

SELECT * FROM LIKES;
SELECT * FROM PHOTOS;
SELECT * FROM USERS;

SELECT LIKES.PHOTO_ID,USERS.USERNAME, COUNT(LIKES.USER_ID) AS NO_OF_LIKES
FROM LIKES INNER JOIN PHOTOS
ON LIKES.PHOTO_ID = PHOTOS.ID
INNER JOIN USERS
ON USERS.ID = PHOTOS.USER_ID
GROUP BY LIKES.PHOTO_ID,USERS.USERNAME ORDER BY NO_OF_LIKES DESC;

-- 4. Identify and suggest the top 5 most commonly used hashtags on the platform?
SELECT * FROM TAGS;
SELECT * FROM PHOTO_TAGS;
SELECT TAG_ID,TAG_NAME, COUNT(PHOTO_ID) AS TOTAL_NO_OF_TAG FROM PHOTO_TAGS
INNER JOIN TAGS
ON TAGS.ID = PHOTO_TAGS.TAG_ID
GROUP BY TAG_ID,TAG_NAME ORDER BY TOTAL_NO_OF_TAG DESC LIMIT 5;

-- 5. What day of the weak do most users register on? 
-- provide insight on when to schedule an ad campgain?
SELECT * FROM users;
SELECT DATE_FORMAT(created_at, '%W') as DAYS, COUNT(username) as Total_week
FROM users 
GROUP BY DAYS 
ORDER BY Total_week DESC;

-- 6. Provide how many times does average user posts on Instagram. 
-- Also, provide the total number of photos on Instagram/total number of users?

select * from users; 
select * from photos;

with base as(
select u.id as userid,count(p.id) as photoid from users u left join photos p
on p.user_id = u.id group by u.id)
select sum(photoid) as totalphotos,count(userid) as
total_users,sum(photoid)/count(userid) as photo_per_user
from base;

-- 7. Provide data on users (bots) who have liked every single photo on the site
-- (since any normal user would  not be able to do this).

SELECT * FROM LIKES;

with base as (
SELECT username,count(photo_id) as likess from users inner join likes
on users.id = likes.user_id group by username order by likess)
select username,likess from base where likess=(select count(*) from photos) order by likess;









