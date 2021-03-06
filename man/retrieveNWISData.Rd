\name{retrieveNWISData}
\alias{retrieveNWISData}
\title{Raw Data Import for USGS NWIS Data}
\usage{
  retrieveNWISData(siteNumber, ParameterCd, StartDate,
    EndDate, StatCd = "00003", interactive = TRUE)
}
\arguments{
  \item{siteNumber}{string USGS site number.  This is
  usually an 8 digit number}

  \item{ParameterCd}{string USGS parameter code.  This is
  usually an 5 digit number.}

  \item{StartDate}{string starting date for data retrieval
  in the form YYYY-MM-DD.}

  \item{EndDate}{string ending date for data retrieval in
  the form YYYY-MM-DD.}

  \item{StatCd}{string USGS statistic code. This is usually
  5 digits.  Daily mean (00003) is the default.}

  \item{interactive}{logical Option for interactive mode.
  If true, there is user interaction for error handling and
  data checks.}
}
\value{
  data dataframe with agency, site, dateTime, value, and
  code columns
}
\description{
  Imports data from NWIS web service. This function gets
  the data from here: \url{http://waterservices.usgs.gov/}
  A list of parameter codes can be found here:
  \url{http://nwis.waterdata.usgs.gov/nwis/pmcodes/} A list
  of statistic codes can be found here:
  \url{http://nwis.waterdata.usgs.gov/nwis/help/?read_file=stat&format=table}
}
\examples{
# These examples require an internet connection to run
siteNumber <- '04085427'
startDate <- '2012-01-01'
endDate <- '2012-06-30'
pCode <- "00060"
rawDailyQ <- retrieveNWISData(siteNumber,pCode, startDate, endDate)
rawDailyTemperature <- retrieveNWISData(siteNumber,'00010', startDate, endDate, StatCd='00001',interactive=FALSE)
rawDailyQAndTempMeanMax <- retrieveNWISData(siteNumber,'00010,00060', startDate, endDate, StatCd='00001,00003', interactive=FALSE)
}
\keyword{USGS}
\keyword{data}
\keyword{import}
\keyword{service}
\keyword{web}

