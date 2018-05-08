library(shiny)
ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  
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
      actionButton("submit", "Submit")
      ),
    mainPanel(
      tabsetPanel(type = 'tabs',
                  tabPanel("Summary",verbatimTextOutput("summary")),
                  tabPanel("Table",tableOutput('contents')))
      
    )
  )
  
)