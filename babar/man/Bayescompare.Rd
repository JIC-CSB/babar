\name{Bayescompare}
\alias{Bayescompare}
\title{Bayescompare}
\description{Perform Bayesian analysis for comparing two bacterial growth curves using the Baranyi model.}
\usage{Bayescompare(data1, data2, hyp, model, inf.sigma1 = TRUE, inf.sigma2 = TRUE, 
    inc.nd1 = FALSE, inc.nd2 = FALSE, sigma1 = 0.3, sigma2 = 0.3, 
    threshold1 = NULL, threshold2 = NULL, mumax.prior1 = "Uniform", 
    mumax.prior2 = "Uniform", mu.mean1 = NULL, mu.mean2 = NULL, 
    mu.sd1 = NULL, mu.sd2 = NULL, tol = 0.1)}
\arguments{
  \item{data1}{
}
  \item{data2}{Datafiles of the two curves to be fitted. This should consist of two columns, the first for time and second for logc.  
The bacterial concentration should be given in log_10 cfu and there should be at least 2 data points (the first 
of which may be undetected). Undetected y values should be represented by "NA".}
  \item{hyp}{Hypothesis to test. This should be one of "H1" (data curves replicates), "H2" (data curves have same growth rate) and 
"H3" (all data curve parameters are different)
}
  \item{model}{The growth model to be used. This should be one of "linear", "logistic", "Bar3par" and "Bar4par".}
  \item{inf.sigma1}{
}
  \item{inf.sigma2}{(TRUE/FALSE) Choose whether or not to infer the noise levels, sigma1 (for curve 1) and sigma2 (for curve 2), as part of 
the analysis. If FALSE, sigma should be specified (or the default value of sigma, 0.3, will be used).}
  \item{inc.nd1}{
}
  \item{inc.nd2}{Choose whether or not to include undetected points for curves 1 and 2 respectively as part of the analysis. If TRUE, 
threshold should be specified.}
  \item{sigma1}{
}
  \item{sigma2}{The choice of noise levels, sigma1 and sigma2, in log_10 cfu if not inferred as part of the analysis. Default is 0.3.}
  \item{threshold1}{
}
  \item{threshold2}{Thresholds in log_10 cfu below which values are considered as undetected.}
  \item{mumax.prior1}{
}
  \item{mumax.prior2}{The type of priors to use for mu_max1 and mu_max2. These should be one of "Uniform", "Gaussian" or "Cauchy" (or the 
default "Uniform" will be used). If "Gaussian" or "Cauchy" are specified for either, mu.mean and mu.sd should be given. }
  \item{mu.mean1}{
}
  \item{mu.mean2}{The means to be used when using a Gaussian or Cauchy prior.}
  \item{mu.sd1}{
}
  \item{mu.sd2}{The standard deviations to be used when using a Gaussian or Cauchy prior.}
  \item{tol}{The termination tolerance for nested sampling}
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

fit.t1,fit.t2: Vectors of time points at which the model is fitted for data1 and data2 respectively.

fit.y1,fit.y2: Matrices of fitted model points, y1 (for data1) and y2 (for data 2), using posterior parameter samples in the  
model. Each column represents a different posterior sample.

fit.y1mean and fit.y2mean: Vectors of fitted model points, y1 and y2, using the mean of the posterior parameter samples in the  
model.}

\author{Lydia Rickett, Matthew Hartley, Richard Morris and Nick Pullen}




\examples{
LmH_411.file <- system.file("extdata", "LmH_411.csv", package = "babar")
LmH_411.data <- read.csv(LmH_411.file, header=TRUE, sep =",",
                         na.strings=c("ND","NA"))
M126_50.file <- system.file("extdata", "M126_50.csv", package = "babar")
M126_50.data <- read.csv(M126_50.file, header=TRUE, sep =",",
                         na.strings=c("ND","NA"))

\dontrun{
results_H1 <- Bayescompare(LmH_411.data, M126_50.data, hyp="H1", model="linear", tol=100)
}
}
