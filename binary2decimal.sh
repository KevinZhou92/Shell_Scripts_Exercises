#! /bin/bash 
help() {
	cat << EOF
	binary2decimal - Convert binary number to decimal number
	USAGE: binary2decimal [-h] binarynum
	OPTIONS: -h help
EOF
	exit 0
}
# This function get the last char of the input
lastchar() {
	if [ -z "$1" ]; then
		return_val=""
		return
	fi
	num_of_char=`echo -n $1 | wc -c | sed 's/ //g'`
    return_val=`echo -n $1 | cut -c $num_of_char`
}

# This function chop the last char from the input
chop() {
	num_of_char=`echo -n $1 | wc -c | sed 's/ //g'`
	if [ "$num_of_char" -le 1 ]; then 
		return_val=""
		return
	fi
	return_val=`echo -n $1 | cut -c1-$(($num_of_char-1))`
}

error() {
	echo "$1"
	exit 1
}

while [ -n "$1" ]; do 
	case "$1" in 
		-h) help; shift 1;;
		--) shift; break;;
		-*) error "ERROR: No such option $1, -h for help";;
		*) break;;
	esac
done

[ -n  "`echo -n $1 | sed "s/[0-1]//g" | sed 's/ //g'`" ] && help

num=0;
weight=1

binary_num=$1
binary_orig=$binary_num

while [ -n "$binary_num" ]; do
	lastchar $binary_num
	if [ "$return_val" -ne 0 ]; then
		num=$(($num + $weight))
	fi
	chop $binary_num
	binary_num=$return_val 
	weight=$(expr $weight "*" 2)
done

echo "The result of converting $1 to decimal number is: $num."