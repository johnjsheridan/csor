fit = function(obj, SecCode = 0, SeaAdj = FALSE)
{
  UseMethod('fit')
}

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
