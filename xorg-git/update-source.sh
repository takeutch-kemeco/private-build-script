#!/bin/bash

BASE_DIR=$(pwd)

. ../common-func/__common-func-2.sh

for n in $(__lsdir)
do
    __cd ${n}
    __vcs-pull
done

