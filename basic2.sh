#! /bin/bash

#       LOOPS
# UNTIL loop
# a=0
# until [ ! $a -lt 10 ]
# do
#    echo $a
#    a=`expr $a + 1`
# done

# SIMPLE FOR LOOP
# NAMES="Brad Kevin Alice Mark"       # name ARRAY
# for NAME in $NAMES
#   do
#     echo "Hello $NAME"
# done

# FOR LOOP TO RENAME FILES
# FILES=$(ls *.txt)
# NEW="new"
# for FILE in $FILES  
#   do
#     echo "Renaming $FILE to new-$FILE"
#     mv $FILE $NEW-$FILE
# done

# WHILE LOOP - READ THROUGH A FILE LINE BY LINE
# LINE=1
# while read -r CURRENT_LINE
#   do
#     echo "$LINE: $CURRENT_LINE"
#     ((LINE++))
# done < "./new-1.txt"



#           FUNCTION
# function sayHello() {
#   echo "Hello World"
# }
# sayHello

# FUNCTION WITH PARAMS
# function greet() {
#   echo "Hello, I am $1 and I am $2"
# }
# greet "Brad" "36"


#           CREATE FOLDER AND WRITE TO A FILE
# mkdir hello
# touch "hello/world.txt"
# echo "Hello World" >> "hello/world.txt"
# echo "Created hello/world.txt"