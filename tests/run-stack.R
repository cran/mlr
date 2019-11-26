if (Sys.getenv("NOT_CRAN") == "true") {
  library(testthat)
  set.seed(getOption("mlr.debug.seed"))
  test_check("mlr", filter = "stack")
}
