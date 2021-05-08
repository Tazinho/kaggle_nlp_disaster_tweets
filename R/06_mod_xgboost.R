train <- list()
valid <- list()
test <- list()

train$data <- as.matrix(df_all %>% filter(set == "train") %>% select(all_of(features)))
train$label <- as.matrix(df_all %>% filter(set == "train") %>% pull(target))

valid$data <- as.matrix(df_all %>% filter(set == "valid") %>% select(all_of(features)))
valid$label <- as.matrix(df_all %>% filter(set == "valid") %>% pull(target))

test$data  <- as.matrix(df_all %>% filter(set == "test") %>% select(all_of(features)))

xgb_train <- xgb.DMatrix(data=train$data,label=train$label)
xgb_valid <- xgb.DMatrix(data=valid$data,label=valid$label)
xgb_test  <- xgb.DMatrix(data=test$data)

params = list(
  objective = "binary:logistic",
  booster="gbtree",
  eval_metric="logloss",
  eta=0.001,
  max_depth=5,
  gamma=3,
  subsample=0.70,
  colsample_bytree=0.4
)

mod_cv <- xgboost::xgb.cv(params = params,
                          early_stopping_rounds = 5,
                          nrounds = 100,
                          nfold = 4,
                          data = xgb_train, 
                          precdiction = T, 
                          showsd = TRUE,
                          metrics = list("auc"), 
                          stratified = TRUE)

mod <- xgboost(
  nround = mod_cv[["best_iteration"]],
  data = xgb_train,
  params = params,
  verbose = 2)

validations <- predict(mod, newdata = xgb_valid)
thr <- opt_f1_score(validations, df_all %>% filter(set == "valid") %>% pull(target))

predictions <- predict(mod, newdata = xgb_test)
