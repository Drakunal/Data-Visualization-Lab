#Install R shiny if it has not been installed previously.
#install.packages("shiny")
#Loading in current R session
library(shiny)

#It defines the user interface, the HTML webpage that humans 
#interact with. In this case, it’s a page containing the words 
#“Hello, world!”.
ui <- fluidPage(
  "Hello, world!"
)

#It specifies the behaviour of our app by defining a server function. 
#It’s currently empty, so our app doesn’t do anything
server <- function(input, output, session) {
}

#It executes shinyApp(ui, server) to construct and start 
#a Shiny application from UI and server.
shinyApp(ui, server)

#> Listening on http://127.0.0.1:5089 --- 5089 is the port number which is random
#> This tells you the URL where your app can be found: 127.0.0.1 is a standard address 
#> you can enter that URL into any compatible2 web browser to open another copy of your app.




