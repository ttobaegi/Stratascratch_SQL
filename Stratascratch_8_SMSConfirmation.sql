-- Q8. SMS Confirmations From Users
-- To calculate the percentage of confirmed SMS texts for august 4, 2020
-- fb_sms_sends table invalid confirmation records : type in ('friend_request', 'confirmation')
-- fb_confirmers valid confirmation records
-- confirmation texts are only valid on the date they were sent

# My solution
-- WITH STATMENT * LEFT JOIN 
WITH c AS
(
	select date ds, phone_number from fb_confirmers 
),
	
    s AS
(
	select * from fb_sms_sends	
    where type not in ('friend_request', 'confirmation')		-- INVALID FILTER OUT
    and ds = '2020-08-04'										-- DATE FILTER IN 
)
,
	cs AS
(
	select count(c.phone_number) c1
	        ,count(s.phone_number) c2
    from s left join c on c.ds = s.ds and c.phone_number = s.phone_number
)
select (c1/c2::float)*100 as percentage from cs

# SOLUTIONS BY OTHER USERS
-- (1) SIMPLE IS THE BEST

select (count(c.phone_number)/count(s.phone_number) as float)*100 as percentage
from fb_sms_sends s
left join fb_confirmers c on c.date = s.ds and c.phone_number = s.phone_number
where type not in ('friend_request', 'confirmation')
	and ds = '2020-08-04';

