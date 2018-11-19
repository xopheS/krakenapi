ticker <- function(pairs){

    pairs <- paste(pairs, sep = ",")
    info = c("ask", "bid", "lastTrade", "volume",
             "vwap", "nbOfTrades", "low", "high", "open")

    url <- "https://api.kraken.com/0/public/Ticker"

    request <- GET(url, query = list(pair = pairs))
    c <- content(request)

    ####CREATES NAMED VECTOR WITH INFOS ON THE TICKER
    vect <- function(v, tick){
     newv <- vector()
     for (i in 1:length(info)) newv[i] <- as.numeric(c$result[[tick]][[i]][[1]])
     names(newv) <- info
     return(newv)
    }

    l <- list()

    for (i in 1:length(pairs)) l[[i]] <- vect(info, pairs[i])
    names(l) <- pairs

    return(l)
    #### RETURN LIST CONTAINING INFO ON PAIRS IN NAMED VECTORS

}
