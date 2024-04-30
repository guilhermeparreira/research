
fx <- function(x) ((20 - x)^2 )/(20*x^2)

curve(fx, 10, 50)

fx0 <- function(x) ((x - 20)^2)/8000

curve(fx0, 10, 50, col = 2, add = TRUE)


A <- matrix(c(2,5,3,-2,0,4,-1,8,7), 3, 3)
B <- matrix(c(1,-4,8,-6,8,5,-1,3,-7), 3, 3)

A%*%B
B%*%A

newton <- function(fx, jacobian, x1, tol = 1e-04, max_iter = 10) {
  solucao <- matrix(NA, ncol = length(x1), nrow = max_iter)
  solucao[1,] <- x1
  for(i in 1:max_iter) {
    J <- jacobian(solucao[i,])
    grad <- fx(solucao[i,])
    solucao[i+1,] = solucao[i,] - solve(J, grad)
    if( sum(abs(solucao[i+1,] - solucao[i,])) < tol) break
  }
  return(solucao)
}

fx <- function(x) {
  t1 <- 4*x[1]^2 - x[2]^3 +28
  t2 <- 3*x[1]^3 + 4*x[2]^2 -145
  return(c(t1,t2))
}

jacobian <- function(x) {
  J <- matrix(NA, 2, 2)
  J[1,1] <- 8*x[1]
  J[1,2] <- -3*x[2]^2
  J[2,1] <- 9*x[1]^2
  J[2,2] <- 8*x[2]
  return(J)
}
jacobian(c(1,1))
fx(x = c(1,1))
newton(fx = fx, jacobian = jacobian, x1 = c(1,1), max_iter = 100)

fx(x = c(3,4))
