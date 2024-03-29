#' @export
makeRLearner.classif.logreg = function() {
  makeRLearnerClassif(
    cl = "classif.logreg",
    package = "stats",
    par.set = makeParamSet(
      makeLogicalLearnerParam("model", default = TRUE, tunable = FALSE)
    ),
    par.vals = list(
      model = FALSE
    ),
    properties = c("twoclass", "numerics", "factors", "prob", "weights"),
    name = "Logistic Regression",
    short.name = "logreg",
    note = "Delegates to `glm` with `family = binomial(link = 'logit')`. We set 'model' to FALSE by default to save memory.",
    callees = "glm"
  )
}

#' @export
trainLearner.classif.logreg = function(.learner, .task, .subset, .weights = NULL, ...) {
  f = getTaskFormula(.task)

  # logreg expects the first label to be the negative class, contrary
  # to the mlr3 convention that the positive class comes first.
  # see https://github.com/mlr-org/mlr/issues/2817
  tn = getTaskTargetNames(.task)
  data = getTaskData(.task, .subset)
  data[[tn]] = swap_levels(data[[tn]])

  stats::glm(f, data = getTaskData(.task, .subset), family = "binomial", weights = .weights, ...)
}

#' @export
predictLearner.classif.logreg = function(.learner, .model, .newdata, ...) {
  x = predict(.model$learner.model, newdata = .newdata, type = "response", ...)
  levs = .model$task.desc$class.levels
  if (.learner$predict.type == "prob") {
    propVectorToMatrix(x, levs)
  } else {
    levs = .model$task.desc$class.levels
    p = as.factor(ifelse(x > 0.5, levs[2L], levs[1L]))
    unname(p)
  }
}
