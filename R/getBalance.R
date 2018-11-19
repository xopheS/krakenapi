getBalance <- function(api_key, api_sign){

  url <- "https://api.kraken.com/0/private/Balance"

  request <- POST(url, add_headers('API-Key'= api_key, 'API-Sign' = api_sign))

  c <- content(request)

  return(c)
}
