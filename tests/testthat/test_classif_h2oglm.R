
test_that("classif_h2oglm", {
  skip_on_ci()
  requirePackages("h2o", default.method = "load")
  h2o::h2o.no_progress()
  foo = capture.output(h2o::h2o.init())

  parset.list = list(
    list(),
    list(alpha = 1),
    list(alpha = 1, lambda = 0.2)
  )
  old.probs.list = list()

  for (i in seq_along(parset.list)) {
    parset = parset.list[[i]]
    parset = c(parset, list(x = colnames(binaryclass.train[, -binaryclass.class.col]),
      y = binaryclass.target, family = "binomial",
      training_frame = h2o::as.h2o(binaryclass.train)))
    set.seed(getOption("mlr.debug.seed"))
    m = do.call(h2o::h2o.glm, parset)
    p = predict(m, newdata = h2o::as.h2o(binaryclass.test))
    old.probs.list[[i]] = as.data.frame(p)[, 2]
  }

  testProbParsets("classif.h2o.glm", binaryclass.df, binaryclass.target,
    binaryclass.train.inds, old.probs.list, parset.list)
})

test_that("class names are integers and probabilities predicted (#1787)", {
  skip_on_ci()
  df = data.frame(matrix(runif(100, 0, 1), 100, 9))
  classx = factor(sample(c(0, 1), 100, replace = TRUE))
  df = cbind(classx, df)

  classif.task = makeClassifTask(id = "example", data = df, target = "classx")
  gb.lrn = makeLearner("classif.h2o.glm", predict.type = "prob")
  rdesc = makeResampleDesc("CV", iters = 3, stratify = TRUE)
  rin = makeResampleInstance(rdesc, task = classif.task)
  r = resample(gb.lrn, classif.task, rin)
  expect_false(is.null(r$pred))
})

test_that("feature importances are returned", {
  skip_on_ci()
  skip_on_cran()
  iris2 = iris[iris$Species %in% c("versicolor", "virginica"), ]
  iris2$Species = droplevels(iris2$Species)
  task = makeClassifTask(data = iris2, target = "Species")

  lrn = makeLearner("classif.h2o.glm")
  mod = train(lrn, task)
  feat.imp = as.data.frame(getFeatureImportance(mod)$res)
  feat.imp.h2o = na.omit(h2o::h2o.varimp(getLearnerModel(mod))[, c("variable", "relative_importance")])
  names(feat.imp) = names(feat.imp.h2o)
  feat.imp = feat.imp[order(feat.imp$relative_importance, decreasing = TRUE), ]

  expect_equal(feat.imp, feat.imp.h2o, ignore_attr = c("row.names", "class"))
})
