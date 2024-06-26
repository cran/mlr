% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generateHyperParsEffect.R
\name{plotHyperParsEffect}
\alias{plotHyperParsEffect}
\title{Plot the hyperparameter effects data}
\usage{
plotHyperParsEffect(
  hyperpars.effect.data,
  x = NULL,
  y = NULL,
  z = NULL,
  plot.type = "scatter",
  loess.smooth = FALSE,
  facet = NULL,
  global.only = TRUE,
  interpolate = NULL,
  show.experiments = FALSE,
  show.interpolated = FALSE,
  nested.agg = mean,
  partial.dep.learn = NULL
)
}
\arguments{
\item{hyperpars.effect.data}{(\code{HyperParsEffectData})\cr
Result of \link{generateHyperParsEffectData}}

\item{x}{(\code{character(1)})\cr
Specify what should be plotted on the x axis. Must be a column from
\code{HyperParsEffectData$data}. For partial dependence, this is assumed to
be a hyperparameter.}

\item{y}{(\code{character(1)})\cr
Specify what should be plotted on the y axis. Must be a column from
\code{HyperParsEffectData$data}}

\item{z}{(\code{character(1)})\cr
Specify what should be used as the extra axis for a particular geom. This
could be for the fill on a heatmap or color aesthetic for a line. Must be a
column from \code{HyperParsEffectData$data}. Default is \code{NULL}.}

\item{plot.type}{(\code{character(1)})\cr
Specify the type of plot: \dQuote{scatter} for a scatterplot, \dQuote{heatmap} for a
heatmap, \dQuote{line} for a scatterplot with a connecting line, or \dQuote{contour} for a
contour plot layered ontop of a heatmap.
Default is \dQuote{scatter}.}

\item{loess.smooth}{(\code{logical(1)})\cr
If \code{TRUE}, will add loess smoothing line to plots where possible. Note that
this is probably only useful when \code{plot.type} is set to either
\dQuote{scatter} or \dQuote{line}. Must be a column from
\code{HyperParsEffectData$data}. Not used with partial dependence.
Default is \code{FALSE}.}

\item{facet}{(\code{character(1)})\cr
Specify what should be used as the facet axis for a particular geom. When
using nested cross validation, set this to \dQuote{nested_cv_run} to obtain a facet
for each outer loop. Must be a column from \code{HyperParsEffectData$data}.
Please note that facetting is not supported with partial dependence plots!
Default is \code{NULL}.}

\item{global.only}{(\code{logical(1)})\cr
If \code{TRUE}, will only plot the current global optima when setting
x = "iteration" and y as a performance measure from
\code{HyperParsEffectData$measures}. Set this to FALSE to always plot the
performance of every iteration, even if it is not an improvement. Not used
with partial dependence.
Default is \code{TRUE}.}

\item{interpolate}{(\link{Learner} | \code{character(1)})\cr
If not \code{NULL}, will interpolate non-complete grids in order to visualize a more
complete path. Only meaningful when attempting to plot a heatmap or contour.
This will fill in \dQuote{empty} cells in the heatmap or contour plot. Note that
cases of irregular hyperparameter paths, you will most likely need to use
this to have a meaningful visualization. Accepts either a regression \link{Learner}
object or the learner as a string for interpolation. This cannot be used with partial
dependence.
Default is \code{NULL}.}

\item{show.experiments}{(\code{logical(1)})\cr
If \code{TRUE}, will overlay the plot with points indicating where an experiment
ran. This is only useful when creating a heatmap or contour plot with
interpolation so that you can see which points were actually on the
original path. Note: if any learner crashes occurred within the path, this
will become \code{TRUE}. Not used with partial dependence.
Default is \code{FALSE}.}

\item{show.interpolated}{(\code{logical(1)})\cr
If \code{TRUE}, will overlay the plot with points indicating where interpolation
ran. This is only useful when creating a heatmap or contour plot with
interpolation so that you can see which points were interpolated. Not used
with partial dependence.
Default is \code{FALSE}.}

\item{nested.agg}{(\code{function})\cr
The function used to aggregate nested cross validation runs when plotting 2
hyperparameters. This is also used for nested aggregation in partial
dependence.
Default is \code{mean}.}

\item{partial.dep.learn}{(\link{Learner} | \code{character(1)})\cr
The regression learner used to learn partial dependence. Must be specified if
\dQuote{partial.dep} is set to \code{TRUE} in
\link{generateHyperParsEffectData}. Accepts either a \link{Learner}
object or the learner as a string for learning partial dependence.
Default is \code{NULL}.}
}
\value{
ggplot2 plot object.
}
\description{
Plot hyperparameter validation path. Automated plotting method for
\code{HyperParsEffectData} object. Useful for determining the importance
or effect of a particular hyperparameter on some performance measure and/or
optimizer.
}
\note{
Any NAs incurred from learning algorithm crashes will be indicated in
the plot (except in the case of partial dependence) and the NA values will be
replaced with the column min/max depending on the optimal values for the
respective measure. Execution time will be replaced with the max.
Interpolation by its nature will result in predicted values for the
performance measure. Use interpolation with caution. If \dQuote{partial.dep}
is set to \code{TRUE} in \link{generateHyperParsEffectData}, only
partial dependence will be plotted.

Since a ggplot2 plot object is returned, the user can change the axis labels
and other aspects of the plot using the appropriate ggplot2 syntax.
}
\examples{
\dontshow{ if (requireNamespace("kernlab")) \{ }
# see generateHyperParsEffectData
\dontshow{ \} }
}
