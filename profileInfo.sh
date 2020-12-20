# line="This script will show user info"
# set $line
# echo $1
# echo $2
# echo $3

# #           INTERNAL FIELD SEPARATOR
# IFS=:
# str="Shell:Scripting:is:fun"
# set $str
# n=1
# echo $1 $2 $3 $4 $5

echo "Enter UserName: "
read user_name

line=`grep $user_name /etc/passwd`
IFS=:
set $line
echo "UserName: $1"
# $2 => Encrypted Password
echo "User ID: $3"
echo "Group ID: $4"
echo "Comment Field: $5"
echo "Home Folder: $6"
echo "Default Shell: $7"