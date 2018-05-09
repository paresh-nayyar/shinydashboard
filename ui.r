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
         # uiOutput("columns"),
           selectInput('plot',"Select Plot",choices = c('Line','Histogram','Bar','Box')),
           conditionalPanel(
           condition = "input.plot == 'Line'",
           uiOutput('line.x'),
           uiOutput("line.y")
           ),
           conditionalPanel(
           condition = "input.plot == 'Histogram'",
           uiOutput('hist')
           )
           ),
           mainPanel(
             plotOutput("check"),
             verbatimTextOutput('check1')
           )
         )),
navbarMenu("More",
           tabPanel("Summary"),
           "----",
           "Section header",
           tabPanel("Table")
)
  
)))