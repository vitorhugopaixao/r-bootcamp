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
library(dplyr) #para o "glimpse".
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
       )) + 
  geom_boxplot()

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
       boxOffice_numSubjects = box_office / number_of_subjects, 
       title_year = paste(title, year_release)) %>%
  select(title_year, box_office, number_of_subjects, boxOffice_numSubjects)


## 4.Mais dplayr
### Pipe: %>% (entao)
glimpse(biopics)
levels(biopics$race_known) # Exemplo original era race_now, mas todos sao NA.
levels((biopics$subject_race)) # Variavel mais interessante que race_know.

### Pipeline: cadeia padronizada de ações de processamento (subRace_pocCode).
subRace_pocCode <- biopics %>%
  filter(subject_race == "Hispanic (Latino)" | subject_race == "White") %>% # Alterado de race_now para subject_race.
  mutate(poc_code = as.numeric(person_of_color)) %>%
  select(title, country, race_known, subject_race, poc_code)

biopics %>%
  filter(country == "US")

### group_by
#### Combinado com summarize para: mean, max, min, sd.
##### Pipeline: box_office por country.
contryMeans <- biopics %>%
  filter(!is.na(box_office)) %>%
  group_by(country) %>%
  summarize(mean_box_office = mean(box_office))

##### Pipeline: box_office por subject_sex.
sexMeans <- biopics %>%
  filter(!is.na(box_office)) %>%
  group_by(subject_sex) %>%
  summarize(mean_boxOffice_by_gender = mean(box_office))

### Contagem
biopics %>%
  group_by(type_of_subject) %>%
  summarise(count = n())
# or
biopics %>% count(type_of_subject)

### Arranjo
biopics %>%
  arrange(year_release, country) # organiza por ano e, depois, por país.

### Selecao
#### Selecionar, reordenar, renomear colunas
biopics %>%
  select(movie_title=title, box_office, subject_sex)

### Desafio juntando tudo
biopics_new <- biopics %>%
  filter(year_release >= 2000 & year_release <= 2014, !is.na(box_office)) %>%
  mutate(box_office_per_subject = box_office / number_of_subjects)
summary(biopics_new)

### Desafio: Mostre o seu trabalho
#### Filmes cujo subject_race é white são mais rentavéis que filmes indianos? Qual o país mais rentável? 
glimpse(biopics)
levels(biopics$race_known)
biopics$race_known
levels(biopics$subject_race)
levels(biopics$country)
boxOffice_contry_subjectRace <- biopics %>%
  select(country, subject_race, box_office) %>%
  filter(subject_race %in% c("White", "Indian"), !is.na(box_office)) %>%
  group_by(subject_race, country) %>%
  summarize(sum_box_office = sum(box_office)) %>%
  arrange(desc(sum_box_office))


  

  
  
  
  
