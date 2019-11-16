#!/bin/bash -x

echo Welcome to Gambling Simulator

#Constants
STAKE=100
PERCENTAGE=50
BET=1
NUMBER_OF_DAYS=5

#Variable
winningStake=$(( $STAKE + ($PERCENTAGE * $STAKE) / 100 ))
lossingStake=$(( $STAKE - ($PERCENTAGE * $STAKE) / 100 ))
totalAmount=0
wonCount=0
lossCount=0
count=1
previousTotalAmount=0
lukiestDay=0
unLukiestDay=0
minimumAmountForContinue=0
checkForWonOrLoss=50
won=1

#dictionary
declare -A amounts
declare -A resultantAmount

function luckiestDay()
{
	for k in "${!resultantAmount[@]}" 
	do 
		echo $k ' - ' ${resultantAmount["$k"]} 
	done | 
	sort -rn -k3 	

	luckyDay=`for k in "${!resultantAmount[@]}" 
	do 
		echo $k ' - ' ${resultantAmount["$k"]} 
	done | 
	sort -rn -k3 | head -1`
	
	echo "LuckiestDay:"$luckyDay
}

function unLuckiestDay()
{
	for k in "${!resultantAmount[@]}" 
	do 
		echo $k ' - ' ${resultantAmount["$k"]} 
	done | 
	sort -rn -k3 	

	luckyDay=`for k in "${!resultantAmount[@]}" 
	do 
		echo $k ' - ' ${resultantAmount["$k"]} 
	done | 
	sort -rn -k3 | tail -1`
	
	echo "UnLuckiestDay:"$luckyDay
}

function bet() 
{
	checkRandom=$((RANDOM%2))
	if [ $checkRandom -eq $won ]
	then
		STAKE=$(($1 + $BET))
		echo $STAKE
	else
		STAKE=$(($1 - $BET))
		echo $STAKE
	fi
}

function resign()
{
	while [ $STAKE -lt $winningStake ] && [ $STAKE -gt $lossingStake ]
	do
		STAKE="$( bet $STAKE )" 
	done
	echo $STAKE
}

function forMultipleDays()
{
	for (( day=1; day<=$NUMBER_OF_DAYS; day++ ))
	do
		STAKE=100
		STAKE="$( resign $STAKE )"
		amounts[$day]=$(($STAKE-100))
		totalAmount=$(($totalAmount+$(($STAKE-100))))
		resultantAmount["day"]=$totalAmount
	done
	echo $totalAmount
}

function gambler()
{
	while [ $totalAmount -ge $minimumAmountForContinue ]
	do
		totalAmount="$( forMultipleDays )"
		luckiestDay
		unLuckiestDay
	done
}

gambler

echo "Total Amount:"$totalAmount
echo "resultant amount key:"${!resultantAmount[@]}
echo "resultant amount value:"${resultantAmount[@]}
echo "Luckiest day:"$lukiestDay
echo "UnLuckiest day:"$unLukiestDay


