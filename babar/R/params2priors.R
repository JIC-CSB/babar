UniformPrior = function
### Generate samples from uniform distribution
(u,
### Input scalar/vector of values between 0 and 1
 lowerBound,
### lower bound
 upperBound
### upper bound
 ) {
  return(lowerBound + u*(upperBound - lowerBound))
### Samples from uniform distribution within given bounds
}

GaussianPrior = function
### Generate samples from normal distribution
(u,
### Input scalar/vector of values between 0 and 1
 mean,
### mean
 sd
### standard deviation
 ) {
  return(mean + sd*qnorm(u))
### Samples from normal distribution
}

LogNormalPrior = function(u, meanlog, sdlog) {
  return(exp(meanlog + sdlog*qnorm(u)))## , lower=FALSE)))
}

JeffreysPrior = function(u, log10lowerBound, log10upperBound) { ## So if you have 0.01, pass -2, or if max is 100000000 pass 8
  return(10**(log10lowerBound + u*(log10upperBound - log10lowerBound)))
}

CauchyPrior = function(u, location, scale) {
  return(location + scale*tan(pi*(u - 0.5)))
}

ExponentialPrior = function(u, rate) { ## mean = 1/rate
  return(-log(u)/rate)
}

WeibullPrior = function(u, shape, scale) {
  return(scale*(-log(u))**(1/shape))## http://www.johndcook.com/cpp_TR1_random.html#weibull
}
