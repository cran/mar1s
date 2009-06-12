\name{fit.mar1s}
\alias{fit.mar1s}
\title{ Fit Multiplicative AR(1) with Seasonal Process to Data }
\description{
  Fits Multiplicative AR(1) with Seasonal process model to time series.
}
\usage{
fit.mar1s(x, xreg = NULL, seasonal.fun = seasonal.smooth, ...)
}
\arguments{
  \item{x}{
    A univariate time series.
  }
  \item{xreg}{
    A univariate or multivariate time series of external regressors, or
    \code{NULL}.
  }
  \item{seasonal.fun}{
    A function which takes a univariate time series as its first
    argument and returns the estimated seasonal component.
  }
  \item{\dots}{
    Additional arguments passed to \code{seasonal.fun}.
  }
}
\value{
  An object of class \code{"mar1s"} with the following components:
  \item{logseasonal}{
    Estimated log-seasonal figure (a univariate or multivariate time
    series object).
  }
  \item{logstoch.ar1}{
    AR(1) with external regressors model fitted for the log-stochastic
    component (an object of class \code{"Arima"}).
  }
  \item{logresid.sd}{
    Standard deviation of the residuals.
  }
  \item{decomposed}{
    An object of class \code{"mar1s.ts"} containing decomposed time
    series (see \code{\link{compose.mar1s}}).
  }
}
\seealso{
  \code{\link{compose.mar1s}} for MAR(1)S process formal definition and
  composition/decomposition functions, \code{\link{seasonal.ave}},
  \code{\link{seasonal.smooth}} for seasonal component extraction
  functions, \code{\link{sim.mar1s}} for MAR(1)S process simulation and
  prediction.
}
\examples{
data(forest.fire, package = "mar1s")
data(nesterov.index, package = "mar1s")

## Simple
mar1s <- fit.mar1s(forest.fire)
plot(mar1s$logseasonal)
confint(mar1s$logstoch.ar1)
mar1s$logresid.sd
resid <- nan2na(mar1s$decomposed$logresid)
qqnorm(resid)
qqline(resid)

## External regressors
mar1s <- fit.mar1s(forest.fire, nesterov.index[, "mean"])
plot(cbind(mar1s$logseasonal, mar1s$logseasonal.r))
confint(mar1s$logstoch.ar1)
resid <- nan2na(mar1s$decomposed$logresid)
qqnorm(resid)
qqline(resid)
}
\keyword{ models }
\keyword{ multivariate }
\keyword{ ts }
