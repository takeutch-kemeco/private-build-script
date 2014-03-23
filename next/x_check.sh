#!/bin/bash

### x_check.sh パス ライブラリー名
### 例（/usr/lib 以下で、libaaa に依存するライブラリーを調べる）:
###     x_check.sh /usr/lib libaaa

for a in $(ls $1)
do
        ldd $1/$a | grep -i $2
        if [ $? -eq 0 ]
        then
                echo $1/$a
        fi
done

