\name{Bayesfit}
\alias{Bayesfit}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
Bayesfit(data, model, inf.sigma = TRUE, inc.nd = FALSE, sigma = 0.3, threshold = NULL, mumax.prior = "Uniform", mu.mean = NULL, mu.sd = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
}
  \item{model}{
%%     ~~Describe \code{model} here~~
}
  \item{inf.sigma}{
%%     ~~Describe \code{inf.sigma} here~~
}
  \item{inc.nd}{
%%     ~~Describe \code{inc.nd} here~~
}
  \item{sigma}{
%%     ~~Describe \code{sigma} here~~
}
  \item{threshold}{
%%     ~~Describe \code{threshold} here~~
}
  \item{mumax.prior}{
%%     ~~Describe \code{mumax.prior} here~~
}
  \item{mu.mean}{
%%     ~~Describe \code{mu.mean} here~~
}
  \item{mu.sd}{
%%     ~~Describe \code{mu.sd} here~~
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
function (data, model, inf.sigma = TRUE, inc.nd = FALSE, sigma = 0.3, 
    threshold = NULL, mumax.prior = "Uniform", mu.mean = NULL, 
    mu.sd = NULL) 
{
    if (model != "linear" && model != "logistic" && model != 
        "Bar3par" && model != "Bar4par" && model != "Bar6par") {
        stop("'model' must be one of 'linear', 'logistic', 'Bar3par', 'Bar4par' or 'Bar6par'")
    }
    if (mumax.prior != "Uniform" && mumax.prior != "Gaussian" && 
        mumax.prior != "Cauchy") {
        stop("'mumax.prior' must be one of 'Uniform', 'Gaussian' or 'Cauchy'")
    }
    if ((mumax.prior == "Gaussian" || mumax.prior == "Cauchy") && 
        (is.null(mu.mean) || is.null(mu.sd))) {
        stop("both 'mu.mean' and 'mu.sd' must be given when using a Gaussian or Cauchy prior for mu_max")
    }
    mu.mean <- mu.mean * log(10)
    mu.sd <- mu.sd * log(10)
    if (model == "linear") {
        par.no <- 2
        modelfunc <- linear
    }
    else if (model == "logistic") {
        par.no <- 3
        modelfunc <- logistic
    }
    else if (model == "Bar3par") {
        par.no <- 3
        modelfunc <- Bar3par
    }
    else if (model == "Bar4par") {
        par.no <- 4
        modelfunc <- Bar4par
    }
    else if (model == "Bar6par") {
        par.no <- 6
        modelfunc <- Bar6par
    }
    if (nrow(data) == 1) {
        stop("'data' must include at least 2 data points")
    }
    if ((nrow(data) == 2) && (inf.sigma == TRUE)) {
        warning("inferring noise level sigma is not recommended with only 2 data points, sigma has been prescribed as 0.3")
        inf.sigma <- FALSE
    }
    sort <- sortdata(data, inc.nd)
    data <- sort$ty
    t <- data[, 1]
    y <- log(10) * data[, 2]
    if (length(t) == 1) {
        stop("'data' must include at least 2 detected data points")
    }
    dataset <- data.frame(t, y)
    t.nd <- sort$t.nd
    if (!inf.sigma) {
        prior.size <- 100
        total.pars <- par.no
        sigma.save <- sigma
        sigma <- rep(sigma * log(10), length(dataset[, 1]))
    }
    else {
        prior.size <- 150
        total.pars <- par.no + 1
    }
    if ((inc.nd) && (is.null(threshold))) {
        stop("'threshold' must be specified when including undetected values")
    }
    threshold <- threshold * log(10)
    tol <- 0.1
    transformParams <- generateTransform(dataset, par.no, model, 
        inc.nd, inf.sigma, mumax.prior, mu.mean, mu.sd)
    logllfun <- function(params) {
        return(logll(params, par.no, modelfunc, model, dataset, 
            inc.nd, threshold, t.nd, inf.sigma, sigma, transformParams, 
            mumax.prior))
    }
    ret <- nestedSampling(logllfun, total.pars, prior.size, transformParams, 
        exploreFn = ballExplore, tolerance = tol)
    posterior <- ret$posterior
    logevidence <- ret$logevidence
    means <- ret$parameterMeans
    vars <- ret$parameterVariances
    chosenSamples = getEqualSamples(ret$posterior, n = Inf)
    if (length(t) == 1) {
        tfit <- seq(from = 0, by = 0.01 * t, to = t)
    }
    else {
        tfit <- seq(from = t[1], by = 0.01 * t[length(t)], to = t[length(t)])
    }
    posteriorModel = apply(chosenSamples[, -1], 1, modelfunc, 
        t = tfit)
    meanfit <- modelfunc(tfit, means)
    if (model != "Bar6par") {
        posterior <- cbind(posterior[, 1:2], posterior[, 3:ncol(posterior)]/log(10))
        means <- means/log(10)
        vars <- vars/log(10)^2
        chosenSamples <- cbind(chosenSamples[, 1], chosenSamples[, 
            2:ncol(chosenSamples)]/log(10))
    }
    else {
        if (inf.sigma == TRUE) {
            posterior <- cbind(posterior[, 1:2], posterior[, 
                3:5]/log(10), posterior[, 6:7], posterior[, 8] * 
                log(10), posterior[, 9]/log(10))
            means <- c(means[1:3]/log(10), means[4:5], means[6] * 
                log(10), means[7]/log(10))
            vars <- c(vars[1:3]/log(10)^2, vars[4:5], vars[6] * 
                log(10)^2, vars[7]/log(10)^2)
            chosenSamples <- cbind(chosenSamples[, 1], chosenSamples[, 
                2:4]/log(10), chosenSamples[, 5:6], chosenSamples[, 
                7] * log(10), chosenSamples[, 8]/log(10))
        }
        else {
            posterior <- cbind(posterior[, 1:2], posterior[, 
                3:5]/log(10), posterior[, 6:7], posterior[, 8] * 
                log(10))
            means <- c(means[1:3]/log(10), means[4:5], means[6] * 
                log(10))
            vars <- c(vars[1:3]/log(10)^2, vars[4:5], vars[6] * 
                log(10)^2)
            chosenSamples <- cbind(chosenSamples[, 1], chosenSamples[, 
                2:4]/log(10), chosenSamples[, 5:6], chosenSamples[, 
                7] * log(10))
        }
    }
    posteriorModel <- posteriorModel/log(10)
    meanfit <- meanfit/log(10)
    cat(rep("#", 30), collapse = "", "\n")
    cat("Model = ", model, "\n")
    cat("mu_max prior type =", mumax.prior, "\n")
    cat(rep("#", 30), collapse = "", "\n\n")
    cat("log evidence = ", logevidence, "\n")
    cat("Means and standard deviations:", "\n")
    if (model == "linear") {
        cat("Log cell count at time 0, y_0 =", means[1], "+/-", 
            (vars[1])^(1/2), "\n")
        cat("Growth rate, mu_max =", means[2], "+/-", (vars[2])^(1/2), 
            "\n")
    }
    else if (model == "logistic") {
        cat("Log cell count at time 0, y_0 =", means[1], "+/-", 
            (vars[1])^(1/2), "\n")
        cat("Log final cell count, y_max =", means[2], "+/-", 
            (vars[2])^(1/2), "\n")
        cat("Growth rate, mu_max =", means[3], "+/-", (vars[3])^(1/2), 
            "\n")
    }
    else if (model == "Bar3par") {
        cat("Log cell count at time 0, y_0 =", means[1], "+/-", 
            (vars[1])^(1/2), "\n")
        cat("Growth rate, mu_max =", means[2], "+/-", (vars[2])^(1/2), 
            "\n")
        cat("h_0 =", means[3], "+/-", (vars[3])^(1/2), "\n")
    }
    else if (model == "Bar4par") {
        cat("Log cell count at time 0, y_0 =", means[1], "+/-", 
            (vars[1])^(1/2), "\n")
        cat("Log final cell count, y_max =", means[2], "+/-", 
            (vars[2])^(1/2), "\n")
        cat("Growth rate, mu_max =", means[3], "+/-", (vars[3])^(1/2), 
            "\n")
        cat("h_0 =", means[4], "+/-", (vars[4])^(1/2), "\n")
    }
    else {
        cat("Log cell count at time 0, y_0 =", means[1], "+/-", 
            (vars[1])^(1/2), "\n")
        cat("Log final cell count, y_max =", means[2], "+/-", 
            (vars[2])^(1/2), "\n")
        cat("Growth rate, mu_max =", means[3], "+/-", (vars[3])^(1/2), 
            "\n")
        cat("Lag time, lambda =", means[4], "+/-", (vars[4])^(1/2), 
            "\n")
        cat("nu =", means[5], "+/-", (vars[5])^(1/2), "\n")
        cat("m =", means[6], "+/-", (vars[6])^(1/2), "\n")
    }
    if (inf.sigma) {
        cat("Noise level, sigma =", means[par.no + 1], "+/-", 
            (vars[par.no + 1])^(1/2), "\n\n")
    }
    else {
        cat("Noise level, sigma = prescribed at", sigma.save, 
            "\n\n")
    }
    return(list(posterior = posterior, logevidence = logevidence, 
        means = means, vars = vars, equalposterior = chosenSamples, 
        fit.t = tfit, fit.y = posteriorModel, fit.ymean = meanfit))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
