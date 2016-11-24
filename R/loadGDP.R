library(rjstat)

loadGDP = function()
{
  gdp.url = "http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/NQQ28"

  lData = fromJSONstat(readLines(gdp.url))

  dfData = lData[[1]]

  Sector = unique(dfData$Sector)

  SectorCode = seq(from = 0, to = length(Sector) - 1)

  dfSectors = data.frame(Sector, SectorCode)

  dfData = merge(dfData, dfSectors)

  dfData$SeasonallyAdjusted = FALSE

  dfData[grepl("Seasonal",dfData$Statistic), "SeasonallyAdjusted"] = TRUE

  temp = strsplit(dfData$Quarter, "Q")

  temp2 = lapply(temp, function(x) return(as.numeric(x[1]) + (0.25 * as.numeric(x[2])) - 0.25))

  dfData$numericQuarter = unlist(temp2)

  out_list = list(data = dfData)

  class(out_list) = 'csor'

  return(out_list)
}
