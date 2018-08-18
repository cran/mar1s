\name{compose.mar1s}
\alias{compose.mar1s}
\alias{decompose.mar1s}
\title{ Compose and Decompose MAR(1)S Process }
\description{
  \code{compose.mar1s} composes MAR(1)S process realization by given
  vector of log-innovations.
  
  \code{decompose.mar1s} extracts MAR(1)S process components from time
  series.
}
\usage{
compose.mar1s(object, loginnov, start.time = head(time(loginnov), 1),
              xreg.absdata = NULL, init.absdata = NULL)

decompose.mar1s(object, absdata, start.time = head(time(absdata), 1),
                init.absdata = rep(NA, NCOL(absdata)))
}
\arguments{
  \item{object}{
    An object of class \code{"mar1s"} specifying the model parameters.
  }
  \item{loginnov}{
    A univariate time series containing the log-innovations.
  }
  \item{absdata}{
    A univariate or multivariate time series containing the process
    realization.
  }
  \item{start.time}{
    The sampling time for the first simulation step.
  }
  \item{xreg.absdata}{
    A matrix-like object with row count = \code{n.ahead}, specifying the
    values for the external regressors. If \code{NULL}, default values
    are used.
  }
  \item{init.absdata}{
    A vector specifying the initial values of the process. If
    \code{NULL}, default values are used.
  }
}
\details{
  \dfn{Multiplicative AR(1) with Seasonal (MAR(1)S) process} is defined
  as
  
  \deqn{x_t = exp(s_t + y_t)}{%
    \code{x[t] = exp(s[t] + y[t])}}
  
  \deqn{y_{t, 1} = b_1 y_{t, 2} + \dots + b_k y_{t, k + 1} + z_t}{%
    \code{y[t, 1] = b[1]*y[t, 2] + \dots + b[k]*y[t, k + 1] + z[t]}}

  \deqn{z_t = a z_{t-1} + e_t}{%
    \code{z[t] = a*z[t-1] + e[t]}}

  where
  
  \eqn{s_t}{s[t]} is the log-seasonal component,
  
  \eqn{y_t}{y[t]} is the AR(1) (log-stochastic) component,
  
  \eqn{e_t}{e[t]} is the log-residuals (random component).
}
\value{
  \item{absdata}{
    Realization of the process (a univariate or multivariate time series
    object).
  }
  \item{logdata}{
    Logarithm of \code{absdata} (a univariate or multivariate time
    series object).
  }
  \item{logstoch}{
    Log-stochastic component (a univariate or multivariate time series
    object).
  }
  \item{logresid}{
    Random component (a univariate time series object).
  }
}
\note{
  \code{decompose.mar1s} and \code{fit.mar1s} compute the random
  component in different ways: \code{decompose.mar1s} uses \code{filter}
  while \code{fit.mar1s} saves the residuals returned by \code{arima}.
  The results may be different in:
  \describe{%
    \item{the first value:}{\code{decompose.mar1s} uses specified
      \code{init.absdata} while \code{arima} always assumes zero initial
      values for the fitted process;}
    \item{non-finite values:}{\code{decompose.mar1s} handles non-finite
      values more accurately.}
  }
}
\seealso{
  \code{\link{compose.ar1}} for the AR(1) with external regressors
  processes, \code{\link{fit.mar1s}} for fitting MAR(1)S process to
  data, \code{\link{sim.mar1s}} for MAR(1)S process simulation and
  prediction.
}
\examples{
data(forest.fire, package = "mar1s")
data(nesterov.index, package = "mar1s")

## Simple
mar1s <- fit.mar1s(window(forest.fire, 1969, 1989))

x <- ts(rnorm(365, sd = mar1s$logresid.sd), start = c(1989, 1))
plot(compose.mar1s(mar1s, x)$absdata)

decomp <- decompose.mar1s(mar1s, mar1s$decomposed$absdata)
delta <- abs(nan2na(mar1s$decomposed$logresid) -
             nan2na(decomp$logresid))
stopifnot(all(na.exclude(tail(delta, -1)) < 1E-6))

## External regressors
mar1s <- fit.mar1s(window(forest.fire, 1969, 1989),
                   window(nesterov.index[, "mean"], 1969, 1989))

x <- rnorm(365, sd = mar1s$logresid.sd)
xreg <- window(nesterov.index[, "mean"], 1989.001, 1990)
plot(compose.mar1s(mar1s, x, c(1989, 1), xreg)$absdata)

decomp <- decompose.mar1s(mar1s, mar1s$decomposed$absdata)
delta <- abs(mar1s$decomposed$logstoch - decomp$logstoch)
stopifnot(all(na.exclude(delta) < 1E-6))
delta <- abs(nan2na(mar1s$decomposed$logresid) -
             nan2na(decomp$logresid))
stopifnot(all(na.exclude(tail(delta, -1)) < 1E-6))
}
\keyword{ models }
\keyword{ multivariate }
\keyword{ ts }
