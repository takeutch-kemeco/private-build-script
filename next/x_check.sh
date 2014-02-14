#!/bin/bash

for a in $(ls $1)
do
        ldd $a | grep -i $2
        if [ $? -eq 0 ]
        then
                echo $a
        fi
done

