% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ModelMultiplexer.R
\name{makeModelMultiplexer}
\alias{makeModelMultiplexer}
\alias{ModelMultiplexer}
\title{Create model multiplexer for model selection to tune over multiple
possible models.}
\usage{
makeModelMultiplexer(base.learners)
}
\arguments{
\item{base.learners}{([list` of \link{Learner})\cr
List of Learners with unique IDs.}
}
\value{
(\link{ModelMultiplexer}). A \link{Learner} specialized as \code{ModelMultiplexer}.
}
\description{
Combines multiple base learners by dispatching
on the hyperparameter \dQuote{selected.learner} to a specific model class.
This allows to tune not only the model class (SVM, random forest, etc) but also
their hyperparameters in one go. Combine this with \link{tuneParams} and
\link{makeTuneControlIrace} for a very powerful approach, see example below.

The parameter set is the union of all (unique) base learners. In order to
avoid name clashes all parameter names are prefixed with the base learner id,
i.e. \code{learnerId.parameterName}.

The predict.type of the Multiplexer is inherited from the predict.type of the
base learners.

The getter \link{getLearnerProperties} returns the properties of the
selected base learner.
}
\note{
Note that logging output during tuning is somewhat shortened to make it
more readable. I.e., the artificial prefix before parameter names is
suppressed.
}
\examples{
\dontshow{ if (requireNamespace("kernlab")) \{ }
set.seed(123)
\donttest{
library(BBmisc)
bls = list(
  makeLearner("classif.ksvm"),
  makeLearner("classif.randomForest")
)
lrn = makeModelMultiplexer(bls)
# simple way to contruct param set for tuning
# parameter names are prefixed automatically and the 'requires'
# element is set, too, to make all paramaters subordinate to 'selected.learner'
ps = makeModelMultiplexerParamSet(lrn,
  makeNumericParam("sigma", lower = -10, upper = 10, trafo = function(x) 2^x),
  makeIntegerParam("ntree", lower = 1L, upper = 500L)
)
print(ps)
rdesc = makeResampleDesc("CV", iters = 2L)
# to save some time we use random search. but you probably want something like this:
# ctrl = makeTuneControlIrace(maxExperiments = 500L)
ctrl = makeTuneControlRandom(maxit = 10L)
res = tuneParams(lrn, iris.task, rdesc, par.set = ps, control = ctrl)
print(res)

df = as.data.frame(res$opt.path)
print(head(df[, -ncol(df)]))

# more unique and reliable way to construct the param set
ps = makeModelMultiplexerParamSet(lrn,
  classif.ksvm = makeParamSet(
    makeNumericParam("sigma", lower = -10, upper = 10, trafo = function(x) 2^x)
  ),
  classif.randomForest = makeParamSet(
    makeIntegerParam("ntree", lower = 1L, upper = 500L)
  )
)

# this is how you would construct the param set manually, works too
ps = makeParamSet(
  makeDiscreteParam("selected.learner", values = extractSubList(bls, "id")),
  makeNumericParam("classif.ksvm.sigma", lower = -10, upper = 10, trafo = function(x) 2^x,
    requires = quote(selected.learner == "classif.ksvm")),
  makeIntegerParam("classif.randomForest.ntree", lower = 1L, upper = 500L,
    requires = quote(selected.learner == "classif.randomForst"))
)

# all three ps-objects are exactly the same internally.
}
\dontshow{ \} }
}
\seealso{
Other multiplexer: 
\code{\link{makeModelMultiplexerParamSet}()}

Other tune: 
\code{\link{TuneControl}},
\code{\link{getNestedTuneResultsOptPathDf}()},
\code{\link{getNestedTuneResultsX}()},
\code{\link{getResamplingIndices}()},
\code{\link{getTuneResult}()},
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
\concept{multiplexer}
\concept{tune}
