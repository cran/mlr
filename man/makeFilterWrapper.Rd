% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FilterWrapper.R
\name{makeFilterWrapper}
\alias{makeFilterWrapper}
\title{Fuse learner with a feature filter method.}
\usage{
makeFilterWrapper(
  learner,
  fw.method = "FSelectorRcpp_information.gain",
  fw.base.methods = NULL,
  fw.perc = NULL,
  fw.abs = NULL,
  fw.threshold = NULL,
  fw.fun = NULL,
  fw.fun.args = NULL,
  fw.mandatory.feat = NULL,
  cache = FALSE,
  ...
)
}
\arguments{
\item{learner}{(\link{Learner} | \code{character(1)})\cr
The learner.
If you pass a string the learner will be created via \link{makeLearner}.}

\item{fw.method}{(\code{character(1)})\cr
Filter method. See \link{listFilterMethods}.
Default is \dQuote{FSelectorRcpp_information.gain}.}

\item{fw.base.methods}{(\code{character(1)})\cr
Simple Filter methods for ensemble filters. See \link{listFilterMethods}. Can
only be used in combination with ensemble filters. See
\link{listFilterEnsembleMethods}.}

\item{fw.perc}{(\code{numeric(1)})\cr
If set, select \code{fw.perc}*100 top scoring features. Mutually exclusive with
arguments \code{fw.abs}, \code{fw.threshold} and `fw.fun.}

\item{fw.abs}{(\code{numeric(1)})\cr
If set, select \code{fw.abs} top scoring features.
Mutually exclusive with arguments \code{fw.perc}, \code{fw.threshold} and \code{fw.fun}.}

\item{fw.threshold}{(\code{numeric(1)})\cr
If set, select features whose score exceeds \code{fw.threshold}. Mutually
exclusive with arguments \code{fw.perc}, \code{fw.abs} and \code{fw.fun}.}

\item{fw.fun}{(\verb{function)})\cr
If set, select features via a custom thresholding function, which must
return the number of top scoring features to select. Mutually exclusive
with arguments \code{fw.perc}, \code{fw.abs} and \code{fw.threshold}.}

\item{fw.fun.args}{(any)\cr
Arguments passed to the custom thresholding function}

\item{fw.mandatory.feat}{(\link{character})\cr
Mandatory features which are always
included regardless of their scores}

\item{cache}{(\code{character(1)} | \link{logical})\cr
Whether to use caching during
filter value creation. See details.}

\item{...}{(any)\cr
Additional parameters passed down to the filter. If you are using more than
one filter method, you need to pass the arguments in a named list via
\code{more.args}. For example \code{more.args = list("FSelectorRcpp_information.gain" = list(equal = TRUE))}.}
}
\value{
\link{Learner}.
}
\description{
Fuses a base learner with a filter method. Creates a learner
object, which can be used like any other learner object. Internally uses
\link{filterFeatures} before every model fit.
}
\details{
If \code{ensemble = TRUE}, ensemble feature selection using all methods specified
in \code{fw.method} is performed. At least two methods need to be selected.

After training, the selected features can be retrieved with
\link{getFilteredFeatures}.

Note that observation weights do not influence the filtering and are simply
passed down to the next learner.
}
\section{Caching}{

If \code{cache = TRUE}, the default mlr cache directory is used to cache filter
values. The directory is operating system dependent and can be checked with
\code{getCacheDir()}. Alternatively a custom directory can be passed to store
the cache. The cache can be cleared with \code{deleteCacheDir()}. Caching is
disabled by default. Care should be taken when operating on large clusters
due to possible write conflicts to disk if multiple workers try to write
the same cache at the same time.
}

\examples{
\dontshow{ if (requireNamespace("FSelectorRcpp")) \{ }
\donttest{
task = makeClassifTask(data = iris, target = "Species")
lrn = makeLearner("classif.lda")
inner = makeResampleDesc("Holdout")
outer = makeResampleDesc("CV", iters = 2)
lrn = makeFilterWrapper(lrn, fw.perc = 0.5)
mod = train(lrn, task)
print(getFilteredFeatures(mod))
# now nested resampling, where we extract the features that the filter method selected
r = resample(lrn, task, outer, extract = function(model) {
  getFilteredFeatures(model)
})
print(r$extract)

# usage of an ensemble filter
lrn = makeLearner("classif.lda")
lrn = makeFilterWrapper(lrn, fw.method = "E-Borda",
  fw.base.methods = c("FSelectorRcpp_gain.ratio", "FSelectorRcpp_information.gain"),
  fw.perc = 0.5)
r = resample(lrn, task, outer, extract = function(model) {
  getFilteredFeatures(model)
})
print(r$extract)

# usage of a custom thresholding function
biggest_gap = function(values, diff) {
  gap_size = 0
  gap_location = 0

  for (i in (diff + 1):length(values)) {
    gap = values[[i - diff]] - values[[i]]
    if (gap > gap_size) {
      gap_size = gap
      gap_location = i - 1
    }
  }
  return(gap_location)
}

lrn = makeLearner("classif.lda")
lrn = makeFilterWrapper(lrn, fw.method = "FSelectorRcpp_information.gain",
  fw.fun = biggest_gap, fw.fun.args = list("diff" = 1))
r = resample(lrn, task, outer, extract = function(model) {
  getFilteredFeatures(model)
})
print(r$extract)
}
\dontshow{ \} }
}
\seealso{
Other filter: 
\code{\link{filterFeatures}()},
\code{\link{generateFilterValuesData}()},
\code{\link{getFilteredFeatures}()},
\code{\link{listFilterEnsembleMethods}()},
\code{\link{listFilterMethods}()},
\code{\link{makeFilter}()},
\code{\link{makeFilterEnsemble}()},
\code{\link{plotFilterValues}()}

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
\concept{filter}
\concept{wrapper}
