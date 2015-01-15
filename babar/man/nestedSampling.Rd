\name{nestedSampling}
\alias{nestedSampling}
\title{nestedSampling}
\description{Perform nested sampling for the given model (expressed through the log
likelihood function).}
\usage{nestedSampling(llFun, numberOfParameters, prior.size, transformParams, 
    exploreFn = ballExplore, tolerance = 0.1)}
\arguments{
  \item{llFun}{The loglikelihood function, which should be of the form:
llFun(params) where params is a vector containing a single
instance of parameters, and should return the log likelihood for
those parameters.}
  \item{numberOfParameters}{The number of parameters to be inferred. Should always equal the number of parameters in the likelihood function.}
  \item{prior.size}{The number of initial prior objects to sample. This is the size of the active set of samples maintained throughout the procedure.}
  \item{transformParams}{Function to transform parameters from the unit hypercube into the correct distribution}
  \item{exploreFn}{Preferred exploration routine. Defaults to a dodgy implementation
currently but ballExplore likely to be more robust.}
  \item{tolerance}{The tolerance at which the routine should stop. Changing this will
affect how long it takes to run nested sampling. Larger values
will terminate sooner but may give inaccurate evidence
scores. This is the expected maximum remaining contribution to
logZ from the points in the active set. delta Z_i = L_max*X_i <
tolerance.}
}

\value{logevidence: The logarithm of the evidence, a scalar.

posterior.samples: The samples from the posterior, together with their log weights and 
log likelihoods as a m x n matrix, where m is the
number of posterior samples and n is the number of
parameters + 2. The log weights are the first column and the log likelihood values are the
second column of this matrix. The sum of the log-weights = logZ.

logZerror: An estimate of the numerical uncertainty of the log evidence.

parameterMeans: A vector of the mean of each parameter, length = no. of parameters.

parameterVariances: A vector of the variance of each parameter, length = no. of parameters.

entropy: The information --- the natural logarithmic measure of the prior-to-posterior shrinkage.}

\author{Lydia Rickett, Matthew Hartley and Nick Pullen}





