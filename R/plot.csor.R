library(ggplot2)

plot.csor = function(obj, SecCode = 0, SeaAdj = FALSE, type = "l")
{
  data = obj$data

  if(type == "l")
  {
    subData = subset(data, (SectorCode == SecCode) & (SeasonallyAdjusted == SeaAdj))

    graphtitle = subData$Statistic[1]
    graphtitle = gsub("annually", "annually\n", graphtitle)
    graphtitle = paste(graphtitle, "\n", subData$Sector[1], sep = "")

    ggplot(subData, aes(x = numericQuarter, y = value)) +
      theme_bw() +
      ggtitle(graphtitle) +
      geom_line() +
      xlab('Time Period') +
      ylab('GDP in Euro Millions')
  }
  else
  {
    subData = subset(data, (SectorCode != 0) & (SectorCode != 2) & (SeasonallyAdjusted == SeaAdj))

    graphtitle = subData$Statistic[1]
    graphtitle = gsub("annually", "annually\n", graphtitle)

    ggplot(subData, aes(x = numericQuarter, y = value ,fill = Sector)) +
      geom_bar(stat='identity') +
      theme_bw() +
      ggtitle(graphtitle) +
      xlab('Time Period') +
      ylab('GDP in Euro Millions')
  }
}
