\name{GaussianPrior}
\alias{GaussianPrior}
\title{GaussianPrior}
\description{Generate samples from normal distribution}
\usage{GaussianPrior(u, mean, sd)}
\arguments{
  \item{u}{Input scalar/vector of values between 0 and 1}
  \item{mean}{mean}
  \item{sd}{standard deviation}
}

\value{Samples from normal distribution}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
samples <- GaussianPrior(runif(100), 5, 1)
summary(samples)
}
