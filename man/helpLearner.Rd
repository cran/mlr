% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpLearner.R
\name{helpLearner}
\alias{helpLearner}
\title{Access help page of learner functions.}
\usage{
helpLearner(learner)
}
\arguments{
\item{learner}{(\link{Learner} | \code{character(1)})\cr
The learner.
If you pass a string the learner will be created via \link{makeLearner}.}
}
\description{
Interactive function that gives the user quick access to the
help pages associated with various functions involved in the given learner.
}
\seealso{
Other learner: 
\code{\link{LearnerProperties}},
\code{\link{getClassWeightParam}()},
\code{\link{getHyperPars}()},
\code{\link{getLearnerId}()},
\code{\link{getLearnerNote}()},
\code{\link{getLearnerPackages}()},
\code{\link{getLearnerParVals}()},
\code{\link{getLearnerParamSet}()},
\code{\link{getLearnerPredictType}()},
\code{\link{getLearnerShortName}()},
\code{\link{getLearnerType}()},
\code{\link{getParamSet}()},
\code{\link{helpLearnerParam}()},
\code{\link{makeLearner}()},
\code{\link{makeLearners}()},
\code{\link{removeHyperPars}()},
\code{\link{setHyperPars}()},
\code{\link{setId}()},
\code{\link{setLearnerId}()},
\code{\link{setPredictThreshold}()},
\code{\link{setPredictType}()}

Other help: 
\code{\link{helpLearnerParam}()}
}
\concept{help}
\concept{learner}
