% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/OverUndersampleWrapper.R
\name{makeUndersampleWrapper}
\alias{makeUndersampleWrapper}
\alias{makeOversampleWrapper}
\title{Fuse learner with simple ove/underrsampling for imbalancy correction in binary classification.}
\usage{
makeUndersampleWrapper(learner, usw.rate = 1, usw.cl = NULL)

makeOversampleWrapper(learner, osw.rate = 1, osw.cl = NULL)
}
\arguments{
\item{learner}{(\link{Learner} | \code{character(1)})\cr
The learner.
If you pass a string the learner will be created via \link{makeLearner}.}

\item{usw.rate}{(\code{numeric(1)})\cr
Factor to downsample a class. Must be between 0 and 1,
where 1 means no downsampling, 0.5 implies reduction to 50 percent
and 0 would imply reduction to 0 observations.
Default is 1.}

\item{usw.cl}{(\code{character(1)})\cr
Class that should be undersampled.
Default is \code{NULL}, which means the larger one.}

\item{osw.rate}{(\code{numeric(1)})\cr
Factor to oversample a class. Must be between 1 and \code{Inf},
where 1 means no oversampling and 2 would mean doubling the class size.
Default is 1.}

\item{osw.cl}{(\code{character(1)})\cr
Class that should be oversampled.
Default is \code{NULL}, which means the smaller one.}
}
\value{
\link{Learner}.
}
\description{
Creates a learner object, which can be
used like any other learner object.
Internally uses \link{oversample} or \link{undersample} before every model fit.

Note that observation weights do not influence the sampling and are simply passed
down to the next learner.
}
\seealso{
Other imbalancy: 
\code{\link{makeOverBaggingWrapper}()},
\code{\link{oversample}()},
\code{\link{smote}()}

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
\code{\link{makeMultilabelStackingWrapper}()},
\code{\link{makeOverBaggingWrapper}()},
\code{\link{makePreprocWrapper}()},
\code{\link{makePreprocWrapperCaret}()},
\code{\link{makeRemoveConstantFeaturesWrapper}()},
\code{\link{makeSMOTEWrapper}()},
\code{\link{makeTuneWrapper}()},
\code{\link{makeWeightedClassesWrapper}()}
}
\concept{imbalancy}
\concept{wrapper}
