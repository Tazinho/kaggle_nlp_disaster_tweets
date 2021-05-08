df_all <- df_all %>% 
  mutate(has_keyword = keyword != "", 
         has_location = location != "") 

# text length (words, signs)
# characteristics (#, numbers, )

df_all <- df_all %>% 
  mutate(text_length = str_length(text),
         text_words = stringi::stri_count_words(text),
         text_hashtags = str_count(text, "#")
  )

# Stemming 
# Stopwords
# stopwords <- stopwords::stopwords("en", source = "snowball")
# 
# df_all <- df_all %>% 
#   mutate(text2 = str_split(text, "\\s")) %>% 
#   mutate(text2 = map(text2, ~ match(.x, stopwords)),
#          text2 = map_chr(text2, ~ paste(.x, collapse = " ")))
# 
# 
# df_all <- df_all %>% 
#   mutate(text_grams = tokenize_ngrams(text, n = 2, n_min = 1))


#--------------

features <- c("has_keyword", "has_location", "text_length", "text_words", "text_hashtags")

df_all <- df_all %>% 
  mutate_at(all_of(features), as.numeric)
