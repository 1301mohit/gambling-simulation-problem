#!/bin/bash -x

echo Welcome to Gambling Simulator

#Variable
stake=100
PERCENTAGE=50
winningStake=$(( $stake + ($PERCENTAGE * $stake) / 100   ))
lossingStake=$(( $stake - ($PERCENTAGE * $stake) / 100 ))
BET=1
numberOfDays=20
totalAmount=0
wonCount=0
lossCount=0

#dictionary
declare -A amounts

won=1
loose=0
for (( day=1; day<=$numberOfDays; day++ ))
do
	stake=100
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
	amounts[$day]=$(($stake-100))
	totalAmount=$(($totalAmount+$(($stake-100))))
	if [ ${amounts[$day]} -eq 50 ]
	then
		((wonCount++))
	else
		((lossCount++))
	fi
done

echo ${!amounts[@]} 
echo ${amounts[@]} 
echo "Total Amount:"$totalAmount
echo "Total Won:"$wonCount
echo "Total loss:"$lossCount





