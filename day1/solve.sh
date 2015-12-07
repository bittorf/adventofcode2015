#!/bin/sh

read LINE <'data.txt'
FLOOR=0		# ( -> floor+ and ) -> floor-
POS=1
while [ $POS -le ${#LINE} ]; do
	CHAR="$( echo "$LINE" | cut -c$POS )"

	case "$CHAR" in
		'(') FLOOR=$(( FLOOR + 1 ));;
		')') FLOOR=$(( FLOOR - 1 ));;
	esac

	POS=$(( POS + 1 ))
done <'data.txt'

echo "$FLOOR"
