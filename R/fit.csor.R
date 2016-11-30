fit = function(obj, SecCode = 0, SeaAdj = FALSE)
{
  UseMethod('fit')
}

fit.csor = function(obj, SecCode = 0, SeaAdj = FALSE)
{
  data = obj$data

  subData = subset(data, (SectorCode == SecCode) & (SeasonallyAdjusted == SeaAdj))

  fit.sp = smooth.spline(subData$numericQuarter, subData$value, cv=TRUE)

  return(fit.sp)
}
