#!/bin/bash -x

#DISPLAYING WELCOME MESSAGE
echo "Welcome To Gambling Simulator"

#DECLARING DICTIONARY
declare -A totalMoneyPerDay

#CONSTANTS
BET=1;
WIN=1;
WINNING_CONDITION=150;
LOSSING_CONDITION=50;
TOTAL_DAYS=20;
LIMIT=0;

#VARIABLES
stake=100;
totalStake=0;
resultPerDay=0;
day=0;

#FUNCTION TO CHECK CONDITION AND PLAY
function gamble() {
	while [[ $stake -gt $LOSSING_CONDITION && $stake -lt $WINNING_CONDITION ]]
	do
		if [[ $(( RANDOM%2 )) -eq $WIN ]]
		then
			stake=$(($stake+$BET))
		else
			stake=$(($stake-$BET))
		fi
	done
	echo $stake
	stake=100;
}

#CALLING FUNCTION FOR TOTAL NUMBER OF DAYS
for (( day=1; day<=$TOTAL_DAYS; day++ ))
do
	resultPerDay=$(gamble)
	if [[ $resultPerDay -gt $stake ]]
	then
		resultPerDay=$(($resultPerDay-$stake))
	else
		resultPerDay=$(($resultPerDay-$stake))
	fi
	totalMoneyPerDay[day $day]=$resultPerDay
	totalStake=$(($totalStake+$resultPerDay))
done

#DISPLAYING TOTAL AMOUNT WON OR LOST
if [[ $totalStake -gt $LIMIT ]]
then
	echo "Total Amount Won After 20 Days = $totalStake"
else
	echo "Total Amount Lost After 20 Days= $totalStake"
fi
