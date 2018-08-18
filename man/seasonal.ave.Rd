\name{seasonal.ave}
\alias{seasonal.ave}
\title{ Averaged Seasonal Component of Time Series }
\description{
  Extracts seasonal component of time series by averaging observations
  on the same position in the cycle.
}
\usage{
seasonal.ave(x, ave.FUN = mean, ...)
}
\arguments{
  \item{x}{
    A univariate time series.
  }
  \item{ave.FUN}{
    Averaging function.
  }
  \item{\dots}{
    Additional arguments passed to \code{ave.FUN}.
  }
}
\value{
  A time series object with times from 0 to 1 and the same frequency as
  \code{x}.
}
\seealso{
  \code{\link{ave}}, \code{\link{seasonal.smooth}} for alternative
  seasonal extraction method.
}
\examples{
set.seed(19860306)

## Artificial example
x <- ts(sin(2*pi*(3:97)/10) + 0.5*rnorm(length(3:97)),
	start = c(0, 3), frequency = 10)

plot.default(time(x)\%\%1, x, xlab = "Phase")
lines(seasonal.ave(x), col = "blue")
lines(seasonal.ave(x, median), col = "green")
legend("bottomleft",
       legend = c("Mean averaging",
		  "Median averaging"),
       col = c("blue", "green"),
       lty = "solid")

## Realistic example
data(nesterov.index, package = "mar1s")
x <- log(nesterov.index[, "mean"])
x[x < -10] <- -Inf

plot.default(time(x)\%\%1, x, xlab = "Phase", pch = ".")
lines(seasonal.ave(x), col = "blue")
lines(seasonal.ave(x, median), col = "green")
legend("topleft",
       legend = c("Mean averaging",
		  "Median averaging"),
       col = c("blue", "green"),
       lty = "solid")
}
\keyword{ ts }
