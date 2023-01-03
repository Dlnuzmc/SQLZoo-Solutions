
-- In which we join two tables; game and goals.

-- # 1. Show matchid and player name for all goals scored by Germany. teamid = 'GER'.
SELECT matchid, player FROM goal
 WHERE teamid = 'GER';

-- # 2. Show id, stadium, team1, team2 for game 1012.
SELECT id, stadium, team1, team2 FROM game
 WHERE id = 1012;

-- # 3. Show the player, teamid and mdate and for every German goal. teamid='GER'.
SELECT player,teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid='GER'

-- # 4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT game.team1, game.team2, goal.player
FROM game
JOIN goal
ON goal.matchid = game.id
WHERE goal.player LIKE 'Mario%';

-- # 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT goal.player, goal.teamid, eteam.coach, goal.gtime
FROM goal
JOIN eteam
ON eteam.id = goal.teamid
WHERE goal.gtime <= 10;

-- # 6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT game.mdate, eteam.teamname  -- You can also write like this 'SELECT mdate, teamname'
FROM game
JOIN eteam
ON eteam.id = game.team1
WHERE eteam.coach = 'Fernando Santos';

-- # 7. List the player for every goal scored in a game where the staium was 'National Stadium, Warsaw'
SELECT goal.player
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw';

-- # 8. Show names of all players who scored a goal against Germany.
SELECT DISTINCT player
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'GER' OR team2 = 'GER')
AND teamid <> 'GER';

-- # 9. Show teamname and the total number of goals scored.
SELECT eteam.teamname, COUNT(*)
FROM eteam
JOIN goal
ON eteam.id = goal.teamid
GROUP BY eteam.teamname;

-- # 10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(*) goals_scored
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY stadium;

-- # 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(*) goals_scored
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;

-- # 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(*)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER'
GROUP BY matchid, mdate;

-- # 13. List every match with the goals scored by each team as shown.
SELECT game.mdate, game.team1, 
SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) score1,
game.team2,
SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, team1, team2;
