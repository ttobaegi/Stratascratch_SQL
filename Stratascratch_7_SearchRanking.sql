-- Q7. Search Ranking 
-- To calculate the percentage of search results that were in the top 3 position.

# My solution
with cte as 
(
select sum(case when position <=3 then 1 else 0 end) target
	, count(distinct result_id) total
from fb_search_results
)
select cast(target/total as float)*100 as top_3_percentage
from cte

# Solutions by other users
-- (1)
select (cast(count(case when position <=3 then 1 end) as float) / count(*) )*100 as top_3_percentage
from fb_search_results ;