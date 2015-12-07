#!/bin/bash

FLOOR=0

# ( -> floor+
# ) -> floor-
read -r LINE <'data.txt'

POS=0
while [ $POS -lt ${#LINE} ]; do {
	case "${LINE:$POS:1}" in
		'(') FLOOR=$(( FLOOR + 1 ));;
		')') FLOOR=$(( FLOOR - 1 ));;
	esac

	POS=$(( POS + 1 ))
} done

echo "$FLOOR"
