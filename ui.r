library(shiny)
library(shinythemes)
library(ggplot2)

shinyUI(fluidPage(navbarPage(theme=shinytheme("flatly"),tags$b("DashBoard"),br(),collapsible = T,
                             
tabPanel("Data",
  sidebarLayout(
    sidebarPanel(
      fileInput("filedata","Choose CSV File",accept = c("text/csv",
                                                        "text/comma-separated-values,text/plain",
                                                        ".csv")),
      checkboxInput("header","Header",TRUE),
      radioButtons("sep",'Separator',inline = T,
                   choices = c(Comma =",",
                               Semicolon =";",
                               Tab = "\t"),
                   selected = ","),
      radioButtons("disp","Display",inline = T,
                   choices = c(Head = 'head',
                               ALL  = 'all'),
                   selected = 'head'),
      actionButton("submit", "Submit",icon('table'))
      ),
    mainPanel(
      tabsetPanel(type = 'tabs',
                  tabPanel("Summary",verbatimTextOutput("summary")),
                  tabPanel("Table",tableOutput('contents')))
      
    )
  )),

tabPanel("Plots",
         sidebarLayout(
           sidebarPanel(
            selectInput('plot',"Select Plot",choices = c('Line','Histogram','Bar','Box')),
            conditionalPanel(
              condition = "input.plot == 'Line'",
              uiOutput('line.x'),
              uiOutput("line.y")
            ),
            conditionalPanel(
              condition = "input.plot == 'Histogram'",
              uiOutput('hist')
           ),
           conditionalPanel(
             condition = "input.plot == 'Box'",
             uiOutput("box.x"),
             uiOutput("box.y")
           ),
           actionButton("submit.plot", "Submit")
           ),
           mainPanel(
            
           )
         )),
navbarMenu("Machine Learning",
      "Data Preparation",
      tabPanel("Training-Testing Data",
               sidebarLayout(
                 sidebarPanel(
                   sliderInput("train", "Percentage of Training Data",
                               min = 1, max = 100, value = 70),
                   actionButton("submit.train", "Submit")
                 ),
                 mainPanel(
                    tabsetPanel(type = 'tabs',
                                tabPanel("Training Data",tableOutput("train.data")),
                                tabPanel("Testing Data",tableOutput('test.data')),
                                tabPanel("Check",verbatimTextOutput('check1')))
                   #verbatimTextOutput('check1')
                 )
               )
               
      ),
      
      "Regression",
      tabPanel("Linear Regression",
               sidebarLayout(
                 sidebarPanel(
                 uiOutput('reg.y'),
                 uiOutput('reg.x'),
                 actionButton("submit.reg", "Submit")
                 ),
                 mainPanel(
                    tabsetPanel(type = 'tabs',
                                tabPanel("Model-Summary",verbatimTextOutput("reg.summary")),
                                tabPanel("Plot",tableOutput('reg.plot')))
                 )
               )
               
               ),
      tabPanel("Logistic  Regression",
               sidebarLayout(
                 sidebarPanel(
                   uiOutput('log.y'),
                   uiOutput('log.x'),
                   actionButton("submit.log", "Submit")
                 ),
                 mainPanel(
                   tabsetPanel(type = 'tabs',
                               tabPanel("Model-Summary",verbatimTextOutput("log.summary")),
                               tabPanel("Plot",tableOutput('log.plot')))
                 )
               )
               
      ),
      "Clustering",
      tabPanel("K-Mean Clustering",
               sidebarLayout(
                 sidebarPanel(
                   uiOutput('var.kmean'),
                   numericInput("clusters", "Select Clusters", 10, min = 1, max = 100),
                   actionButton("submit.kmean", "Submit")
                 ),
                 mainPanel(
                   tabsetPanel(type = 'tabs',
                               tabPanel("Model-Summary",verbatimTextOutput("kmean.summary")),
                               tabPanel("Plot",tableOutput('kmean.plot')))
                 )
               )
               
      )
     
      
      )
  
)))