# BaBaR - Bayesian Bacterial growth curve analysis in R

This is the code repository for the babar package.

## Building and installing

This section describes the process for installing the package from source.

### Prerequisites

To build the package, make sure that your version of R has the following packages
(needed to build the package vignettes):

* knitr
* R.rsp

You can install these from the R command prompt with:

    install.packages(c('R.rsp', 'knitr'))

### Build and install

To build the package (including vignettes), from the command prompt type:

    R CMD build babar

Then to install:

    R CMD INSTALL babar_1.0.tar.gz

## Viewing the installed documentation

You can browse the package vignettes with:

    browseVignettes(package='babar')

from within R.

## Generating documentation

Code functions are documented using inlinedocs. To rebuild the documentation:

    install.packages('inlinedocs')
    library(inlinedocs)
    package.skeleton.dx('babar')

