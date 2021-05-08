df_all <- 
  bind_rows(
    # train/validatio
    df_all %>% 
      filter(set == "train") %>% 
      mutate(set = sample(c("train", "valid"), 
                          size = nrow(.), replace = TRUE, 
                          prob = c(0.8, 0.2))),
    # test
    df_all %>% filter(set == "test")
  )