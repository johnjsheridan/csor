#' Predict one quarter ahead for each of the GDP time series
#'
#' @param object An object of class \code{csor} from \code{\link{loadGDP}}
#' @param ... Additional arguments passed to or from other methods
#'
#' @return A data frame wih a prediction for the next quarters GDP for each combination of sector and whether the data is seasonally adjusted or not.
#' @export
#' @importFrom stats "predict"
#'
#' @seealso \code{\link{loadGDP}}, \code{\link{plot.csor}}, \code{\link{sectorList}}, \code{\link{fit}}, \code{\link{smooth.spline}}
#' @examples
#' data = loadGDP()
#' pred = predict(data)
predict.csor = function(object, ...)
{
  # Extract the data from the csor object
  data = object$data

  # Set xs to one quarter beyond the last quarter in the time series
  xs = max(data$numericQuarter) + 0.25

  # Create a textual version of this new quarter
  splitNumeric = strsplit(as.character(xs), "[.]")

  if (is.null(splitNumeric[[1]][2]))
  {
    quarter = "Q1"
  }
  if (splitNumeric[[1]][2] == "25")
  {
    quarter = "Q2"
  }
  if (splitNumeric[[1]][2] == "5")
  {
    quarter = "Q3"
  }
  if (splitNumeric[[1]][2] == "75")
  {
    quarter = "Q4"
  }

  period = paste(splitNumeric[[1]][1], quarter, sep = "")

  # Set up a data frame to hold our predictions
  predictions = unique(data.frame(SectorName = data$Sector, SectorCode = data$SectorCode, SeasonallyAdjusted = data$SeasonallyAdjusted))

  predictions$period = period

  predictions$PredictedValue = 0

  rownames(predictions) = NULL

  # Create a prediction for the new quarter for each combination of sector and
  # whether the data is seasonally adjusted or not
  for(i in 1:nrow(predictions))
  {
    predictions[i,]$PredictedValue = predict(fit(object, SecCode = predictions[i,]$SectorCode, SeaAdj = predictions[i,]$SeasonallyAdjusted), xs)$y
  }

  return(predictions)
}
