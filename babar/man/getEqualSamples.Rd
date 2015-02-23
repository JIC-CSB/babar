\name{getEqualSamples}
\alias{getEqualSamples}
\title{getEqualSamples}
\description{Return n equally weighted posterior samples}
\usage{getEqualSamples(posterior, n = Inf)}
\arguments{
  \item{posterior}{Matrix from the output of nested sampling. Should have log weights
in column 1, log likelihoods in column 2 and then the parameter
values in the remaining column(s).}
  \item{n}{Number of samples from the posterior required. If infinity (the deafult) this
will return the maximum number of equally weighted samples
generated from the posterior it can. Likewise if n is greater than
this maximum number of samples.}
}

\value{A set of equally weighted samples from the inferred posterior
distribution.}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{

mu <- 1
sigma <- 1
data <- rnorm(100, mu, sigma)

transform <- function(params) {
  tParams = numeric(length=length(params))
  tParams[1] = GaussianPrior(params[1], mu, sigma)
  tParams[2] = UniformPrior(params[2], 0, 2 * sigma)
  return(tParams)
}

llf <- function(params) {
  tParams = transform(params)
  mean = tParams[1]
  sigma = tParams[2]
  n <- length(data)
  ll <- -(n/2) * log(2*pi) - (n/2) * log(sigma**2) - (1/(2*sigma**2)) * sum((data-mean)**2)
  return(ll)
}

prior.size <- 25
tol <- 0.5

ns.results <- nestedSampling(llf, 2, prior.size, transform, tolerance=tol)

getEqualSamples(ns.results$posterior)
}
