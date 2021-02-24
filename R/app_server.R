#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here

  # define some credentials
  credentials <- data.frame(
    user = c("lefkios", "admin"), # mandatory
    password = c("12345", "12345"), # mandatory
    start = c("2020-01-01"), # optinal (all others)
    expire = c(NA, "2022-12-31"),
    admin = c(FALSE, TRUE),
    comment = "Simple and secure authentification mechanism 
  for single ‘Shiny’ applications.",
    stringsAsFactors = FALSE
  )
  
  res_auth <- shinymanager::secure_server(
    check_credentials = shinymanager::check_credentials(credentials)
  )
  
  
  output$auth_output <- renderPrint({
    
    reactiveValuesToList(res_auth)
  })
  
  output$user <- renderPrint(
    
    res_auth$user
  )
  
  output$user_menu <- shinydashboard::renderMenu({
    
    user <- res_auth$user
    
    dropdownMenu(
       notificationItem(
         user,
         icon = icon("check")
       ),
       headerText = "Logged in as:",
       badgeStatus = NULL,
      type = "notifications",
      icon = icon("user")
    )
    
  })
 
  
}
