\name{ballExplore}
\alias{ballExplore}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
ballExplore(current.values, steps, llMin, llFun)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{current.values}{
%%     ~~Describe \code{current.values} here~~
}
  \item{steps}{
%%     ~~Describe \code{steps} here~~
}
  \item{llMin}{
%%     ~~Describe \code{llMin} here~~
}
  \item{llFun}{
%%     ~~Describe \code{llFun} here~~
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
function (current.values, steps, llMin, llFun) 
{
    msub <- 20
    m <- 5
    accepted <- vector()
    for (k in 1:m) {
        for (i in 1:msub) {
            ret <- ballMcmcStep(current.values, llFun, llMin, 
                steps)
            current.values <- ret$new.values
            accepted <- cbind(accepted, ret$accepted)
        }
    }
    ratio <- sum(accepted)/length(accepted)
    if (ratio > 0.6) 
        steps <- steps * (1 + 2 * (ratio - 0.6)/0.4)
    if (ratio < 0.4) 
        steps <- steps/(1 + 2 * ((0.4 - ratio)/0.4))
    steps <- pmax(steps, 0.01)
    return(list(new.values = ret$new.values, new.steps = steps, 
        new.ll = llFun(ret$new.values)))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
