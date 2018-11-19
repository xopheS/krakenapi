lastTrades <- function(pair, since = Sys.time()-3600){

  s = as.numeric(since)
  info = c("time", "price", "volume", "buy/sell", "market/limit")

  url <- "https://api.kraken.com/0/public/Trades"

  request <- GET(url, query = list(pair = pair, since = s))
  c <- content(request)

  price <- vector()
  volume <- vector()
  time <- vector()
  bs <- factor(levels = c("buy", "sell"))
  ml <- factor(levels = c("market", "limit"))

  for (i in 1:length(c$result[[pair]])) {
    time[i] <- as.numeric(c$result[[pair]][[i]][[3]])
    price[i] <- as.numeric(c$result[[pair]][[i]][[1]])
    volume[i] <- as.numeric(c$result[[pair]][[i]][[2]])
    bs[i] <- if(c$result[[pair]][[i]][[4]] == "b") "buy" else "sell"
    ml[i] <- if(c$result[[pair]][[i]][[5]] == "l") "limit" else "market"
  }

  res <- data.frame(time = as_datetime(time),
                    price = price,
                    volume = volume,
                    buy_sell = bs,
                    market_limit = ml)
  return(res)

}
