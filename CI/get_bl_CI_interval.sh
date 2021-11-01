#! /bin/bash


###############################################
d=`dirname $0`
PROG=$d/get_bl_CI_interval.rb

minmax_arg=""
multiply_arg=""
format=''


###############################################
figtree_file=$1


###############################################
while [ $# -gt 0 ]; do
	case $1 in
		-i)
			figtree_file=$2
			shift
			;;
		--minmax)
			minmax_arg="--minmax"
			;;
		--multiply)
			multiply_arg="--multiply $2"
			shift
			;;
		--format|-f)
			format=$2
			;;
	esac
	shift
done


###############################################
if [ -z $format ]; then
	echo "--format (mcmctree or revbayes) has to be specified! Exiting ......" >&2
	echo ""
	exit 1
fi


###############################################
case $format in
	mcmctree)
		sed -f $d/figtree_mcmctree_reformat.sed $figtree_file | ruby $PROG -i - $minmax_arg $multiply_arg
		;;
	revbayes)
		sed -f $d/figtree_revbayes_reformat.sed $figtree_file | ruby $PROG -i - $minmax_arg $multiply_arg
		;;
esac


