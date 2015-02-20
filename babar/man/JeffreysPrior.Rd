\name{JeffreysPrior}
\alias{JeffreysPrior}
\title{JeffreysPrior}
\description{Generate samples from the Jeffreys prior}
\usage{JeffreysPrior(u, log10lowerBound, log10upperBound)}
\arguments{
  \item{u}{Input scalar/vector of values between 0 and 1}
  \item{log10lowerBound}{Base 10 logarithm of the lower bound}
  \item{log10upperBound}{Base 10 logarithm of the upper bound}
}

\value{Samples from Jeffreys prior}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
samples <- JeffreysPrior(runif(100), -2, 8)
summary(samples)
}
