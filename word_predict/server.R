#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))

# Load Quadgram,Trigram & Bigram Data frame files

quadgram <- readRDS("fourgram.rds");
trigram <- readRDS("threegram.rds");
bigram <- readRDS("twogram.rds");


# Cleaning of user input before predicting the next word

predictWord <- function(x) {
  cleanInput <- removeNumbers(removePunctuation(tolower(x)))
  cleanInput <- strsplit(cleanInput, " ")[[1]]
  
  
  if (length(cleanInput)>= 3) {
    cleanInput <- tail(cleanInput,3)
    if (identical(character(0),head(quadgram[quadgram$unigram == cleanInput[1] & quadgram$bigram == cleanInput[2] & quadgram$trigram == cleanInput[3], 4],1))){
      predictWord(paste(cleanInput[2],cleanInput[3],sep=" "))
    }
    else {head(quadgram[quadgram$unigram == cleanInput[1] & quadgram$bigram == cleanInput[2] & quadgram$trigram == cleanInput[3], 4],1)}
  }
  else if (length(cleanInput) == 2){
    cleanInput <- tail(cleanInput,2)
    if (identical(character(0),head(trigram[trigram$unigram == cleanInput[1] & trigram$bigram == cleanInput[2], 3],1))) {
      predictWord(cleanInput[2])
    }
    else {head(trigram[trigram$unigram == cleanInput[1] & trigram$bigram == cleanInput[2], 3],1)}
  }
  else if (length(cleanInput) == 1){
    cleanInput <- tail(cleanInput,1)
    if (identical(character(0),head(bigram[bigram$unigram == cleanInput[1], 2],1))) {mesg<<-"No match found. Most common word 'the' is returned."; head("the",1)}
    else {head(bigram[bigram$unigram == cleanInput[1],2],1)}
  }
}


shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    predictedWord <- predictWord(input$inputData)
    predictedWord
  });
}
)