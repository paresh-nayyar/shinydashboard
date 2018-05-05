library(shiny)
ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("filedata","Choose CSV File",accept = c("text/csv",
                                                        "text/comma-separated-values,text/plain",
                                                        ".csv")),
      tags$hr(),
      checkboxInput("header","Header",TRUE),
      radioButtons("sep",'Separator',
                   choices = c(Comma =",",
                               Semicolon =";",
                               Tab = "\t"),
                   selected = ","),
      radioButtons("disp","Display",
                   choices = c(Head = 'head',
                               ALL  = 'all'),
                   selected = 'head')
      ),
    mainPanel(
      tableOutput('contents')
    )
  )
  
)