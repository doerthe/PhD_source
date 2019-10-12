color2 <- c("dodgerblue4", "lightskyblue")
Test <- read.csv(file="/media/doerthe/4EC6F987C6F97017/store/PhD/Thesis/validation/allN3.csv", header=TRUE, sep=",")
timesEYE <- as.vector(Test[4])

boxplot(Test[1:37,4], Test[38:98, 4]  , Test[99:123, 4], Test[124:193, 4],  Test[194:266, 4], Test[267:279, 4], outline=FALSE, horizontal=TRUE) 

means <- c( mean(Test[1:37,4]), mean(Test[38:98, 4])  , mean(Test[99:123, 4]), mean(Test[124:193, 4]),  mean(Test[194:266, 4]), mean(Test[267:279, 4]))
medians <- c( median(Test[1:37,4]), median(Test[38:98, 4])  , median(Test[99:123, 4]), median(Test[124:193, 4]),  median(Test[194:266, 4]), median(Test[267:279, 4]))

boxplot(Test[1:37,4])

RDFUnit <- read.csv(file="/media/doerthe/4EC6F987C6F97017/store/PhD/Thesis/validation/allRDFUnit.csv", header=F, sep=",")
means2 <- c( mean(RDFUnit[1:37,4]), mean(RDFUnit[38:98, 4])  , mean(RDFUnit[99:123, 4]), mean(RDFUnit[124:193, 4]),  mean(RDFUnit[194:266, 4]), mean(RDFUnit[267:279, 4]))
medians2 <- c( median(RDFUnit[1:37,4]), median(RDFUnit[38:98, 4])  , median(RDFUnit[99:123, 4]), median(RDFUnit[124:193, 4]),  median(RDFUnit[194:266, 4]), median(RDFUnit[267:342, 4]))

names1 <- c("10", "100", "1k", "10k", "100k", "1m")
names <- c("10", "100", "1,000", "10,000", "100,000", "1,000,000")

barplot(means2)
both <- rbind(medians, medians2)/1000
barplot(both,  beside = TRUE, col=color2, names=names, xlab="data set size in (rounded) number of triples", ylab="time in sec.",ylim=c(0,140),cex.names =1.5, cex.axis=1.5, cex.lab=1.5)
legend(1,130, 
       c("Validatrr", "RDFUnit"), fill=color2, cex=1.5)