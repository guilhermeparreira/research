## Exercicio 4

x <- seq(-1,1,l = 100)
b0 <- 10
b1 <- 2

y <- rnorm(100, mean = b0 + b1*x, sd = 1)

plot(y ~ x)

ff <- function(b, x, y) {
  mu <- b[1] + b[2]*x
  erro <- sum(abs(y - mu))
  return(erro)
}

ff(b = c(10,2), x = x, y =y )

resul <- optim(par = c(10, 2), fn = ff, x = x, y = y)
resul$par
abline(resul$par)
