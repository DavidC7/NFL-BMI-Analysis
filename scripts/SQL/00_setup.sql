/* NOTE: This project uses the default 'public' schema intentionally.
The dataset was fully cleaned and validated prior to loading, and the project
involves a single, static data load rather than an ongoing pipeline.
To keep the environment simple and transparent for review, tables are created
directly in 'public' with separate backup copies for safe experimentation. */

CREATE DATABASE nfl_bmi;

--Table creation 

CREATE TABLE conferences (
	conf_id SERIAL PRIMARY KEY,
	conference VARCHAR(3) NOT NULL,
	division VARCHAR(5) NOT NULL,

	CHECK (conference IN ('AFC', 'NFC')),
	CHECK (division IN ('North', 'South', 'East', 'West'))
);

CREATE TABLE teams (
	team_id SERIAL PRIMARY KEY,
	conf_id INTEGER NOT NULL REFERENCES conferences(conf_id),
	team_name VARCHAR(100) NOT NULL
);

CREATE TABLE bmi (
	bmi_id SERIAL PRIMARY KEY,
	bmi NUMERIC(4, 2) NOT NULL,
	bmi_cat VARCHAR(25) NOT NULL,

	CHECK (bmi_cat IN ('Healthy Weight', 'Overweight', 'Obese', 'Extreme Obesity'))
);

CREATE TABLE players (
	player_id SERIAL PRIMARY KEY,
	team_id INTEGER NOT NULL REFERENCES teams(team_id),
	bmi_id INTEGER NOT NULL REFERENCES bmi(bmi_id),
	player_name VARCHAR(100) NOT NULL,
	age INTEGER NOT NULL, 
	position VARCHAR(5) NOT NULL,
	height_in INTEGER NOT NULL,
	weight_lbs INTEGER NOT NULL
);



/* 
    Loading CSV files.

    NOTE:
    - Running locally, so COPY works because the Postgres server can access the file path.
    - If running from psql, use \copy instead of COPY (reads from the client machine).
    - Alternatively, use the Import tool in pgAdmin instead of COPY or \copy.
*/

COPY players
FROM 'C:\Users\Public\players.csv'
WITH (FORMAT CSV,HEADER);

COPY teams
FROM 'C:\Users\Public\teams.csv'
WITH (FORMAT CSV,HEADER);

COPY conferences
FROM 'C:\Users\Public\conferences.csv'
WITH (FORMAT CSV,HEADER);

COPY bmi
FROM 'C:\Users\Public\bmi.csv'
WITH (FORMAT CSV,HEADER);
	

