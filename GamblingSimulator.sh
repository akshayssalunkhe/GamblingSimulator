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
stake=100;
totalStake=0;
resultPerDay=0;
day=0;
month=0;
winDay=0;
lossDay=0;
winPerDay=0;
lossPerDay=0;

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

#CALLING FUNCTION FOR TOTAL NUMBER OF DAYS IN MONTH AND FOR EACH MONTH
for (( month=1; $month<=12; month++ ))
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
	if [[ $totalStake -gt $LIMIT ]]
	then
		echo "Total Amount Won After 30 Days in Month $month = $totalStake"
	else
		echo "Total Amount Lost After 30 Days in Month $month= $totalStake"
	fi
	echo " Total Win Days In Month $month = $winDay "
	echo " Total Amount Won In $winDay Days = $winPerDay"
	echo " Total Loss Days In Month $month = $lossDay "
	echo " Total Amount Lost In $lossDay Days = $lossPerDay"
#REINITIALIZING VARIABLES FOR NEXT MONTH
	winDay=0;
	lossDay=0;
	totalStake=0;
	winPerDay=0;
	lossPerDay=0;
#SORTING DICTIONARY TO FIND LUCKIEST
	echo " Luckiest Day In Month $month And Total Stake He Had = "
	for i in ${!totalMoneyPerDay[@]}
	do
		echo " $i ${totalMoneyPerDay[$i]}"
	done | sort -k2 -rn | head -1
#SORTING DICTIONARY TO FIND UNLUCKIEST DAY
	echo " UnLuckiest Day In Month $month And Total Stake He Had = "
	for i in ${!totalMoneyPerDay[@]}
	do
		echo " $i ${totalMoneyPerDay[$i]}"
	done | sort -k2 -rn | tail -1
	echo "--------------------MONTHEND------------------------"
done
