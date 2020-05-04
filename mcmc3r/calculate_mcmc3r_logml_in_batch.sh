#! /bin/bash


#########################################################
A=`pwd`

for i in `ls`; do
	[ ! -d $i ] && continue
	echo $i
	cd $i/mcmc3r/
	cd AR
	Rscript ~/project/Rhizobiales/scripts/dating/mcmc3r/calculate_mcmc3r_logml.R
	cd ../IR
	Rscript ~/project/Rhizobiales/scripts/dating/mcmc3r/calculate_mcmc3r_logml.R
	echo
	cd $A
done 2>/dev/null


