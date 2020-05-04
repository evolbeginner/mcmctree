library(coda)

args=commandArgs(T)

a=read.table(args[1], header=TRUE);

ess=coda::effectiveSize(a$lnL)

print (ess)

