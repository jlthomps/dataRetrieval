\name{removeDuplicates}
\alias{removeDuplicates}
\title{Remove Duplicates}
\usage{
  removeDuplicates(localSample = Sample)
}
\arguments{
  \item{localSample}{dataframe with at least DecYear and
  ConcHigh, default name is Sample}
}
\value{
  Sample1 dataframe
}
\description{
  Removes observations from the data frame Sample when the
  observation has the identical date and value as another
  observation
}
\examples{
DecYear <- c('1985.01', '1985.01', '1985.02', '1985.02', '1985.03')
ConcHigh <- c(1,2,3,3,5)
dataInput <- data.frame(DecYear, ConcHigh, stringsAsFactors=FALSE)
removeDuplicates(dataInput)
}

