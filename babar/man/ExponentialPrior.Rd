\name{ExponentialPrior}
\alias{ExponentialPrior}
\title{ExponentialPrior}
\description{Generate samples from the exponential prior}
\usage{ExponentialPrior(u, rate)}
\arguments{
  \item{u}{Input scalar/vector of values between 0 and 1}
  \item{rate}{The rate paramter (such that the mean of the distribution is 1 / rate)}
}

\value{Samples from the Exponential prior}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
samples <- ExponentialPrior(runif(100), 5)
summary(samples)
}
