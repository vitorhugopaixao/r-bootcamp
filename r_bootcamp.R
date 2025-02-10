# R-Boorcamp
#1 A Magia do ggplot2
##Bibliotecas
library(ggplot2)
##Inspecionando uma variável
gap1992$pop;
## Nomes das variaveis
colnames(gap1992)
## Numero de linhas e colunas
nrow(gap1992)
ncol(gap1992)
## Representando variaveis num grafico
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
library(dplyr)
# Dados nominais:
##  Dados categóricos (factor)
##  Dados Ordinais (order)
### Visão Geral dos Dados
#### Primeiras Linhas
head(pets)
#### Visão Geral dos Dados
glimpse(pets)

### Grafico Barras e Titulo
ggplot(data = pets,
       mapping = aes(
         x = name
      )) +
  geom_bar() +
  ggtitle("Nomes de Pets")

ggplot(data = pets, 
       mapping = aes(
         x = animal
      )) +
  geom_bar() +
  ggtitle("Tipos de Animais")

#### Grafico Barras
ggplot(data = pets,
       mapping = aes(
         x = animal,
         fill = shotsCurrent # colorir as barras conf shotsCurrent (animais vacinados)
       )) +
  geom_bar() +
  ggtitle("Quantidade de Animais")
#### Bordas em Preto
ggplot(data = pets,
       mapping = aes(
         x = animal,
         fill = shotsCurrent
       )) + 
  geom_bar(color = "black", #Em volta da barra. 
           position = "stack") + #Position = "stack"(Padrao)
  ggtitle("Quantidade de Animais")
#### Proporcao
ggplot(data = pets,
       mapping = aes(
         x = animal,
         fill = shotsCurrent
       )) + 
  geom_bar(
         color = "black",
         position = "fill" #Barras empilhadas, normalizadas para 100%.  
         ) +
  ggtitle("Proporção de Animais")
#### Opacidade(alpha entre 0 e 1)
ggplot(data = pets,
       mapping = aes(
         x = animal,
         fill = shotsCurrent
       )) + 
  geom_bar(
    color = "black",
    position = "fill",
    alpha = 0.3 #Mais transparente
  ) +
  ggtitle("Proporção de Animais")

ggplot(data = pets,
       mapping = aes(
         x = animal,
         fill = shotsCurrent
       )) + 
  geom_bar(
    color = "black",
    position = "fill", 
    alpha = 0.7 #Menos transparente
  ) +
  ggtitle("Proporção de Animais")

#### lado a lado
ggplot(data = pets, 
       mapping = aes(
         x = animal, 
         fill = shotsCurrent
         )) +
  geom_bar(
    color = "green",
    position = "dodge", # "dodge"(desviar = ladao-a-lado)
    alpha = 0.5
    ) +
  ggtitle("Quantidade de Animais")

####Facetando gráfico (facet_wrap)
ggplot(data = pets,
       mapping = aes(
         x = animal,
         fill = shotsCurrent 
       )) +
  geom_bar(color = "blue",
           position = "stack",
           alpha = 0.5) +
  facet_wrap(facets =~ shotsCurrent) +#(=~)facetar por essa variavel
  ggtitle("Quantidade de Animais por shotsCurrent")

####Tema
ggplot(data = pets,
       mapping = aes(
         x = name,
         fill = animal
       )) + 
  geom_bar(color = "yellow",
           position = "stack", 
           alpha = 0.5) +
  facet_wrap(facets =~shotsCurrent) +
  theme(axis.text.x = element_text(angle = 45)) +
  ggtitle("Nome e tipo de Animal por shotsCurrent")

### Desafio
ggplot(data = pets,
       mapping = aes(
         x = ageCategory,
         fill = animal)) +
  geom_bar(position = "fill") + 
  facet_wrap(facets =~ shotsCurrent, scale = "free_x")

### Boxplot
ggplot(data = pets,
       mapping = aes(
         x = animal,
         y = weight
       )) + geom_boxplot()

#3 Introducao a dplyr
library(dplyr)

# Manipular quadro de dados
biopics <- readRDS("C:/Users/vitro/git/r-bootcamp/biopics.rds")

## Inspeciona df
colnames(biopics)
levels(biopics$country)

str(biopics)
glimpse(biopics)
head(biopics, 4)

summary(biopics)

## Filtro
biopicsUK <- filter(biopics, country == "UK") 

head(biopicsUK)
levels(biopics$type_of_subject)

crimeMovies <- filter(biopics, type_of_subject == "Criminal")
View(crimeMovies)

## Conectores (Enc)
filter(biopics, year_release > 1980 &
         type_of_subject == "Criminal"
       )

filter(biopics, year_release > 1980 & 
         type_of_subject == "Criminal" & 
         person_of_color == FALSE
       )

## Passando resultado de uma funcao como primeiro argumento para a proxima funcao.
df <- biopics
df_filtrado <- filter(df, year_release > 1980)
df_selecionado <- select(df_filtrado, year_release, person_of_color)
head(df_selecionado)

biopics %>%
  filter(year_release > 1980) %>%
  select(year_release, person_of_color)

## %in%
biopicsUsUk <- biopics %>% 
  filter(country %in% c("US", "UK"))
levels(biopicsUsUk$country)

biopicsUsUk <- biopics %>% 
  filter(country %in% c("US", "UK")) %>%
  droplevels()
levels(biopicsUsUk$country)

colnames(biopics)
levels(biopics$type_of_subject)
biopicsArt <- biopics %>%
  filter(type_of_subject %in% 
           c("Artist", "Musician", "Singer")) %>%
  select(title, country, director, type_of_subject, subject)

## Remover NA
filter(biopics, !is.na(box_office))

biopics %>%
  filter(!is.na(box_office))

filtereBiopics <- biopics %>% 
  filter(!is.na(box_office))
nrow(biopics)
nrow(filtereBiopics)

## Mutate (cria uma nova coluna)
biopics2 <- biopics %>% 
  mutate(normalized_box_office = box_office/ number_of_subjects) %>%
  filter(!is.na(normalized_box_office))

## Paste
colnames(biopics)
levels(biopics$subject_race)
levels(biopics$subject_sex)
biopics3 <- biopics %>%
  mutate(race_and_gender = paste(subject_race, subject_sex))

mutate(biopics, 
       box_office_year = year_release * box_office, 
       box_office_subject = paste0(box_office_year, subject))

## Mais dplayr
