#Limpando a mem�ria do R
rm(list=ls(all=T))

# Packages
library(xlsx)
library(reshape)
library(tm)
library(wordcloud)

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Nuvem de Palavras Simples

#Dados
dataset=read.xlsx("C:/Users/KLC/Desktop/Reposit�rio/Text mining, word clouds and comparison clouds/data.xlsx",1,encoding = "UTF-8")

data <- data.frame(text = dataset$Coment�rio)
text <- paste(data$text, collapse = " ")
text <- toupper(text)

source <- VectorSource(text)
corpus <- VCorpus(source, list(language = "pt"))

# Tratamento dos textos                 
clean_corpus <- function(corpus){
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeWords, c(stopwords("pt")))
  return(corpus)
}   

clean_corp <- clean_corpus(corpus)
data_tdm <- TermDocumentMatrix(clean_corp)
data_m <- as.matrix(data_tdm)

#Plot da nuvem de palavras
par(mar = c(0,0,0,0))
commonality.cloud(data_m, colors = c("#224768", "#ffc000"), max.words = 50)


