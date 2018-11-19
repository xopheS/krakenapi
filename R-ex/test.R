rm(list = ls())

p <- c("jsonlite", "httr", "lubridate", "tidyverse", "qamoco", "ggpubr")
sapply(p, require, character.only = TRUE)

######ORDER BOOKS#######
count <- 100


order1 <- orderBook("XXBTZUSD", count)
tab1 <- data.frame(ask = cumsum(order1$ask_volume),
                   bid = cumsum(order1$bid_volume),
                   price_ask = order1$ask_price,
                   price_bid = order1$bid_price)

o1 <- ggplot(data = tab1) +
  geom_area(mapping = aes(x = price_ask, y = ask), fill = "#fc1900") +
  geom_area(mapping = aes(x = price_bid, y = bid), fill = "#01c738") +
  labs(x= "Price", y="Volume") +
  theme(legend.text=element_text(size=20))+
  ggtitle("Order Book")

order2 <- orderBook("XETHZUSD", count)
tab2 <-data.frame(ask = cumsum(order2$ask_volume),
                   bid = cumsum(order2$bid_volume),
                   price_ask = order2$ask_price,
                   price_bid = order2$bid_price)

o2 <- ggplot(data = tab2) +
  geom_area(mapping = aes(x = price_ask, y = ask), fill = "#fc1900") +
  geom_area(mapping = aes(x = price_bid, y = bid), fill = "#01c738") +
  labs(x= "Price", y="Volume") +
  theme(legend.text=element_text(size=20))+
  ggtitle("ETH/USD")

order3 <- orderBook("XETHXXBT", count)
tab3 <-data.frame(ask = cumsum(order3$ask_volume),
                    bid = cumsum(order3$bid_volume),
                    price_ask = order3$ask_price,
                    price_bid = order3$bid_price)

o3 <- ggplot(data = tab3) +
  geom_area(mapping = aes(x = price_ask, y = ask), fill = "#fc1900") +
  geom_area(mapping = aes(x = price_bid, y = bid), fill = "#01c738") +
  labs(x= "Price", y="Volume") +
  theme(legend.text=element_text(size=20))+
  ggtitle("ETH/XBT")

ggarrange(o3, o2, o1, nrow = 3) +
  ggtitle("ORDER BOOKS")


######DATA###########
ethxbt <- bars("XETHXXBT", interval = 60, since = (Sys.time() - 3600*24*31*3))
xbtusd <- bars("XXBTZUSD", interval = 60, since = (Sys.time() - 3600*24*31*3))
ethusd <- bars("XETHZUSD", interval = 60, since = (Sys.time() - 3600*24*31*3))

######PRICE#########
x_prices <- matrix(data = c(ethusd$open, ethxbt$open, xbtusd$open), nrow = 3)
rownames(x_prices) <- c("ethusd", "ethxbt", "xbtusd")

t_arma <- ecvarma_ons(run = 550, x = x_prices)
arma <- ecvarma_ons(run = 100, A = t_arma$A, y = t_arma$y, x = x_prices[, 500:length(x_prices[,1])])

res <- data.frame(RMSE = arma$RMSE,
                  time = 1:length(arma$RMSE),
                  X = arma$X[1,],
                  pred = arma$Xpred[1,])

ggplot(data = res) +
  geom_line(mapping = aes(x = time, y = RMSE)) +
  labs(x= "T", y="RMSE") +
  theme(legend.text=element_text(size=20))+
  ggtitle("RMSE")

ggplot(data = res) +
  geom_point(mapping = aes(x = time, y = X), color = "#01c738") +
  geom_point(mapping = aes(x = time, y = pred), color = "#fc1900") +
  labs(x= "T", y="RMSE") +
  theme(legend.text=element_text(size=20))+
  ggtitle("RMSE")

######PLOT CORRELATION######

##############################PRICES##############################
p1 <- ggplot(data = ethxbt) +
  geom_line(mapping = aes(x = time, y = open)) +
  labs(x= "Time", y="Price") +
  theme(legend.text=element_text(size=20))+
  ggtitle("ETH/XBT")

p2 <- ggplot(data = ethusd) +
  geom_line(mapping = aes(x = time, y = open)) +
  labs(x= "Time", y="Price") +
  theme(legend.text=element_text(size=20))+
  ggtitle("ETH/USD")

p3 <- ggplot(data = xbtusd) +
  geom_line(mapping = aes(x = time, y = open)) +
  labs(x= "Time", y="Price") +
  theme(legend.text=element_text(size=20))+
  ggtitle("XBT/USD")

ggarrange(p1, p2, p3, nrow = 3) +
  ggtitle("Price")
