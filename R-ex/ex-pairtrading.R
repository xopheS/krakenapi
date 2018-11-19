rm(list = ls())

p <- c("jsonlite", "httr", "lubridate", "tidyverse", "xts", "pairtrading")
sapply(p, require, character.only = TRUE)

btc <- bars("XXBTZUSD", interval = 5)
eth <- bars("XETHZUSD", interval = 5)


price.pair <- cbind(btc$close, eth$close)
colnames(price.pair) <- c("btc", "eth")
price.pair <- xts(price.pair, order.by = btc$time)


par(mfrow = c(2, 1))
plot(price.pair$btc)
plot(price.pair$eth)


params <- EstimateParametersHistorically(price.pair, period = 60)

signal <- Simple(params$spread, 0.05)

plot(params$spread, type="l", col = "red", lwd = 3, main = "Spread & Signal")

return.pairtrading <- Return(price.pair, lag(signal), lag(params$hedge.ratio))

plot(100 * cumprod(1 + return.pairtrading), main = "Performance of pair trading")
