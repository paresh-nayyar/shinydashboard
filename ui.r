library(shiny)
library(shinythemes)

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
      actionButton("submit", "Submit"),
      uiOutput("columns")
      ),
    mainPanel(
      tabsetPanel(type = 'tabs',
                  tabPanel("Summary",verbatimTextOutput("summary")),
                  tabPanel("Table",tableOutput('contents')))
      
    )
  )),
navbarMenu("More",
           tabPanel("Summary"),
           "----",
           "Section header",
           tabPanel("Table")
)
  
)))