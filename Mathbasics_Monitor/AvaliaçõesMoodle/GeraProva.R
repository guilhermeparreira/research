## Gera questões Prova 2 - Probabilidades
require(exams)

## Exercício 1 -------------------------------------------------------
# Só visualiza o html
exams2html("Ex1.Rmd", mathjax = TRUE, 
           converter = "pandoc-mathjax")

# Gera o arquivo para o moodle
exams2moodle("Ex1.Rmd", n = 1, name = "M1Ex1",
             converter = "pandoc-mathjax")

## Exercício 2--------------------------------------------------------
exams2html("Ex2.Rmd", mathjax = TRUE, converter = "pandoc-mathjax")

# Gera arquivo para o moodle
exams2moodle("Ex2.Rmd", n = 1, name = "M1Ex2",
             converter = "pandoc-mathjax")

## Exercício 3--------------------------------------------------------
