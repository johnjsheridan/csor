library(rjstat)

loadGDP = function()
{
  # Set up the url for the GDP data from the CSO
  gdp.url = "http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/NQQ28"

  # Load the data in JSONstat format and convert to a list
  lData = fromJSONstat(readLines(gdp.url, warn = FALSE))

  # Pull the data frame of the data from the list
  dfData = lData[[1]]

  # Pull the sectors and assign a numeric code
  Sector = unique(dfData$Sector)

  SectorCode = seq(from = 0, to = length(Sector) - 1)

  dfSectors = data.frame(Sector, SectorCode)

  dfData = merge(dfData, dfSectors)

  # Add a logical column to say whether the data is seasonally adjusted or not
  dfData$SeasonallyAdjusted = FALSE

  dfData[grepl("Seasonal",dfData$Statistic), "SeasonallyAdjusted"] = TRUE

  # Turn the textual description of the year and quarter into a numeric version
  # Will be useful for plotting
  temp = strsplit(dfData$Quarter, "Q")

  temp2 = lapply(temp, function(x) return(as.numeric(x[1]) + (0.25 * as.numeric(x[2])) - 0.25))

  dfData$numericQuarter = unlist(temp2)

  # Package up the output into a list and set the class to csor
  out_list = list(data = dfData)

  class(out_list) = 'csor'

  return(out_list)
}
