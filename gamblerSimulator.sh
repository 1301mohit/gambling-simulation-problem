#!/bin/bash -x

echo Welcome to Gambling Simulator

#Variable
stake=100
BET=1

won=1
loose=0

checkRandom=$((RANDOM%2))
if [ $checkRandom -eq $won ]
then
	stake=$(($stake + $BET))
else
	stake=$((stake - $BET))
fi
