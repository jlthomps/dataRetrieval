#' Populate Daily data frame
#'
#' Using raw data that has at least dateTime, value, code, populates the rest of the basic Daily data frame used in WRTDS
#'
#' @param rawData dataframe contains at least dateTime, value, code columns
#' @param qConvert string conversion to cubic meters per second
#' @param interactive logical Option for interactive mode.  If true, there is user interaction for error handling and data checks.
#' @keywords WRTDS flow
#' @author Robert M. Hirsch \email{rhirsch@@usgs.gov}
#' @import zoo
#' @return dataframe Daily
#' @export
#' @examples
#' dateTime <- c('1985-01-01', '1985-01-02', '1985-01-03')
#' value <- c(1,2,3)
#' code <- c("","","")
#' dataInput <- data.frame(dateTime, value, code, stringsAsFactors=FALSE)
#' Daily <- populateDaily(dataInput, 2, interactive=FALSE)
populateDaily <- function(rawData,qConvert,interactive=TRUE){  # rawData is a dataframe with at least dateTime, value, code
  localDaily <- as.data.frame(matrix(ncol=2,nrow=length(rawData$value)))
  colnames(localDaily) <- c('Date','Q')
  localDaily$Date <- rawData$dateTime
  
  # need to convert to cubic meters per second to store the values
  localDaily$Q <- rawData$value/qConvert
  
  dateFrame <- populateDateColumns(rawData$dateTime)
  localDaily <- cbind(localDaily, dateFrame[,-1])
  
  localDaily$Date <- as.Date(localDaily$Date)
  
  if(length(rawData$code) != 0) localDaily$Qualifier <- rawData$code
  
  localDaily$i <- 1:nrow(localDaily)
  
  noDataValue <- -999999
  nd<-ifelse(localDaily$Q==noDataValue,T,F)
  localDaily$Q<-ifelse(nd,NA,localDaily$Q)
  
  zeros<-which(localDaily$Q<=0)
  
  nz<-length(zeros)
  
  if(nz>0) qshift<-0.001*mean(localDaily$Q, na.rm=TRUE) else qshift<-0.0
  
  localDaily$Q<-localDaily$Q+qshift
  
  localDaily$LogQ <- log(localDaily$Q)
  
  Qzoo<-zoo(localDaily$Q)
  
  if (length(rawData$dateTime) < 30){
    if (interactive){
      cat("This program requires at least 30 data points. You have only provided:", length(rawData$dateTime),"Rolling means will not be calculated.\n")
    }
    warning("This program requires at least 30 data points. Rolling means will not be calculated.")
  } else {
    localDaily$Q7<-as.numeric(rollapply(Qzoo,7,mean,na.rm=FALSE,fill=NA,align="right"))
    localDaily$Q30<-as.numeric(rollapply(Qzoo,30,mean,na.rm=FALSE,fill=NA,align="right"))    
  }
  
  dataPoints <- nrow(localDaily)
  difference <- (localDaily$Julian[dataPoints] - localDaily$Julian[1])+1  
  if (interactive){
    cat("There are ", as.character(dataPoints), "data points, and ", as.character(difference), "days.\n")
    cat("There are ",as.character(nz), "zero flow days\n")
    cat("If there are any zero discharge days, all days had",as.character(qshift),"cubic meters per second added to the discharge value.\n")
    #these next two lines show the user where the gaps in the data are if there are any
    n<-nrow(localDaily)
    for(i in 2:n) {if((localDaily$Julian[i]-localDaily$Julian[i-1])>1) cat("\n discharge data jumps from",as.character(localDaily$Date[i-1]),"to",as.character(localDaily$Date[i]))}
  }
  
  return (localDaily)  
}