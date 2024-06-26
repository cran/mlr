% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/benchmark.R
\name{benchmark}
\alias{benchmark}
\title{Benchmark experiment for multiple learners and tasks.}
\usage{
benchmark(
  learners,
  tasks,
  resamplings,
  measures,
  keep.pred = TRUE,
  keep.extract = FALSE,
  models = FALSE,
  show.info = getMlrOption("show.info")
)
}
\arguments{
\item{learners}{(list of \link{Learner} | \link{character})\cr
Learning algorithms which should be compared, can also be a single learner.
If you pass strings the learners will be created via \link{makeLearner}.}

\item{tasks}{{list of \link{Task}}\cr
Tasks that learners should be run on.}

\item{resamplings}{(list of \link{ResampleDesc} | \link{ResampleInstance})\cr
Resampling strategy for each tasks.
If only one is provided, it will be replicated to match the number of tasks.
If missing, a 10-fold cross validation is used.}

\item{measures}{(list of \link{Measure})\cr
Performance measures for all tasks.
If missing, the default measure of the first task is used.}

\item{keep.pred}{(\code{logical(1)})\cr
Keep the prediction data in the \code{pred} slot of the result object.
If you do many experiments (on larger data sets) these objects might unnecessarily increase
object size / mem usage, if you do not really need them.
The default is set to \code{TRUE}.}

\item{keep.extract}{(\code{logical(1)})\cr
Keep the \code{extract} slot of the result object. When creating a lot of
benchmark results with extensive tuning, the resulting R objects can become
very large in size. That is why the tuning results stored in the \code{extract}
slot are removed by default (\code{keep.extract = FALSE}). Note that when
\code{keep.extract = FALSE} you will not be able to conduct analysis in the
tuning results.}

\item{models}{(\code{logical(1)})\cr
Should all fitted models be stored in the \link{ResampleResult}?
Default is \code{FALSE}.}

\item{show.info}{(\code{logical(1)})\cr
Print verbose output on console?
Default is set via \link{configureMlr}.}
}
\value{
\link{BenchmarkResult}.
}
\description{
Complete benchmark experiment to compare different learning algorithms across one or more tasks
w.r.t. a given resampling strategy. Experiments are paired, meaning always the same
training / test sets are used for the different learners.
Furthermore, you can of course pass \dQuote{enhanced} learners via wrappers, e.g., a
learner can be automatically tuned using \link{makeTuneWrapper}.
}
\examples{
\dontshow{ if (requireNamespace("rpart")) \{ }
\dontshow{ if (requireNamespace("MASS")) \{ }
\dontshow{ if (requireNamespace("rpart")) \{ }
\dontshow{ if (requireNamespace("PMCMRplus")) \{ }
lrns = list(makeLearner("classif.lda"), makeLearner("classif.rpart"))
tasks = list(iris.task, sonar.task)
rdesc = makeResampleDesc("CV", iters = 2L)
meas = list(acc, ber)
bmr = benchmark(lrns, tasks, rdesc, measures = meas)
rmat = convertBMRToRankMatrix(bmr)
print(rmat)
plotBMRSummary(bmr)
plotBMRBoxplots(bmr, ber, style = "violin")
plotBMRRanksAsBarChart(bmr, pos = "stack")
friedmanTestBMR(bmr)
friedmanPostHocTestBMR(bmr, p.value = 0.05)
\dontshow{ \} }
\dontshow{ \} }
\dontshow{ \} }
\dontshow{ \} }
}
\seealso{
Other benchmark: 
\code{\link{BenchmarkResult}},
\code{\link{batchmark}()},
\code{\link{convertBMRToRankMatrix}()},
\code{\link{friedmanPostHocTestBMR}()},
\code{\link{friedmanTestBMR}()},
\code{\link{generateCritDifferencesData}()},
\code{\link{getBMRAggrPerformances}()},
\code{\link{getBMRFeatSelResults}()},
\code{\link{getBMRFilteredFeatures}()},
\code{\link{getBMRLearnerIds}()},
\code{\link{getBMRLearnerShortNames}()},
\code{\link{getBMRLearners}()},
\code{\link{getBMRMeasureIds}()},
\code{\link{getBMRMeasures}()},
\code{\link{getBMRModels}()},
\code{\link{getBMRPerformances}()},
\code{\link{getBMRPredictions}()},
\code{\link{getBMRTaskDescs}()},
\code{\link{getBMRTaskIds}()},
\code{\link{getBMRTuneResults}()},
\code{\link{plotBMRBoxplots}()},
\code{\link{plotBMRRanksAsBarChart}()},
\code{\link{plotBMRSummary}()},
\code{\link{plotCritDifferences}()},
\code{\link{reduceBatchmarkResults}()}
}
\concept{benchmark}
