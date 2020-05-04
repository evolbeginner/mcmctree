#! /bin/bash


###############################################################################################
source ~/.bash_profile


###############################################################################################
DIR=`dirname $0`

indir=''
type=''
suffix=''


###############################################################################################
while [ $# -gt 0 ]; do
	case $1 in
		--indir)
			indir=$2
			shift
			;;
		--nohup)
			type="nohup"
			;;
		--hpc|--HPC)
			type=hpc
			;;
		--pre|--prefix)
			prefix=$2
			shift
			;;
		*)
			echo "Wrong argu $1" >&2
			exit 1
	esac
	shift
done


if [ -z $indir ]; then
	echo "indir not given! Exiting ......" >&2
	exit 1
fi


###############################################################################################
for i in `find $indir -name mcmctree.ctl`; do
	d=`dirname $i`
	cd $d;
	d_b=`basename $d`
	case $type in
		nohup)
			mcmctree > mcmctree.final &
			;;
		hpc)
			submitHPC.sh --cmd "mcmctree > mcmctree.final" -n 1 --lsf $prefix$d_b.lsf --df
			;;
		*)
			exit 1
			;;
	esac
	cd -
done


