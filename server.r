get <- NULL
df <- NULL
server <- function(input, output)
{
  data <- reactive({
    df <<- read.csv(input$filedata$datapath,
                   header = input$header,
                   sep    = input$sep)
    return (df)
    
  })
  output$contents <- renderTable({
    data()
    req(input$filedata)
    get <- input$filedata
     
    
    if(input$disp == 'head'){
      return(head(df))
    }
    else {
      return(df)
    }
  })
}

