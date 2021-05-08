df_train <- data.table::fread("data/input/train.csv", data.table = FALSE) %>% 
  as_tibble() %>% mutate(set = "train")
df_test  <- data.table::fread("data/input/test.csv", data.table = FALSE) %>% 
  as_tibble() %>% mutate(set = "test")
df_ss    <- data.table::fread("data/input/sample_submission.csv", data.table = FALSE) %>% 
  as_tibble()

df_all <- bind_rows(df_test, df_train)