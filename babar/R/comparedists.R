# Compare distributions

source('R/nested.R')
source("R/params2priors.R")

n.samples <- 500

sd.a <- 2
mean.a <- 0
data.a <- rnorm(n.samples, mean.a, sd.a)

sd.b <- 2
mean.b <- 1
data.b <- rnorm(n.samples, mean.b, sd.b)

transformParams <- function(uParams) {
 tParams = numeric(length = length(uParams))
 tParams = UniformPrior(uParams, 0, 2.0)
 return(tParams)
}