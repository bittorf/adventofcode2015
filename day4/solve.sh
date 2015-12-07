#!/bin/sh

read -r LINE <'data.txt'

I=0
while :;do
	HASH="$( printf '%s' "${LINE}$I" | md5sum )"

	case "$HASH" in
		'00000'*)
			break
		;;
	esac

	I=$(( I + 1 ))
done

echo "$I"
