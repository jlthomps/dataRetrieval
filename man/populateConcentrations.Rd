\name{populateConcentrations}
\alias{populateConcentrations}
\title{Populate Concentration Columns}
\usage{
  populateConcentrations(rawData)
}
\arguments{
  \item{rawData}{vector with value and code columns}
}
\value{
  concentrationColumns dataframe
}
\description{
  Creates ConcLow, ConcHigh, Uncen (0 if censored, 1 if
  uncensored) columns for Sample data frame for WRTDS
  study.
}
\examples{
code <- c("","<","")
value <- c(1,2,3)
dataInput <- data.frame(value, code, stringsAsFactors=FALSE)
concentrationDF <- populateConcentrations(dataInput)
}

