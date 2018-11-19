getPairs <- function(){

  url <- "https://api.kraken.com/0/public/AssetPairs"
  request <- GET(url)
  c <- content(request)
  return(names(c$result))

}
