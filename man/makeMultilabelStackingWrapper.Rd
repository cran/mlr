% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MultilabelStackingWrapper.R
\name{makeMultilabelStackingWrapper}
\alias{makeMultilabelStackingWrapper}
\title{Use stacking method (stacked generalization) to create a multilabel learner.}
\usage{
makeMultilabelStackingWrapper(learner, cv.folds = 2)
}
\arguments{
\item{learner}{(\link{Learner} | \code{character(1)})\cr
The learner.
If you pass a string the learner will be created via \link{makeLearner}.}

\item{cv.folds}{(\code{integer(1)})\cr
The number of folds for the inner cross validation method to predict labels for the augmented feature space. Default is \code{2}.}
}
\value{
\link{Learner}.
}
\description{
Every learner which is implemented in mlr and which supports binary
classification can be converted to a wrapped stacking multilabel learner.
Stacking trains a binary classifier for each label using predicted label information of all labels (including the target label)
as additional features (by cross validation).
During prediction these labels need are obtained by the binary relevance method using the same binary learner.

Models can easily be accessed via \link{getLearnerModel}.
}
\examples{
if (requireNamespace("rpart")) {
d = getTaskData(yeast.task)
# drop some labels so example runs faster
d = d[seq(1, nrow(d), by = 20), c(1:2, 15:17)]
task = makeMultilabelTask(data = d, target = c("label1", "label2"))
lrn = makeLearner("classif.rpart")
lrn = makeMultilabelBinaryRelevanceWrapper(lrn)
lrn = setPredictType(lrn, "prob")
# train, predict and evaluate
mod = train(lrn, task)
pred = predict(mod, task)
performance(pred, measure = list(multilabel.hamloss, multilabel.subset01, multilabel.f1))
# the next call basically has the same structure for any multilabel meta wrapper
getMultilabelBinaryPerformances(pred, measures = list(mmce, auc))
# above works also with predictions from resample!
}
}
\references{
Montanes, E. et al. (2013)
\emph{Dependent binary relevance models for multi-label classification}
Artificial Intelligence Center, University of Oviedo at Gijon, Spain.
}
\seealso{
Other wrapper: 
\code{\link{makeBaggingWrapper}()},
\code{\link{makeClassificationViaRegressionWrapper}()},
\code{\link{makeConstantClassWrapper}()},
\code{\link{makeCostSensClassifWrapper}()},
\code{\link{makeCostSensRegrWrapper}()},
\code{\link{makeDownsampleWrapper}()},
\code{\link{makeDummyFeaturesWrapper}()},
\code{\link{makeExtractFDAFeatsWrapper}()},
\code{\link{makeFeatSelWrapper}()},
\code{\link{makeFilterWrapper}()},
\code{\link{makeImputeWrapper}()},
\code{\link{makeMulticlassWrapper}()},
\code{\link{makeMultilabelBinaryRelevanceWrapper}()},
\code{\link{makeMultilabelClassifierChainsWrapper}()},
\code{\link{makeMultilabelDBRWrapper}()},
\code{\link{makeMultilabelNestedStackingWrapper}()},
\code{\link{makeOverBaggingWrapper}()},
\code{\link{makePreprocWrapper}()},
\code{\link{makePreprocWrapperCaret}()},
\code{\link{makeRemoveConstantFeaturesWrapper}()},
\code{\link{makeSMOTEWrapper}()},
\code{\link{makeTuneWrapper}()},
\code{\link{makeUndersampleWrapper}()},
\code{\link{makeWeightedClassesWrapper}()}

Other multilabel: 
\code{\link{getMultilabelBinaryPerformances}()},
\code{\link{makeMultilabelBinaryRelevanceWrapper}()},
\code{\link{makeMultilabelClassifierChainsWrapper}()},
\code{\link{makeMultilabelDBRWrapper}()},
\code{\link{makeMultilabelNestedStackingWrapper}()}
}
\concept{multilabel}
\concept{wrapper}
