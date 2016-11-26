fit.csor = function(obj)
{
  data = obj$data

  SecCode = 0
  SeaAdj = FALSE

  subData = subset(data, (SectorCode == SecCode) & (SeasonallyAdjusted == SeaAdj))

  fit.sp <- smooth.spline(subData$numericQuarter, subData$value, cv=TRUE)
  plot(subData$numericQuarter, subData$value)
  points(subData$numericQuarter,predict(fit.sp,subData$numericQuarter)$y,col="green",type="l",lty=1)
}
plot(subData$numericQuarter, subData$value)
points(subData$numericQuarter,predict(fit.sp,subData$numericQuarter)$y,col="green",type="l",lty=1)

matrix(, nrow = 15, ncol = 0)
