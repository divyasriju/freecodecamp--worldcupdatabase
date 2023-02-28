#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo  "$($PSQL "SELECT SUM(winner_goals)+sum(opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo  "$($PSQL "SELECT avg(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo  "$($PSQL "SELECT round(avg(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT round(avg(winner_goals)+avg(opponent_goals),16) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo  "$($PSQL "SELECT max(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo  "$($PSQL "SELECT count(*) FROM games where winner_goals>2 ")"

echo -e "\nWinner of the 2018 tournament team name:"
echo  "$($PSQL "SELECT teams.name from teams inner join games on teams.team_id=games.winner_id where round='Final' and year=2018 ")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT teams.name from games inner join teams on games.winner_id=teams.team_id where round='Eighth-Final' and year=2014 union SELECT teams.name from games inner join teams on games.opponent_id=teams.team_id where round='Eighth-Final' and year=2014 ")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT distinct(teams.name) from games inner join teams on games.winner_id=teams.team_id order by teams.name")"

echo -e "\nYear and team name of all the champions:"
echo  "$($PSQL "SELECT games.year,teams.name from games inner join teams on games.winner_id=teams.team_id where round='Final' order by games.year")"


echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name from teams where name like 'Co%' ")"
