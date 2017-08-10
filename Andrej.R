library(twitteR)
library(purrr)
library(dplyr)
library(stringr)
library(tidytext)
library(wordcloud)

# balast = slovní vata nepřinášející informace
balast <- data.frame(word = c("rt", "a", "na", "to", "v", "se","u","mi","po", "aby","když", "bude", "asi", "já", "k", "má",  "že", "je", "jsem", "jsme","o","za", "si", "ale", "s", "z", "ale", "už", "http", "https", "tak","do","ve", "pro", "už", "co", "t.co", "i", "od", "by", "mě"))

# Připojení ----

heslo <- readRDS("heslo.rds") # tajné heslo, viz. gitignore :)
setup_twitter_oauth(heslo$api_key, 
                    heslo$api_secret, 
                    heslo$access_token, 
                    heslo$access_token_secret)

# Oficiální komunikace
# Babiš = AndrejBabis, Ovčáček - čtveráček = PREZIDENTmluvci, Slávek = SlavekSobotka
tweets <- userTimeline("PREZIDENTmluvci", n = 3200)

# Hlas lidu...
tweets <- searchTwitter("Zeman", n=3200, lang = "cs")

# Vlastní těžení... ----
tweets <- tbl_df(map_df(tweets, as.data.frame))

words <- tweets %>%
  select(id, text, created) %>%
  filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "words") %>%
  filter(!word %in% balast$word,
       str_detect(word, "[a-z]"))

freq <- count(words, word)
freq$n[freq$n > 200] <- 200 # zastropovat maximální frekvenci na 200

wordcloud(freq$word, freq$n, max.words = 75, colors=rev(brewer.pal(6,"RdYlGn")))
