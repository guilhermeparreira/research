##########################################################################################
## Analysing data from youtube ###########################################################
## Author: Wagner Hugo Bonat LEG/IMADA ###################################################
## Date: 17/04/2016 ######################################################################
##########################################################################################
rm(list=ls())
## Loading the data
data <- read.table("dados.csv", header = TRUE, sep = ",")
head(data)
matriz <- matrix(NA, ncol = 35, nrow=43)
for(i in 1:35){matriz[,i] <- as.numeric(data[i,][3:45])}
nomes <- c()
for(i in 1:35){nomes[i] <- data[i,2]}
nomes2 <- levels(data[1,2])[nomes]
data <- as.data.frame(matriz)
names(data) <- nomes2
data <- data/10000

head(data)
## Plot
X11()
par(mfrow=c(2,5))
for(i in 2:11){
plot(as.numeric(data[,i]) ~ c(1:43), type="l", main = names(data)[i])}

par(mfrow=c(2,5))
for(i in 12:21){
plot(as.numeric(data[,i]) ~ c(1:43), type="l", main = names(data)[i])}

par(mfrow=c(2,5))
for(i in 22:31){
plot(as.numeric(data[,i]) ~ c(1:43), type="l", main = names(data)[i])}

par(mfrow=c(2,2))
for(i in 32:35){
plot(as.numeric(data[,i]) ~ c(1:43), type="l", main = names(data)[i])}

y <- c(data[,2],data[,3],data[,4],data[,5],data[,6],data[,7],data[,8],data[,9],data[,10])
cov <- rep(c(1:43),9)
cod <- c(rep(1:9,each=43))
dados <- data.frame("y" = y, "cov" = cov, "cod" = cod)

## Non-linear model
fit1.nlm <- nls(y ~ L/(1 + exp(-beta*(cov - beta0))), data = dados,start = list(L = 1500, beta=2, beta0=20))
fit1.nlm
X11()
plot(data[,2] ~ c(1:43), type = "l", ylim = c(0,8000))
for(i in 3:9){lines(c(1:43),data[,i], col = i)}
lines(predict(fit1.nlm, newdata=data.frame("cov" = 1:43)),lty=2)

## Non-Linear mixed model
require(nlme)
dados.na <- na.exclude(dados)
fit4.nlm <- nlme(y ~ L/(1 + exp(-beta*(cov - beta0))) ,
           random= L ~ 1|cod, fixed=L+beta+beta0~1,
           data=dados.na, start=c(L=9198, beta=0.23, beta0 = 36.26), method="ML", control = list(maxIter=2000))
fit4.nlm
summary(fit4.nlm)
confint(fit4.nlm)
plot(c(data[,2],rep(NA,17)) ~ c(1:60), type = "l", ylim = c(0,4000), main = names(data)[2])
lines(predict(fit4.nlm, newdata=data.frame("cov" = 1:60, "cod" = 1)),lty=2)

plot(c(data[,3],rep(NA,17)) ~ c(1:60), type = "l", ylim = c(0,28000), main = names(data)[3])
lines(predict(fit4.nlm, newdata=data.frame("cov" = 1:60, "cod" = 2)),lty=2)

plot(c(data[,4],rep(NA,17)) ~ c(1:60), type = "l", ylim = c(0,8000), main = names(data)[4])
lines(predict(fit4.nlm, newdata=data.frame("cov" = 1:60, "cod" = 3)),lty=2)

plot(c(data[,5],rep(NA,17)) ~ c(1:60), type = "l", ylim = c(0,12000), main = names(data)[5])
lines(predict(fit4.nlm, newdata=data.frame("cov" = 1:60, "cod" = 4)),lty=2)

plot(c(data[,6],rep(NA,17)) ~ c(1:60), type = "l", ylim = c(0,8000), main = names(data)[6])
lines(predict(fit4.nlm, newdata=data.frame("cov" = 1:60, "cod" = 5)),lty=2)

plot(c(data[,7],rep(NA,17)) ~ c(1:60), type = "l", ylim = c(0,3500), main = names(data)[7])
lines(predict(fit4.nlm, newdata=data.frame("cov" = 1:60, "cod" = 6)),lty=2)

plot(c(data[,8],rep(NA,17)) ~ c(1:60), type = "l", ylim = c(0,12000), main = names(data)[8])
lines(predict(fit4.nlm, newdata=data.frame("cov" = 1:60, "cod" = 7)),lty=2)

plot(c(data[,9],rep(NA,17)) ~ c(1:60), type = "l", ylim = c(0,10000), main = names(data)[9])
lines(predict(fit4.nlm, newdata=data.frame("cov" = 1:60, "cod" = 8)),lty=2)

plot(c(data[,10],rep(NA,17)) ~ c(1:60), type = "l", ylim = c(0,5500), main = names(data)[10])
lines(predict(fit4.nlm, newdata=data.frame("cov" = 1:60, "cod" = 9)),lty=2)





