library(httr)
library(rvest)
library(XML)
library(data.table)
library(DT)

## can change stock number
x <- '2451.html'
url <- paste('http://tw.stock.yahoo.com/d/s/major_', x, sep='')
url
res <- GET(url)
connect <- content(res,as='text',encoding = 'big5')

## parser
data <- connect %>%
  read_html() %>%
  html_nodes(xpath = '//table[1]//table[2]') %>%
  as.character() %>%
  readHTMLTable(encoding = "UTF-8") %>%
  .[[1]]
head(data)

## turn into table
table <- data
# table == null at first
names(table) <- NULL
# 5 rows
table[,c(1,5)] <- sapply(table[, c(1,5)], as.character)
# 2~4;6~8
table[, c(2:4, 6:8)] <- sapply(table[, c(2:4, 6:8)],
                                     function(x) {
                                       as.integer(as.character(x))
                                     })
names(table)[c(1, 5)] <- "券商"
names(table)[c(2, 6)] <- "買進"
names(table)[c(3, 7)] <- "賣出"
names(table)[c(4, 8)] <- "買賣超"


dt <- data.table::rbindlist(
  list(table[, 1:4], table[, 5:8]),
  use.names = FALSE)
DT::datatable(dt)
