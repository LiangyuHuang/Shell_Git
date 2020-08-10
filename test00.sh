#!/bin/sh


if [ -d ".shrug" ]
then
	rm -rf ".shrug"
fi

rm -f output sample check


echo "Testing 00 start"

./shrug-add a >> output 
./shrug-init >> output 
./shrug-init >> output 

echo "./shrug-add: error: no .shrug directory containing shrug repository exists" >>sample
echo "Initialized empty shrug repository in .shrug" >>sample
# since in code ,the command must be:
# $0: error: .shrug already exists
# there must be "./" in front of "shrug-init"
echo "./shrug-init: error: .shrug already exists" >>sample


diff -u "sample" "output" >check

if [ $? == 1 ]
then
    cat check
    echo "Test Failed"
else
    echo "Test Passed"
fi



rm output sample check 2> /dev/null
rm -rf ".shrug/"

