get <- NULL
server <- function(input, output)
{
  output$contents <- renderTable({
    req(input$filedata)
    get <- input$filedata
     
    df <- read.csv(input$filedata$datapath,
                   header = input$header,
                   sep    = input$sep)
    if(input$disp == 'head'){
      return(head(df))
    }
    else {
      return(df)
    }
  })
}

