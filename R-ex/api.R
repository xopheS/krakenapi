rm(list = ls())

p <- c("jsonlite", "httr", "lubridate")
sapply(p, require, character.only = TRUE)

key <- "tNQyL3iTmTaDP6K3S3yxMs0ciZ/dT6izZyjAmpdmg9WbN32sqRkzMPug"
sign <- "v/rn6x5rRKoHzUtRDs9vkh8ab64ZWI8hNzc/MfG4Sa5pb4YTYGDWF2qJjGIHeAeUrs5CU2ahto7g2QeTLRTPWA=="
keyStage <- "FbGMIXtZ0/TNYi0tAdEQhIFLL4cV4n6GJr8hegpIETa9lbYwXOG6d4qg"
signStage <- "X2HinsE2/GW4EhbA0dPC7wpxm1q69OmC5RPYY4MD2l5BfRfnjxuPvR0khUJw5SwXT6/9t6WWFpmFzNQxZ0ArGA=="


url <- "https://api.kraken.com/0/private/TradeBalance"

v <- c(keyStage, signStage)
names(v) <- c("API-key", "API-sign")
request <- POST(url, add_headers(v))

c <- content(request)


stop_for_status(request)
