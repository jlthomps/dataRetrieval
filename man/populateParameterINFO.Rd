\name{populateParameterINFO}
\alias{populateParameterINFO}
\title{Populate Parameter Information Columns}
\usage{
  populateParameterINFO(parameterCd, localINFO = INFO,
    interactive = TRUE)
}
\arguments{
  \item{localINFO}{dataframe with value and code columns.
  Default is INFO}

  \item{parameterCd}{string USGS parameter code}

  \item{interactive}{logical Option for interactive mode.
  If true, there is user interaction for error handling and
  data checks.}
}
\value{
  localINFO dataframe
}
\description{
  Populates INFO data frame with additional user-supplied
  information concerning the measured parameter.
}
\examples{
#This example requires an internet connection to run
INFO <- getSiteFileData('01594440')
parameterCd <- "00175"
parameterData <- getParameterInfo(parameterCd,interactive=interactive)
INFO$param.nm <- parameterData$parameter_nm
INFO$param.units <- parameterData$parameter_units
INFO$paramShortName <- parameterData$srsname
INFO$paramNumber <- parameterData$parameter_cd
INFO <- populateParameterINFO(parameterCd,interactive=FALSE)
}

