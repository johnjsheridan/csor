#' Fit a smoothing spline to one of the GDP time series
#'
#' @param obj An object of class \code{csor} from \code{\link{loadGDP}}
#' @param SecCode The sector code for the sector to fit
#' @param SeaAdj An indicator of whether we are fitting to the seasonally adjusted (TRUE) or the non-seasonally adjusted (FALSE) data
#'
#' @return Returns a list of class \code{smooth.spline}
#' @export
#' @importFrom stats "smooth.spline"
#'
#' @seealso \code{\link{loadGDP}}, \code{\link{plot.csor}}, \code{\link{sectorList}}, \code{\link{predict.csor}}, \code{\link{smooth.spline}}
#' @examples
#' data = loadGDP()
#' fit1 = fit(data)
#' fit2 = fit(data, SecCode = 4, SeaAdj = TRUE)
fit = function(obj, SecCode = 0, SeaAdj = FALSE)
{
  UseMethod('fit')
}
#' @export
fit.csor = function(obj, SecCode = 0, SeaAdj = FALSE)
{
  # Extract the data from the csor object
  data = obj$data

  # Subet the data according to the parameters
  subData = subset(data, (SectorCode == SecCode) & (SeasonallyAdjusted == SeaAdj))

  # Fit a smoothing spline to the data
  fit.sp = smooth.spline(subData$numericQuarter, subData$value, cv=TRUE)

  return(fit.sp)
}
