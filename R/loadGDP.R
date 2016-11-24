library(rjstat)

loadGDP = function()
{
  gdp.url = "http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/NQQ28"

  lData = fromJSONstat(readLines(gdp.url))

  dfData = lData[[1]]

  Sector = unique(dfData$Sector)

  SectorCodes = seq(from = 0, to = length(Sector) - 1)

  dfSectors = data.frame(Sector, SectorCodes)

  dfData = merge(dfData, dfSectors)

  dfData$SeasonallyAdjusted = FALSE

  dfData[grepl("Seasonal",dfData$Statistic), "SeasonallyAdjusted"] = TRUE

  out_list = list(data = dfData)

  class(out_list) = 'csor'

  return(out_list)
}
