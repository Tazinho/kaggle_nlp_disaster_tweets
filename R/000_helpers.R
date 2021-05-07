true_positive <- function(pred, label, thr) {
  sum(pred >= thr & label)
}
false_positive <- function(pred, label, thr) {
  sum(pred >= thr & !label)
}
true_negative <- function(pred, label, thr) {
  sum(pred < thr & !label)
}
false_negative <- function(pred, label, thr) {
  sum(pred < thr & label)
}

f1_score <- function(pred, label, thr) {
  2 * true_positive(pred, label, thr) / (2 * true_positive(pred, label, thr) + false_positive(pred, label, thr) + false_negative(pred, label, thr))
}

opt_f1_score <- function(pred, label) {
  
  grid <- seq(0, 1, by = .01)
  out <- vector("integer", length(grid))
  
  for (i in seq_along(grid)) {
    out[i] <- f1_score(pred, label, grid[[i]])
  }
  
  mean(grid[out == max(out)])
}

