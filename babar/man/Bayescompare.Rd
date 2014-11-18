\name{Bayescompare}
\alias{Bayescompare}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
Bayescompare(data1, data2, hyp, model, inf.sigma1 = TRUE, inf.sigma2 = TRUE, inc.nd1 = FALSE, inc.nd2 = FALSE, sigma1 = 0.3, sigma2 = 0.3, threshold1 = NULL, threshold2 = NULL, mumax.prior1 = "Uniform", mumax.prior2 = "Uniform", mu.mean1 = NULL, mu.mean2 = NULL, mu.sd1 = NULL, mu.sd2 = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data1}{
%%     ~~Describe \code{data1} here~~
}
  \item{data2}{
%%     ~~Describe \code{data2} here~~
}
  \item{hyp}{
%%     ~~Describe \code{hyp} here~~
}
  \item{model}{
%%     ~~Describe \code{model} here~~
}
  \item{inf.sigma1}{
%%     ~~Describe \code{inf.sigma1} here~~
}
  \item{inf.sigma2}{
%%     ~~Describe \code{inf.sigma2} here~~
}
  \item{inc.nd1}{
%%     ~~Describe \code{inc.nd1} here~~
}
  \item{inc.nd2}{
%%     ~~Describe \code{inc.nd2} here~~
}
  \item{sigma1}{
%%     ~~Describe \code{sigma1} here~~
}
  \item{sigma2}{
%%     ~~Describe \code{sigma2} here~~
}
  \item{threshold1}{
%%     ~~Describe \code{threshold1} here~~
}
  \item{threshold2}{
%%     ~~Describe \code{threshold2} here~~
}
  \item{mumax.prior1}{
%%     ~~Describe \code{mumax.prior1} here~~
}
  \item{mumax.prior2}{
%%     ~~Describe \code{mumax.prior2} here~~
}
  \item{mu.mean1}{
%%     ~~Describe \code{mu.mean1} here~~
}
  \item{mu.mean2}{
%%     ~~Describe \code{mu.mean2} here~~
}
  \item{mu.sd1}{
%%     ~~Describe \code{mu.sd1} here~~
}
  \item{mu.sd2}{
%%     ~~Describe \code{mu.sd2} here~~
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
function (data1, data2, hyp, model, inf.sigma1 = TRUE, inf.sigma2 = TRUE, 
    inc.nd1 = FALSE, inc.nd2 = FALSE, sigma1 = 0.3, sigma2 = 0.3, 
    threshold1 = NULL, threshold2 = NULL, mumax.prior1 = "Uniform", 
    mumax.prior2 = "Uniform", mu.mean1 = NULL, mu.mean2 = NULL, 
    mu.sd1 = NULL, mu.sd2 = NULL) 
{
    if (model != "linear" && model != "logistic" && model != 
        "Bar3par" && model != "Bar4par") {
        stop("'model' must be one of 'linear', 'logistic', 'Bar3par' or 'Bar4par'")
    }
    if (mumax.prior1 != "Uniform" && mumax.prior1 != "Gaussian" && 
        mumax.prior1 != "Cauchy") {
        stop("'mumax.prior1' must be one of 'Uniform', 'Gaussian' or 'Cauchy'")
    }
    if (mumax.prior2 != "Uniform" && mumax.prior2 != "Gaussian" && 
        mumax.prior2 != "Cauchy") {
        stop("'mumax.prior2' must be one of 'Uniform', 'Gaussian' or 'Cauchy'")
    }
    if ((hyp == "H1" || hyp == "H2") && mumax.prior2 != "Uniform") {
        warning("using the current hypothesis, mumax.prior1 will be used for both parameter sets and mumax.prior2 \n            will not be used")
    }
    if ((mumax.prior1 == "Gaussian" || mumax.prior1 == "Cauchy") && 
        (is.null(mu.mean1) || is.null(mu.sd1))) {
        stop("both 'mu.mean1' and 'mu.sd1' must be given when using a Gaussian or Cauchy prior for mu_max1")
    }
    if ((mumax.prior2 == "Gaussian" || mumax.prior2 == "Cauchy") && 
        (is.null(mu.mean2) || is.null(mu.sd2))) {
        stop("both 'mu.mean2' and 'mu.sd2' must be given when using a Gaussian or Cauchy prior for mu_max2")
    }
    mu.mean1 <- mu.mean1 * log(10)
    mu.sd1 <- mu.sd1 * log(10)
    mu.mean2 <- mu.mean2 * log(10)
    mu.sd2 <- mu.sd2 * log(10)
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
    if (nrow(data1) == 1) {
        stop("'data1' must include at least 2 data points")
    }
    if (nrow(data2) == 1) {
        stop("'data2' must include at least 2 data points")
    }
    if ((nrow(data1) == 2) && (inf.sigma1 == TRUE)) {
        warning("inferring noise level sigma is not recommended with only 2 data points, sigma1 has been prescribed as 0.3")
    }
    if ((nrow(data2) == 2) && (inf.sigma2 == TRUE)) {
        warning("inferring noise level sigma is not recommended with only 2 data points, sigma2 has been prescribed as 0.3")
    }
    sort1 <- sortdata(data1, inc.nd1)
    sort2 <- sortdata(data2, inc.nd2)
    data1 <- sort1$ty
    data2 <- sort2$ty
    t1 <- data1[, 1]
    y1 <- log(10) * data1[, 2]
    t2 <- data2[, 1]
    y2 <- log(10) * data2[, 2]
    if (length(t1) == 1) {
        stop("'data1' must include at least 2 detected data points")
    }
    if (length(t2) == 1) {
        stop("'data2' must include at least 2 detected data points")
    }
    dataset1 <- data.frame(t1, y1)
    dataset2 <- data.frame(t2, y2)
    t.nd1 <- sort1$t.nd
    t.nd2 <- sort2$t.nd
    if (hyp != "H1" && hyp != "H2" && hyp != "H3") {
        stop("'hyp' must be one of 'H1', 'H2' or 'H3'")
    }
    if (hyp == "H1") {
        hypinfo <- "data curves are replicates"
        hyp.par.no <- par.no
    }
    else if (hyp == "H2") {
        hypinfo <- "data curves have same growth rate"
        hyp.par.no <- 2 * par.no - 1
    }
    else {
        hypinfo <- "all data curve parameters are different"
        hyp.par.no <- 2 * par.no
    }
    if (!inf.sigma1) {
        total.pars <- hyp.par.no
        sigma1.save <- sigma1
        sigma1 <- rep(sigma1 * log(10), length(dataset1[, 1]))
    }
    else {
        total.pars <- hyp.par.no + 1
    }
    if (!inf.sigma2) {
        total.pars <- total.pars
        sigma2.save <- sigma2
        sigma2 <- rep(sigma2 * log(10), length(dataset2[, 1]))
    }
    else {
        total.pars <- total.pars + 1
    }
    prior.size <- 250
    if ((inc.nd1) && (is.null(threshold1))) {
        stop("'threshold1' must be specified when including undetected values in curve 1")
    }
    if ((inc.nd2) && (is.null(threshold2))) {
        stop("'threshold2' must be specified when including undetected values in curve 2")
    }
    threshold1 <- threshold1 * log(10)
    threshold2 <- threshold2 * log(10)
    tol <- 0.1
    transformParams <- generateTransform(dataset1, dataset2, 
        par.no, model, inc.nd1, inc.nd2, inf.sigma1, inf.sigma2, 
        hyp, mumax.prior1, mu.mean1, mu.sd1, mumax.prior2, mu.mean2, 
        mu.sd2)
    logllfun <- function(params) {
        return(logll(params, par.no, modelfunc, model, dataset1, 
            dataset2, inc.nd1, inc.nd2, threshold1, threshold2, 
            t.nd1, t.nd2, inf.sigma1, inf.sigma2, sigma1, sigma2, 
            hyp, transformParams, mumax.prior1, mumax.prior2))
    }
    ret <- nestedSampling(logllfun, total.pars, prior.size, transformParams, 
        exploreFn = ballExplore, tolerance = tol)
    posterior <- ret$posterior
    logevidence <- ret$logevidence
    means <- ret$parameterMeans
    vars <- ret$parameterVariances
    chosenSamples = getEqualSamples(ret$posterior, n = Inf)
    if (length(t1) == 1) {
        tfit1 <- seq(from = 0, by = 0.01 * t1, to = t1)
    }
    else {
        tfit1 <- seq(from = t1[1], by = 0.01 * t1[length(t1)], 
            to = t1[length(t1)])
    }
    if (length(t2) == 1) {
        tfit2 <- seq(from = 0, by = 0.01 * t2, to = t2)
    }
    else {
        tfit2 <- seq(from = t2[1], by = 0.01 * t2[length(t2)], 
            to = t2[length(t2)])
    }
    posteriorModel1 = apply(chosenSamples[, -1], 1, modelfunc, 
        t = tfit1)
    if (hyp == "H1") {
        posteriorModel2 = apply(chosenSamples[, -1], 1, modelfunc, 
            t = tfit2)
    }
    else if (hyp == "H2") {
        if (model == "linear") {
            posteriorModel2 = apply(chosenSamples[, c(4, 3)], 
                1, modelfunc, t = tfit2)
        }
        else if (model == "logistic") {
            posteriorModel2 = apply(chosenSamples[, c(5, 6, 4)], 
                1, modelfunc, t = tfit2)
        }
        else if (model == "Bar3par") {
            posteriorModel2 = apply(chosenSamples[, c(5, 3, 6)], 
                1, modelfunc, t = tfit2)
        }
        else {
            posteriorModel2 = apply(chosenSamples[, c(6, 7, 4, 
                8)], 1, modelfunc, t = tfit2)
        }
    }
    else {
        posteriorModel2 = apply(chosenSamples[, (par.no + 2):(2 * 
            par.no + 1)], 1, modelfunc, t = tfit2)
    }
    meanfit1 <- modelfunc(tfit1, means)
    if (hyp == "H1") {
        meanfit2 <- modelfunc(tfit2, means)
    }
    else if (hyp == "H2") {
        if (model == "linear") {
            meanfit2 <- modelfunc(tfit2, means[c(3, 2)])
        }
        else if (model == "logistic") {
            meanfit2 <- modelfunc(tfit2, means[c(4, 5, 3)])
        }
        else if (model == "Bar3par") {
            meanfit2 <- modelfunc(tfit2, means[c(4, 2, 5)])
        }
        else {
            meanfit2 <- modelfunc(tfit2, means[c(5, 6, 3, 7)])
        }
    }
    else {
        meanfit2 <- modelfunc(tfit2, means[(par.no + 1):(2 * 
            par.no)])
    }
    posterior <- cbind(posterior[, 1:2], posterior[, 3:ncol(posterior)]/log(10))
    means <- means/log(10)
    vars <- vars/log(10)^2
    chosenSamples <- cbind(chosenSamples[, 1], chosenSamples[, 
        2:ncol(chosenSamples)]/log(10))
    posteriorModel1 <- posteriorModel1/log(10)
    posteriorModel2 <- posteriorModel2/log(10)
    meanfit1 <- meanfit1/log(10)
    meanfit2 <- meanfit2/log(10)
    cat(rep("#", 30), collapse = "", "\n")
    cat("Model = ", model, "\n")
    cat("mu_max1 prior type =", mumax.prior1, ", mu_max2 prior type =", 
        mumax.prior2, "\n")
    cat("Hypothesis = ", hyp, "(", hypinfo, ")", "\n")
    cat(rep("#", 30), collapse = "", "\n\n")
    cat("log evidence = ", logevidence, "\n")
    cat("Means and standard deviations:", "\n")
    if (hyp == "H1") {
        if (model == "linear") {
            cat("Log cell counts at time 0, y_01 = y_02 =", means[1], 
                "+/-", (vars[1])^(1/2), "\n")
            cat("Growth rates, mu_max1 = mu_max2 =", means[2], 
                "+/-", (vars[2])^(1/2), "\n")
        }
        else if (model == "logistic") {
            cat("Log cell counts at time 0, y_01 = y_02 =", means[1], 
                "+/-", (vars[1])^(1/2), "\n")
            cat("Log final cell counts, y_max1 = y_max2 =", means[2], 
                "+/-", (vars[2])^(1/2), "\n")
            cat("Growth rates, mu_max1 = mu_max2 =", means[3], 
                "+/-", (vars[3])^(1/2), "\n")
        }
        else if (model == "Bar3par") {
            cat("Log cell counts at time 0, y_01 = y_02 =", means[1], 
                "+/-", (vars[1])^(1/2), "\n")
            cat("Growth rates, mu_max1 = mu_max2 =", means[2], 
                "+/-", (vars[2])^(1/2), "\n")
            cat("h_01 = h_02 =", means[3], "+/-", (vars[3])^(1/2), 
                "\n")
        }
        else {
            cat("Log cell counts at time 0, y_01 = y_02", means[1], 
                "+/-", (vars[1])^(1/2), "\n")
            cat("Log final cell counts, y_max1 = y_max2 =", means[2], 
                "+/-", (vars[2])^(1/2), "\n")
            cat("Growth rates, mu_max1 = mu_max2 =", means[3], 
                "+/-", (vars[3])^(1/2), "\n")
            cat("h_01 = h_02 =", means[4], "+/-", (vars[4])^(1/2), 
                "\n")
        }
    }
    if (hyp == "H2") {
        if (model == "linear") {
            cat("Log cell counts at time 0, y_01 =", means[1], 
                "+/-", (vars[1])^(1/2), ", y_02 =", means[3], 
                "+/-", (vars[3])^(1/2), "\n")
            cat("Growth rates, mu_max1 = mu_max2 =", means[2], 
                "+/-", (vars[2])^(1/2), "\n")
        }
        else if (model == "logistic") {
            cat("Log cell counts at time 0, y_01 =", means[1], 
                "+/-", (vars[1])^(1/2), ", y_02 =", means[4], 
                "+/-", (vars[4])^(1/2), "\n")
            cat("Log final cell counts, y_max1 =", means[2], 
                "+/-", (vars[2])^(1/2), ", y_max2 =", means[5], 
                "+/-", (vars[5])^(1/2), "\n")
            cat("Growth rates, mu_max1 = mu_max2 =", means[3], 
                "+/-", (vars[3])^(1/2), "\n")
        }
        else if (model == "Bar3par") {
            cat("Log cell counts at time 0, y_01 =", means[1], 
                "+/-", (vars[1])^(1/2), ", y_02 =", means[4], 
                "+/-", (vars[4])^(1/2), "\n")
            cat("Growth rates, mu_max1 = mu_max2 =", means[2], 
                "+/-", (vars[2])^(1/2), "\n")
            cat("h_01 =", means[3], "+/-", (vars[3])^(1/2), ", h_02 =", 
                means[5], "+/-", (vars[5])^(1/2), "\n")
        }
        else {
            cat("Log cell counts at time 0, y_01 =", means[1], 
                "+/-", (vars[1])^(1/2), ", y_02 =", means[5], 
                "+/-", (vars[5])^(1/2), "\n")
            cat("Log final cell counts, y_max1 =", means[2], 
                "+/-", (vars[2])^(1/2), ", y_max2 =", means[6], 
                "+/-", (vars[6])^(1/2), "\n")
            cat("Growth rates, mu_max1 = mu_max2 =", means[3], 
                "+/-", (vars[3])^(1/2), "\n")
            cat("h_01 =", means[4], "+/-", (vars[4])^(1/2), ", h_02 =", 
                means[7], "+/-", (vars[7])^(1/2), "\n")
        }
    }
    if (hyp == "H3") {
        if (model == "linear") {
            cat("Log cell counts at time 0, y_01 =", means[1], 
                "+/-", (vars[1])^(1/2), ", y_02 =", means[3], 
                "+/-", (vars[3])^(1/2), "\n")
            cat("Growth rates, mu_max1 =", means[2], "+/-", (vars[2])^(1/2), 
                ", mu_max2 =", means[4], "+/-", (vars[4])^(1/2), 
                "\n")
        }
        else if (model == "logistic") {
            cat("Log cell counts at time 0, y_01 =", means[1], 
                "+/-", (vars[1])^(1/2), ", y_02 =", means[4], 
                "+/-", (vars[4])^(1/2), "\n")
            cat("Log final cell counts, y_max1 =", means[2], 
                "+/-", (vars[2])^(1/2), ", y_max2 =", means[5], 
                "+/-", (vars[5])^(1/2), "\n")
            cat("Growth rates, mu_max1 =", means[3], "+/-", (vars[3])^(1/2), 
                ", mu_max2 =", means[6], "+/-", (vars[6])^(1/2), 
                "\n")
        }
        else if (model == "Bar3par") {
            cat("Log cell counts at time 0, y_01 =", means[1], 
                "+/-", (vars[1])^(1/2), ", y_02 =", means[4], 
                "+/-", (vars[4])^(1/2), "\n")
            cat("Growth rates, mu_max1 =", means[2], "+/-", (vars[2])^(1/2), 
                ", mu_max2 =", means[5], "+/-", (vars[5])^(1/2), 
                "\n")
            cat("h_01 =", means[3], "+/-", (vars[3])^(1/2), ", h_02 =", 
                means[6], "+/-", (vars[6])^(1/2), "\n")
        }
        else {
            cat("Log cell counts at time 0, y_01 =", means[1], 
                "+/-", (vars[1])^(1/2), ", y_02 =", means[5], 
                "+/-", (vars[5])^(1/2), "\n")
            cat("Log final cell counts, y_max1 =", means[2], 
                "+/-", (vars[2])^(1/2), ", y_max2 =", means[6], 
                "+/-", (vars[6])^(1/2), "\n")
            cat("Growth rates, mu_max1 =", means[3], "+/-", (vars[3])^(1/2), 
                ", mu_max2 =", means[7], "+/-", (vars[7])^(1/2), 
                "\n")
            cat("h_01 =", means[4], "+/-", (vars[4])^(1/2), ", h_02 =", 
                means[8], "+/-", (vars[8])^(1/2), "\n")
        }
    }
    if (inf.sigma1 && inf.sigma2) {
        cat("Noise level, sigma1 =", means[hyp.par.no + 1], "+/-", 
            (vars[par.no + 1])^(1/2), "\n")
        cat("Noise level, sigma2 =", means[hyp.par.no + 2], "+/-", 
            (vars[par.no + 2])^(1/2), "\n\n")
    }
    else if (inf.sigma1) {
        cat("Noise level, sigma1 =", means[hyp.par.no + 1], "+/-", 
            (vars[par.no + 1])^(1/2), "\n")
        cat("Noise level, sigma2 = prescribed at", sigma2.save, 
            "\n\n")
    }
    else if (inf.sigma2) {
        cat("Noise level, sigma1 = prescribed at", sigma1.save, 
            "\n\n")
        cat("Noise level, sigma2 =", means[hyp.par.no + 1], "+/-", 
            (vars[par.no + 2])^(1/2), "\n\n")
    }
    else {
        cat("Noise level, sigma1 = prescribed at", sigma1.save, 
            "\n")
        cat("Noise level, sigma2 = prescribed at", sigma2.save, 
            "\n\n")
    }
    return(list(posterior = posterior, logevidence = logevidence, 
        means = means, vars = vars, equalposterior = chosenSamples, 
        fit.t1 = tfit1, fit.y1 = posteriorModel1, fit.t2 = tfit2, 
        fit.y2 = posteriorModel2, fit.y1mean1 = meanfit1, fit.y2mean = meanfit2))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
