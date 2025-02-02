# R-Boorcamp
##
library(ggplot2)

#1 A Magia do ggplot2
##Inspeciinando uma variável
gap1992$pop;
## Nomes das variaveis
colnames(gap1992)
## numero de linhas
nrow(gap1992)
## representando variaveis num grafico
### mapeando variaveis (mapping = )
#### aes (atributo estetico) e geom_ (forma geometrica)
ggplot(data = gap1992, mapping = aes(x=log(gdpPercap), y = log(pop))) +
  geom_point()
#### esteticas (x y colour)
ggplot(data = gap1992, 
       mapping = aes(
         x = log(gdpPercap), 
         y = log(pop), 
         colour = continent 
       )) + 
  geom_point()

#### esteticas (x y colour size)
ggplot(data = gap1992, 
       mapping = aes(
         x = log(gdpPercap), 
         y = lifeExp, 
         colour = continent,
         size = pop
         )) +
  geom_point()

#### geom_line
ggplot(data = gap1992,
       mapping = aes(
       x = log(gdpPercap),
       y = lifeExp,
       color = continent)) +
  geom_line()

#### titulo
ggplot(data = gap1992,
       mapping = aes(
         x = log(gdpPercap),
         y = lifeExp,
         color = continent,
         size = pop)) +
  geom_point() +
  ggtitle("Gapminder for 1992")


#2 ggplot2 e dados categoricos

#3 Introducao a dplyr

## Mais dplayr