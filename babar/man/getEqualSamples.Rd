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





