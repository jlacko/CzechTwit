library(twitteR)
library(purrr)
library(dplyr)
library(stringr)
library(tidytext)
library(wordcloud)
library(ggplot2)

# balast = slovní vata nepřinášející informace
balast <- data.frame(word = c("rt", "t.c", "http", "https", "a", "na", "to", "v", "se","u", "mi","po", "aby","když", "asi", "já", "k", "má",  "že", "je", "jsem", "jsme","o", "za", "si", "ale", "s", "z", "ale", "už", "tak","do","ve", "pro", "už", "co", "t.co", "i", "od", "by", "mě"))

# Připojení ----

heslo <- readRDS("heslo.rds")  # tajné heslo, viz. gitignore :)
setup_twitter_oauth(heslo$api_key, 
                    heslo$api_secret, 
                    heslo$access_token, 
                    heslo$access_token_secret)

# tweety stahnout buď jedny, nebo druhé (nemá smysl si je přemazávat :)

# Oficiální komunikace
# Babiš = AndrejBabis, Ovčáček - čtveráček = PREZIDENTmluvci, Slávek = SlavekSobotka
tweets <- userTimeline("AndrejBabis", n = 3200)

# Hlas lidu...
tweets <- searchTwitter("volby", n=3200, lang = "cs")

# Vlastní těžení... ----
tweets <- tbl_df(map_df(tweets, as.data.frame))

words <- tweets %>%
  select(id, text, created) %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%  # pryč s odkazy!
  unnest_tokens(word, text, token = "words") %>%  # převede do lowercase defaultně
  filter(!word %in% balast$word, str_detect(word, "[a-z]"))  # odstraní balast

freq <- words %>%
  count(word) %>%
  arrange(desc(n))

if (freq[1,2] > 1.5*freq[2,2]) freq[1,2] <- 1.5*freq[2,2]  # snížit prominenci prvního slova

wordcloud(freq$word, freq$n, max.words = 75, random.order = F, colors=rev(brewer.pal(6,"RdYlGn")))

ggplot(data = freq[1:20,], aes (x = reorder(word, n), y = n)) +
  geom_col(fill = "firebrick")+
  coord_flip()+
  theme_light()+
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank())
  
