\name{WeibullPrior}
\alias{WeibullPrior}
\title{WeibullPrior}
\description{Generate samples from the Weibull prior}
\usage{WeibullPrior(u, shape, scale)}
\arguments{
  \item{u}{Input scalar/vector of values between 0 and 1}
  \item{shape}{The shape parameter of the distriubtion}
  \item{scale}{The scale parameter of the distribution}
}

\value{Samples from the Weibull prior}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
samples <- WeibullPrior(runif(100), 5, 5)
summary(samples)
}
