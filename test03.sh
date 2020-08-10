#!/bin/sh


if [ -d ".shrug" ]
then
	rm -rf ".shrug/"
fi

rm -f a b c d e
rm -f output sample check

touch a b c d e
./shrug-init >> output 
echo "Initialized empty shrug repository in .shrug" >>sample
./shrug-add a >> output 
./shrug-commit -m 'first commit' >> output 
echo "Committed as commit 0" >>sample
./shrug-commit -m 'second commit' >> output 
echo "nothing to commit" >>sample

echo hello > a

./shrug-add a >> output 
./shrug-commit -m :a >> output 
echo "Committed as commit 1" >>sample
./shrug-commit -m again >> output 
echo "nothing to commit" >>sample
./shrug-add b c d >> output 
./shrug-commit -m 'second commit' >> output 
echo "Committed as commit 2" >>sample

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

