## Youtube inscritos -------------------------------------------------
## Canais de sucesso -------------------------------------------------
setwd('/home/guilherme/Documents/Mathbasics_Monitor/Youtube')
# Lendo a base de dados
dados <- read.csv("dataNew.csv", header = TRUE)[,-c(5,6)]
dados$INSCRITOS <- dados$INSCRITOS/100000
dados_canal <- split(dados, dados$CANAL)

dados2 <- rbind(dados_canal[[1]], dados_canal[[4]])
dados2$CANAL <- droplevels(dados2$CANAL)
write.table(dados2, file = "youtube.txt")
head(dados2)
par(mfrow = c(1,4), mar=c(2.6, 3, 1.2, 0.5), mgp = c(1.6, 0.6, 0))
plot(cumsum(dados_canal[[1]]$INSCRITOS) ~ dados_canal[[1]]$DIAS, 
     ylab = "Número de inscritos", xlab = "Dias", type = "l")
plot(cumsum(dados_canal[[2]]$INSCRITOS[-c(1:100)]) ~ dados_canal[[2]]$DIAS[-c(1:100)], 
     ylab = "Número de inscritos", xlab = "Dias", type = "l")
plot(cumsum(dados_canal[[3]]$INSCRITOS) ~ dados_canal[[3]]$DIAS, 
     ylab = "Número de inscritos", xlab = "Dias", type = "l")
plot(cumsum(dados_canal[[4]]$INSCRITOS) ~ dados_canal[[4]]$DIAS, 
     ylab = "Número de inscritos", xlab = "Dias", type = "l")

dados_canal <- split(dados, dados$CANAL)
dados_canal[[1]]$y <- cumsum(dados_canal[[1]]$INSCRITOS)
dados_canal[[2]]$y <- cumsum(dados_canal[[2]]$INSCRITOS)
dados_canal[[3]]$y <- cumsum(dados_canal[[3]]$INSCRITOS)
dados_canal[[4]]$y <- cumsum(dados_canal[[4]]$INSCRITOS)


fit1 <- nls(y ~ L/(1+exp(-beta*(DIAS - beta0))), 
            data = dados_canal[[1]], 
            start = list(L = 50, beta=0.1, beta0=800) )

fit2 <- nls(y ~ L/(1+exp(-beta*(DIAS - beta0))), 
            data = dados_canal[[4]], 
            start = list(L = 20, beta=0.1, beta0=300) )

f_log <- function(DIAS, L, beta, beta0) {
  out <- L/(1+ exp(-beta*(DIAS - beta0)))
  return(out)
}
DIAS <- 1:800
plot(f_log(DIAS = DIAS, L = 90, beta = 0.01, beta0 = 10) ~ DIAS)

fit1 <- nls(dados_1$Y ~ L/(1+exp(-beta*(DIAS - beta0))), 
            data = dados_1, start = list(L = 50, beta=0.1, beta0=800) )
fit1
plot(dados_1$Y ~ dados_1$DIAS, type = "l")

fx <- function(par, Y, x) {
  mu <- par[1]/(1+exp(-par[2]*(x-par[3])))
  SQ = mean((Y-mu)^2)
  return(SQ)
}

fit1 <- optim(par = c(30, 0.01, 630), fn = fx, Y = dados_1$Y, x = dados_1$DIAS, 
              method = "BFGS")

plot(dados_1$Y ~ dados_1$DIAS, type = "l", xlim = c(0, 1200), ylim = c(0, 25))
lines(c(1:1200), f_log(DIAS = 1:1200, L = fit1$par[1], beta = fit1$par[2], 
                       beta0 = fit1$par[3]), col = "red")


fit1 <- optim(par = c(30, 0.01, 630), fn = fx, Y = dados_4$Y, x = dados_1$DIAS, 
              method = "BFGS")


plot(dados_4$Y ~ dados_1$DIAS, type = "l", xlim = c(0, 1200), ylim = c(0, 25))
lines(c(1:1200), f_log(DIAS = 1:1200, L = fit1$par[1], beta = fit1$par[2], 
                       beta0 = fit1$par[3]), col = "red")



