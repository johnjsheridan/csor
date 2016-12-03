#' Shiny App for to show the plots from the csor package
#'
#' @return Runs the shiny app
#' @export
#'
#' @examples
#' \dontrun{
#' csor_shiny()
#' }
csor_shiny = function()
{
  appDir = system.file("shiny-examples", 'app', package = 'csor')
  if (appDir == "") {
    stop("Could not find shiny directory in package. Try re-installing `csor`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
