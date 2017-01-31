#!/bin/sh

# sudo apt-get update
# sudo apt-get install texlive texlive-lang-french texlive-latex-extra texlive-full texlive-latex-base python gnumeric & pip install pygments
ssconvert -S auto_rapport.xlsx tmp.csv 2>/dev/null
mv tmp.csv.0 intro.csv & mv tmp.csv.1 synthese.csv & mv tmp.csv.2 vulnerabilites.csv
ruby test.rb
rm intro.csv synthese.csv vulnerabilites.csv

rc=$?;
if [ $rc = 0 ]
then
    texi2pdf auto_rapport.tex
    rm *.aux *.log *.toc
    xpdf auto_rapport.pdf
fi
