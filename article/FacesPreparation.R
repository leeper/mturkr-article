# MTurk/Crowdsourced Facial Competence Study
# 2015-06-03

# Download and process photos
## SystemRequirements: ImageMagick, xpdf
## R requirements: MTurkR

### START ###

# Congressional photos
# 105th
# http://www.gpo.gov/fdsys/search/pagedetails.action?packageId=GPO-PICTDIR-105&fromBrowse=true
 # States are listed in alphabetical order
 # http://www.gpo.gov/fdsys/pkg/GPO-PICTDIR-105/pdf/GPO-PICTDIR-105-8-1.pdf
 # http://www.gpo.gov/fdsys/pkg/GPO-PICTDIR-105/pdf/GPO-PICTDIR-105-8-50.pdf

# 113th
# http://www.gpo.gov/fdsys/search/pagedetails.action?packageId=GPO-PICTDIR-113&fromBrowse=true
 # http://www.gpo.gov/fdsys/pkg/GPO-PICTDIR-113/pdf/GPO-PICTDIR-113-10-1.pdf
 # http://www.gpo.gov/fdsys/pkg/GPO-PICTDIR-113/pdf/GPO-PICTDIR-113-10-50.pdf

dir.create("Congress")
dir.create("Congress/pdf")
sapply(1:50, function(x) {
    download.file(paste0("http://www.gpo.gov/fdsys/pkg/GPO-PICTDIR-113/pdf/GPO-PICTDIR-113-10-",x,".pdf"), 
                  paste0("Congress/pdf/",formatC(x, width = 2, flag = "0"),".pdf"), quiet = TRUE, mode = "wb")
})

# extract images from each PDF using `pdfimages` from XPDF
# http://stackoverflow.com/questions/17065274/how-to-extract-images-from-pdf-using-ghostscript-or-imagemagick

dir.create("Congress/image")
setwd("Congress")
sapply(1:50, function(x) {
    system(paste0("pdfimages -j pdf/",x,".pdf image/",formatC(x, width = 2, flag = "0")))
})

# zip PDF and delete
setwd("pdf")
zip("pdfs.zip", dir())
file.copy("pdfs.zip", "../")
setwd("../")

# if not JPEG, images come out as PPM so need to convert to jpg using ImageMagick
#system("mogrify -format jpg -type Grayscale image/*.ppm") # also convert to grayscale
system("mogrify -format jpg image/*.ppm")

dir.create("cropped")
z <- sapply(dir("image/"), function(x) file.copy(paste0("image/", x), to = "cropped", overwrite = TRUE))
any(!z)

setwd("image")
zip("images.zip", dir())
file.copy("images.zip", "../")
setwd("../")

# delete some blank images (vacant seats)
unlink("cropped/01-003.jpg")
unlink("cropped/21-007.jpg")
unlink("cropped/33-003.jpg")

# manually oval crop the images using GIMP to remove most background, clothing, and hair

file.rename("Congress/cropped", "CongressSample")
file.rename("Congress/pdfs.zip", "pdfs.zip")
file.rename("Congress/images.zip", "images.zip")
unlink("Congress")


# 10k face database images are 256px height, 72px/in resolution
# Congress images are 277px height to begin with, but some faces are really small
# resize everything to be 150px height
system("mogrify -geometry x150 cropped/*.jpg")
setwd("cropped")
zip("cropped.zip", dir())
file.copy("cropped.zip", "../")
setwd("../")

# General population faces
# 10K US Adult Faces Database (Wilma Bainbridge)
# http://www.wilmabainbridge.com/facememorability2.html

# stored in "/Bainbridge"
setwd("../Bainbridge")
system("mogrify -geometry x150 *.jpg")
setwd("../")

# sample 5000 faces at random
dir.create("BainbridgeSample")
bfaces <- dir("Bainbridge")
set.seed(123456)
sfaces <- sample(bfaces, 5000, FALSE)
saveRDS(sfaces, "sampledfaces.RDS")
z <- file.copy(paste0("Bainbridge/", sfaces), "BainbridgeSample")
any(!z)
setwd("Bainbridge")
zip("bainbridge.zip", dir())
file.copy("bainbridge.zip", "../")
setwd("../")
unlink("Bainbridge")

bf <- dir("BainbridgeSample")
cf <- dir("CongressSample")
ff <- c(bf, cf)
ff <- ff[sample(seq_along(ff), length(ff), FALSE)]
saveRDS(ff, "mturkfaceorder.RDS")

dir.create("Combined")
setwd("BainbridgeSample")
z <- file.copy(dir(), "../Combined")
any(!z)
setwd("../CongressSample")
z <- file.copy(dir(), "../Combined")
any(!z)
setwd("../")

# upload the sampled images to S3
## this was done manually

# run on MTurk (via separate MTurk script)
source("FacesMTurkR.R")

### END ###
