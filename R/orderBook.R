orderBook <- function(pair, count = 100){

  url <- "https://api.kraken.com/0/public/Depth"

  request <- GET(url, query = list(pair = pair, count = count))

  c <- content(request)

  ask_price <- vector()
  ask_volume <- vector()
  bid_price <- vector()
  bid_volume <- vector()

  for(i in 1:length(c$result[[pair]]$asks)) {
    ask_price <- c(ask_price, as.numeric(c$result[[pair]]$asks[[i]][[1]]))
    ask_volume <- c(ask_volume, as.numeric(c$result[[pair]]$asks[[i]][[2]]))
    bid_price <- c(bid_price, as.numeric(c$result[[pair]]$bids[[i]][[1]]))
    bid_volume <- c(bid_volume, as.numeric(c$result[[pair]]$bids[[i]][[2]]))
  }

  orderbook <- data.frame(ask_price = ask_price, ask_volume = ask_volume,
                          bid_price = bid_price, bid_volume = bid_volume)
  return(orderbook)

}
