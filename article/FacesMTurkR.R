# Reproduction script for RJournal submission
## AWS security credentials are loaded automatically from local .Renviron file

# load package
library("MTurkR")

# use sandbox
options(MTurkR.sandbox = TRUE)

# Check Account Balance as a "Hello World!" test for security credentials
AccountBalance()
## Balance: $10,000.00

# Qualification Requirements (US, 95% approval)
qual <- GenerateQualificationRequirement(c("Locale", "Approved"), c("==", ">"), c("US", 95), preview = TRUE)
qual
## [1] "&QualificationRequirement.1.QualificationTypeId=00000000000000000071&QualificationRequirement.1.Comparator=EqualTo&QualificationRequirement.1.LocaleValue.1.Country=US&QualificationRequirement.1.RequiredToPreview=1&QualificationRequirement.2.QualificationTypeId=000000000000000000L0&QualificationRequirement.2.Comparator=GreaterThan&QualificationRequirement.2.IntegerValue.1=95&QualificationRequirement.2.RequiredToPreview=1"
## attr(,"class")
## [1] "QualificationRequirement"

# register HITType
hittype <- 
RegisterHITType(title = "Rate the competence of a person",
                description = "Judge the competence of a person from an image of their face. The HIT involves only one question: a rating of the competence of the person. You have 45 seconds to complete the HIT. There are several thousand HITs available in this batch. If you recognize the person, please enter their name in the space provided; your work will still be approved even if you recognize the face.",
                reward = "0.01",
                duration = seconds(seconds = 45), 
                auto.approval.delay = seconds(days = 2),
                qual.req = qual,
                keywords = "categorization, photo, image, rate, rating, face, judgment, batch, quick, fast, easy, competent")
## HITType Registered: 3ES7ZYWJECPCXMRPI985M23J088HCR
hittype
##                        HITTypeId Valid
## 1 3ES7ZYWJECPCXMRPI985M23J088HCR  TRUE

# Read actual file with 5534 file names
#faces <- readRDS("faces_all.RDS")

# Read sample file with 10 file names
# set.seed(12345)
# sample <- faces[sample(seq_along(faces), 10, FALSE)]
# saveRDS(sample, "faces_sample.RDS")
faces <- readRDS("faces_sample.RDS")
faces
##  [1] "49-001.jpg"                          
##  [2] "Google_1_Lynda Archer_1_oval.jpg"    
##  [3] "Google_1_Adam Griswold_9_oval.jpg"   
##  [4] "Google_1_Tina Stout_1_oval.jpg"      
##  [5] "Google_1_Kenneth Pipkin_11_oval.jpg" 
##  [6] "Google_1_Juan Bender_3_oval.jpg"     
##  [7] "43-034.jpg"                          
##  [8] "Google_1_Jeanne Tracy_13_oval.jpg"   
##  [9] "Google_1_Russell Najera_5_oval.jpg"  
## [10] "Google_1_Jacqueline John_12_oval.jpg"

# Create data.frame of face image URLs
s3url <- "https://s3.amazonaws.com/mturkfaces/"
d <- data.frame(face = paste0(s3url,faces), stringsAsFactors = FALSE)

# Bulk Create HITs
bulk <- 
BulkCreateFromTemplate(template = "mturk.html",
                       frame.height = 550,
                       input = d,
                       hit.type = hittype$HITTypeId,
                       expiration = seconds(days=7),
                       assignments = 5, # 5 assignments/face
                       annotation = "Face Categorization 2015-06-08")

do.call(rbind, bulk)
##                         HITTypeId                          HITId Valid
## 1  3ES7ZYWJECPCXMRPI985M23J088HCR 33K3E8REWWFNIIT8C9463M21Y0I8XV  TRUE
## 2  3ES7ZYWJECPCXMRPI985M23J088HCR 3L2OEKSTW9UCINJIH5Q8M09A06C8Y1  TRUE
## 3  3ES7ZYWJECPCXMRPI985M23J088HCR 3M67TQBQQH8B0A4P6RI6JAMEHLRA9I  TRUE
## 4  3ES7ZYWJECPCXMRPI985M23J088HCR 3087LXLJ6M0O07XKHBL540WCBXAF0O  TRUE
## 5  3ES7ZYWJECPCXMRPI985M23J088HCR 3Z8UJEJOCZXBGP54XC3WW288BBZ93L  TRUE
## 6  3ES7ZYWJECPCXMRPI985M23J088HCR 3ZURAPD2887O7WI2DUP5I5FMGPGF1R  TRUE
## 7  3ES7ZYWJECPCXMRPI985M23J088HCR 3NI0WFPPI90SHE49GII1AUJZIY760C  TRUE
## 8  3ES7ZYWJECPCXMRPI985M23J088HCR 3PUV2Q8SV4OSMAMYOLN40HPAQORDBX  TRUE
## 9  3ES7ZYWJECPCXMRPI985M23J088HCR 3Q2T3FD0ONSQN9OYML711OESBA63ME  TRUE
## 10 3ES7ZYWJECPCXMRPI985M23J088HCR 3M4KL7H8KV7SO3PRC1M1OZ29NQD61F  TRUE
                       
# HIT Status
HITStatus(annotation = "Face Categorization 2015-06-08")
## 10 HITs Retrieved
##                           HITId ReviewStatus Pending Available Completed           Expiration
##  3087LXLJ6M0O07XKHBL540WCBXAF0O  NotReviewed       0         5         0 2015-11-17T17:01:17Z
##  33K3E8REWWFNIIT8C9463M21Y0I8XV  NotReviewed       0         5         0 2015-11-17T17:01:10Z
##  3L2OEKSTW9UCINJIH5Q8M09A06C8Y1  NotReviewed       0         5         0 2015-11-17T17:01:11Z
##  3M4KL7H8KV7SO3PRC1M1OZ29NQD61F  NotReviewed       0         5         0 2015-11-17T17:01:22Z
##  3M67TQBQQH8B0A4P6RI6JAMEHLRA9I  NotReviewed       0         5         0 2015-11-17T17:01:13Z
##  3NI0WFPPI90SHE49GII1AUJZIY760C  NotReviewed       0         5         0 2015-11-17T17:01:19Z
##  3PUV2Q8SV4OSMAMYOLN40HPAQORDBX  NotReviewed       0         5         0 2015-11-17T17:01:20Z
##  3Q2T3FD0ONSQN9OYML711OESBA63ME  NotReviewed       0         5         0 2015-11-17T17:01:21Z
##  3Z8UJEJOCZXBGP54XC3WW288BBZ93L  NotReviewed       0         5         0 2015-11-17T17:01:18Z
##  3ZURAPD2887O7WI2DUP5I5FMGPGF1R  NotReviewed       0         5         0 2015-11-17T17:01:19Z
##  ------------------------------ ------------ ------- --------- --------- --------------------
##                          Totals                    0        50         0                     

# Approve Assignments
# THIS LINE WILL PRODUCE AN ERROR BECAUSE NO ASSIGNMENTS WILL HAVE BEEN SUBMITTED
approved <- ApproveAllAssignments(annotation = "Face Categorization 2015-06-08", verbose = FALSE)

# retrieve results as data.frame
# THIS WILL BE EMPTY BECAUSE NO ASSIGNMENTS WILL HAVE BEEN SUBMITTED
a <- GetAssignments(annotation = "Face Categorization 2015-06-08")
a
## 0 of 0 Assignments Retrieved
##  [1] AssignmentId          WorkerId              HITId                 AssignmentStatus      AutoApprovalTime      AcceptTime           
##  [7] SubmitTime            ApprovalTime          RejectionTime         RequesterFeedback     ApprovalRejectionTime SecondsOnHIT         
## <0 rows> (or 0-length row.names)

# For purposes of reproducibility, read in actual data from local copy
a <- readRDS("FacialCompetence.RDS")
str(a)
## 'data.frame':   27670 obs. of  25 variables:
##  $ AssignmentId         : Factor w/ 27670 levels "38YMOXR4MUZ4AATF57UQP920QY0W6N",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ WorkerId             : Factor w/ 225 levels "A12LI6GAHU6S2H",..: 5 4 3 1 2 3 6 4 7 2 ...
##  $ HITId                : chr  "301KG0KX9CLV8ZHVX3QLA9FEXL32H9" "301KG0KX9CLV8ZHVX3QLA9FEXL32H9" "301KG0KX9CLV8ZHVX3QLA9FEXL32H9" "301KG0KX9CLV8ZHVX3QLA9FEXL32H9" ...
##  $ AssignmentStatus     : Factor w/ 1 level "Submitted": 1 1 1 1 1 1 1 1 1 1 ...
##  $ AutoApprovalTime     : Factor w/ 5660 levels "2015-06-10T09:29:45Z",..: 3 1 4 5 2 9 7 8 10 6 ...
##  $ AcceptTime           : Factor w/ 5653 levels "2015-06-08T09:29:40Z",..: 3 1 4 5 2 9 7 8 10 6 ...
##  $ SubmitTime           : Factor w/ 5660 levels "2015-06-08T09:29:45Z",..: 3 1 4 5 2 9 7 8 10 6 ...
##  $ ApprovalTime         : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
##  $ RejectionTime        : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
##  $ RequesterFeedback    : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
##  $ ApprovalRejectionTime: int  NA NA NA NA NA NA NA NA NA NA ...
##  $ SecondsOnHIT         : num  4 5 5 6 4 5 5 3 3 5 ...
##  $ competent            : chr  "4" "2" "0" "6" ...
##  $ recognized           : chr  "0" "0" "0" "0" ...
##  $ name                 : chr  "" "" "" "" ...
##  $ face                 : chr  "https://s3.amazonaws.com/mturkfaces/Google_1_Ernest Swisher_9_oval.jpg" "https://s3.amazonaws.com/mturkfaces/Google_1_Ernest Swisher_9_oval.jpg" "https://s3.amazonaws.com/mturkfaces/Google_1_Ernest Swisher_9_oval.jpg" "https://s3.amazonaws.com/mturkfaces/Google_1_Ernest Swisher_9_oval.jpg" ...
##  $ condition            : chr  "politician" "person" "politician" "politician" ...
##  $ browser              : chr  "Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101 Firefox/38.0" "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0) Gecko/20100101 Firefox/38.0" "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.30 Safari/537.36" ...
##  $ engine               : chr  "Gecko" "Gecko" "Gecko" "Gecko" ...
##  $ platform             : chr  "Win32" "Win32" "MacIntel" "Win32" ...
##  $ language             : chr  "en-US" "en-US" "en-US" "en-US" ...
##  $ width                : chr  "1280" "1920" "1920" "1366" ...
##  $ height               : chr  "800" "1080" "1080" "768" ...
##  $ resolution           : chr  "24" "24" "24" "24" ...
##  $ problem              : chr  NA NA NA NA ...

# Reproduce analysis reported in manuscript
competence <- as.numeric(a$competent)
politician <- as.numeric(grepl("[[:digit:]]{2}-[[:digit:]]{3}", a$face))
round(prop.table(table(politician, competence), 1), 2)
##           competence
## politician    0    1    2    3    4    5    6    7    8    9   10
##          0 0.03 0.03 0.04 0.07 0.11 0.13 0.17 0.17 0.16 0.06 0.02
##          1 0.01 0.01 0.02 0.04 0.07 0.12 0.19 0.20 0.22 0.09 0.04
wilcox.test(competence ~ politician)
## 
##         Wilcoxon rank sum test with continuity correction
## 
## data:  competence by politician
## W = 26886000, p-value < 2.2e-16
## alternative hypothesis: true location shift is not equal to 0
kruskal.test(competence ~ politician)
## 
##         Kruskal-Wallis rank sum test
## 
## data:  competence by politician
## Kruskal-Wallis chi-squared = 271.82, df = 1, p-value < 2.2e-16
t.test(competence ~ politician)
## 
##         Welch Two Sample t-test
## 
## data:  competence by politician
## t = -18.748, df = 3473.2, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.8456886 -0.6855561
## sample estimates:
## mean in group 0 mean in group 1 
##        5.741885        6.507508

# Cleanup
disable <- DisableHIT(annotation = "Face Categorization 2015-06-08")
## 1: HIT 3087LXLJ6M0O07XKHBL540WCBXAF0O Disabled
## 2: HIT 33K3E8REWWFNIIT8C9463M21Y0I8XV Disabled
## 3: HIT 3L2OEKSTW9UCINJIH5Q8M09A06C8Y1 Disabled
## 4: HIT 3M4KL7H8KV7SO3PRC1M1OZ29NQD61F Disabled
## 5: HIT 3M67TQBQQH8B0A4P6RI6JAMEHLRA9I Disabled
## 6: HIT 3NI0WFPPI90SHE49GII1AUJZIY760C Disabled
## 7: HIT 3PUV2Q8SV4OSMAMYOLN40HPAQORDBX Disabled
## 8: HIT 3Q2T3FD0ONSQN9OYML711OESBA63ME Disabled
## 9: HIT 3Z8UJEJOCZXBGP54XC3WW288BBZ93L Disabled
## 10: HIT 3ZURAPD2887O7WI2DUP5I5FMGPGF1R Disabled
disable
##                             HITId Valid
## 1  3087LXLJ6M0O07XKHBL540WCBXAF0O  TRUE
## 2  33K3E8REWWFNIIT8C9463M21Y0I8XV  TRUE
## 3  3L2OEKSTW9UCINJIH5Q8M09A06C8Y1  TRUE
## 4  3M4KL7H8KV7SO3PRC1M1OZ29NQD61F  TRUE
## 5  3M67TQBQQH8B0A4P6RI6JAMEHLRA9I  TRUE
## 6  3NI0WFPPI90SHE49GII1AUJZIY760C  TRUE
## 7  3PUV2Q8SV4OSMAMYOLN40HPAQORDBX  TRUE
## 8  3Q2T3FD0ONSQN9OYML711OESBA63ME  TRUE
## 9  3Z8UJEJOCZXBGP54XC3WW288BBZ93L  TRUE
## 10 3ZURAPD2887O7WI2DUP5I5FMGPGF1R  TRUE

### END ###
