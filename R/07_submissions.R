predictions <- case_when(
  predictions >= thr ~ 1,
  TRUE ~ 0
)

df_ss <- df_ss %>%
  mutate(target = predictions)

readr::write_csv(df_ss, file = "data/output/submission_2.csv")
