getTradeBalance <- function(api_key, api_sign, asset = "ZUSD"){

  url <- "https://api.kraken.com/0/private/TradeBalance"

  request <- POST(url, add_headers('API-Key'= api_key, 'API-Sign' = api_sign),
                  query = list(asset = asset))

  c <- content(request)

  return(c)
}
