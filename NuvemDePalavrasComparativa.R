#Limpando a memória do R
rm(list=ls(all=T))

# Packages
library(xlsx)
library(reshape)
library(tm)
library(wordcloud)

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Comparison Cloud

#Dados
dataset=read.xlsx("C:/Users/User/Desktop/Repositório/Text mining, word clouds and comparison clouds/data.xlsx",1,encoding = "UTF-8")

Neutro <- as.vector(dataset[dataset$Sentimento == "Neutro","Comentário"])
Negativo <- as.vector(dataset[dataset$Sentimento == "Negativo","Comentário"])
Positivo <- as.vector(dataset[dataset$Sentimento == "Positivo","Comentário"])

## Building the list for the corpus
wordALL <- list(Neutro, Negativo,Positivo)

source <- VectorSource(wordALL)
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
colnames(data_m) <- c("Neutro", "Negativo","Positivo")

## Plotting
dev.new()
comparison.cloud(data_m, max.words=50, scale=c(4,0.5), rot.per=0.2,
                 random.order=FALSE,title.size=1.5,colors=c("gold","orangered","royalblue4"))
