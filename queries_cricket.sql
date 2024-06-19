-- Top batsmen based on total runs
SELECT batsman, SUM(runs) AS total_runs, AVG(strike_rate) AS avg_strike_rate
FROM batsman
GROUP BY batsman
ORDER BY total_runs DESC
LIMIT 10;

-- Top bowlers based on total wickets
SELECT bowler, SUM(wicket_count) AS total_wickets, AVG(economy) AS avg_economy_rate
FROM bowlers
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;



-- Bowlers with max wickets at unique place
select winning_matches AS (
    SELECT match_id, venue
    FROM match1
    WHERE win_by = 'wickets'
)

, bowler_performance AS (
    SELECT
        bowler_id,
        venue,
        SUM(wicket_count) AS total_wickets,
        COUNT(DISTINCT venue) AS unique_venues
    FROM bowler1 b
    JOIN winning_matches w ON b.match_id = w.match_id
    GROUP BY bowler_id, venue
)


SELECT
    bowler_id,
    
    MAX(unique_venues) AS max_unique_venues,
    total_wickets
FROM bowler_performance
GROUP BY bowler_id,  total_wickets
ORDER BY max_unique_venues DESC, total_wickets DESC
LIMIT 10;

-- batsmen who were never out for a duck & highest score in 2022
WITH no_duck_batsmen AS (
    SELECT batsman_id
    FROM batsman1
    WHERE runs > 0
    GROUP BY batsman_id
    HAVING COUNT(CASE WHEN runs = 0 THEN 1 ELSE NULL END) = 0
)

SELECT batsman_id, MAX(runs) AS highest_runs
FROM batsman1
WHERE batsman_id IN (SELECT batsman_id FROM no_duck_batsmen)
AND date_part('year', match_dt) = 2022
GROUP BY batsman_id
ORDER BY highest_runs DESC
LIMIT 10;




