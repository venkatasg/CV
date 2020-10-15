#!/bin/sh
latexmk -xelatex -verbose
latexmk -c
rm -rf *.bbl *.run.xml *.xdv
open *.pdf
