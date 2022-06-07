#!/bin/bash

states=('NSW' 'QLD' 'VIC' 'TAS' 'ACT')

for state in ${states[@]};
do
	if [ $state == 'ACT' ];
	then
		echo "ACT is the best"
	else
		echo "I am not fond of ACT"
	fi
done
