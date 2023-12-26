#!/bin/bash

cash_desk=5000 #initialization of cash desk

sum2=0	 #initialization of total time 

customers=0 #initialization of  multitude of customers

time_left=300 #initialization of time that cash desk works for
while [ $sum2 -lt 300 ] && [  $cash_desk  -gt 0 ]	#valid check 
do
echo "Give the time of  customer in minutes:"
read time #enter the time of every customer stays in the cash desk
var1=`expr $time + $sum2`
while [ $var1 -gt 300 ] #valid check for time expired	
do
echo "You have get over the limit"
echo "Time left is:$time_left"
read time
var1=`expr $time + $sum2`
done 
echo "Give the amount of the customer:"
read amount #enter the amount that pay or paid by cash desk
var2=`expr $amount + $cash_desk`
while [ $var2 -lt 0 ] #valid check for empty cash desk
do
echo "You have get over the limit"
read amount
var2=`expr $amount + $cash_desk`
done
sum2=`expr $sum2 + $time`  #calculation of total time
time_left=`expr 300 - $sum2` #calculation of time left each time
cash_desk=`expr $cash_desk + $amount` #calculation of the amount that has the cash desk
customers=`expr $customers + 1` #increase the customer each time when this process finished
done
echo "The customers are:$customers" 	#print the number of customers
echo "The cash desk works for:$sum2 minutes"	#print the time that cash desk works for
