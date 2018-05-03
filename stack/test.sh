#!/bin/bash

for t in $(ls t*.in); # | sed -e sX.*/XX | sed -e s/\\.in//);
do
    printf "Evaluating test case $t ...\n";
    diff <(./stack < $t) <(./a.out < $t) \
         -wB --width=160 --suppress-common-lines;
    for i in $(seq 42); do printf "-"; done
    printf "\n";
done
