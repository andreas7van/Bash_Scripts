#!/bin/bash

if [ $# -lt 1 ]; then

    echo "You have not given an argument";
    exit 0;
fi

#if it is between 0 kai 14
if (($1 <= 0 || $1 > 14)); then
    echo 'The argument is not between 0-14';
    exit 0;
fi

apotelesmata=0
count=0

# for each file in the current folder, it counts the results
for f in *
do
    grammi=`stat -c '%w' "$f"`

    # if the field is empty then it ignores the file
    if [ "$grammi" == "-" ]
    then
        continue;
    else
        #else, it then isolates the field with time
        wra=`echo $grammi | cut -d' ' -f2 | cut -d':' -f1`

	# if the time ends with the time the file was created
	let wra=wra+0

        if [ "$1" -eq "$wra" ]
	then
		let apotelesmata++
	fi
    fi
done

# if there are results
if (( apotelesmata > 0 ))
then
	rm -f timefile
	touch timefile

	# for each file in the current folder it writes the file if it exists
	for f in *
	do
	    grammi=`stat -c '%w' "$f"`

	    # if the field is empty then it ignores the file
	    if [ "$grammi" == "-" ]
	    then
		continue;
	    else
		#else, it then isolates the field with time
		wra=`echo $grammi | cut -d' ' -f2 | cut -d':' -f1`

		# if the time ends with the time the file was created
		let wra=wra+0
		if [ "$1" -eq "$wra" ]
		then
			count=`expr $count + 1` 
			echo $f >> timefile
		fi
	    fi
	done
else
	echo "There are no files created on time "$1
fi
echo "The number of files that create are: $count"
