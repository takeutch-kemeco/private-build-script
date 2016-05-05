### __common-func-2.sh

CURBUILDAPP=

__dep()
{
    echo Dependent Apps: $@
}

__echo-setcol-green()
{
    COLGREEN=$'\e[1;32;1m'
    echo "$COLGREEN"$@
}

__echo-setcol-red()
{
    COLRED=$'\e[0;31;1m'
    echo "$COLRED"$@
}

__echo-setcol-def()
{
    COLDEF=$'\e[0m'
    echo "$COLDEF"$@
}

__echo-g()
{
    __echo-setcol-green $@
    __echo-setcol-def
}

__err()
{
    __echo-setcol-red "cur build app : " $CURBUILDAPP
    echo $@

    __echo-setcol-def

    exit
}

__mes()
{
    __echo-g "------------------------------"
    __echo-g $1
    __echo-g "------------------------------"
    __echo-g $2
}

__wait()
{
    __echo-g "<<< Prease enter key >>>"
#   read
}

__cd()
{
    CURBUILDAPP=$1
    __mes $1 "Are you sure you want to build?"

    cd $BASE_DIR/$1
    if [ $? -ne 0 ]
    then
	__err "not directory error!!"
    fi

    __git-pull

    __wait
}

__decord()
{
    __mes $1 "Are you sure you want to decode?"
    __wait

    cd $SRC_DIR
    BN=$(ls $1*.tar.*)
    if [ $? -ne 0 ]
    then
        BN=$(ls $1*.tgz)
    fi
    __echo-g $BN

    cd $BASE_DIR
    case $BN in
        *.tgz) gzip  -dc $SRC_DIR/$BN | tar xvf - ;;
	*.gz)  gzip  -dc $SRC_DIR/$BN | tar xvf - ;;
	*.bz2) bzip2 -dc $SRC_DIR/$BN | tar xvf - ;;
	*.xz)  xz    -dc $SRC_DIR/$BN | tar xvf - ;;
    esac
}

__dcd()
{
    __decord $1
    __cd $1
}

__cdbt()
{
    BLDTMP=$BASE_DIR/__bldtmp

    rm $BLDTMP -rf
    mkdir -v $BLDTMP
    cd $BLDTMP
}

__mk()
{
    __echo-g $CURBUILDAPP "[ make" $@ "]"

    make $@
    if [ $? -ne 0 ]
    then
	__err "make error!!"
    fi
}

__mkinst()
{
    __echo-g $CURBUILDAPP "[ sudo make install" $@ "]"

    sudo make install $@
    if [ $? -ne 0 ]
    then
	__err "sudo make install error!!"
    fi

    sudo ldconfig
}

__lsdir()
{
    ls -F | grep / | sed -e "s/\/$//g"
}

__wget()
{
    __mes "wget ["$1"]"

    wget -c --directory-prefix=${SRC_DIR} $1
#   if [ $? -ne 0 ]
#   then
#   __err "wget error!! ["$1"]"
#   fi
}

__patch()
{
    patch -p1 < $@
    if [ $? -eq 2 ]
    then
	__err "patch error!! ["$@"]"
    fi
}

__git-pull()
{
    ls .git 2>& 1>& /dev/null
    if [ $? -eq 0 ]
    then
	git pull
    fi	
}

__svn-pull()
{
    ls .svn 2>& 1>& /dev/null
    if [ $? -eq 0 ]
    then
        svn upgrade
	svn cleanup
	svn update
    fi
}

__hg-pull()
{
    ls .hg 2>& 1>& /dev/null
    if [ $? -eq 0 ]
    then
	hg pull
	hg update
    fi
}

__cvs-pull()
{
    ls CVS 2>& 1>& /dev/null
    if [ $? -eq 0 ]
    then
	cvs update
    fi
}

__vcs-pull()
{
    __git-pull
    __hg-pull
    __svn-pull
    __cvs-pull
}

__git-clone()
{
    cd $BASE_DIR
    git clone $@
}

__hg-clone()
{
    cd $BASE_DIR
    hg clone $@
}

__svn-clone()
{
    cd $BASE_DIR
    svn co $@
}

__cvs-clone()
{
    cd $BASE_DIR
    cvs $@
}

__autogen()
{
    ls autogen.sh 2>& 1>& /dev/null
    if [ $? -eq 0 ]
    then
	./autogen.sh
    fi
}

__self-autogen()
{
    ls m4 2>& 1>& /dev/null
    if [ $? -eq 0 ]
    then
        aclocal --force -I m4
    else
        aclocal --install
    fi

    libtoolize
    autoheader
    automake -acf
    autoconf
}

__cfg()
{
    __autogen
    ./configure $@
    if [ $? -ne 0 ]
    then
	__err "./configure error!! ["$@"]"
    fi
}

__bld-common-simple()
{
    $DIST_CLEAN
    __cfg --prefix=/usr $@

    $MAKE_CLEAN
    __mk
    __mkinst
}

__bld-common()
{
    __bld-common-simple --sysconfdir=/etc $@
}

__common()
{
    __cd $1
    __bld-common
}

__pl-common()
{
    __dcd $1
    perl Makefile.PL
    __mk
    __mkinst
}

### cgroup として build-group を作成し、このスクリプトが含まれる現在のプロセスを登録する。
### build-group は、ビルド時の使用メモリーの上限を 7GByte までに制限する為に使う。
__init-build-group()
{
    sudo cgcreate -g memory,cpu:/build-group
    sudo sh -c "echo 7G >  /sys/fs/cgroup/memory/build-group/memory.limit_in_bytes"
    sudo sh -c "echo $$ >> /sys/fs/cgroup/memory/build-group/tasks"
}

