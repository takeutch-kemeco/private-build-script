### common-func.sh

CURBUILDAPP=

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
#	read
}

__cd()
{
	CURBUILDAPP=$1
	__mes $1 "Are you sure you want to build?"

	cd $1
	if [ $? -ne 0 ]
	then
		__err "not directory error!!"
	fi

	__wait
}

__decord()
{
	__mes $1 "Are you sure you want to decode?"
	__wait

	cd $SRC
	echo aaaaaaaaaaaaaaaaaaaa $SRC

	BN=$(ls $1*.tar.*)
	__echo-g $BN

	case $BN in
		*.gz)  gzip  -dc $BN | tar xvf - ;;
		*.bz2) bzip2 -dc $BN | tar xvf - ;;
		*.xz)  xz    -dc $BN | tar xvf - ;;
	esac
}

__dcd()
{
	__decord $1
	__cd $1
}

__cdbt()
{
	BLDTMP=$SRC/__bldtmp

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

__lsdir()
{
	ls -F | grep / | sed -e "s/\/$//g"
}

