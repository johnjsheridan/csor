

sectorList = function(data)
{
  sl = unique(data.frame(SectorName = data$Sector, SectorCode = data$SectorCode))

  sl
}
