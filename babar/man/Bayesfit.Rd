\name{Bayesfit}
\alias{Bayesfit}
\title{Bayesfit}
\description{Perform Bayesian analysis for fitting a single bacterial growth curve using the Baranyi model.}
\usage{Bayesfit(data, model, inf.sigma = TRUE, inc.nd = FALSE, sigma = 0.3, 
    threshold = NULL, mumax.prior = "Uniform", mu.mean = NULL, 
    mu.sd = NULL, tol = 0.1)}
\arguments{
  \item{data}{A datafile of the curve to be fitted. This should consist of two columns, the first for time and second for logc. 
The bacterial concentration should be given in log_10 cfu and there should be at least 2 data points (the first of which 
may be undetected). Undetected y values should be represented by "NA".}
  \item{model}{The growth model to be used. This should be one of "linear", "logistic", "Bar3par", "Bar4par" and "Bar6par".}
  \item{inf.sigma}{(TRUE/FALSE) Choose whether or not to infer the noise level, sigma, as part of the analysis. If FALSE, sigma should be
specified (or the default value of sigma, 0.3, will be used).}
  \item{inc.nd}{Choose whether or not to include undetected points as part of the analysis. If TRUE, threshold should be specified.}
  \item{sigma}{The choice of noise level, sigma, in log_10 cfu if it is not inferred as part of the analysis. Default is 0.3.}
  \item{threshold}{Threshold in log_10 cfu below which values are considered as undetected.}
  \item{mumax.prior}{The type of prior to use for mu_max. This should be one of "Uniform", "Gaussian" or "Cauchy" (or the default "Uniform"
will be used). If "Gaussian" or "Cauchy" are specified, mu.mean and mu.sd should be given. }
  \item{mu.mean}{The mean to be used when using a Gaussian or Cauchy prior.}
  \item{mu.sd}{The standard deviation to be used when using a Gaussian or Cauchy prior.}
  \item{tol}{The termination tolerance for the nested sampling}
}

\value{Returns: 

posterior: The samples from the posterior, together with their log weights and 
log likelihoods as a m x n matrix, where m is the
number of posterior samples and n is the number of
parameters + 2. The log weights are the first column and the log likelihood values are the
second column of this matrix. The sum of the log-weights = logZ.

logevidence: The logarithm of the evidence, a scalar.

means: A vector of the mean of each parameter, length = no. of parameters.

vars: A vector of the variance of each parameter, length = no. of parameters.

equalposterior: Equally weighted posterior samples together with their 
log likelihoods as a m x n matrix, where m is the
number of posterior samples and n is the number of
parameters + 1. The log likelihood values are the
first column of this matrix.

fit.t: A vector of time points at which the model is fitted.

fit.y: A matrix of fitted model points, y, using posterior parameter samples in the model. Each column represents a different 
posterior sample.

fit.ymean: A vector of fitted model points, y, using the mean of the posterior parameter samples in the model.}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
B092_1.file <- system.file("extdata", "B092_1.csv", package = "babar")
B092_1.data <- read.csv(B092_1.file, header=TRUE, sep=",",
                        na.strings=c("ND","NA"))
\dontrun{
results_linear <- Bayesfit(B092_1.data,model="linear",inf.sigma=FALSE,tol=10)
}
}
