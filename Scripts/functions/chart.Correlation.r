#' correlation matrix chart
#' 
#' Visualization of a Correlation Matrix. On top the (absolute) value of the
#' correlation plus the result of the cor.test as stars. On bottom, the
#' bivariate scatterplots, with a fitted line
#' 
#' 
#' @param R data for the x axis, can take matrix,vector, or timeseries
#' @param histogram TRUE/FALSE whether or not to display a histogram
#' @param method a character string indicating which correlation coefficient
#'           (or covariance) is to be computed.  One of "pearson"
#'           (default), "kendall", or "spearman", can be abbreviated.
#' @param \dots any other passthru parameters into \code{\link{pairs}}
#' @note based on plot at originally found at addictedtor.free.fr/graphiques/sources/source_137.R
#' @author Peter Carl
#' @seealso \code{\link{table.Correlation}}
###keywords ts multivariate distribution models hplot
#' @examples
#' 
#' data(managers)
#' chart.Correlation(managers[,1:8], histogram=TRUE, pch="+")
#' 
#' @export
chart.Correlation <-
  function (R, histogram = TRUE, method=c("pearson", "kendall", "spearman"), raw.p_val=F, rsq=F, ...)
  { # @author R Development Core Team
    # @author modified by Peter Carl
    # Visualization of a Correlation Matrix. On top the (absolute) value of the
    # correlation plus the result of the cor.test as stars. On botttom, the
    # bivariate scatterplots, with a fitted line
    
    x = checkData(R, method="matrix")
    
    if(missing(method)) method=method[1] #only use one
    cormeth <- method
    
    panel.cor <- function(x, y, digits=2, prefix="r2 = ", use="pairwise.complete.obs", method=cormeth, cex.cor, ...)
    {
      usr <- par("usr"); on.exit(par(usr))
      par(usr = c(0, 1, 0, 1))
      r <- cor(x, y, use=use, method=method) # MG: remove abs here
      if(rsq == T){
        r <- r^2
        r <- round(r, 2)
      }
      txt <- format(c(r, 0.123456789), digits=digits)[1]
      txt <- paste(prefix, txt, sep="")
      if(missing(cex.cor)) cex <- 1.1#/strwidth(txt)
      
      test <- cor.test(as.numeric(x),as.numeric(y), method=method)
      # borrowed from printCoefmat
      Signif <- symnum(test$p.value, corr = FALSE, na = FALSE,
                       cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                       symbols = c("***", "**", "*", ".", " "))
      if(raw.p_val == T){
        Signif <- formatC(test$p.value, format = "e", digits = 2)
      }
      
      # MG: add abs here and also include a 30% buffer for small numbers
      #text(0.5, 0.5, txt, cex = cex * (abs(r) + .3) / 1.3)
      text(0.5, 0.6, txt, cex = cex)
      Signif <- paste0('p = ',Signif)
      text(.5, .3, Signif, cex=cex*0.7)
    }
    f <- function(t) {
      dnorm(t, mean=mean(x), sd=sd.xts(x) )
    }
    
    #remove method from dotargs
    dotargs <- list(...)
    dotargs$method <- NULL
    rm(method)
    
    hist.panel = function (x, ...=NULL ) {
      par(new = TRUE)
      hist(x,
           col = "light gray",
           probability = TRUE,
           axes = FALSE,
           main = "",
           breaks = "FD")
      lines(density(x, na.rm=TRUE),
            col = "red",
            lwd = 1)
      #lines(f, col="blue", lwd=1, lty=1) how to add gaussian normal overlay?
      rug(x)
    }
    
    # Draw the chart
    if(histogram)
      pairs(x, gap=0, lower.panel=panel.smooth, upper.panel=panel.cor, diag.panel=hist.panel)
    else
      pairs(x, gap=0, lower.panel=panel.smooth, upper.panel=panel.cor) 
  }