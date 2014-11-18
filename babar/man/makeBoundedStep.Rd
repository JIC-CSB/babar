\name{makeBoundedStep}
\alias{makeBoundedStep}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
makeBoundedStep(current.values, step)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{current.values}{
%%     ~~Describe \code{current.values} here~~
}
  \item{step}{
%%     ~~Describe \code{step} here~~
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
function (current.values, step) 
{
    step.attempt <- makeStep(current.values, step)
    stopifnot(length(current.values) == length(step))
    failed.steps <- step.attempt < 0 | step.attempt > 1
    for (i in which(failed.steps)) {
        step.attempt[i] <- runif(1, min = 0, max = 1)
    }
    return(step.attempt)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
