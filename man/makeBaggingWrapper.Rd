\name{makeBaggingWrapper}
\alias{makeBaggingWrapper}
\title{Fuse learner with the bagging technique.}
\usage{
  makeBaggingWrapper(learner, bag.iters = 10L,
    bag.replace = TRUE, bag.size, bag.feats = 1)
}
\arguments{
  \item{learner}{[\code{\link[mlr]{Learner}}]\cr The
  learner.}

  \item{bag.iters}{[\code{integer(1)}]\cr Iterations =
  number of fitted models in bagging.  Default is 10.}

  \item{bag.replace}{[\code{logical(1)}]\cr Sample bags
  with replacement (bootstrapping)?  Default is TRUE.}

  \item{bag.size}{[\code{numeric(1)}]\cr Percentage size of
  sampled bags.  Default is 1 for bootstrapping and 0.632
  for subampling.}

  \item{bag.feats}{[\code{numeric(1)}]\cr Percentage size
  of randomly selected features in bags.  Default is 1.}
}
\value{
  [\code{\link[mlr]{Learner}}].
}
\description{
  Fuses a learner with the bagging method (i.e., similar to
  what a \code{randomForest} does). Creates a learner
  object, which can be used like any other learner object.
  Models can easily be accessed via
  \code{\link{getBaggingModels}}.
}
\details{
  Bagging is implemented as follows: For each iteration a
  random data subset is sampled (with or without
  replacement) and potentially the number of features is
  also restricted to a random subset. Note that this is
  usually handled in a slightly different way in the random
  forest where features are sampled at each tree split).

  Prediction works as follows: For classification we do
  majority voting to create a discrete label and
  probabilites are predicted by considering the proportions
  of all predicted labels. For regression the mean value
  accross predictions is computed. Prediction of local
  standard error for regression is a current TODO and
  currently not implemented.
}

