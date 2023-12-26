#!/bin/bash


#check of arguments
if [ $# -lt 2 ]; then
    echo "You have not given 2 arguments";
    exit 0;
fi

count1=0 #starting alphanumeric
count2=0 #alphanumeric as word
count3=0 #last alphanumeric

value=`cat $1 ` # open the file 
echo "$value"  #print the values inside the txt file
echo "The alphanumeric that we want to find is $2" #print the definition that we want
file=$1
sub=$2
firstcharacter1=${sub:0:1} #find the first letter of word
j=$((${#sub}-1))

#take the length of second argument
len=`expr "$2" : '.*'`
echo "The length of the input string is $len"
lastcharacter1=${sub: -len} #find the last letter of word
str4=$firstcharacter1
str5=$lastcharacter1


#print the file
y=1
while read line; do
#Reading each line of text
echo "Line No. $y : $line"
y=$((y+1))
done < $file


i=1
#find the counts and lines
while read line; do
word="$line"
str=$word
firstcharacter=${str:0:$len} #find the first alphanumeric  of word
str2=$firstcharacter
j=$((${#str}-1))
lastcharacter=${str: -len} #find the last alphanumeric of word
str3=$lastcharacter

#check the alphanumeric if there is in starting
if [[ "$str2" == *"$sub"* ]];then 
        echo "We found the starting alphanumeric"
        echo "Line No . $i"
        count1=`expr $count1 + 1 `
fi
#check the alphanumeric if there is as word
if [[ "$str" == *"$sub"* ]]; then
        echo "We found the alphanumeric as word"
        echo "Line No. $i"
        count2=`expr $count2 + 1 `
fi
#check the alphanumeric if there is at last  
if [[ "$str3" == *"$sub"* ]]; then
        echo "We found the last alphanumeric"
        echo "Line No . $i"
        count3=`expr $count3 + 1 `
fi

i=$((i+1))
done < $file

#print the counts
echo "The count of starting alphanumeric is : $count1"
echo "The count of alphanumeric as word is : $count2"
echo "The count of alphanumeric at final is : $count3" 
