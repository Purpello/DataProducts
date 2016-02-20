library(shiny)

#Define the UI
shinyUI(fluidPage(
  div(
  titlePanel("Continuously vs Periodically Compounded Growth"),
  style="margin-bottom:50px;background-color:#efefef;padding:10px"
  ),

#Sidebar with two sliders
  sidebarLayout(
    sidebarPanel(
      sliderInput("rate",
                "r = Growth Rate or Interest Rate (e.g. 5 = 5%):",
                min = 1,
                max = 100,
                value = 5),
      sliderInput("periods",
                "t = Number of Periods:",
                min = 1,
                max = 100,
                value = 20),
      helpText("
               r is the Growth Rate or Interest Rate as a percent.  So, if you choose 5, you are selecting 5%.
               "),
      helpText("
               t is the Number of Periods over which r will operate.
               "),
      helpText("
               Two types of growth are plotted on the right.
               "),
      withMathJax(helpText(
        "$$e^{rt} = {continuous } $$  
        $$(1 + r)^t = {periodic } $$ ")),
      
      helpText("
               Growth Factor, the y-axis in the plot on the right, is the 
               factor by which the original input grows according to either the 
               continous or periodic growth formulas above.
               "),
      
      helpText(
               tags$a(href="http://rpubs.com/jaysonwebb/154428","Click for more Information about continuous and periodic growth
                      in the context of this application.")
               )
      
  ),
  #Show the graph and text output
  mainPanel (
    div(
    plotOutput("matPlot"),
    style="width:700px"),
    div(
    h1("Summary"),
    h2(textOutput("summaryIntro")),
    h3(textOutput("summaryContinuous")),
    h3(textOutput("summaryPeriodic")),
    style="color:gray;margin-left:50px"), 
    div(
    p("So, if you started with 100 units of something
      (dollars, cells, etc.)
      you would end up with"),
    textOutput("gf"),
    p("\n"),
    htmlOutput("tbl"),
    style="color:#555;margin-left:50px;margin-top:25px")

  )
  )
))