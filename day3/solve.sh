#!/bin/sh

read LINE <'data.txt'

array_put()
{
        local x="$1"
        local y="$2"
        local value="$3"

        eval ARRAY_${x}_${y}='$value'
}

array_get()
{
        local x="$1"
        local y="$2"

        # set a global var
	eval FIELD="\"\${ARRAY_${x}_${y}:- }\""
}

array_add_gift()
{
	array_get $X $Y
	GIFTS="${FIELD:-0}"
	GIFTS=$(( GIFTS + 1 ))
	test $GIFTS -eq 1 && LUCKY_HOUSES=$(( LUCKY_HOUSES + 1 ))
	array_put $X $Y "$GIFTS"
}

LUCKY_HOUSES=0
POS=1
X=1000
Y=1000
# LINE='^>v<'
while [ $POS -le ${#LINE} ]; do
	CHAR="$( echo "$LINE" | cut -c$POS )"

	array_add_gift
	case "$CHAR" in
		'^') Y=$(( Y + 1 ));;
		'v') Y=$(( Y - 1 ));;
		'>') X=$(( X + 1 ));;
		'<') X=$(( X - 1 ));;
	esac

	POS=$(( POS + 1 ))
done <'data.txt'

array_add_gift

echo "$LUCKY_HOUSES"
