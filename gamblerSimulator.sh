#!/bin/bash -x

echo Welcome to Gambling Simulator

#Variable
stake=100
PERCENTAGE=50
winningStake=$(( $stake + ($PERCENTAGE * $stake) / 100   ))
lossingStake=$(( $stake - ($PERCENTAGE * $stake) / 100 ))
BET=1

won=1
loose=0

while [ $stake -lt $winningStake ] && [ $stake -gt $lossingStake ]
do
	checkRandom=$((RANDOM%2))
	if [ $checkRandom -eq $won ]
	then
		stake=$(($stake + $BET))
	else
		stake=$((stake - $BET))
	fi
done
