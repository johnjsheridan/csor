#' Return the list of sectors with their codes
#'
#' @param data Output from the \code{\link{loadGDP}} function
#'
#' @return Nothing: prints the list
#' @export
#'
#' @seealso \code{\link{loadGDP}}, \code{\link{plot.csor}}, \code{\link{fit.csor}}, \code{\link{predict.csor}}
#' @examples
#' data = loadGDP()
#' sectorList(data)
sectorList = function(data)
{
  # Check that the class is csor before we continue
  if(class(data) == 'csor')
  {
    # Send back a list of sectors and sector codes
    sl = unique(data.frame(SectorName = data[[1]]$Sector, SectorCode = data[[1]]$SectorCode))
    sl = sl[order(sl[,2]), ]

    print(sl, row.names = F)
  }
  else
  {
    print("sectorList only accepts an object of type csor")
  }
}
