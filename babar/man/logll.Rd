\name{logll}
\alias{logll}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
logll(params, par.no, modelfunc, model, dataset, inc.nd, threshold, t.nd, inf.sigma, sigma, transformParams, mumax.prior)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{params}{
%%     ~~Describe \code{params} here~~
}
  \item{par.no}{
%%     ~~Describe \code{par.no} here~~
}
  \item{modelfunc}{
%%     ~~Describe \code{modelfunc} here~~
}
  \item{model}{
%%     ~~Describe \code{model} here~~
}
  \item{dataset}{
%%     ~~Describe \code{dataset} here~~
}
  \item{inc.nd}{
%%     ~~Describe \code{inc.nd} here~~
}
  \item{threshold}{
%%     ~~Describe \code{threshold} here~~
}
  \item{t.nd}{
%%     ~~Describe \code{t.nd} here~~
}
  \item{inf.sigma}{
%%     ~~Describe \code{inf.sigma} here~~
}
  \item{sigma}{
%%     ~~Describe \code{sigma} here~~
}
  \item{transformParams}{
%%     ~~Describe \code{transformParams} here~~
}
  \item{mumax.prior}{
%%     ~~Describe \code{mumax.prior} here~~
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
function (params, par.no, modelfunc, model, dataset, inc.nd, 
    threshold, t.nd, inf.sigma, sigma, transformParams, mumax.prior) 
{
    t <- dataset$t
    y <- dataset$y
    ymax <- max(y)
    ymin <- min(y)
    tmax <- max(t)
    ydiff <- (ymax - ymin)
    tParams <- transformParams(params)
    if (inf.sigma) {
        sigma <- rep(tParams[par.no + 1], length = length(y))
    }
    if (((mumax.prior == "Cauchy") && (model == "linear" || model == 
        "Bar3par") && (tParams[2] < 0 || tParams[2] > 10 * ydiff/tmax)) || 
        ((mumax.prior == "Cauchy") && (model == "logistic" || 
            model == "Bar4par" || model == "Bar6par") && (tParams[3] < 
            0 || tParams[3] > 10 * ydiff/tmax))) {
        llhood <- -10^4
    }
    else {
        fun <- modelfunc(t, tParams[1:par.no])
        res <- sum(((y - fun)/sigma)^2)
        llhood <- log(1/prod(sigma * (2 * pi)^(1/2))) - res/2
        if (inc.nd && length(t.nd > 0)) {
            fun.nd <- modelfunc(t.nd, tParams[1:par.no])
            P.nd <- rep(1/threshold, length = length(fun.nd))
            P.d <- numeric(length = length(fun.nd))
            for (k in 1:length(t.nd)) {
                if ((fun.nd[k] >= 0) && (fun.nd[k] <= threshold)) {
                  P.d[k] <- 0
                }
                else {
                  P.d[k] <- ((fun.nd[k] - threshold)/10^(-10))^2
                }
            }
            llhood <- llhood + log(prod(P.nd)) - sum(P.d)
        }
    }
    return(llhood)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
