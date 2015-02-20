\name{UniformPrior}
\alias{UniformPrior}
\title{UniformPrior}
\description{Generate samples from uniform distribution}
\usage{UniformPrior(u, lowerBound, upperBound)}
\arguments{
  \item{u}{Input scalar/vector of values between 0 and 1}
  \item{lowerBound}{lower bound}
  \item{upperBound}{upper bound}
}

\value{Samples from uniform distribution within given bounds}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
samples <- UniformPrior(runif(1000), -5, 5)
summary(samples)
}
