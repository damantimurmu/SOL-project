-- SQL Project
-- IPL Dataset

create database ipl_analysis;
use ipl_analysis;
select * from batting_summary;
select * from bowling_summary;
select * from match_summary;
select * from players;

-- Basic Questions;

-- Q1. List all unique players in the tournament?
select distinct name from players;

-- Q2 List all teams that participated in the ipl?
select distinct team from players;
 
-- Q3 List the top 3 highest-scoring batsman ?
select batsmanName as runs from batting_summary group by  batsmanName order by runs desc limit 3;

 -- Q4 Find the number of sixes hit by each batsman?
 select batsmanname , sum(6s) as sixes from batting_summary group by batsmanname;
 
 -- Q5 Find the top 5 bowlers with the most wickets? 
 select bowlerName , sum(wickets) as total_wickets from bowling_summary 
 group by bowlerName order by total_wickets desc limit 5;
 
 -- Q6 show the total runs scored by each batsman in the datset?
 select batsmanName, sum(runs) as total_runs from batting_summary group by batsmanName;
 
 -- Moderate
 
-- Q1 Retrives the top 5 batsmen with the highest strike rates?
select batsmanname, avg(SR) as avg_strike_rate from batting_summary
 group by batsmanname order by avg_strike_rate desc limit 5; 

-- Q2 list all matches where the winner margine was more than 50 runs?
select team1,team2, winner , margin from match_summary 
where won_by ='Run' and margin>50;

-- Q3 Find the top 3 teams with the most match wins in the last three seasons.

SELECT winner AS Team,COUNT(*) AS Matches_Won
FROM match_summary
GROUP BY winner
ORDER BY Matches_Won DESC
LIMIT 3;


-- Q4 Find the players who have both batting and bowling records in the dataset.
SELECT DISTINCT p.name
FROM players p
JOIN batting_summary b ON p.name = b.batsmanname
JOIN bowling_summary bw ON p.name = bw.bowlername;

-- Q5 Find the number of matches each team has won?
SELECT winner, COUNT(*) AS wins
FROM match_summary
GROUP BY winner
ORDER BY wins DESC;

-- Hard Que

-- Q1 Player with Most Ducks (0 Runs) in the Last 3 Seasons.

SELECT b.batsmanname, p.team, COUNT(*) AS ducks
FROM batting_summary b
JOIN players p ON b.batsmanname = p.name
WHERE b.runs = 0 GROUP BY b.batsmanname, p.team
ORDER BY ducks DESC LIMIT 1;

-- Q2 Team with Highest Win Percentage 
SELECT m.winner AS team, COUNT(*) AS wins, 
(COUNT(*) * 100.0 / (SELECT COUNT(*) 
FROM match_summary))
AS win_percentage
FROM match_summary m
GROUP BY m.winner
ORDER BY win_percentage DESC
LIMIT 1;

-- Q3 Find the Player with the Highest Contribution in a Winning Cause
SELECT b.batsmanname, p.team, 
SUM(b.runs) AS total_runs_in_wins
FROM batting_summary b
JOIN match_summary m ON b.match_id = m.match_id
JOIN players p ON b.batsmanname = p.name
WHERE m.winner = p.team
GROUP BY b.batsmanname, p.team
ORDER BY total_runs_in_wins DESC
LIMIT 1;

-- Q4 Find the Match with the Highest Margin of Victory 
SELECT 
    m.match_id, 
    m.team1, 
    m.team2, 
    m.margin, 
    m.winner
FROM match_summary m
WHERE m.margin = (SELECT MAX(margin) FROM match_summary);
    
-- Q5 Find the player who hit the most 4s in each season.
  
SELECT bs.batsmanname, ms.year, SUM(bs.4s)AS total_fours
FROM batting_summary AS bs
JOIN match_summary AS ms ON bs.match_id = ms.match_id
GROUP BY bs.batsmanname, ms.year
ORDER BY total_fours DESC
LIMIT 1;








