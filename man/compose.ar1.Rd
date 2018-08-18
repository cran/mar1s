\name{compose.ar1}
\alias{compose.ar1}
\alias{decompose.ar1}
\title{ Compose and Decompose AR(1) Process }
\description{
  \code{compose.ar1} composes AR(1) process realization by given vector(s)
  of innovations.
  
  \code{decompose.ar1} extracts AR(1) process residuals from time
  series.
}
\usage{
compose.ar1(arcoef, innov, init = 0, xregcoef = 0, xreg = NULL,
            init.xreg = rep(0, length(xregcoef)))

decompose.ar1(arcoef, data, init = NA, xregcoef = 0, xreg = NULL,
              init.xreg = rep(NA, length(xregcoef)))
}
\arguments{
  \item{arcoef}{
    A number specifying autoregression coefficient.
  }
  \item{innov}{
    A univariate or multivariate time series containing the innovations.
  }
  \item{data}{
    A univariate or multivariate time series containing the process
    realization(s).
  }
  \item{init}{
    A number specifying the value of the process just prior to the start
    value in \code{innov}/\code{data}.
  }
  \item{xregcoef}{
    A vector specifying coefficients for the external regressors.
  }
  \item{xreg}{
    A matrix-like object of the same row count as
    \code{innov}/\code{data}, specifying the values of external
    regressors. The default \code{NULL} means zeroes.
  }
  \item{init.xreg}{
    A vector specifying the values of external regressors just prior to
    the start values in \code{xreg}. The default \code{NULL} means
    zeroes.
  }
}
\details{
  Here \dfn{AR(1) process with external regressors} is a linear
  regresson with AR(1) model for the error term:

  \deqn{y_t = b_1 x_{t, 1} + \dots + b_k x_{t, k} + z_t}{%
    \code{y[t] = b[1]*x[t, 1] + \dots + b[k]*x[t, k] + z[t]}}

  \deqn{z_t = a z_{t-1} + e_t}{%
    \code{z[t] = a*z[t-1] + e[t]}}

  Use \code{xreg = NULL} for the regular AR(1) process.
}
\value{
  An object of the same type and dimensions as \code{innov}/\code{data}
  (typically time series).
}
\seealso{
  \code{\link{arima}} for more general \eqn{ARMA(p, q)} processes.
}
\examples{
## Simple
e <- ts(c(0, 1, 0, 1, 0), freq = 12)
compose.ar1(0.1, e)
compose.ar1(0.1, e, 1)

x <- ts(c(0, 1, 0, 1, 0), freq = 12)
decompose.ar1(0.1, x)
decompose.ar1(0.1, x, 1)

## Multiseries
compose.ar1(0.1, ts(cbind(0, 1)))
compose.ar1(0.1, ts(cbind(c(0, 1, 0), c(1, 0, 1))))

decompose.ar1(0.1, ts(cbind(0, 1)))
decompose.ar1(0.1, ts(cbind(c(0, 1, 0), c(1, 0, 1))))

## External regressors
xreg1 <- rep(2, 5)
xreg2 <- matrix(rep(c(2, 1), each = 5), 5, 2)
e <- ts(c(0, 1, 0, 1, 0), freq = 12)
compose.ar1(0.1, e, xregcoef = 0.5, xreg = xreg1)
compose.ar1(0.1, e, xregcoef = 0.5, init = 0, xreg = xreg1, init.xreg = -2)
compose.ar1(0.1, e, xregcoef = c(1, -1), xreg = xreg2)

x <- ts(c(0, 1, 0, 1, 0), freq = 12)
decompose.ar1(0.1, x, xregcoef = 0.5, xreg = xreg1)
decompose.ar1(0.1, x, xregcoef = 0.5, init = 0, xreg = xreg1, init.xreg = -2)
decompose.ar1(0.1, x, xregcoef = c(1, -1), xreg = xreg2)

## Back-test
a <- 0.5
innov <- ts(rnorm(10), frequency = 12)
init <- 1
xrcoef <- seq(-0.1, 0.1, length.out = 3)
xreg <- matrix(1:30, 10, 3)
init.xreg <- 1:3
x <- compose.ar1(a, innov, init, xrcoef, xreg, init.xreg)
r <- decompose.ar1(a, x, init, xrcoef, xreg, init.xreg)
stopifnot(all.equal(innov, r))
}
\keyword{ models }
\keyword{ multivariate }
\keyword{ ts }
