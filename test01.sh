#!/bin/sh


if [ -d ".shrug" ]
then
	rm -rf ".shrug/"
fi

rm -f a
rm -f output sample check

echo "Testing 01 start"

touch a
./shrug-add a >> output 
echo "./shrug-add: error: no .shrug directory containing shrug repository exists" >>sample
./shrug-init >> output 
echo "Initialized empty shrug repository in .shrug" >>sample
./shrug-add a >> output 
./shrug-commit -m 'first commit' >> output 
echo "Committed as commit 0" >>sample
./shrug-commit -a 'first commit' >> output 
echo "usage: shrug-commit [-a] -m commit-message" >>sample
./shrug-commit -m >> output 
echo "usage: shrug-commit [-a] -m commit-message" >>sample
./shrug-commit -m "" >> output 
echo "nothing to commit" >>sample
./shrug-commit -m '' >> output 
echo "nothing to commit" >>sample

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
rm -f a 




