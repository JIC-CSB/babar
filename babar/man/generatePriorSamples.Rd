\name{generatePriorSamples}
\alias{generatePriorSamples}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
generatePriorSamples(n.samples, numberOfParameters)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n.samples}{
%%     ~~Describe \code{n.samples} here~~
}
  \item{numberOfParameters}{
%%     ~~Describe \code{numberOfParameters} here~~
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
function (n.samples, numberOfParameters) 
{
    prior.samples <- replicate(n.samples, generateUnitHyperCube(numberOfParameters))
    if (numberOfParameters == 1) {
        return(as.matrix(prior.samples))
    }
    else {
        return(t(prior.samples))
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
