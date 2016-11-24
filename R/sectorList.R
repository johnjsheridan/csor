sectorList = function(data)
{
  if(class(data) == 'csor')
  {
    sl = unique(data.frame(SectorName = data[[1]]$Sector, SectorCode = data[[1]]$SectorCode))
    sl = sl[order(sl[,2]), ]

    print(sl, row.names = F)
  }
  else
  {
    print("sectorList only accepts an object of type csor")
  }
}
