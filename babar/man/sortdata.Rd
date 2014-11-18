\name{sortdata}
\alias{sortdata}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
sortdata(data, inc.nd)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
}
  \item{inc.nd}{
%%     ~~Describe \code{inc.nd} here~~
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
function (data, inc.nd) 
{
    t <- numeric(0)
    y <- numeric(0)
    t.nd <- numeric(0)
    for (i in 1:nrow(data)) {
        if (is.na(data[i, 2]) == FALSE) {
            t <- c(t, data[i, 1])
            y <- c(y, data[i, 2])
        }
        else {
            if (inc.nd) {
                t.nd <- c(t.nd, data[i, 1])
            }
            else {
                warning("there are undetected points which are not being used as part of the analysis")
            }
        }
    }
    ty <- data.frame(t, y)
    return(list(ty = ty, t.nd = t.nd))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
