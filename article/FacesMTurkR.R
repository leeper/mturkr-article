library("MTurkR")

# not sandbox
options(MTurkR.sandbox = FALSE)

# Qualification Requirements (US, 95% approval)
qual <- GenerateQualificationRequirement(c("Locale", "Approved"), c("==", ">"), c("US", 95), preview = TRUE)

# register HITType
hittype <- 
RegisterHITType(title = "Rate the competence of a person",
                description = "Judge the competence of a person from an image of their face. The HIT involves only one question: a rating of the competence of the person. You have 45 seconds to complete the HIT. There are several thousand HITs available in this batch. If you recognize the person, please enter their name in the space provided; your work will still be approved even if you recognize the face.",
                reward = "0.01",
                duration = seconds(seconds = 45), 
                auto.approval.delay = seconds(days = 2),
                qual.req = qual,
                keywords = "categorization, photo, image, rate, rating, face, judgment, batch, quick, fast, easy, competent")

# create test HIT
testhit <- 
CreateHIT(hit.type = hittype$HITTypeId, 
          question = GenerateHTMLQuestion(file = "mturk.html", frame.height = "600")$string, 
          expiration = seconds(days = 7), 
          assignments = 20,
          validate.question = TRUE,
          annotation = 'Face Categorization Test')

# Bulk Create
s3url <- "https://s3.amazonaws.com/mturkfaces/"
faces <- readRDS("mturkfaceorder.RDS")

bulk <- 
BulkCreateFromTemplate(template = "facetemplate.html",
                       frame.height = 550,
                       input = data.frame(face = paste0(s3url,faces), stringsAsFactors = FALSE),
                       hit.type = hittype$HITTypeId,
                       expiration = seconds(days=7),
                       assignments = 5, # 5 assignments/face
                       annotation = paste("Face Categorization", Sys.Date())
                       )

# HIT Status
HITStatus(annotation = "Face Categorization 2015-06-08")

# Approve Assignments
approved <- ApproveAllAssignments(annotation = "Face Categorization 2015-06-08", verbose = FALSE)

# retrieve results as data.frame
a <- GetAssignments(annotation = "Face Categorization 2015-06-08")
saveRDS(a, "FacialCompetence.RDS")

### END ###
