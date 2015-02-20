all: man build check
	
man:
	Rscript make-man.R
	./fix-man.sh

build:
	R CMD build babar

check:
	R CMD check --as-cran babar_*.tar.gz

clean:
	rm -rf babar.Rcheck
