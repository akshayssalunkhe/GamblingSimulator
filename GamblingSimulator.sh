#!/bin/bash -x

#DISPLAYING WELCOME MESSAGE
echo "Welcome To Gambling Simulator"

#CONSTANTS
BET=1;
WIN=1;

#VARIABLE
stake=100;

#CHECKING FOR CONDITION
function gamble() {
	if [[ $(( RANDOM%2 )) -eq $WIN ]]
	then
		stake=$(($stake+$BET))
	else
		stake=$(($stake-$BET))
	fi
}

#CALLING FUNCTION
gamble
