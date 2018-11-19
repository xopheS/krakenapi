###RECENT SPREAD DATA

spread <- function(pair, since = Sys.time()-3600){

  s = as.numeric(since)
  info = c("time", "bid", "ask")

  url <- "https://api.kraken.com/0/public/Spread"

  request <- GET(url, query = list(pair = pair, since = s))
  c <- content(request)

  bid <- vector()
  ask <- vector()
  time <- vector()

  for (i in 1:length(c$result[[pair]])) {
    time[i] <- as.numeric(c$result[[pair]][[i]][[1]])
    bid[i] <- as.numeric(c$result[[pair]][[i]][[2]])
    ask[i] <- as.numeric(c$result[[pair]][[i]][[3]])
  }

  res <- data.frame(time = as_datetime(time),
                    bid = bid,
                    ask = ask,
                    spread = ask - bid)
  return(res)

}
