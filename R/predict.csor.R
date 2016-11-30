predict.csor = function(obj)
{
  data = obj$data

  xs = max(data$numericQuarter) + 0.25

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

  predictions = unique(data.frame(SectorName = data$Sector, SectorCode = data$SectorCode, SeasonallyAdjusted = data$SeasonallyAdjusted))

  predictions$period = period

  predictions$PredictedValue = 0

  rownames(predictions) = NULL

  for(i in 1:nrow(predictions))
  {
    predictions[i,]$PredictedValue = predict(fit(obj, SecCode = predictions[i,]$SectorCode, SeaAdj = predictions[i,]$SeasonallyAdjusted), xs)$y
  }

  return(predictions)
}
