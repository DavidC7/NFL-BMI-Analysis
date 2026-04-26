-- ****COUNTS****

--Number of players by bmi category
SELECT b.bmi_cat, COUNT(p.player_id) AS player_count
FROM players p
JOIN bmi b ON b.bmi_id = p.bmi_id
GROUP BY bmi_cat
ORDER BY player_count DESC;

--Number of players per position
SELECT position, COUNT(player_id) AS total
FROM players
GROUP BY position
ORDER BY total DESC;

-- ****MIN/MAX****
--BMI 22.50/44.99

SELECT MIN(bmi) AS min_bmi, MAX(bmi) AS max_bmi
FROM bmi;

-- ****AVERAGES****

--Average BMI by age group.

SELECT ROUND(AVG(b.bmi), 2) AS avg_bmi, 
 		CASE
	 		WHEN age BETWEEN 20 AND 24 THEN '20-24'
			WHEN age BETWEEN 25 AND 29 THEN '25-29'
     		WHEN age BETWEEN 30 AND 34 THEN '30-34'
			WHEN age BETWEEN 35 AND 39 THEN '35-39'
     		WHEN age >=40 THEN '40 plus'
	 		ELSE 'Other'
 		END AS age_group
 FROM players p
 JOIN bmi b ON b.bmi_id = p.bmi_id
 GROUP BY age_group
 ORDER BY avg_bmi DESC;

--Average BMI by division - not used, but calculated out of curiosity. 

SELECT c.conference, c.division, ROUND(AVG(b.bmi), 2) AS avg_bmi
FROM conferences c
JOIN teams t ON t.conf_id = c.conf_id
JOIN players p ON p.team_id = t.team_id
JOIN bmi b ON b.bmi_id = p.bmi_id
GROUP BY c.conference, c.division
ORDER BY avg_bmi DESC; 

--Average BMI by team.

SELECT t.team_name, ROUND(AVG(b.bmi), 2) AS avg_bmi
FROM players p
JOIN teams t ON t.team_id = p.team_id
JOIN bmi b ON b.bmi_id = p.bmi_id
GROUP BY t.team_name
ORDER BY avg_bmi DESC;

--Average BMI by player positions

SELECT p.position, ROUND(AVG(b.bmi), 2) AS avg_bmi
FROM players p
JOIN bmi b ON b.bmi_id = p.bmi_id
GROUP BY p.position
ORDER BY avg_bmi DESC;

--Average BMI of all players = 31.13
SELECT ROUND(AVG(b.bmi), 2) AS avg_bmi
FROM bmi b
JOIN players p ON p.bmi_id = b.bmi_id;

--Classifying player as offense, defense or special teams
SELECT 
    p.player_id, p.position, b.bmi,
    CASE 
        WHEN p.position IN ('QB','RB','FB', 'HB', 'TB', 'WR','TE','LT','LG','C','RG','RT','OL', 'G', 'OG', 'OT', 'T') 
            THEN 'Offense'
        WHEN p.position IN ('DE','DT', 'DL', 'NT','ED','OLB','ILB','MLB','LB','CB','FS','SS', 'S', 'DB') 
            THEN 'Defense'
        WHEN p.position IN ('K','P','LS', 'RS', 'ST', 'KR', 'PR' ) 
            THEN 'Special Teams'
        ELSE 'Unknown'
    END AS unit
FROM players p
JOIN bmi b ON b.bmi_id = p.bmi_id;

--Average BMI by units (O, D, ST)
WITH unit_bmi AS (
    SELECT 
        CASE 
            WHEN p.position IN ('QB','RB','FB', 'HB', 'TB', 'WR','TE','LT','LG','C','RG','RT','OL', 'G', 'OG', 'OT', 'T') THEN 'Offense'
            WHEN p.position IN ('DE','DT', 'DL', 'NT','ED','OLB','ILB','MLB','LB','CB','FS','SS', 'S', 'DB') THEN 'Defense'
            WHEN p.position IN ('K','P','LS', 'RS', 'ST' ) THEN 'Special Teams'
            ELSE 'Unknown'
        END AS unit,
        b.bmi
    FROM players p
    JOIN bmi b ON b.bmi_id = p.bmi_id
)
SELECT unit, ROUND(AVG(bmi), 2) AS avg_bmi
FROM unit_bmi
GROUP BY unit
ORDER BY avg_bmi DESC;





	




