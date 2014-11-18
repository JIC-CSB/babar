\name{generateTransform}
\alias{generateTransform}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
generateTransform(dataset, par.no, model, inc.nd, inf.sigma, mumax.prior, mu.mean, mu.sd)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dataset}{
%%     ~~Describe \code{dataset} here~~
}
  \item{par.no}{
%%     ~~Describe \code{par.no} here~~
}
  \item{model}{
%%     ~~Describe \code{model} here~~
}
  \item{inc.nd}{
%%     ~~Describe \code{inc.nd} here~~
}
  \item{inf.sigma}{
%%     ~~Describe \code{inf.sigma} here~~
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
function (dataset, par.no, model, inc.nd, inf.sigma, mumax.prior, 
    mu.mean, mu.sd) 
{
    t <- dataset$t
    y <- dataset$y
    ymax <- max(y)
    ymin <- min(y)
    ydiff <- (ymax - ymin)
    tmax <- max(t)
    transformParams <- function(uParams) {
        tParams = numeric(length = length(uParams))
        if (t[1] != 0 | inc.nd) {
            fact <- 0
        }
        else {
            fact <- 1
        }
        if (par.no == 4) {
            tParams[1] = UniformPrior(uParams[1], fact * (ymin - 
                ydiff/2), ymin + ydiff/2)
            tParams[2] = UniformPrior(uParams[2], ymax - ydiff/2, 
                ymax + ydiff/2)
            if (mumax.prior == "Gaussian") {
                tParams[3] = GaussianPrior(uParams[3], mu.mean, 
                  mu.sd)
            }
            else if (mumax.prior == "Cauchy") {
                tParams[3] = CauchyPrior(uParams[3], mu.mean, 
                  mu.sd)
            }
            else {
                tParams[3] = UniformPrior(uParams[3], 0, 10 * 
                  ydiff/tmax)
            }
            tParams[4] = UniformPrior(uParams[4], 0, 9 * ydiff)
        }
        else if (par.no == 3) {
            if (model == "logistic") {
                tParams[1] = UniformPrior(uParams[1], fact * 
                  (ymin - ydiff/2), ymin + ydiff/2)
                tParams[2] = UniformPrior(uParams[2], ymax - 
                  ydiff/2, ymax + ydiff/2)
                if (mumax.prior == "Gaussian") {
                  tParams[3] = GaussianPrior(uParams[3], mu.mean, 
                    mu.sd)
                }
                else if (mumax.prior == "Cauchy") {
                  tParams[3] = CauchyPrior(uParams[3], mu.mean, 
                    mu.sd)
                }
                else {
                  tParams[3] = UniformPrior(uParams[3], 0, 10 * 
                    ydiff/tmax)
                }
            }
            else {
                tParams[1] = UniformPrior(uParams[1], fact * 
                  (ymin - ydiff/2), ymin + ydiff/2)
                if (mumax.prior == "Gaussian") {
                  tParams[2] = GaussianPrior(uParams[2], mu.mean, 
                    mu.sd)
                }
                else if (mumax.prior == "Cauchy") {
                  tParams[2] = CauchyPrior(uParams[2], mu.mean, 
                    mu.sd)
                }
                else {
                  tParams[2] = UniformPrior(uParams[2], 0, 10 * 
                    ydiff/tmax)
                }
                tParams[3] = UniformPrior(uParams[3], 0, 9 * 
                  ydiff)
            }
        }
        else if (par.no == 2) {
            tParams[1] = UniformPrior(uParams[1], fact * (ymin - 
                ydiff/2), ymin + ydiff/2)
            if (mumax.prior == "Gaussian") {
                tParams[2] = GaussianPrior(uParams[2], mu.mean, 
                  mu.sd)
            }
            else if (mumax.prior == "Cauchy") {
                tParams[2] = CauchyPrior(uParams[2], mu.mean, 
                  mu.sd)
            }
            else {
                tParams[2] = UniformPrior(uParams[2], 0, 10 * 
                  ydiff/tmax)
            }
        }
        else {
            tParams[1] = UniformPrior(uParams[1], fact * (ymin - 
                ydiff/2), ymin + ydiff/2)
            tParams[2] = UniformPrior(uParams[2], ymax - ydiff/2, 
                ymax + ydiff/2)
            if (mumax.prior == "Gaussian") {
                tParams[3] = GaussianPrior(uParams[3], mu.mean, 
                  mu.sd)
            }
            else if (mumax.prior == "Cauchy") {
                tParams[3] = CauchyPrior(uParams[3], mu.mean, 
                  mu.sd)
            }
            else {
                tParams[3] = UniformPrior(uParams[3], 0, 10 * 
                  ydiff/tmax)
            }
            tParams[4] = UniformPrior(uParams[4], 0, 0.9 * tmax)
            tParams[5] = UniformPrior(uParams[5], 0, 10/tmax)
            tParams[6] = UniformPrior(uParams[6], 0, 10/ymax)
        }
        if (inf.sigma) {
            tParams[length(uParams)] = JeffreysPrior(uParams[length(uParams)], 
                -2, 1)
        }
        return(tParams)
    }
    return(transformParams)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
