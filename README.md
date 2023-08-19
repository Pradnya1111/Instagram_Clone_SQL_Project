# Unveiling Social Media Insights: Condensed Analysis
Our project encapsulates the essence of data-driven decision-making within the realm of social media. Each query peels back layers of user behavior, enabling actionable insights that drive engagement, content strategy, and user satisfaction. Through meticulous analysis, we offer a nuanced perspective on user activity, empowering strategic choices and informed growth.<br>

Our data exploration reveals key insights into user behavior, shaping strategic decisions for effective engagement:<br>

1. Longevity Recognition: Identified five oldest users, recognizing commitment and loyalty.
```sql
select * from users order by  created_at asc limit 5;
```

2. Targeting Dormancy: Flagged non-photo posters for reactivation email campaign, re-engaging users.
```sql
select * from users where id not in(select user_id from photos);
```

3. Photo Like Winner: Determined most-liked photo, showcasing impactful content resonance.
```sql
create or replace view first1 as
(select count(photo_id) as m_like, photo_id from likes group by photo_id order by m_like desc);

select u.username from first1 f1 join photos p on f1.photo_id =p.id join users u on p.user_id=u.id order by m_like desc limit 1;
```

4. Posting Patterns: Calculated average posting frequency, guiding investor understanding.
```sql
select(select count(id) from photos)/ (select count(id) from users) as avg;
```

5. Hashtag Strategy: Top five hashtags identified, enabling effective content strategies.
```sql
select t.tag_name,count(pt.tag_id) as maxused from tags t join photo_tags pt on t.id=pt.tag_id group by pt.tag_id order by maxused desc limit 5;
```

6. Bot Detection: Isolated users exhibiting uniform liking behavior, distinguishing engagement authenticity.
```sql
select l.user_id,u.username,count(*) l_count
 from likes l 
 join  users u on u.id=l.user_id
 group by user_id having l_count in  (select count(id) from photos); 
```
7. Newcomer Spotlight: Highlighted top five May-joiners, facilitating personalized onboarding.
```sql
 select * from users where month(created_at) = 5 order by created_at desc limit 5;

```

8. Unique User Traits: Segmented users with distinct posting and liking patterns, revealing niche behaviors.
```sql
select distinct username as users_name 
from users u join photos p on u.id=p.user_id
join likes l on l.user_id=p.user_id 
where username regexp'^c' and username regexp'[0-9]$';
```

9. Engaging Users Range: Presented top 30 usernames with 3 to 5 posts, capturing active engagement.
```sql
select p.user_id,u.username,count(*) posts 
from photos p join users u on p.user_id=u.id
group by p.user_id 
having posts between 3 and 5 
order by posts desc limit 30;
```
