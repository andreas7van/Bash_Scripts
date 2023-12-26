#!/bin/bash

set -eu -o pipefail

echo   "write your choice"
read choice
choice_lc=`echo $choice | tr '[A-Z]' '[a-z]'`
while [ "$choice_lc" != "num"  -a  "$choice_lc" != "rom" ];do
        echo  "Try again"
        read choice
        choice_lc=`echo $choice | tr '[A-Z]' '[a-z]'`
done




if [ $choice == "num"  ];then
        echo "Enter a number"
	read number

# Test that it is valid
	while [ $number -le 0 ];
	do
		echo "choose a number between 0-9"
		read number
	done

# First we convert the number to a Roman Numeral unary representation
# then we replace appropriate chunks of tokens and end up with a Roman Numeral
# representation.
roman_numerals=$(
    printf "%.sI" $(seq 1 ${number}) |
    sed 's/IIIII/V/g' |
    sed 's/IIII/IV/g' |
    sed 's/VV/X/g' |
    sed 's/VIV/IX/g' |
    sed 's/XXXXX/L/g' | 
    sed 's/XXXX/XL/g' |
    sed 's/LL/C/g' |
    sed 's/LXL/XC/g' |
    sed 's/CCCCC/D/g' |
    sed 's/CCCC/CD/g' |
    sed 's/DD/M/g' |
    sed 's/DCD/CM/g'
)

 echo ${number} is ${roman_numerals}
else
	echo "enter roman character"



echo "CHOOSE CHARACTERS BETWEEN I,V,X,L,C,D,M"

read roman_numerals

roman_numerals=$(echo $roman_numerals | tr a-z A-Z)

# Test that it is valid
[[ "${roman_numerals//[IVXLCDM]/}" == "" ]] || \
    { echo Roman numerals ${roman_numerals} contains invalid characters ; \
    exit 1 ;}






# We want to replace all tokens to eventually have
# all I's, remove new lines and count the characters.
number=$(
    echo ${roman_numerals} |
    sed 's/CM/DCD/g' |
    sed 's/M/DD/g' |
    sed 's/CD/CCCC/g' |
    sed 's/D/CCCCC/g' |
    sed 's/XC/LXL/g' |
    sed 's/C/LL/g' |
    sed 's/XL/XXXX/g' |
    sed 's/L/XXXXX/g' |
    sed 's/IX/VIV/g' |
    sed 's/X/VV/g' |
    sed 's/IV/IIII/g' |
    sed 's/V/IIIII/g' |
    tr -d '\n' |
    wc -m
)

echo ${roman_numerals} is ${number}
fi


