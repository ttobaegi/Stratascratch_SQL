-- Q3.  Comments Distribution 
-- Write a query to calculate the distribution of comments by the count of users that joined Facebook bet 2008 and 2020 for the month of Jan 2020

-- 2008-2020 가입자 
-- jan 2020에 작성된 comment 
-- OUTPUT : comment 수 별 user 수 

# MY SOLUTION 
WITH u AS
	( select id as user_id
			from fb_users
            where extract( year from joined_at) between 2008 and 2020  -- postgreSQL year함수 없음 extract 함수로 대체
),
	c AS
    ( select user_id, count(user_id) as cnt
    from fb_comments
	where created_at between '01-01-2020' and '01-31-2020'			-- ** 1차결과 오답 이유 : 조건 정리해서 풀 것 
    group by user_id
)
, sumup AS
	( select u.user_id, c.cnt 
		from u inner join c on u.user_id = c.user_id   -- postgreSQL where 절에 join 조건 쓰지 않는다 > ON 
) 
select cnt, count(user_id)
from sumup 
group by cnt	



# SOLUTIONS FROM OTHER USERS
-- (1)
-- join fb_users and fb_comments by the id and id_user key
	-- add logic for join date of 2008 and 2020
	-- add logic for comments mad by users
-- count the number of comments made by users
-- count the number of users that made the corresponding number of comments
