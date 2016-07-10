library(magrittr)
library(httr)
library(rvest)
library(stringr)

## [method one]
url <- "https://www.ptt.cc/bbs/Gossiping/M.1464355692.A.0E5.html"
res <- GET(url, 
           set_cookies(over18="1"))  # over18 cookie

res %>% 
  content(as = "text", encoding = "UTF-8") %>% 
  read_html %>% 
  html_nodes(xpath = "//span[@class='hl push-tag']") %>% 
  html_text() %>%
  `Encoding<-`("UTF-8") %>% 
  gsub("^: ", "",.)


## [method one two]
GET("https://www.ptt.cc/bbs/Gossiping/M.1464355692.A.0E5.html",set_cookies("over18"="1")) %>%
  content(as = "text", encoding = "UTF-8") %>%
  read_html %>% 
  html_nodes(xpath = "//span[@class='hl push-tag']") %>% 
  html_text() %>%
  `Encoding<-`("UTF-8") %>% 
  gsub("^: ", "",.)



