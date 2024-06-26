% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ResampleDesc.R
\name{makeResampleDesc}
\alias{makeResampleDesc}
\alias{ResampleDesc}
\alias{hout}
\alias{cv2}
\alias{cv3}
\alias{cv5}
\alias{cv10}
\title{Create a description object for a resampling strategy.}
\usage{
makeResampleDesc(
  method,
  predict = "test",
  ...,
  stratify = FALSE,
  stratify.cols = NULL,
  fixed = FALSE,
  blocking.cv = FALSE
)
}
\arguments{
\item{method}{(\code{character(1)})\cr
\dQuote{CV} for cross-validation, \dQuote{LOO} for leave-one-out, \dQuote{RepCV} for
repeated cross-validation, \dQuote{Bootstrap} for out-of-bag bootstrap, \dQuote{Subsample} for
subsampling, \dQuote{Holdout} for holdout, \dQuote{GrowingWindowCV} for growing window
cross-validation, \dQuote{FixedWindowCV} for fixed window cross validation.}

\item{predict}{(\code{character(1)})\cr
What to predict during resampling: \dQuote{train}, \dQuote{test} or \dQuote{both} sets.
Default is \dQuote{test}.}

\item{...}{(any)\cr
Further parameters for strategies.\cr
\describe{
\item{iters (\code{integer(1)})}{Number of iterations, for \dQuote{CV}, \dQuote{Subsample}
and \dQuote{Bootstrap}.}
\item{split (\code{numeric(1)})}{Proportion of training cases for \dQuote{Holdout} and
\dQuote{Subsample} between 0 and 1. Default is 2 / 3.}
\item{reps (\code{integer(1)})}{Repeats for \dQuote{RepCV}. Here \code{iters = folds * reps}.
Default is 10.}
\item{folds (\code{integer(1)})}{Folds in the repeated CV for \code{RepCV}.
Here \code{iters = folds * reps}. Default is 10.}
\item{horizon (\code{numeric(1)})}{Number of observations in the forecast test set for \dQuote{GrowingWindowCV}
and \dQuote{FixedWindowCV}. When \code{horizon > 1} this will be treated as the number of
observations to forecast, else it will be a fraction of the initial window. IE,
for 100 observations, initial window of .5, and horizon of .2, the test set will have
10 observations. Default is 1.}
\item{initial.window (\code{numeric(1)})}{Fraction of observations to start with
in the training set for \dQuote{GrowingWindowCV} and \dQuote{FixedWindowCV}.
When \code{initial.window > 1} this will be treated as the number of
observations in the initial window, else it will be treated as the fraction
of observations to have in the initial window. Default is 0.5.}
\item{skip (\code{numeric(1)})}{ How many resamples to skip to thin the total amount
for \dQuote{GrowingWindowCV} and \dQuote{FixedWindowCV}. This is passed through as the \dQuote{by} argument
in \code{seq()}. When \code{skip > 1} this will be treated as the increment of the sequence of resampling indices,
else it will be a fraction of the total training indices. IE for 100 training sets and a value of .2, the increment
of the resampling indices will be 20. Default is \dQuote{horizon} which gives mutually exclusive chunks
of test indices.}
}}

\item{stratify}{(\code{logical(1)})\cr
Should stratification be done for the target variable?
For classification tasks, this means that the resampling strategy is applied to all classes
individually and the resulting index sets are joined to make sure that the proportion of
observations in each training set is as in the original data set. Useful for imbalanced class sizes.
For survival tasks stratification is done on the events, resulting in training sets with comparable
censoring rates.}

\item{stratify.cols}{(\link{character})\cr
Stratify on specific columns referenced by name. All columns have to be factor or integer.
Note that you have to ensure yourself that stratification is possible, i.e.
that each strata contains enough observations.
This argument and \code{stratify} are mutually exclusive.}

\item{fixed}{(\code{logical(1)})\cr
Whether indices supplied via argument 'blocking' in the task should be used as
fully pre-defined indices. Default is \code{FALSE} which means
they will be used following the 'blocking' approach.
\code{fixed} only works with ResampleDesc \code{CV} and the supplied indices must match
the number of observations. When \code{fixed = TRUE}, the \code{iters} argument will be ignored
and is interally set to the number of supplied factor levels in \code{blocking}.}

\item{blocking.cv}{(\code{logical(1)})\cr
Should 'blocking' be used in \code{CV}? Default to \code{FALSE}.
This is different to \code{fixed = TRUE} and cannot be combined. Please check the mlr online tutorial
for more details.}
}
\value{
(\link{ResampleDesc}).
}
\description{
A description of a resampling algorithm contains all necessary information to
create a \link{ResampleInstance}, when given the size of the data set.
}
\details{
Some notes on some special strategies:
\describe{
\item{Repeated cross-validation}{Use \dQuote{RepCV}. Then you have to set the aggregation function
for your preferred performance measure to \dQuote{testgroup.mean}
via \link{setAggregation}.}
\item{B632 bootstrap}{Use \dQuote{Bootstrap} for bootstrap and set predict to \dQuote{both}.
Then you have to set the aggregation function for your preferred performance measure to
\dQuote{b632} via \link{setAggregation}.}
\item{B632+ bootstrap}{Use \dQuote{Bootstrap} for bootstrap and set predict to \dQuote{both}.
Then you have to set the aggregation function for your preferred performance measure to
\dQuote{b632plus} via \link{setAggregation}.}
\item{Fixed Holdout set}{Use \link{makeFixedHoldoutInstance}.}
}

Object slots:
\describe{
\item{id (\code{character(1)})}{Name of resampling strategy.}
\item{iters (\code{integer(1)})}{Number of iterations. Note that this is always the complete number
of generated train/test sets, so for a 10-times repeated 5fold cross-validation it would be 50.}
\item{predict (\code{character(1)})}{See argument.}
\item{stratify (\code{logical(1)})}{See argument.}
\item{All parameters passed in ... under the respective argument name}{See arguments.}
}
}
\section{Standard ResampleDesc objects}{

For common resampling strategies you can save some typing
by using the following description objects:
\describe{
\item{hout}{holdout a.k.a. test sample estimation
(two-thirds training set, one-third testing set)}
\item{cv2}{2-fold cross-validation}
\item{cv3}{3-fold cross-validation}
\item{cv5}{5-fold cross-validation}
\item{cv10}{10-fold cross-validation}
}
}

\examples{
# Bootstraping
makeResampleDesc("Bootstrap", iters = 10)
makeResampleDesc("Bootstrap", iters = 10, predict = "both")

# Subsampling
makeResampleDesc("Subsample", iters = 10, split = 3 / 4)
makeResampleDesc("Subsample", iters = 10)

# Holdout a.k.a. test sample estimation
makeResampleDesc("Holdout")
}
\seealso{
Other resample: 
\code{\link{ResamplePrediction}},
\code{\link{ResampleResult}},
\code{\link{addRRMeasure}()},
\code{\link{getRRPredictionList}()},
\code{\link{getRRPredictions}()},
\code{\link{getRRTaskDesc}()},
\code{\link{getRRTaskDescription}()},
\code{\link{makeResampleInstance}()},
\code{\link{resample}()}
}
\concept{resample}
