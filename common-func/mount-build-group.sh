#!/bin/bash

### 使い方:
###     ./mount-build-group.sh プロセスID
###
### 例:
###     今実行中のbashを登録する場合:
###         ./mount-build-group.sh $$
###
###     任意のプログラムを登録する場合:
###         ./mount-build-group.sh systemd-cgls等で探したプロセスID

sudo cgcreate -g memory:/build-group
sudo sh -c "echo 1G >  /sys/fs/cgroup/memory/build-group/memory.limit_in_bytes"
sudo sh -c "echo $1 >> /sys/fs/cgroup/memory/build-group/tasks"

