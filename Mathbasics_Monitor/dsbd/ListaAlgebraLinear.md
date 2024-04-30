---
title: "Introdução a Álgebra Linear para Ciência de Dados"
author: "Wagner Hugo Bonat"
date: '2018-04-23'
output: pdf_document
subtitle: 'Lista de exercícios II: Vetores, Matrizes e Sistemas Lineares'
---



Exercícios para fixação, recomendo que usem o $\texttt{R}$ e o $\texttt{python}$ para auxiliar e verificar suas respostas.

1. Sejam os vetores $\boldsymbol{v}_1 = (1, 5, 10)$ e $\boldsymbol{v}_2 = (10, 50, 100)$,
obtenha

a) O módulo (comprimento) de $\boldsymbol{v}_1$ e $\boldsymbol{v}_2$.
b) O vetor unitário definido por $\boldsymbol{v}_1$ e $\boldsymbol{v}_2$.
c) A soma de $\boldsymbol{v}_1$ e $\boldsymbol{v}_2$.
d) A multiplicação de $\boldsymbol{v}_1$ por $\boldsymbol{v}_2$.
e) O produto interno de $\boldsymbol{v}_1$ por $\boldsymbol{v}_2$.
f) Sendo $\alpha = 10$, obtenha $\alpha \boldsymbol{v}_1$.

2. Implemente usando apenas funções básicas em \texttt{R} e/ou \texttt{python} funções genéricas para a soma, subtração, multiplicação por escalar e produto interno de vetores.

3. Sendo
$$ 
\mathbf{A} = \begin{bmatrix}
1 & 0.8 & 0.6\\ 
0.8 & 1 & 0.4 \\ 
0.6 & 0.4 & 1
\end{bmatrix} \quad \text{e} \quad
\mathbf{B} = \begin{bmatrix}
1.5 & 0.1 & 0.5\\ 
0.1 & 2 & 0.3\\ 
0.5 & 0.3 & 3
\end{bmatrix}
$$
obtenha:

a) $\mathbf{C} = \mathbf{A} + \mathbf{B}$.
b) $\mathbf{C} = \mathbf{A} - \mathbf{B}$.
c) $\mathbf{A}^{\top}$ e $\mathbf{B}^{\top}$.
d) Sendo $\alpha = 5$ obtenha $\alpha (\mathbf{A} + \mathbf{B})$.
e) O determinante de $\mathbf{A}$ (Dica use a função \texttt{det()}).
f) Calcule $\mathbf{C} = \mathbf{A}\mathbf{B}$.
g) Calcule $\mathbf{C} = \mathbf{B}\mathbf{A}$.
h) Calcule $\mathbf{C} = \mathbf{A}\mathbf{A}^{\top}$.
h) Calcule $\mathbf{C} = \mathbf{A}(\mathbf{A} + \mathbf{B})$.
4. Implemente uma função em \texttt{R} ou \texttt{python} para multiplicar
duas matrizes. Não esquece de verificar se as matrizes são compatíveis.

5. Considere o seguinte sistema de equações lineares:
$$
\begin{matrix}
2x_1 + 2x_2 - 3_x3 = 2\\ 
-1 x_1 + 3 x_2 + 2 x_3 = 0\\ 
3 x_1 + x_2 - 3x_3 = 1
\end{matrix}
$$

a) Resolva manualmente usando o método de eliminação de Gauss.
b) Use a função criada em aula para resolver o sistema usando o método
de elimanação de Gauss.
c) Resolve o sistema usando o método de Gauss-Jordan.
d) Obtenha a decomposição LU e resolva o sistema.
e) Resolva o sistema usando o método de Jacobi.
f) Resolva o sistema usando o método de Gauss-Seidel.

6. Considere a matriz
$$
\mathbf{A} =
\begin{bmatrix}
1 & 0.9 & 0.8\\ 
0.9 & 1 & 0.95\\ 
0.8 & 0.95 & 1
\end{bmatrix}.
$$
a) Obtenha $\mathbf{A}^{-1}$ pela decomposição LU.
b) Obtenha a decomposição em autovalores e autovetores de $\mathbf{A}$.
c) Baseado na letra b) obtenha $\mathbf{A}^{-1}$.

7. A função densidade probabilidade da distribuição Normal multivariada
é dada pela seguinte equação 
$$ p(\boldsymbol{y}; \boldsymbol{\mu}, \mathbf{\Sigma}) = (2 \pi)^{-\frac{n}{2}} | \mathbf{\Sigma}|^{\frac{1}{2}} \exp\left \{ -\frac{1}{2}(\boldsymbol{y} - \boldsymbol{\mu})^{\top} \mathbf
{\Sigma}^{-1} (\boldsymbol{y} - \boldsymbol{\mu}) \right \},$$
onde $\boldsymbol{y}$ e $\boldsymbol{\mu}$ são vetores $n \times 1$
de variáveis aleatórias e valores esperados. A matriz $\mathbf{\Sigma}$
é chamada de matriz de variância-covariância, sendo simétrica e
positiva definida (admite inversa). 

a) Implemente a função densidade da distribuição Normal multivariada
em $\texttt{R}$ em pelo menos três formas diferentes e compare o tempo
computacional para diferentes números de variáveis aleatórias.

b) Compare a sua implementação com a função $\texttt{dmvnorm()}$ do
pacote $\texttt{mvtnorm}$ em termos de tempo computacional.
