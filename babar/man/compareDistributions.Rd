\name{compareDistributions}
\alias{compareDistributions}
\title{compareDistributions}
\description{Compare two sets of normally distributed samples using nested sampling,
to determine whether they have the same mean and variance.}
\usage{compareDistributions(data.first, data.second)}
\arguments{
  \item{data.first}{Samples from the first distriubtion, as a vector of normally distributed values}
  \item{data.second}{Samples from the second distribution as a vector of normally distributed values}
}

\value{Bayes factor for the hypothesis that the distributions have the same mean and variance
versus the hypothesis that they have different means and variances}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
data.a <- rnorm(10, 1, 1)
data.b <- rnorm(10, 5, 1)
compareDistributions(data.a, data.b)
}
