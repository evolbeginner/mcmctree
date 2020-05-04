#! /bin/bash


###############################################
d=`dirname $0`
prog=$d/get_bl_CI_interval.rb


###############################################
sed -f $d/figtree_reformat.sed $1 | ruby $prog -i -


