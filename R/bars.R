bars <- function(pair = "XXBTZUSD", interval = 1, since = Sys.time()-24*30*3600*2){
  ###INTERVALS ONLY 1, 5, 15, 30, 60, 240, 1440, 10080, 21600
  time = as.numeric(since)

  url <- "https://api.kraken.com/0/public/OHLC"
  request <- GET(url, query = list(pair = pair, interval = interval, since = time))
  c <- content(request)

  t <- vector()
  open <- vector()
  high <- vector()
  low <- vector()
  close <- vector()
  vwap <- vector()
  volume <- vector()
  count <- vector()

  for (i in 1:length(c$result[[pair]])) {
      t[i] <- as.numeric(c$result[[pair]][[i]][[1]])
      open[i] <- as.numeric(c$result[[pair]][[i]][[2]])
      high[i] <- as.numeric(c$result[[pair]][[i]][[3]])
      low[i] <- as.numeric(c$result[[pair]][[i]][[4]])
      close[i] <- as.numeric(c$result[[pair]][[i]][[5]])
      vwap[i] <- as.numeric(c$result[[pair]][[i]][[6]])
      volume[i] <- as.numeric(c$result[[pair]][[i]][[7]])
      count[i] <- as.numeric(c$result[[pair]][[i]][[8]])
  }

  res <- data.frame(time = as_datetime(t),
                    open = open,
                    high = high,
                    low = low,
                    close = close,
                    vwap = vwap,
                    volume = volume,
                    count = count)
  return(res)

}
