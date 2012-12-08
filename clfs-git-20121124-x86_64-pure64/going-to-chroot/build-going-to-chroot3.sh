#!/tools/bin/bash

BASE_DIR=/sources/going-to-chroot
SRC_DIR=/sources/src
. $SRC_DIR/__common-func.sh

__create-pas2()
{
	touch /var/run/utmp /var/log/{btmp,lastlog,wtmp}
	chgrp -v utmp /var/run/utmp /var/log/lastlog
	chmod -v 664 /var/run/utmp /var/log/lastlog
	chmod -v 600 /var/log/btmp
}

__mount-kfs()
{
	mount -vt devpts -o gid=4,mode=620 none /dev/pts
	mount -vt tmpfs none /dev/shm
}

#__rem(){
__create-pas2
__mount-kfs

