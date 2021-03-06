\name{dataOverview}
\alias{dataOverview}
\title{Data Overview for WRTDS}
\usage{
  dataOverview(localDaily = Daily, localSample = Sample)
}
\arguments{
  \item{localDaily}{dataframe}

  \item{localSample}{dataframe}
}
\description{
  Gives a summary of data to be used for WRTDS analysis
}
\examples{
# These examples require an internet connection to run
exDaily <- getDVData('01594440','00060', '1985-01-01', '1985-03-31', interactive=FALSE)
exSample <- getSampleData('01594440','01075', '1985-01-01', '1985-03-31', interactive=FALSE)
dataOverview(localDaily = exDaily, localSample = exSample)
}
\seealso{
  \code{\link{mergeReport}}
}
\keyword{USGS}
\keyword{WRTDS}
\keyword{data}
\keyword{import}

