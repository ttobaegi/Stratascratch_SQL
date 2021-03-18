-- Q4.  Top 10 Active User on Facebook Messenger 
-- Find the top 10 most active users on Facebook Messenger 
-- by counting their total number of messages sent and received.
-- user1 sender user2 receiver


select distinct a.user, sum(msg_count) 
from (select user1 as user, msg_count
	from fb_messages
	Union all 						-- UNION VS UNION ALL 중복제거하면 안되니까 UNION ALL
	select user2 as user, msg_count
	from fb_messages
)a
group by 1
order by 2 Desc
Limit 10 ;
