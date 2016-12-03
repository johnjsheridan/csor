#' Plot the GDP data in various ways
#'
#' @param obj An object of class \code{csor} from \code{\link{loadGDP}}
#' @param SecCode The sector code for the sector to fit
#' @param SeaAdj An indicator of whether we are fitting to the seasonally adjusted (TRUE) or the non-seasonally adjusted (FALSE) data
#' @param type The type of plot to create. "l" for a straight line plot. "lf" for a points plot with a fitted smoothing spline line. "b" for a stacked bar chart of all sectors.
#'
#' @return Nothing generates a plot
#' @export
#' @import ggplot2
#'
#' @seealso \code{\link{loadGDP}}, \code{\link{plot.csor}}, \code{\link{sectorList}}, \code{\link{predict.csor}}, \code{\link{smooth.spline}}
#' @examples
#' #' data = loadGDP()
#' plot(data)
#' plot(data, SecCode = 4, SeaAdj = TRUE)
#' plot(data, SecCode = 2, SeaAdj = FALSE, type = "lf")
#' plot(data, SeaAdj = FALSE, type = "b")
plot.csor = function(obj, SecCode = 0, SeaAdj = FALSE, type = "l")
{
  # Extract the data from our object
  data = obj$data

  # l and lf are line plots
  if((type == "l") || (type == "lf"))
  {
    # Subset the data according to the parameters
    subData = subset(data, (SectorCode == SecCode) & (SeasonallyAdjusted == SeaAdj))

    # Extract the title from the data
    graphtitle = subData$Statistic[1]
    graphtitle = gsub("annually", "annually\n", graphtitle)
    graphtitle = paste(graphtitle, "\n", subData$Sector[1], sep = "")

    # Prepare a plot object
    p = ggplot(subData, aes(x = numericQuarter, y = value)) +
      theme_bw() +
      ggtitle(graphtitle) +
      xlab('Time Period') +
      ylab('GDP in Euro Millions')

    if(type == "l")
    {
      # If the type is l just plot the data with a line
      p + geom_line()
    }
    else
    {
      # If the type is lf plot the data as points and add a fitted line
      p + geom_point() + geom_line(aes(subData$numericQuarter,predict(fit(obj, SecCode, SeaAdj),subData$numericQuarter)$y))
    }
  }
  else
  {
    # Plot all sectors as a stacked bar chart
    subData = subset(data, (SectorCode != 0) & (SectorCode != 2) & (SeasonallyAdjusted == SeaAdj))

    graphtitle = subData$Statistic[1]
    graphtitle = gsub("annually", "annually\n", graphtitle)

    ggplot(subData, aes(x = numericQuarter, y = value ,fill = Sector)) +
      geom_bar(stat='identity') +
      theme_bw() +
      ggtitle(graphtitle) +
      xlab('Time Period') +
      ylab('GDP in Euro Millions')
  }
}
