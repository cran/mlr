% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/createSpatialResamplingPlots.R
\name{createSpatialResamplingPlots}
\alias{createSpatialResamplingPlots}
\title{Create (spatial) resampling plot objects.}
\usage{
createSpatialResamplingPlots(
  task = NULL,
  resample = NULL,
  crs = NULL,
  datum = 4326,
  repetitions = 1,
  color.train = "#0072B5",
  color.test = "#E18727",
  point.size = 0.5,
  axis.text.size = 14,
  x.axis.breaks = waiver(),
  y.axis.breaks = waiver()
)
}
\arguments{
\item{task}{\link{Task} \cr
Task object.}

\item{resample}{\link{ResampleResult} or named \code{list} with (multiple)
\link{ResampleResult}\cr
As returned by \link{resample}.}

\item{crs}{\link{integer}\cr
Coordinate reference system (EPSG code number) for the supplied
coordinates in the \code{Task}.}

\item{datum}{\link{integer}\cr
Coordinate reference system which should be used in the resulting map.}

\item{repetitions}{\link{integer}\cr
Number of repetitions.}

\item{color.train}{\link{character}\cr
Color for train set.}

\item{color.test}{\link{character}\cr
Color for test set.}

\item{point.size}{\link{integer}\cr
Point size.}

\item{axis.text.size}{\link{integer}\cr
Font size of axis labels.}

\item{x.axis.breaks}{\link{numeric}\cr
Custom x axis breaks}

\item{y.axis.breaks}{\link{numeric}\cr
Custom y axis breaks}
}
\value{
(\link{list} of \code{2L} containing (1) multiple `gg`` objects and (2) their
corresponding labels.
}
\description{
Visualize partitioning of resample objects with spatial
information.
}
\details{
If a named list is given to \code{resample}, names will appear in the title of
each fold.
If multiple inputs are given to \code{resample}, these must be named.

This function makes a hard cut at five columns of the resulting gridded plot.
This means if the \code{resample} object consists of \code{folds > 5}, these folds will
be put into the new row.

For file saving, we recommend to use \link[cowplot:save_plot]{cowplot::save_plot}.

When viewing the resulting plot in RStudio, margins may appear to be
different than they really are.
Make sure to save the file to disk and inspect the image.

When modifying axis breaks, negative values need to be used if the area is
located in either the western or southern hemisphere.
Use positive values for the northern and eastern hemisphere.
}
\section{CRS}{


The crs has to be suitable for the coordinates stored in the \code{Task}.
For example, if the coordinates are UTM, \code{crs} should be set to a
UTM projection.
Due to a limited axis space in the resulting grid (especially on the x-axis),
the data will by default projected into a lat/lon projection, specifically
EPSG 4326.
If other projections are desired for the resulting map, please set argument
\code{datum} accordingly. This argument will be passed onto \link[ggplot2:ggsf]{ggplot2::coord_sf}.
}

\examples{
\donttest{
\dontshow{ if (requireNamespace("cowplot")) \{ }
\dontshow{ if (requireNamespace("MASS")) \{ }
\dontshow{ if (requireNamespace("sf")) \{ }
rdesc = makeResampleDesc("SpRepCV", folds = 5, reps = 4)
r = resample(makeLearner("classif.qda"), spatial.task, rdesc)

## -------------------------------------------------------------
## single unnamed resample input with 5 folds and 2 repetitions
## -------------------------------------------------------------

plots = createSpatialResamplingPlots(spatial.task, r, crs = 32717,
  repetitions = 2, x.axis.breaks = c(-79.065, -79.085),
  y.axis.breaks = c(-3.970, -4))
cowplot::plot_grid(plotlist = plots[["Plots"]], ncol = 5, nrow = 2,
  labels = plots[["Labels"]])

## --------------------------------------------------------------------------
## single named resample input with 5 folds and 1 repetition and 32717 datum
## --------------------------------------------------------------------------

plots = createSpatialResamplingPlots(spatial.task, list("Resamp" = r),
  crs = 32717, datum = 32717, repetitions = 1)
cowplot::plot_grid(plotlist = plots[["Plots"]], ncol = 5, nrow = 1,
  labels = plots[["Labels"]])

## -------------------------------------------------------------
## multiple named resample inputs with 5 folds and 1 repetition
## -------------------------------------------------------------

rdesc1 = makeResampleDesc("SpRepCV", folds = 5, reps = 4)
r1 = resample(makeLearner("classif.qda"), spatial.task, rdesc1)
rdesc2 = makeResampleDesc("RepCV", folds = 5, reps = 4)
r2 = resample(makeLearner("classif.qda"), spatial.task, rdesc2)

plots = createSpatialResamplingPlots(spatial.task,
  list("SpRepCV" = r1, "RepCV" = r2), crs = 32717, repetitions = 1,
  x.axis.breaks = c(-79.055, -79.085), y.axis.breaks = c(-3.975, -4))
cowplot::plot_grid(plotlist = plots[["Plots"]], ncol = 5, nrow = 2,
  labels = plots[["Labels"]])

## -------------------------------------------------------------------------------------
## Complex arrangements of multiple named resample inputs with 5 folds and 1 repetition
## -------------------------------------------------------------------------------------

p1 = cowplot::plot_grid(plots[["Plots"]][[1]], plots[["Plots"]][[2]],
  plots[["Plots"]][[3]], ncol = 3, nrow = 1, labels = plots[["Labels"]][1:3],
  label_size = 18)
p12 = cowplot::plot_grid(plots[["Plots"]][[4]], plots[["Plots"]][[5]],
  ncol = 2, nrow = 1, labels = plots[["Labels"]][4:5], label_size = 18)

p2 = cowplot::plot_grid(plots[["Plots"]][[6]], plots[["Plots"]][[7]],
  plots[["Plots"]][[8]], ncol = 3, nrow = 1, labels = plots[["Labels"]][6:8],
  label_size = 18)
p22 = cowplot::plot_grid(plots[["Plots"]][[9]], plots[["Plots"]][[10]],
  ncol = 2, nrow = 1, labels = plots[["Labels"]][9:10], label_size = 18)

cowplot::plot_grid(p1, p12, p2, p22, ncol = 1)
\dontshow{ \} }
\dontshow{ \} }
\dontshow{ \} }
}
}
\seealso{
Other plot: 
\code{\link{plotBMRBoxplots}()},
\code{\link{plotBMRRanksAsBarChart}()},
\code{\link{plotBMRSummary}()},
\code{\link{plotCalibration}()},
\code{\link{plotCritDifferences}()},
\code{\link{plotLearningCurve}()},
\code{\link{plotPartialDependence}()},
\code{\link{plotROCCurves}()},
\code{\link{plotResiduals}()},
\code{\link{plotThreshVsPerf}()}
}
\author{
Patrick Schratz
}
\concept{plot}
