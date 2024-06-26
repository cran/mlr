% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ConstantClassWrapper.R
\name{makeConstantClassWrapper}
\alias{makeConstantClassWrapper}
\title{Wraps a classification learner to support problems where the class label is (almost) constant.}
\usage{
makeConstantClassWrapper(learner, frac = 0)
}
\arguments{
\item{learner}{(\link{Learner} | \code{character(1)})\cr
The learner.
If you pass a string the learner will be created via \link{makeLearner}.}

\item{frac}{\code{numeric(1)}\cr
The fraction of labels in [0, 1) that can be different from the majority label. Default is 0, which means that constant labels are only predicted if there is exactly one label in the data.}
}
\value{
\link{Learner}.
}
\description{
If the training data contains only a single class (or almost only a single class), this wrapper creates a model that always predicts the constant class in the training data. In all other cases, the underlying learner is trained and the resulting model used for predictions.

Probabilities can be predicted and will be 1 or 0 depending on whether the label matches the majority class or not.
}
\seealso{
Other wrapper: 
\code{\link{makeBaggingWrapper}()},
\code{\link{makeClassificationViaRegressionWrapper}()},
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
\code{\link{makeMultilabelStackingWrapper}()},
\code{\link{makeOverBaggingWrapper}()},
\code{\link{makePreprocWrapper}()},
\code{\link{makePreprocWrapperCaret}()},
\code{\link{makeRemoveConstantFeaturesWrapper}()},
\code{\link{makeSMOTEWrapper}()},
\code{\link{makeTuneWrapper}()},
\code{\link{makeUndersampleWrapper}()},
\code{\link{makeWeightedClassesWrapper}()}
}
\concept{wrapper}
