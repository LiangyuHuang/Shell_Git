#!/bin/sh


if [ -d ".shrug" ]
then
	rm -rf ".shrug/"
fi

echo  "Testing start 08"

rm -f a b c d e
rm -f output sample check

touch a b c d e
./shrug-add a >> output 
./shrug-init >> output 
./shrug-add a >> output 
./shrug-commit -m a >> output 
./shrug-commit -m aaa >> output 
./shrug-add b c >> output
echo d >> d
echo e >> e
./shrug-commit -m bc >> output 
./shrug-rm --cached a >> output 
./shrug-add e  >> output 
./shrug-rm --cached e >> output 
./shrug-rm e >> output 
./shrug-rm a >> output 
./shrug-rm --forced e >> output 
./shrug-commit -m e >> output 
./shrug-rm --force e >> output
./shrug-show :e >> output
./shrug-show 0:e >> output
./shrug-show 1:e >> output
./shrug-show 2:e >> output
./shrug-show 3:e >> output
./shrug-add e  >> output 
./shrug-commit -m e >> output 

./shrug-show 3:e >> output
rm e
./shrug-add d >> output
./shrug-commit -m delete-e >> output 
./shrug-show 4:e >> output
./shrug-show 4:d >> output

./shrug-add e >> output
./shrug-commit -m delete-e >> output 
./shrug-show 5:d >> output
./shrug-show 5:e >> output
./shrug-show :e >> output


echo "./shrug-add: error: no .shrug directory containing shrug repository exists" >>sample
echo "Initialized empty shrug repository in .shrug" >>sample
echo "Committed as commit 0" >>sample
echo "nothing to commit" >>sample
echo "Committed as commit 1" >>sample
echo "./shrug-rm: error: 'e' is not in the shrug repository" >>sample
echo "./shrug-rm: error: 'a' is not in the shrug repository" >>sample
echo "usage: shrug-rm [--force] [--cached] <filenames>" >>sample
echo "Committed as commit 2" >>sample
echo "./shrug-rm: error: 'e' is not in the shrug repository" >>sample
echo "./shrug-show: error: 'e' not found in index" >>sample
echo "./shrug-show: error: 'e' not found in commit 0" >>sample
echo "./shrug-show: error: 'e' not found in commit 1" >>sample
echo "./shrug-show: error: 'e' not found in commit 2" >>sample
echo "./shrug-show: error: unknown commit '3'" >>sample
echo "Committed as commit 3" >>sample
echo "e" >>sample
echo "Committed as commit 4" >>sample
echo "e" >>sample
echo "d" >>sample
echo "Committed as commit 5" >>sample
echo "d" >>sample
echo "./shrug-show: error: 'e' not found in commit 5" >>sample
echo "./shrug-show: error: 'e' not found in index" >>sample


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


