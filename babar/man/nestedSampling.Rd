\name{nestedSampling}
\alias{nestedSampling}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
nestedSampling(llFun, numberOfParameters, prior.size, transformParams, exploreFn = ballExplore, tolerance = 0.1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{llFun}{
%%     ~~Describe \code{llFun} here~~
}
  \item{numberOfParameters}{
%%     ~~Describe \code{numberOfParameters} here~~
}
  \item{prior.size}{
%%     ~~Describe \code{prior.size} here~~
}
  \item{transformParams}{
%%     ~~Describe \code{transformParams} here~~
}
  \item{exploreFn}{
%%     ~~Describe \code{exploreFn} here~~
}
  \item{tolerance}{
%%     ~~Describe \code{tolerance} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (llFun, numberOfParameters, prior.size, transformParams, 
    exploreFn = ballExplore, tolerance = 0.1) 
{
    prior.samples <- generatePriorSamples(prior.size, numberOfParameters)
    ll.values <- apply(prior.samples, 1, llFun)
    evaluated.samples = cbind(ll.values, prior.samples)
    ordered.samples <- evaluated.samples[order(evaluated.samples[, 
        1]), ]
    numParamsAddOne = NCOL(ordered.samples)
    if (numParamsAddOne == 1) {
        numParamsAddOne = 2
        ordered.samples = t(ordered.samples)
    }
    numParams <- numParamsAddOne - 1L
    posterior.samples <- matrix(ncol = numParamsAddOne)
    first <- TRUE
    steps <- rep(1, numParams)
    logZ <- -Inf
    log.width <- log(1 - exp(-1/prior.size))
    log.weight = numeric()
    entropy <- 0
    maxLeft = Inf
    logTolerance = log(tolerance)
    samplesCounter = 0
    while (maxLeft > logTolerance) {
        samplesCounter = samplesCounter + 1
        if (first) {
            posterior.samples[1, ] <- ordered.samples[1, ]
            first <- FALSE
        }
        else {
            posterior.samples <- rbind(posterior.samples, ordered.samples[1, 
                ])
        }
        llMin <- ordered.samples[1, 1]
        log.weight[samplesCounter] = llMin + log.width
        logZnew <- logPlus(logZ, log.weight[samplesCounter])
        worst.weight <- log.weight[samplesCounter]
        if (is.infinite(logZ)) {
            entropy <- exp(worst.weight - logZnew) * llMin - 
                logZnew
        }
        else {
            entropy <- exp(worst.weight - logZnew) * llMin + 
                exp(logZ - logZnew) * (entropy + logZ) - logZnew
        }
        logZ <- logZnew
        log.width = log.width - 1/prior.size
        if (numParams == 1) {
            selected.point <- 1
        }
        else {
            selected.point <- sample(2:prior.size, 1)
        }
        llSelected <- ordered.samples[selected.point, 1]
        ret <- exploreFn(ordered.samples[selected.point, 2:numParamsAddOne], 
            steps, llMin, llFun)
        steps <- ret$new.step
        new.point <- ret$new.values
        new.ll <- ret$new.ll
        ordered.samples[1, ] <- c(new.ll, new.point)
        ordered.samples <- ordered.samples[order(ordered.samples[, 
            1]), ]
        if (numParams == 1 & prior.size == 1) {
            ordered.samples = t(ordered.samples)
        }
        max.ll <- ordered.samples[prior.size, 1]
        remaining.prior.volume <- exp(-samplesCounter/prior.size)
        deltaZi = max.ll + log(remaining.prior.volume)
        maxLeft = deltaZi - logZ
    }
    lw <- log(remaining.prior.volume/prior.size)
    for (i in 1:prior.size) {
        lL <- ordered.samples[i, 1]
        log.weight[i + samplesCounter] = lw + lL
        logZ <- logPlus(logZ, log.weight[i + samplesCounter])
    }
    logZerror <- sqrt(entropy)/prior.size
    posterior.samples = rbind(posterior.samples, ordered.samples)
    if (numParams == 1) {
        print("This is experimental if numParams = 1. Needs more testing!")
        posterior.samples = cbind(posterior.samples[, 1], sapply(posterior.samples[, 
            -1], transformParams))
    }
    else {
        posterior.samples[, -1] = t(apply(posterior.samples[, 
            -1], 1, transformParams))
    }
    posterior.samples = cbind(log.weight, posterior.samples)
    totalSamples = nrow(posterior.samples)
    sampleMean <- rep(0, numParams)
    sampleMeanOfSquare <- rep(0, numParams)
    sampleVariance <- rep(0, numParams)
    for (i in 1:totalSamples) {
        sampleWeight = exp(posterior.samples[i, 1] - logZ)
        for (j in 1:numParams) {
            sampleMean[j] = sampleMean[j] + sampleWeight * posterior.samples[i, 
                j + 2]
            sampleMeanOfSquare[j] = sampleMeanOfSquare[j] + sampleWeight * 
                posterior.samples[i, j + 2] * posterior.samples[i, 
                j + 2]
        }
    }
    for (k in 1:numParams) {
        if (sampleMeanOfSquare[k] < sampleMean[k] * sampleMean[k]) {
            sampleMeanOfSquare[k] = 0
        }
        else {
            sampleVariance[k] = sampleMeanOfSquare[k] - sampleMean[k] * 
                sampleMean[k]
        }
    }
    colnames(posterior.samples) = c("logWeight", "logLikelihood", 
        paste0("parameter", seq(2, numParamsAddOne) - 1))
    return(list(logevidence = unname(logZ), posterior = posterior.samples, 
        logZerror = unname(logZerror), parameterMeans = sampleMean, 
        parameterVariances = sampleVariance, entropy = unname(entropy)))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
