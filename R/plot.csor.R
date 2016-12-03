library(ggplot2)

plot.csor = function(obj, SecCode = 0, SeaAdj = FALSE, type = "l")
{
  # Extract the data from our object
  data = obj$data

  # l and lf are line plots
  if((type == "l") || (type == "lf"))
  {
    # Subset the data according to the parameters
    subData = subset(data, (SectorCode == SecCode) & (SeasonallyAdjusted == SeaAdj))

    # Extract the title from the data
    graphtitle = subData$Statistic[1]
    graphtitle = gsub("annually", "annually\n", graphtitle)
    graphtitle = paste(graphtitle, "\n", subData$Sector[1], sep = "")

    # Prepare a plot object
    p = ggplot(subData, aes(x = numericQuarter, y = value)) +
      theme_bw() +
      ggtitle(graphtitle) +
      xlab('Time Period') +
      ylab('GDP in Euro Millions')

    if(type == "l")
    {
      # If the type is l just plot the data with a line
      p + geom_line()
    }
    else
    {
      # If the type is lf plot the data as points and add a fitted line
      p + geom_point() + geom_line(aes(subData$numericQuarter,predict(fit(obj, SecCode, SeaAdj),subData$numericQuarter)$y))
    }
  }
  else
  {
    # Plot all sectors as a stacked bar chart
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
