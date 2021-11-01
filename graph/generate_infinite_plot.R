#! /usr/bin/env Rscript


#####################################################
library(ggplot2)
library(getopt)
#library(cowplot)
#library(gridExtra)


#####################################################
spec = matrix(
	c(
		'infile', 'i', 1, 'character',
		'outfile', 'o', 1, 'character',
		'minmax', 'm', 1, 'character'
	),
	byrow=2, ncol=4
)

opts = getopt(spec)
infile = opts$infile
outfile = opts$outfile
minmax = as.numeric(unlist(strsplit(opts$minmax, ',')))


#####################################################
a = read.table(infile, header=TRUE)

a.lm <- lm(interval ~ age+0, data = a)

print (summary(lm(interval~age, data = a))$r.squared)
print(a.lm$coefficients)


lm.scatter <- ggplot(a, aes(x=age, y=interval)) + 
  geom_point(color='black', size = 2) + xlim(minmax) + ylim(minmax) + 
  geom_abline(color="grey", intercept=0, slope=a.lm$coefficients[1], size=1)

p = lm.scatter

#p <- with(a,plot(age, interval)) + abline(0, a.lm$coefficients[1])
p <- p + theme_set(theme_bw()) + theme_set(theme_bw()) + theme(panel.grid.minor=element_line(colour=NA))

p <- p + xlab("Posterior mean age (Ma)") + ylab("95% HPD width (Ma)")

p <- p + theme(text = element_text(size=24), legend.title = element_blank())

ggsave(outfile, p)

q()

