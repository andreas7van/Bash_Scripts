#!/bin/bash

# resets query counters
metritis1=0
metritis2=0
metritis3=0
metritis4=0
metritis5=0

#  check for arguments
if [ ! $# -eq 2 ]; then
	echo "Two arguments required"
	exit 0
fi


# check for arguments to be positive numbers
if ! [[ "$1" =~ ^[0-9]+$ ]]  ||  [ $1 -lt 0 ]
then
    echo "The first argument must be positive number"
    exit 0;
fi

if ! [[ "$2" =~ ^[0-9]+$ ]]  ||  [ $2 -lt 0 ]
then
    echo "The second argument must be positive number"
    exit 0;
fi


# passage of definitions
dikaiwmata=$1

imeres=$((-1*$2))                    # so that it can detect up 2 days 



# construction of boards with paths and meters
declare -A pinakasI
declare -A pinakasII
declare -A pinakasIII
declare -A pinakasIV
declare -A pinakasV


# expects the user to enter the name of the folder
echo -n "Fill the directory name (or E to exit) :  "
read fakelos


while [ $fakelos != "E" ]; do

    # check for folder
    if [[ -d $fakelos ]]; then

        # counters of results for each sub-query
        metritisPinakaI=${pinakasI[$fakelos]}
        metritisPinakaII=${pinakasII[$fakelos]}
        metritisPinakaIII=${pinakasIII[$fakelos]}
        metritisPinakaIV=${pinakasIV[$fakelos]}
        metritisPinakaV=${pinakasV[$fakelos]}


        # sub-query 1
	    count=$(find $fakelos -type f -perm $dikaiwmata  | wc -l)
	    echo "Ypoerwtima 1 apotelesmata= "$count

	    metritis1=$(( $metritis1 + $count ))
	    metritisPinakaI=$(( $metritisPinakaI + $count ))

	    find $fakelos -type f -perm $dikaiwmata


        echo "*****************************************************"


        # sub-query 2
        count=$(find $fakelos -type f -ctime $imeres | wc -l)
        echo "Ypoerwtima 2 apotelesmata= "$count

	    metritis2=$(( $metritis2 + $count ))
	    metritisPinakaII=$(( $metritisPinakaII + $count ))

	    find $fakelos -type f -ctime $imeres


        echo "*****************************************************"

        # sub-query 3
        count=$(find $fakelos -type d -atime $imeres | wc -l)
        echo "Ypoerwtima 3 apotelesmata= "$count

	    metritis3=$(( $metritis3 + $count ))
	    metritisPinakaIII=$(( $metritisPinakaIII + $count ))

	    find $fakelos -type d -atime $imeres

        echo "*****************************************************"

        # sub-query 4
        count=$(find $fakelos -type s,p | wc -l)
        echo "Ypoerwtima 4 apotelesmata= "$count

	    metritis4=$(( $metritis4 + $count ))
	    metritisPinakaIV=$(( $metritisPinakaIV + $count ))

	    find $fakelos -type s,p

        echo "*****************************************************"

        # sub-query 5
        count=$(find $fakelos -maxdepth 1 -type f  -size 0 | wc -l)
        echo "Ypoerwtima 5 apotelesmata= "$count

	    metritis5=$(( $metritis5 + $count ))
	    metritisPinakaV=$(( $metritisPinakaV + $count ))
	    find $fakelos -maxdepth 1 -type f -size 0

        # transfer of results to tables
        pinakasI+=([$fakelos]=$metritisPinakaI)
        pinakasII+=([$fakelos]=$metritisPinakaII)
        pinakasIII+=([$fakelos]=$metritisPinakaIII)
        pinakasIV+=([$fakelos]=$metritisPinakaIV)
        pinakasV+=([$fakelos]=$metritisPinakaV)
    else
        echo $fakelos" cannot be processed or is not folder"

    fi

    # expects the user to enter the name of the folder
    echo -n "Fill the directory name (or E to exit) :  "
    read fakelos

done

# print all the results
echo  "------Final Count-------"

echo  "Ypoerwtima 1= "$metritis1

echo  "Ypoerwtima 2= "$metritis2

echo  "Ypoerwtima 3= "$metritis3

echo  "Ypoerwtima 4= "$metritis4

echo  "Ypoerwtima 5= "$metritis5

echo "*****************************************************"

# view each result per path-(folder and file)

for monopati in "${!pinakasI[@]}"
do
    echo "Monopati "$monopati" Ypoerwtima 1= "${pinakasI[$monopati]}", Ypoerwtima 2=: "${pinakasII[$monopati]}", Ypoerwtima 3= "${pinakasIII[$monopati]}", Ypoerwtima 4= "${pinakasIV[$monopati]}", Ypoerwtima 5= "${pinakasV[$monopati]}
done


exit 0

