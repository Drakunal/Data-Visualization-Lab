#Install R shiny if it has not been installed previously.
#install.packages("shiny")
#Loading in current R session
library(shiny)

#It defines the user interface, the HTML webpage that humans 
#interact with. In this case, it’s a page containing the words 
#“Hello, world!”.


#ui <- fluidPage(
#  "Hello, world!"
#)


#It specifies the behaviour of our app by defining a server function. 
#It’s currently empty, so our app doesn’t do anything



#server <- function(input, output, session) {
#}


#It executes shinyApp(ui, server) to construct and start 
#a Shiny application from UI and server.


#shinyApp(ui, server)


#> Listening on http://127.0.0.1:5089 --- 5089 is the port number which is random
#> This tells you the URL where your app can be found: 127.0.0.1 is a standard address 
#> you can enter that URL into any compatible2 web browser to open another copy of your app.

#Adding UI Controls-------------------------------------------------------------


#fluidPage() is a layout function that sets up the basic visual structure of the page. 
#selectInput() is an input control that lets the user interact with the app by 
#providing a value. In this case, it’s a select box with the label “Dataset” and 
#lets you choose one of the built-in datasets that come with R. 

#verbatimTextOutput() and tableOutput() are output controls that tell Shiny 
#where to put rendered output. 
#verbatimTextOutput() displays code and tableOutput() displays tables.

#a page containing a select box. We only see the input, not the two outputs, 
#because we haven’t yet told Shiny how the input and outputs are related.



ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)
# 
# server <- function(input, output, session) {
# }
# 
# shinyApp(ui, server)


#Adding behaviours -------------------------------------------------------------

#Shiny uses reactive programming to make apps interactive. 
#as of now, just be aware that it involves telling Shiny how to perform a 
#computation, not ordering Shiny to actually go do it. 
#It’s like the difference between giving someone a recipe versus demanding that 
#they go make you a sandwich.

#We’ll tell Shiny how to fill in the summary and table outputs in the sample app
#by providing the “recipes” for those outputs. Replace your empty server
#function with this:
server <- function(input, output, session) {
  output$summary <- renderPrint({
    dataset <- get(input$dataset, "package:datasets")
    summary(dataset)
  })
  
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}

server <- function(input, output, session) {
}

shinyApp(ui, server)