-- Q2. Post Success
-- Write a query to get the post success rate by date

-- assumption : post가 되려면 enter 먼저
-- event name 이 post 면 Success : Post Success Rate = #post/ #enter
# My solution
WITH E
AS ( select *
	from fb_post_events
	where event_name = 'enter' 
    )
 ,
	P
    ( select * 
    from fb_post_events
    where event_name = 'post'
    )
select (count(distinct P.user_id) / count(distinct E.user_id)) as Post_success_rate
from E
	left join P where E.user_id=P.user_id
order by e.created_date


# Solutions from other users
-- (1) COUNT(CASE WHEN.. THEN.. END) / Sub-query
	-- COUNT안에 CASE문을 넣기 
	-- SUBQUERY는 ALIAS 필수
SELECT 
	created_at
    , post
    , enter
    , post/enter::float as post_success_rate
FROM
	( SELECT 
		created_at
        , COUNT(case when event_name = 'enter' then user_id END) as enter
		, COUNT(case when event_name = 'cancel' then user_id END) as cancel
        , COUNT(case when event_name = 'post' then user_id END) as post
		from fb_post_events
        group by created_at 
        ) a
group by 1 ;

-- (2) 
