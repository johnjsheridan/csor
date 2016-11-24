library(ggplot2)

plot.csor = function(obj, SecCode = 0, SeaAdj = FALSE)
{
  data = obj$data

  subData = subset(data, (SectorCode == SecCode) & (SeasonallyAdjusted == SeaAdj))

  ggplot(subData, aes(x = numericQuarter, y = value)) +
    geom_line() +
    xlab('Time Period') +
    ylab('GDP in Euro Millions')

  # Stacked bar chart
  subDataStacked = subset(data, (SectorCode != 0) & (SeasonallyAdjusted == SeaAdj))

  ggplot(subDataStacked, aes(x = numericQuarter, y = value ,fill = SectorCode)) +
    geom_bar(stat='identity')
}
