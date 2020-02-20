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
TOTAL_DAYS=30;
LIMIT=0;

#VARIABLES
day=0;
stake=100;
winDay=0;
lossDay=0;
winPerDay=0;
lossPerDay=0;
totalStake=0;
resultPerDay=0;

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

#FUNCTION TO GET LUCKY DAY
function getLuckyDay() {
	echo " Luckiest Day In Month And Total Stake Player Had = "
	for i in ${!totalMoneyPerDay[@]}
	do
		echo " $i ${totalMoneyPerDay[$i]}"
	done | sort -k2 -rn | head -1
}

#FUNCTION TO GET UNLUCKY DAY
function getUnluckDay() {
	echo " Unluckiest Day In Month And Total Stake Player Had = "
	for i in ${!totalMoneyPerDay[@]}
	do
		echo " $i ${totalMoneyPerDay[$i]}"
	done | sort -k2 -rn | tail -1
}

#CALLING FUNCTION FOR TOTAL NUMBER OF DAYS IN MONTH
while [[ $stake -ge $LIMIT && $totalStake -ge $LIMIT ]]
do
	for (( day=1; day<=$TOTAL_DAYS; day++ ))
	do
		resultPerDay=$(gamble)
		if [[ $resultPerDay -gt $stake ]]
		then
			((winDay++))
			resultPerDay=$(($resultPerDay-$stake))
			winPerDay=$(($winPerDay+$resultPerDay))
		else
			((lossDay++))
			resultPerDay=$(($resultPerDay-$stake))
			lossPerDay=$(($lossPerDay+$resultPerDay))
		fi
		totalStake=$(($totalStake+$resultPerDay))
		totalMoneyPerDay[day$day]=$totalStake
	done
#DISPLAYING TOTAL AMOUNT WON OR LOST
	if [[ $totalStake -ge $LIMIT ]]
	then
		echo "Total Amount Won After 30 Days in A Month = $totalStake "
	else
		echo "Total Amount Lost After 30 Days in A Month= $totalStake "
	fi
#DISPLAYING NUMBER OF DAYS WON AND LOST IN A MONTH
	echo " Total Days In A Month Player Won = $winDay "
	echo " Total Amount Won after $winDay Days = $winPerDay "
	echo " Total Days In A Month Player Lost = $lossDay "
	echo " Total Amount Lost after $lossDay Days = $lossPerDay "
#REINITIALIZING VARIABLES FOR NEXT MONTH
	winDay=0;
	lossDay=0;
	winPerDay=0;
	lossPerDay=0;
#CALLING FUNCTION TO GET LUCKY DAY
	getLuckyDay
#CALLING FUNCTION TO GET UNLUCK DAY
	getUnluckDay
	echo "----------------------- MONTH END ---------------------"
done
