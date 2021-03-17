/** stratascratch **/

# Q1 Friend Acceptance Rate (Interview Walkthrough)
-- ACCEPTANCE RATE BY DATE
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