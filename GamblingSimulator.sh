#!/bin/bash -x

#DISPLAYING WELCOME MESSAGE
echo "Welcome To Gambling Simulator"

#CONSTANTS
BET=1;
WIN=1;
WINNING_CONDITION=150;
LOSSING_CONDITION=50;

#VARIABLE
stake=100;

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
}

#CALLING FUNCTION
gamble
