-- ****CORRELATION CALCULATION****

--Correlation between avg_bmi and avg_wt by positions
--post_corr = 0.97

WITH position_corr AS (
	SELECT p.position, ROUND(AVG(b.bmi), 2) AS avg_bmi,
	ROUND(AVG(p.weight_lbs), 2) AS avg_wt
	FROM players p
	JOIN bmi b on b.bmi_id = p.bmi_id
	GROUP BY p.position
)
SELECT
	ROUND(CORR(avg_bmi, avg_wt):: numeric, 2) AS post_corr
FROM position_corr; 

--Correlation of player raw bmi and raw weight
-- player_corr = 0.95

SELECT ROUND(CORR(b.bmi, p.weight_lbs):: numeric, 2) AS player_corr
FROM players p
JOIN bmi b on b.bmi_id = p.bmi_id; 

--Correlation between avg_bmi and avg_wt by team
-- team_corr = 0.64

WITH team_correlation AS (
	SELECT t.team_name, ROUND(AVG(b.bmi), 2) AS avg_bmi,
	ROUND(AVG(p.weight_lbs), 2) AS avg_wt
	FROM players p
	JOIN teams t ON t.team_id = p.team_id
	JOIN bmi b ON b.bmi_id = p.bmi_id
	GROUP BY t.team_name
)
SELECT
	ROUND(CORR(avg_bmi, avg_wt):: numeric, 2) AS team_corr
FROM team_correlation; 


--Correlation between avg_bmi and avg_wt by division
-- div_corr = .90

WITH division_correlation AS(
	SELECT c.division, ROUND(AVG(b.bmi), 2) AS avg_bmi,
	ROUND(AVG(p.weight_lbs), 2) AS avg_wt
	FROM conferences c
	JOIN teams t ON t.conf_id = c.conf_id
	JOIN players p ON p.team_id = t.team_id
	JOIN bmi b ON b.bmi_id = p.bmi_id
	GROUP BY c.division
)
SELECT ROUND(CORR(avg_bmi, avg_wt):: numeric, 2) AS div_corr
FROM division_correlation;

--Table creation and data insertion

CREATE TABLE correlations (
	position NUMERIC(3,2) NOT NULL,
	player NUMERIC(3,2) NOT NULL,
	division NUMERIC(3,2) NOT NULL,
	team NUMERIC(3,2) NOT NULL
);

INSERT INTO correlations (position, player, division, team)
VALUES (0.97, 0.95, 0.90, 0.64);

SELECT * FROM correlations;
