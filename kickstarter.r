library(magrittr)
library(httr)
library(rvest)
library(stringr)

# //div[@class='row']/li[@class='project col col-3 mb4']//h6[@class='project-title']
# //div[@class='row']/li[@class='project col col-3 mb4']//h6[@class='project-title']/a
# //div[@class='row']/li[@class='project col col-3 mb4']//p[@class='project-byline']
# //div[@class='row']/li[@class='project col col-3 mb4']//p[@class='project-blurb']
# //div[@class='row']/li[@class='project col col-3 mb4']//span[@class='location-name']
# //div[@class='row']/li[@class='project col col-3 mb4']//ul[@class='project-stats']/li[1]/div[@class='project-stats-value']
# //div[@class='row']/li[@class='project col col-3 mb4']//ul[@class='project-stats']/li[2]/div[@class='project-stats-value']
# //div[@class='row']/li[@class='project col col-3 mb4']//div[@class='num']

url <- "https://www.kickstarter.com/discover/popular?ref=home_popular"
res <- GET(url)

## Get title
title <- res %>%
  content(as="text",encoding = "UTF-8") %>%
  read_html %>%
  html_nodes(xpath = "//div[@class='row']/li[@class='project col col-3 mb4']//h6[@class='project-title']") %>%
  html_text() %>%
  `Encoding<-`("UTF-8") %>%
  gsub("^: ", "",.)

## Get title url (undo)
# title_url <- res %>%
#   content(as="text",encoding = "UTF-8") %>%
#   read_html %>%
#   html_nodes(xpath = "//div[@class='row']/li[@class='project col col-3 mb4']//h6[@class='project-title']/a") %>%
#   html_attrs()
# title_url <- rbind(paste('www.kickstarter.com', title_url, sep=''))
# title_url <- unlist(title_url)

## Get author
author <- res %>%
  content(as="text",encoding = "UTF-8") %>%
  read_html %>%
  html_nodes(xpath = "//div[@class='row']/li[@class='project col col-3 mb4']//p[@class='project-byline']") %>%
  html_text() %>%
  `Encoding<-`("UTF-8") %>%
  gsub("^: ", "",.)

## Get work content
work_content <- res %>%
  content(as="text",encoding = "UTF-8") %>%
  read_html %>%
  html_nodes(xpath = "//div[@class='row']/li[@class='project col col-3 mb4']//p[@class='project-blurb']") %>%
  html_text() %>%
  `Encoding<-`("UTF-8") %>%
  gsub("^: ", "",.)

## change table
DF = data.frame(Title=title,Author=author,Content=work_content)
DF
