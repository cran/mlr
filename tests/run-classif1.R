if (Sys.getenv("NOT_CRAN") == "true") {
  skip_on_cran()
  set.seed(getOption("mlr.debug.seed"))
  test_check("mlr", "_classif_[a-l].*")
}
