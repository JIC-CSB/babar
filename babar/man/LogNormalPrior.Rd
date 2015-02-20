\name{LogNormalPrior}
\alias{LogNormalPrior}
\title{LogNormalPrior}
\description{Generate samples from the log normal distribution}
\usage{LogNormalPrior(u, meanlog, sdlog)}
\arguments{
  \item{u}{Input scalar/vector of values between 0 and 1}
  \item{meanlog}{Log of mean}
  \item{sdlog}{Log of standard deviation}
}

\value{Samples from log normal distribution}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
samples <- LogNormalPrior(runif(100), 2, 2)
summary(samples)
}
