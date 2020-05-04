#! /bin/bash


############################################################
dir=`dirname $0`
cd $dir
dir=`pwd`
cd -

indir=''
outdir=''


############################################################
while [ $# -gt 0 ]; do
	case $1 in
		--indir)
			indir=$2
			shift
			;;
		--outdir)
			outdir=$2
			shift
			;;		
	esac
	shift
done


############################################################
[ -z $indir ] && echo "indir not given" && exit 1
[ -z $outdir ] && echo "outdir not given" && exit 1


############################################################
mkdir $outdir/{S,A,I}R/{1,2,3,4,5,6,7,8} -p

cp $indir/mcmctree/combined/mcmctree.ctl $indir/combined.phy $indir/species.trees $outdir/SR
cp $indir/mcmctree/combined/mcmctree.ctl $indir/combined.phy $indir/species.trees $outdir/IR
cp $indir/mcmctree/combined/mcmctree.ctl $indir/combined.phy $indir/species.trees $outdir/AR

cd $outdir


############################################################
for i in `find -name mcmctree.ctl`; do sed 's/burnin = .\+/burnin = 10000/; s/sampfreq = .\+/sampfreq = 10/; s/nsample = .\+/nsample = 1000/' -i $i; done

find -name mcmctree.ctl -exec sed 's/usedata = .\+/usedata = 1/' -i {} \;


############################################################
cd SR
find -name mcmctree.ctl -exec sed 's/clock = .\+/clock = 1/' -i {} \;
for i in `seq 1 1 8`; do cp mcmctree.ctl species.trees combined.phy $i; done
mv mcmctree.ctl mcmctree.ctl0
Rscript $dir/mcmc3r.R
cd ..

cd IR
find -name mcmctree.ctl -exec sed 's/clock = .\+/clock = 2/' -i {} \;
for i in `seq 1 1 8`; do cp mcmctree.ctl species.trees combined.phy $i; done
mv mcmctree.ctl mcmctree.ctl0
Rscript $dir/mcmc3r.R
cd ..

cd AR
find -name mcmctree.ctl -exec sed 's/clock = .\+/clock = 3/' -i {} \;
for i in `seq 1 1 8`; do cp mcmctree.ctl species.trees combined.phy $i; done
mv mcmctree.ctl mcmctree.ctl0
Rscript $dir/mcmc3r.R
cd ..


