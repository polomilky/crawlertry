library(magrittr)
library(httr)
library(rvest)
library(stringr)

## connect PTT Gossiping
url <- "https://www.ptt.cc/bbs/Gossiping/index.html"
res <- GET(url,
           set_cookies(over18="1"))

## get title
title <- res %>%
  content(as="text",encoding = "UTF-8") %>%
  read_html %>%
  html_nodes(css=".title a") %>%
  html_text() %>%
  `Encoding<-`("UTF-8") %>%
  gsub("^: ", "",.)

## get time
time <- res %>%
  content(as="text",encoding = "UTF-8") %>%
  read_html %>%
  html_nodes(css=".date") %>%
  html_text()

## get author
author <- res %>%
  content(as="text",encoding = "UTF-8") %>%
  read_html %>%
  html_nodes(css=".author") %>%
  html_text()

##################
data <- res %>%
  content(as="text",encoding = "UTF-8") %>%
  read_html %>%
  html_nodes(css=".title a") %>%
  html_attrs()
data
url_list <- rbind(paste('www.ptt.cc', data, sep=''))
url_list <- unlist(url_list)


## rbind data
total_data <- rbind(time,author,title,url_list)
View(total_data)
total_data[3]
##################
# get connect
get_url <- url_list[1]
connect = GET(get_url, config=set_cookies('over18'='1')) %>% 
  read_html(res, encoding = "UTF-8") %>% 
  html_nodes(xpath = '//*[@id="main-content"]') %>%
  html_text() %>%
  `Encoding<-`("UTF-8") %>%
  gsub("^: ", "",.)
connect