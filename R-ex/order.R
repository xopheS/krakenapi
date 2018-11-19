rm(list = ls())

p <- c("jsonlite", "httr", "lubridate", "tidyverse")
sapply(p, require, character.only = TRUE)

order <- orderBook("XXBTZUSD", 50)
table <-data.frame(ask = cumsum(order$ask_volume),
                   bid = cumsum(order$bid_volume),
                   price_ask = order$ask_price,
                   price_bid = order$bid_price)

ggplot(data = table, width = 1400, height = 500) +
  geom_area(mapping = aes(x = price_ask, y = ask), fill = "#fc1900") +
  geom_area(mapping = aes(x = price_bid, y = bid), fill = "#01c738") +
  labs(x= "Price", y="Volume") +
  theme(legend.text=element_text(size=20))+
  ggtitle("Order Book")
