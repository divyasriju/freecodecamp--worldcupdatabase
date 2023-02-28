#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo "$($PSQL "TRUNCATE TABLE games, teams;")"

GET_TEAM_ID() {
  TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$1'")

  if [[ -z $TEAM_ID ]]
  then

    INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$1')")

    if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
    then

      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$1'")

    fi

  fi

  echo "$TEAM_ID"
}

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then

    WINNER_ID=$(GET_TEAM_ID "$WINNER")
    OPPONENT_ID=$(GET_TEAM_ID "$OPPONENT")

    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES($YEAR, '$ROUND', $WINNER_GOALS, $OPPONENT_GOALS, $WINNER_ID, $OPPONENT_ID)")

    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then

    echo "Inserted into games, $YEAR, $ROUND, $WINNER_GOALS, $OPPONENT_GOALS, $WINNER_ID, $OPPONENT_ID"

    fi

  fi
done
