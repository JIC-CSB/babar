#!/bin/bash
BAYESCOMPARE=babar/man/Bayescompare.Rd
BAYESFIT=babar/man/Bayesfit.Rd

function add_dontrun {
    FILENAME=$1
    STATEMENT=$2

sed "/$STATEMENT/i \\\\\dontrun{" $FILENAME | sed "/$STATEMENT/a \
}" 
}

add_dontrun $BAYESCOMPARE results_H1 > .newfile
mv .newfile $BAYESCOMPARE
add_dontrun $BAYESFIT results_linear > .newfile
mv .newfile $BAYESFIT
rm -f babar/man/ballExplore.Rd
