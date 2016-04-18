This directory contains files needed to replicate a manuscript submission to *The R Journal*. It contains a number of files. The first are needed to produce the manuscript itself:

 * `Leeper.tex`
 * `RJwrapper.tex`
 * `RJournal.sty`
 * `MTurkR.bib`
 * `RJwrapper.pdf`
 * `hit2.png`
 
The other files reproduce the analysis reported in the manuscript's example:

 * `FacesMTurkR.R` is a copy of the MTurkR code reported in the manuscript that includes the R output that would be seen by running the manuscript's examples
 * `faces_all.RDS`, an R data file containing a vector of filenames used in the original study reported in the manuscript
 * `faces_sample.RDS`, an R data file containing a shorter vector of filenames from the original study that can be used for reproducing the MTurkR code.
 * `FacialCompetence.RDS`, an R data file containing the complete, anonymized results of the original study

The face images, though proprietary, have been uploaded to Amazon S3 and made publicly available for the purposes of peer review. As a reference `FacesPreparation.R` contains the code needed to obtain and modify the face images used in the example study. This is not fully executable in its current form because it requires the proprietary image data from http://www.wilmabainbridge.com/facememorability2.html. It also requires ImageMagick and xpdf as system requirements.
 
To test the code reported in the paper, one will need to execute in the code in `FacesMTurkR.R`. This file assumes that valid Amazon Web Services access credentials have been stored in a local .Renviron file as:

```
AWS_ACCESS_KEY_ID=EXAMPLEACCESSKEY
AWS_SECRET_ACCESS_KEY=EXAMPLESECRETACCESSKEY
```

or set within R using `Sys.setenv()` prior to executing the file. The only R dependency is MTurkR along with the packages it imports. There are no other system requirements other than an internet connection.
