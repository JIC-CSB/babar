\name{CauchyPrior}
\alias{CauchyPrior}
\title{CauchyPrior}
\description{Generate samples from the Cauchy prior}
\usage{CauchyPrior(u, location, scale)}
\arguments{
  \item{u}{Input scalar/vector of values between 0 and 1}
  \item{location}{The location parameter (the peak of the distribution)}
  \item{scale}{The scale factor (full width at half maximum)}
}

\value{Samples from Cauchy prior}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
samples <- CauchyPrior(runif(100), 5, 2)
summary(samples)
}
