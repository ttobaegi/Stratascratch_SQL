/** stratascratch **/

# Q1 Friend Acceptance Rate (Interview Walkthrough)
-- ACCEPTANCE RATE BY DATE

# My Solution
WITH S AS (
SELECT  user_id_sender sent, date
FROM fb_friend_requests
WHERE action = 'sent'
),
    R AS (
    SELECT  user_id_sender accepted, date
    FROM fb_friend_requests
    WHERE action =  'accepted'
),
    C AS (
        SELECT s.date, 
        count(distinct accepted)::numeric accepted, 
        count(distinct sent)::numeric sent
        FROM S LEFT JOIN R ON S.sent=R.accepted
        group by 1
    )
SELECT date,
        round(accepted / sent,15) percentage_acceptance
FROM C
ORDER BY date ASC;


# Solution by other users
-- (1) Self Join
-- action에 대한 조건(sent/accepted)을 다르게 주어 a left join b 
select a.date, count(b.user_id_receiver) / count(a.user_id_sender)::float as acceptance_rate
from 
	( select * 	from fb_friend_requests where action = 'sent') a							
left join 
	( select * 	from fb_friend_requests     where action = 'accepted') b
on a.user_id_sender = b.user_id_sender
group by a.date

-- (2) cte & case
select a. date
	,  ( SUM( case when b.action = 'accepted' then 1 else 0 end) / 
		SUM( case when a.caction = 'senet' then 1 else 0 end)::float) as percentage_acceptance
from fb_friends_requests a
		left join fb_friend_requests b
		on a.user_id_sender=b.user_id_sender
		and a.user_id_receiver = b.user_id_receiver
where a.action = 'sent'
group by 1
order by 1;
 
