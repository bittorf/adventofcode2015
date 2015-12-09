#!/bin/sh

array_put()
{
        local x="$1"
        local y="$2"
        local value="$3"
#echo "$x/$y -> $value"
        eval ARRAY_${x}_${y}='$value'
}

array_get()
{
        local x="$1"
        local y="$2"

        # set a global var
	eval FIELD="\"\${ARRAY_${x}_${y}:- }\""
}

# toggle 173,401 through 496,407
# turn off 660,55 through 986,197

J=0
while read LINE; do
	J=$(( J + 1 ))

	case "$LINE" in
		'toggle'*)
			LINE="NOP $LINE"
			TOGGLE='true'
		;;
		*)
			TOGGLE=
		;;
	esac

	echo "$(date) - $J - $LINE"
	set -- $LINE

	VALUE="$2"	# on|off|toggle
	X1=${3%,*}
	Y1=${3#*,}
	X2=${5%,*}
	Y2=${5#*,}

	for X in $(seq $X1 $X2); do
		for Y in $(seq $Y1 $Y2); do
			case "$TOGGLE" in
				'');;
				*)
					array_get $X $Y
					case "$FIELD" in
						on) VALUE='off';;
						*) VALUE='on';;
					esac
				;;
			esac

			array_put $X $Y "$VALUE"
		done
	done
done <'data.txt'

I=0
for X in $(seq 0 999); do
	for Y in $(seq 0 999); do
		array_get $X $Y
		test "$FIELD" = 'on' && I=$(( I + 1 ))
	done
done

echo "$I"	# = 400410 needs ~60 hours
