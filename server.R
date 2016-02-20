library(shiny)
library(scales) # for printing values between 0 and 1 as percents (character)
library(xtable)

#Define server logic
shinyServer(function(input,output) {
  output$matPlot <- renderPlot({
    #get the inputs
    r<-input$rate
    t<-input$periods
    
    a<-expression(e^rt)                       #for the graph legend.
    b<-expression({(1 + r)}^t)                #for the graph legend.
    x<-percent(eval(r/100))          #for the subtitle, show the r value as a percent.
    y<-eval(t)                                #for the subtitle, the number of periods t.
    c<-paste("r =",x,",","t =",y,"periods")   #Paste together the subtitle.
    
    
    #define the plot
    matplot(c(0:t),cbind(exp(seq(0,r/100*t,by=r/100)), (1+r/100)^seq(0,t)),
            main ="Growth as a function of r (Growth or Interest Rate) and t (Number of Periods)",
            xlab="Periods",
            ylab = "Growth Factor",
            type="b",
            pch=c(20,21),
            lty=c(1,2),
            col=c("red","blue")
    )
    
    legend("top",
           c(a,b),
           bty="n",
           lty=c(1,2),
           pch=c(20,21),
           col=c("red","blue")
    )
    
    mtext(c,3) #effectively a subtitle, showing the chosen r and t values.
    
  })
  
  output$summaryIntro<-renderText({
    paste(input$rate,"%"," growth for ",input$periods," periods:",sep="" )
  })
  
  output$summaryContinuous<-renderText({
    paste(round(exp(input$rate/100*input$periods),2),
          "is the final growth factor",
          "under Continuous Growth."
          )
  })
  
  output$summaryPeriodic<-renderText({
    paste(round((1+input$rate/100)^input$periods,2),
          "is the final growth factor",
          "under Periodic Growth."
    )
  })
  output$gf<-renderText({
        paste(round(exp(input$rate/100*input$periods)*100,0),
          "units under continous growth, and",
          round((1+input$rate/100)^input$periods*100,0),
          "units under periodic growth."
    )
  })
  
  output$tbl<-renderText({
    r<-input$rate
    t<-input$periods
    jay<-as.data.frame(cbind(c(0:t),exp(seq(0,r/100*t,by=r/100)), (1+r/100)^seq(0,t)))
    names(jay)<-c("Period","\b \b Continuous: e^rt","\b \b Periodic: (1+r)^t")
    tab <- xtable(jay,digits=c(0,0,3,3),
                  style="padding:10px",
                  caption='Table: Growth factor values for each period'
                  )
    print(tab, type="html",include.rownames = FALSE,
          html.table.attributes = getOption("xtable.html.table.attributes",
                                            "border=0"),
          caption.placement = getOption("xtable.caption.placement","top")
          )
    
  })
  
})