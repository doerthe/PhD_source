#install.packages("plotrix")
library(plotrix)
color2 <- c("dodgerblue4", "lightskyblue")

dl <- c(45.8, 21.4,0.1,2.4,2.4,3,1.6,2.2)
rl <- c(2.1,2.1,2.4,2.1,2.1,2.2,2.4,2.1)
rl2 <- c(0.4,0.6,0.7,0.4,0.4,0.4,0.5,0.4)
three <- rbind(dl,rl,rl2)
two <- rbind(rl,rl2)

dl2 <- c(1125.7, 755.6,0.1,67,66.7,25.6,17.5,65.8)
rl12 <- c(30.7,30.7,34.9,30.6,30.6,30.7,35,30.5)
rl22 <- c(6.8,10.7,12.2,8.1,8.0,6.7,9.3,8.1)
three2 <- rbind(dl2,rl12,rl22)
two2 <- rbind(rl12,rl22)

par(mfrow = c(1,1))
par(xpd=FALSE)
barplot(three, col=color,  horiz=TRUE, 
        names.arg=c( 1,2,3,4,5,6,7,8), cex.names =1, cex.axis=1, beside=T,xlim=c(0,50)) 
text(three+1.1, c(1.6,2.6,3.6,5.6,6.6,7.6,9.6,10.6,11.6,13.6,14.6,15.6,17.6,18.6,19.6,21.6,22.6,23.6,25.6,26.6,27.6,29.6,30.6,31.6)-0.1, labels=three)
box()
axis(side = 3)
abline(v=10)
abline(v=20)
abline(v=30)
abline(v=40)



par(mfrow = c(1,1))
par(xpd=FALSE)
barplot(three, col=color,  
        names.arg=c( 1,2,3,4,5,6,7,8), cex.names =1, cex.axis=1, beside=T, 
        ylim=c(0,47), xlab= "step number", ylab="time in sec.") 
#box()
#axis(side = 4)
#abline(h=10)
#abline(h=20)
#abline(h=30)
#abline(h=40)
legend("topright", 
       c("DL+SPARQL", "RL+rules", "prep+RL+rules"), fill=color)


par(xpd=FALSE)
barplot(three2, col=color,  
        names.arg=c( 1,2,3,4,5,6,7,8), cex.names =1, cex.axis=1, beside=T, 
        ylim=c(0,1200), xlab= "step number", ylab="time in sec.") 
legend("topright", 
       c("DL+SPARQL", "RL+rules", "prep+RL+rules"), fill=color)
#axis.break(axis=2,breakpos=200,style="slash")


box()
axis(side = 4)
abline(h=200)
abline(h=400)
abline(h=600)
abline(h=800)
abline(h=1000)


#legend("bottom", fill=color, legend=labels)
#legend("bottomleft", legend=labels, xpd = TRUE, horiz = TRUE, inset = c(-0.1, -0.5), fil = color, cex = 1)

# pictures just EYE
par(xpd=FALSE)
barplot(two, col=color2,  
        names.arg=c( 1,2,3,4,5,6,7,8), cex.names =1, cex.axis=1, beside=T, 
        ylim=c(0,3), xlab= "step number", ylab="time in sec.") 
legend("topright", 
       c( "RL+rules", "prep+RL+rules"), fill=color2)