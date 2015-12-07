#!/bin/sh

PAPER=0
while read LINE; do
	oldIFS="$IFS"; IFS='x'; set -- $LINE; IFS="$oldIFS"	# 8x18x19
	L=$1
	W=$2
	H=$3
	SIDE1=$(( L * W ))
	SIDE2=$(( W * H ))
	SIDE3=$(( H * L ))

	MIN=999999
	for VALUE in $SIDE1 $SIDE2 $SIDE3; do
		test $VALUE -lt $MIN && MIN="$VALUE"
	done

	PAPER=$(( PAPER + (2*SIDE1) + (2*SIDE2) + (2*SIDE3) + MIN ))
done <'data.txt'

echo "$PAPER"
