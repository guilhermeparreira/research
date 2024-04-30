##########################################################################################
## Youtube example of mixed models #######################################################
## Author: Wagner Hugo Bonat LEG/IMADA ###################################################
## Date: 06/08/2015 ######################################################################
## Lastest updated 06/08/2015 ############################################################
##########################################################################################
rm(list=ls())
## Loading extra package
require(lme4)
require(lattice)
require(nlme)

## Loading data set
data <- read.table("dataNew.csv", header = TRUE, sep = ",")[,1:4]
head(data)
dim(data)
table(data$CANAL)
data.canal <- split(data,data$CANAL)
dim(data.canal[[1]])/30
cod <- rep(1:28, each = 30)
cod <- c(rep(1:28, each = 30), rep(NA, 10))
data.canal[[1]]$cod <- cod
data.new <- data.frame("INSCRITOS" = tapply(data.canal[[1]]$INSCRITOS, data.canal[[1]]$cod, sum),
                       "VIEWS" = tapply(data.canal[[1]]$VIEWS, data.canal[[1]]$cod, sum))
data.new$MES <- 1:28
data.new$CANAL <- "inventonahora"

dim(data.canal[[2]])/30
cod <- c(rep(1:16, each = 30), rep(NA, 4))
data.canal[[2]]$cod <- cod
data.new2 <- data.frame("INSCRITOS" = tapply(data.canal[[2]]$INSCRITOS, data.canal[[2]]$cod, sum),
                       "VIEWS" = tapply(data.canal[[2]]$VIEWS, data.canal[[2]]$cod, sum))
data.new2$MES <- 1:16
data.new2$CANAL <- "japa"


dim(data.canal[[3]])/30
cod <- c(rep(1:7, each = 30), rep(NA, 0))
data.canal[[3]]$cod <- cod
data.new3 <- data.frame("INSCRITOS" = tapply(data.canal[[3]]$INSCRITOS, data.canal[[3]]$cod, sum),
                       "VIEWS" = tapply(data.canal[[3]]$VIEWS, data.canal[[3]]$cod, sum))
data.new3$MES <- 1:7
data.new3$CANAL <- "lucaslira"

dim(data.canal[[4]])/30
cod <- c(rep(1:20, each = 30), rep(NA, 7))
data.canal[[4]]$cod <- cod
data.new4 <- data.frame("INSCRITOS" = tapply(data.canal[[4]]$INSCRITOS, data.canal[[4]]$cod, sum),
                       "VIEWS" = tapply(data.canal[[4]]$VIEWS, data.canal[[4]]$cod, sum))
data.new4$MES <- 1:20
data.new4$CANAL <- "vocesabia"

data <- rbind(data.new,data.new2,data.new3,data.new4)

xyplot(INSCRITOS ~ MES | CANAL, data = data)
xyplot(VIEWS ~ MES | CANAL, data = data)


## Fitting a non-linear models (only fixed effects)
fit1.nlm <- nls(INSCRITOS ~ L/(1 + exp(-beta*(MES - beta0))), 
                data = data, 
                start = list(L = 250, beta=0.20, beta0=0.20))
summary(fit1.nlm)

data.canal <- split(data2,data2$CANAL)
plot(data.canal[[1]]$INSCRITOS ~ c(1:dim(data.canal[[1]])[1]), type = "l", ylim = c(0,35000), xlim = c(1, 1500))
lines(c(1:dim(data.canal[[2]])[1]),data.canal[[2]]$INSCRITOS, col = 2)
lines(c(1:dim(data.canal[[4]])[1]),data.canal[[4]]$INSCRITOS, col = 3)
lines(predict(fit1.nlm, newdata=data.frame("DIAS" = 1:1500)),lty=2)

fit1.nlm
## Fitting a non-linear mixed model
fit.nlmm <- nlme(INSCRITOS ~ L/(1 + exp(-beta*(DIAS - beta0))) ,
           random= L ~ 1|CANAL, fixed=L+beta+beta0~1,
           data = data2, start=c(L=4.82e03, beta=1.137e-02, beta0 = 2.94e02), method="ML", control = list(maxIter=2000))
fit.nlmm
summary(fit.nlmm)
plot(data.canal[[1]]$INSCRITOS ~ c(1:dim(data.canal[[1]])[1]), type = "l", ylim = c(0,35000), xlim = c(1, 1500), ylab = "Inscritos", xlab = "Dias")
lines(c(1:dim(data.canal[[2]])[1]),data.canal[[2]]$INSCRITOS, col = 2)
lines(c(1:dim(data.canal[[4]])[1]),data.canal[[4]]$INSCRITOS, col = 3)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" = "inventonahora")),lty = 2)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" = "Japa")),lty = 2, col = 2)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" = "vocesabia")),lty = 2, col = 3)
lines(predict(fit1.nlm, newdata=data.frame("DIAS" = 1:1500)),lty=3)


## Loading prospective data set
data.prosp <- read.table("dataProspec.csv", header = TRUE, sep = ",")[,1:5]
head(data.prosp)
table(data.prosp$CATEGORIA)
table(data.prosp$CANAL)

## Test 1
data.test1 <- subset(data.prosp, data.prosp$CANAL == "brunamalheirosmakeup")
plot(data.test$INSCRITOS ~ c(1:dim(data.test)[1]), type = "l", ylim = c(0,35000), xlim = c(1, 25), ylab = "Inscritos", xlab = "Dias")
fit.test <- nls(INSCRITOS ~ L/(1 + exp(-beta*(DIAS - beta0))), data = data.test,start = list(L = 5000, beta= 2, beta0=2))
lines(predict(fit.test, newdata=data.frame("DIAS" = 1:1500)),lty=2, lwd = 3)
plot(data.canal[[1]]$INSCRITOS ~ c(1:dim(data.canal[[1]])[1]), type = "l", ylim = c(0,35000), xlim = c(1, 1500))
lines(predict(fit1.nlm, newdata=data.frame("DIAS" = 1:1500)),lty=3)
lines(predict(fit.test, newdata=data.frame("DIAS" = 1:1500)),lty=2, lwd = 3)

## Test 2
## Fitting a non-linear mixed model
data.aug <- rbind(data2, data.test[,1:4])
fit.nlmm <- nlme(INSCRITOS ~ L/(1 + exp(-beta*(DIAS - beta0))) ,
           random= L ~ 1|CANAL, fixed=L+beta+beta0~1,
           data = data.aug, start=c(L=4.82e03, beta=1.137e-02, beta0 = 2.94e02), method="ML", control = list(maxIter=2000))
fit.nlmm
summary(fit.nlmm)
plot(data.canal[[1]]$INSCRITOS ~ c(1:dim(data.canal[[1]])[1]), type = "l", ylim = c(0,35000), xlim = c(1, 1500), ylab = "Inscritos", xlab = "Dias")
lines(c(1:dim(data.canal[[2]])[1]),data.canal[[2]]$INSCRITOS, col = 2)
lines(c(1:dim(data.canal[[4]])[1]),data.canal[[4]]$INSCRITOS, col = 3)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" = "inventonahora")),lty = 2)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" = "Japa")),lty = 2, col = 2)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" = "vocesabia")),lty = 2, col = 3)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" =  "brunamalheirosmakeup")),lty = 2, col = 4, lwd = 2)

##########################################################################################
xyplot(INSCRITOS ~ DIAS | CANAL, data = data.prosp)
nome <- as.character(unique(factor(data.prosp$CANAL)))
data.test <- data.prosp[which(data.prosp$CANAL == nome[9]),]
dim(data.test)
data.aug <- rbind(data2, data.test[,1:4])
fit.nlmm <- nlme(INSCRITOS ~ L/(1 + exp(-beta*(DIAS - beta0))) ,
           random= L ~ 1|CANAL, fixed=L+beta+beta0~1,
           data = data.aug, start=c(L=4.82e03, beta=1.137e-02, beta0 = 2.94e02), method="ML", control = list(maxIter=2000))
fit.nlmm
summary(fit.nlmm)
plot(data.canal[[1]]$INSCRITOS ~ c(1:dim(data.canal[[1]])[1]), type = "l", ylim = c(0,55000), xlim = c(1, 1500), ylab = "Inscritos", xlab = "Dias")
lines(c(1:dim(data.canal[[2]])[1]),data.canal[[2]]$INSCRITOS, col = 2)
lines(c(1:dim(data.canal[[4]])[1]),data.canal[[4]]$INSCRITOS, col = 3)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" = "inventonahora")),lty = 2)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" = "Japa")),lty = 2, col = 2)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" = "vocesabia")),lty = 2, col = 3)
lines(predict(fit.nlmm, newdata=data.frame("DIAS" = 1:1500, "CANAL" =  nome[9])),lty = 2, col = 4, lwd = 2)

