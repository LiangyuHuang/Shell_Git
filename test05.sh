#!/bin/sh


if [ -d ".shrug" ]
then
	rm -rf ".shrug/"
fi

echo  "Testing start 05"

rm -f a b c d e
rm -f output sample check

touch a b c d e
./shrug-add a >> output 
echo "./shrug-add: error: no .shrug directory containing shrug repository exists" >>sample
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
./shrug-commit -m bcd >> output 
echo "Committed as commit 2" >>sample
./shrug-log >> output
echo "2 bcd" >>sample
echo "1 :a" >>sample
echo "0 first commit" >>sample
./shrug-add b c d e >> output 
./shrug-commit -m bcde >> output 
echo "Committed as commit 3" >>sample
./shrug-log >> output
echo "3 bcde" >>sample
echo "2 bcd" >>sample
echo "1 :a" >>sample
./shrug-show 0:a >> output
echo "0 first commit" >>sample



./shrug-show 1:a >> output
./shrug-show 2:a >> output
./shrug-show 0:b >> output
./shrug-show 1:b >> output
./shrug-show 2:e >> output
./shrug-show 3:c >> output
./shrug-show 4:c >> output
./shrug-show :c >> output
echo c >> c
./shrug-add c >> output 
./shrug-commit -m c >> output
./shrug-show :c >> output


echo "hello" >>sample
echo "hello" >>sample
echo "./shrug-show: error: 'b' not found in commit 0" >>sample 
echo "./shrug-show: error: 'b' not found in commit 1" >>sample 
echo "./shrug-show: error: 'e' not found in commit 2" >>sample 
echo "./shrug-show: error: unknown commit '4'" >>sample
echo "Committed as commit 4" >> sample
echo "c" >> sample

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

rm -f a b c d e


