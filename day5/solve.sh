#!/bin/sh

NICE_STRINGS=0

while read LINE; do
	case "$LINE" in
		*'ab'*|*'cd'*|*'pq'*|*'xy'*)
			LINE=
		;;
	esac

	POS=1
	VOWELS=0
	DOUBLE_CHARS=
	OLDCHAR=
	while [ $POS -le ${#LINE} ]; do
		CHAR="$( echo "$LINE" | cut -c$POS )"
		case "$CHAR" in
			'a'|'A'|'e'|'E'|'i'|'I'|'o'|'O'|'u'|'U')
				VOWELS=$(( VOWELS + 1 ))
			;;
		esac

		test "$OLDCHAR" = "$CHAR" && DOUBLE_CHARS='true'
		OLDCHAR="$CHAR"

		POS=$(( POS + 1 ))
	done

	test $VOWELS -ge 3 && {
		test -n "$DOUBLE_CHARS" && NICE_STRINGS=$(( NICE_STRINGS + 1 ))
	}
done <'data.txt'

echo "$NICE_STRINGS"
