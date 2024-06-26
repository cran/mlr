% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getResamplingIndices.R
\name{getResamplingIndices}
\alias{getResamplingIndices}
\title{Get the resampling indices from a tuning or feature selection wrapper..}
\usage{
getResamplingIndices(object, inner = FALSE)
}
\arguments{
\item{object}{(\link{ResampleResult}) \cr
The result of resampling of a tuning or feature selection wrapper.}

\item{inner}{(\link{logical}) \cr
If \code{TRUE}, returns the inner indices of a nested resampling setting.}
}
\value{
(\link{list}). One list for each outer resampling fold.
}
\description{
After you resampled a tuning or feature selection wrapper (see \link{makeTuneWrapper})
with \code{resample(..., extract = getTuneResult)} or \code{resample(..., extract = getFeatSelResult)} this helper returns a \code{list} with
the resampling indices used for the respective method.
}
\examples{
\dontshow{ if (requireNamespace("rpart")) \{ }
task = makeClassifTask(data = iris, target = "Species")
lrn = makeLearner("classif.rpart")
# stupid mini grid
ps = makeParamSet(
  makeDiscreteParam("cp", values = c(0.05, 0.1)),
  makeDiscreteParam("minsplit", values = c(10, 20))
)
ctrl = makeTuneControlGrid()
inner = makeResampleDesc("Holdout")
outer = makeResampleDesc("CV", iters = 2)
lrn = makeTuneWrapper(lrn, resampling = inner, par.set = ps, control = ctrl)
# nested resampling for evaluation
# we also extract tuned hyper pars in each iteration and by that the resampling indices
r = resample(lrn, task, outer, extract = getTuneResult)
# get tuning indices
getResamplingIndices(r, inner = TRUE)
\dontshow{ \} }
}
\seealso{
Other tune: 
\code{\link{TuneControl}},
\code{\link{getNestedTuneResultsOptPathDf}()},
\code{\link{getNestedTuneResultsX}()},
\code{\link{getTuneResult}()},
\code{\link{makeModelMultiplexer}()},
\code{\link{makeModelMultiplexerParamSet}()},
\code{\link{makeTuneControlCMAES}()},
\code{\link{makeTuneControlDesign}()},
\code{\link{makeTuneControlGenSA}()},
\code{\link{makeTuneControlGrid}()},
\code{\link{makeTuneControlIrace}()},
\code{\link{makeTuneControlMBO}()},
\code{\link{makeTuneControlRandom}()},
\code{\link{makeTuneWrapper}()},
\code{\link{tuneParams}()},
\code{\link{tuneThreshold}()}
}
\concept{tune}
