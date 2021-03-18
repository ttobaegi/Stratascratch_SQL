-- Q9. Search CTR
-- To calculate the percentage of search results that were positioned in the top 3 AND clicked by user
-- 1. LEFT JOIN tables on key result_id
-- 2. count(case when top 3 & clicked yes ) / count(result_id)
-- 3. convert to float * 100
       
WITH R AS
(
	select * from fb_search_results  
),
	E AS
(
	select result_id from fb_search_events where has_clicked = 'yes'
),
RE AS
(
	select * from R inner join E on R.result_id=E.Result_id
    where position <= 3
)

select count(distinct RE.result_id)/count(distinct R.result_id) 
from R  left join RE on RE.result_id = R.result_id

-- (2) CASE 문
SELECT 
	(count(CASE WHEN a.position <=3 and has_clicked ='yes' then 1 else NULL)*1.0 / count(a.result_id))*100 as percentage	
		-- then 1 else null > count 
        -- then 1 else 0 > sum  
FROM fb_search_result a 
LEFT JOIN fb_search_events b
on a.result_id = b.result_id
