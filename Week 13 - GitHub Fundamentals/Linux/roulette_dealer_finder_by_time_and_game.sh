#!/bin/bash

# $1 is date
# $2 is time
# $3 is AM/PM
# $4 game being played

if [ $4 = 'Blackjack' ];
then
	awk -F'\t' '{print $1, $2}' $1_Dealer_schedule | grep $2 | grep $3
elif [ $4 = 'Roulette' ];
then
	awk -F'\t' '{print $1, $3}' $1_Dealer_schedule | grep $2 | grep $3
elif [ $4 = 'Poker' ];
then
	awk -F'\t' '{print $1, $4}' $1_Dealer_schedule | grep $2 | grep $3
fi
