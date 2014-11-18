\name{staircaseSampling}
\alias{staircaseSampling}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
staircaseSampling(posterior)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{posterior}{
%%     ~~Describe \code{posterior} here~~
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
function (posterior) 
{
    logSamples = 0
    logevidence = log(sum(exp(posterior[, 1])))
    numNestedSamples = nrow(posterior)
    for (i in 1:numNestedSamples) {
        logSamples = logSamples - exp(posterior[i, 1] - logevidence) * 
            (posterior[i, 1] - logevidence)
    }
    multiplicity = exp(posterior[, 1] - logevidence) * round(exp(logSamples))
    integerPart = trunc(multiplicity)
    decimalPart = multiplicity - integerPart
    for (mm in 1:numNestedSamples) {
        if (runif(1) <= decimalPart[mm]) 
            integerPart[mm] = integerPart[mm] + 1
    }
    equallyWeightedSamples = numeric()
    for (i in 1:numNestedSamples) {
        equallyWeightedSamples = c(equallyWeightedSamples, rep(posterior[i, 
            -1], times = integerPart[i]))
    }
    equallyWeightedSamples = matrix(equallyWeightedSamples, ncol = ncol(posterior) - 
        1L, byrow = TRUE)
    colnames(equallyWeightedSamples) = c("logLikelihood", paste0("parameter", 
        seq(2, ncol(equallyWeightedSamples)) - 1L))
    return(equallyWeightedSamples)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
