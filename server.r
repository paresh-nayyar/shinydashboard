get <- NULL
server <- function(input, output)
{
    data <- eventReactive(input$submit,{
      df <- read.csv(input$filedata$datapath,sep = input$sep, header = input$header)
      
    })
    
    reg.model <- eventReactive(input$submit.reg,{
      var <- input$reg.x
      mat <- NULL
      for (char in var){
        mat <- cbind(mat,matrix(data()[,char]))
      }
      
      linear.model <- lm(data()[,input$reg.y] ~ mat)
      print(linear.model)
    })
    
    log.model <- eventReactive(input$submit.log,{
      var <- input$log.x
      mat <- NULL
      for (char in var){
        mat <- cbind(mat,matrix(data()[,char]))
      }
      
      log.model <- glm(data()[,input$log.y] ~ mat,family = binomial(link = "logit"))
      print(log.model)
    })
   
    kmean.model <- eventReactive(input$submit.kmean,{
      var <- input$var.kmean
      mat <- NULL
      for (char in var){
        mat <- cbind(mat,matrix(data()[,char]))
      }
      
      kmean.model <- kmeans(mat,centers = input$clusters,iter.max = 10)
      print(kmean.model)
    })
    
    model.data <- eventReactive(input$submit.train,{
      n1 <- nrow(data())
      n2 <- n1*input$train/100
      index <- sample(n1,n2)
      train_data <- data()[index,]
      test_data  <- data()[-index,]
      data.list <- list(train_data,test_data)
    })
    
  output$contents <- renderTable({
    
    if(is.null(input$filedata)){
      return(NULL)
    }else{
    
    if(input$disp == 'head'){
      return(head(data()))
    }
    else {
      return(data())
    }
    }    
  })
  output$train.data <- renderTable({
    
    if(is.null(input$submit.train)){
      return(NULL)
    }else{
      
      return(model.data()[[1]])
      
    }    
  })
  
  output$test.data <- renderTable({
    
    if(is.null(input$submit.train)){
      return(NULL)
    }else{
      return(model.data()[[2]])
      }    
  })
  
  output$summary <- renderPrint({

    if(is.null(input$submit)){
      return("Waitingforfile")
    }else{
      summary(data())
    }
    }
    
  )
  
  output$reg.summary <- renderPrint({
    
    if(is.null(input$submit.reg)){
      return("Waitingforfile")
    }else{
      summary(reg.model())
    }
  }
  
  )
  
  output$log.summary <- renderPrint({
    
    if(is.null(input$submit.log)){
      return("Waitingforfile")
    }else{
      summary(log.model())
    }
  }
  
  )
  
  output$kmean.summary <- renderPrint({
    
    if(is.null(input$submit.kmean)){
      return("Waitingforfile")
    }else{
      summary(kmean.model())
    }
  }
  
  )
  
 output$line.x <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("line.x","Select X-Axis",col.names,multiple = T)
   
 })
 
 output$line.y <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("line.y","Select Y-Axis",col.names,multiple = T)
   
 })
 
 output$hist <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("hist","Select Column",col.names,multiple = F)
   
 })
 
 output$box.x <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("box.x","Select Nominal Variable",col.names,multiple = F)
   
 })
 
 output$box.y <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("box.y","Select Continuous Variable",col.names,multiple = F)
   
 })
 
 output$reg.y <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("reg.y","Select Dependent Variable",col.names,multiple = F)
   
 })
 
 output$reg.x <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("reg.x","Select Indpenedent Variables",col.names,multiple = T)
   
 })
 
 output$log.y <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("log.y","Select Dependent Variable",col.names,multiple = F)
   
 })
 
 output$log.x <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("log.x","Select Indpenedent Variables",col.names,multiple = T)
   
 })
 
 output$var.kmean <- renderUI({
   df        <- data()
   col.names <- names(df)
   selectInput("var.kmean","Select Columns",col.names,multiple = T)
   
 })
 
 # getvalue <- reactive({
 #   output$hist
 #   print(input$hist)
 # })
 
 output$plots <- renderPlot({
   
   if(is.null(input$submit)){
     return("Waitingforfile")
   }else
     if(input$plot == 'Box'){
      df <- data.frame(data())
      x.axis <- as.character(df[,input$box.x])
      y.axis <- as.numeric(df[,input$box.y])
      box    <- ggplot(data=data(), aes(y = y.axis,x = x.axis)) + geom_boxplot() 
      box
   }else
     if(input$plot == 'Histogram')
     {
       hist   <- ggplot(data=data(), aes(data()[,input$hist])) + geom_histogram() + 
       labs(x = input$hist)
       hist
     }else
       if(input$plot == 'Line')
       {
         df <- data.frame(data())
         x.axis <- as.numeric(df[,input$line.x])
         y.axis <- as.numeric(df[,input$line.y])
         line <- ggplot(data = data(),aes(y = y.axis,x = x.axis)) + geom_line(color = 'black')
         line
       }
  }
 )
 
  output$check1 <- renderPrint({
    
    if(is.null(input$submit.train)){
      return("Waitingforfile")
    }else{
      print(model.data())
   }
  }
 )
 
}

