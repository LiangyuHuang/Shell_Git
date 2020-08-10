#!/bin/sh


if [ -d ".shrug" ]
then
	rm -rf ".shrug/"
fi

echo  "Testing start 09"

rm -f a 
rm -f output sample check

./shrug-init >>output
echo line 2 >a
./shrug-add a >> output
./shrug-commit -a -m commit-0 >>output 
echo line 1 >>a
./shrug-rm a >>output 
echo line 0 >>a
./shrug-rm --cached a >>output 
./shrug-commit -m commit-1 >>output 
./shrug-rm --cached a >>output 
./shrug-add a >>output 
./shrug-commit -m commit-2 >>output 
cat "a" >>output
./shrug-log >> output
./shrug-show 2:a >> output
./shrug-status



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


