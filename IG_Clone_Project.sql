use ig_clone;
-- Question 1
select * from users order by  created_at asc limit 5;

-- Question 2
select * from users where id not in(select user_id from photos);

-- Question 3 user got most likes on photo
create or replace view first1 as
(select count(photo_id) as m_like, photo_id from likes group by photo_id order by m_like desc);
select u.username from first1 f1 join photos p on f1.photo_id =p.id join users u on p.user_id=u.id order by m_like desc limit 1;

-- Question 4 how many times does avg user posts
select(select count(id) from photos)/ (select count(id) from users) as avg;

-- Question 5 most used hashtags
select t.tag_name,count(pt.tag_id) as maxused from tags t join photo_tags pt on t.id=pt.tag_id group by pt.tag_id order by maxused desc limit 5;

-- Question 6 user who have liked every single photo
select l.user_id,u.username,count(*) l_count
 from likes l 
 join  users u on u.id=l.user_id
 group by user_id having l_count in  (select count(id) from photos); 
 
 -- Question 7 users who have created instagramid in may and select top 5 newest joinees from it?
 
 select * from users where month(created_at) = 5 order by created_at desc limit 5;

-- Question 8 users whose name starts with c  and ends with any number and have posted the photos as well as liked the photos?

select distinct username as users_name 
from users u join photos p on u.id=p.user_id
join likes l on l.user_id=p.user_id 
where username regexp'^c' and username regexp'[0-9]$';

-- Question 9 top 30 usernames to the company who have posted photos in the range of 3 to 5.


select p.user_id,u.username,count(*) posts 
from photos p join users u on p.user_id=u.id
group by p.user_id 
having posts between 3 and 5 
order by posts desc limit 30;
 