#! /bin/bash

# To see available shells
# cat /etc/shells
# For Debugging
# bash -x {{FILE_NAME}}

#           ECHO COMMAND
# echo "Hello World"

#           VARIABLES
# NAME=("John")
# NUM1=31 #NO_SPACE
# NUM2=5

# var=3
# readonly var        # var becomes CONSTANT
# var = 50 # NOT ALLOWED
# echo $var


#           USER INPUT
# echo "Enter your first name: "
# read fname
# read -p "Enter your last name: " lname
# echo "Full Name => $fname $lname"
# read -sp "Enter Secret Key: " key # s => for SECURE ENTRY
# echo "Your key is $key"

#           ARGUMENTS
# echo $0 $1 $2
# args=("$@") #No SPACE
# echo ${args[0]} ${args[1]} ${args[2]}
# echo $@
# ./basic1.sh Hello World


#           CONDITIONAL STATEMENTS
# SIMPLE IF STATEMENT
# if [ "$NAME" == "Brad" ]
# then
#   echo "Your name is Brad"
# fi

# IF-ELSE
# if [ "$NAME" == "Brad" ]
# then
#   echo "Your name is Brad"
# else 
#   echo "Your name is NOT Brad"
# fi

# ELSE-IF (elif)
# if [ "$NAME" == "Brad" ]
# then
#   echo "Your name is Brad"
# elif [ "$NAME" == "Jack" ]
# then  
#   echo "Your name is Jack"
# else 
#   echo "Your name is NOT Brad or Jack"
# fi

#           COMPARISON
# if [ "$NUM1" -gt "$NUM2" ]
# then
#   echo "$NUM1 is greater than $NUM2"
# else
#   echo "$NUM1 is less than $NUM2"
# fi

########
# val1 -eq val2 Returns true if the values are equal
# val1 -ne val2 Returns true if the values are not equal
# val1 -gt val2 Returns true if val1 is greater than val2
# val1 -ge val2 Returns true if val1 is greater than or equal to val2
# val1 -lt val2 Returns true if val1 is less than val2
# val1 -le val2 Returns true if val1 is less than or equal to val2
########



#           FILE CONDITIONS
# FILE="test.txt"
# if [ -e "$FILE" ]
# then
#   echo "$FILE exists"
# else
#   echo "$FILE does NOT exist"
# fi

########
# -d file   True if the file is a directory
# -e file   True if the file exists (note that this is not particularly portable, thus -f is generally used)
# -f file   True if the provided string is a file
# -g file   True if the group id is set on a file
# -r file   True if the file is readable
# -s file   True if the file has a non-zero size
# -u    True if the user id is set on a file
# -w    True if the file is writable
# -x    True if the file is an executable
########

#CASE STATEMENT
# read -p "Are you 21 or over? Y/N " ANSWER
# case "$ANSWER" in 
#   [yY] | [yY][eE][sS])
#     echo "You can have a beer :)"
#     ;;
#   [nN] | [nN][oO])
#     echo "Sorry, no drinking"
#     ;;
#   *)
#     echo "Please enter y/yes or n/no"
#     ;;
# esac
