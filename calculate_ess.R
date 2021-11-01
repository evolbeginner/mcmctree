library(coda)

args=commandArgs(T)

df=read.table(args[1], header=TRUE);

ess=coda::effectiveSize(df$t_n87); print(ess); q()

ess=coda::effectiveSize(df$lnL); print(ess)
q()

#lapply(df, coda::effectiveSize)

for(i in colnames(df)){
	ess=coda::effectiveSize(df[[i]])
	print(ess)
}

