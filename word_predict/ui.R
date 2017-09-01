#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

suppressWarnings(library(shiny))
shinyUI(navbarPage("Project which is predicting words made to finish Data Science Spec.",
                   tabPanel(
                            sidebarLayout(
                              sidebarPanel(
                                textInput("inputData", "Enter a partial sentence here",value = ""),
                                br()
                              ),
                              mainPanel(
                                h2("Predicted Word"),
                                verbatimTextOutput("prediction"),
                                strong("Sentence Input:"),
                                textOutput('text1'),
                                br()
                              )
                            )
                   )
)
)