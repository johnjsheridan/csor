library(ggplot2)

plot.csor = function(obj, SecCode = 0, SeaAdj = FALSE, type = "l")
{
  data = obj$data

  if((type == "l") || (type == "lf"))
  {
    subData = subset(data, (SectorCode == SecCode) & (SeasonallyAdjusted == SeaAdj))

    graphtitle = subData$Statistic[1]
    graphtitle = gsub("annually", "annually\n", graphtitle)
    graphtitle = paste(graphtitle, "\n", subData$Sector[1], sep = "")

    p = ggplot(subData, aes(x = numericQuarter, y = value)) +
      theme_bw() +
      ggtitle(graphtitle) +
      xlab('Time Period') +
      ylab('GDP in Euro Millions')

    if(type == "l")
    {
      p + geom_line()
    }
    else
    {
      p + geom_point() + geom_line(aes(subData$numericQuarter,predict(fit(obj, SecCode, SeaAdj),subData$numericQuarter)$y))
    }
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
