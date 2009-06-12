\name{sim.mar1s}
\alias{sim.mar1s}
\alias{predict.mar1s}
\title{ Simulate from MAR(1)S Process }
\description{
  \code{sim.mar1s} simulates from MAR(1)S process.

  \code{predict.mar1s} is a wrapper around \code{sim.mar1s} which
  estimates confidence intervals for the future values of the MAR(1)S
  process.
}
\usage{
sim.mar1s(object, n.ahead = 1, n.sim = 1, start.time = 0,
          xreg.absdata = NULL, init.absdata = NULL)

\method{predict}{mar1s}(object, n.ahead = 1, start.time = 0,
        xreg.absdata = NULL, init.absdata = NULL,
        probs = c(0.05, 0.5, 0.95), n.sim = 1000, ...)}
\arguments{
  \item{object}{
    An object of class \code{"mar1s"} specifying the model parameters.
  }
  \item{n.ahead}{
    Number of steps ahead at which to simulate/predict.
  }
  \item{n.sim}{
    Number of simulations.
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
  \item{probs}{
    A vector of probabilities.
  }
  \item{\dots}{
    Arguments from previous methods.
  }
}
\value{
  For \code{sim.mar1s}, a vector of simulated values.

  For \code{predict.mar1s}, a vector of estimated quantiles.
}
\seealso{
  \code{\link{compose.mar1s}} for MAR(1)S process formal definition and
  composition/decomposition functions, \code{\link{fit.mar1s}} for
  fitting MAR(1)S process to data.
}
\examples{
data(forest.fire, package = "mar1s")
data(nesterov.index, package = "mar1s")

## Univariate
mar1s <- fit.mar1s(forest.fire)

sim.mar1s(mar1s)
sim.mar1s(mar1s, n.sim = 6)
sim.mar1s(mar1s, n.ahead = 3)

predict(mar1s)
predict(mar1s, n.ahead = 10)
predict(mar1s, init.absdata = 100)

t <- seq(1/12, 11/12, 1/6) 
p <- mapply(predict, start.time = t,
            MoreArgs = list(object = mar1s, probs = c(0.05, 0.95)))
plot(exp(mar1s$logseasonal), ylim = c(0, max(p)),
     ylab = "Forest fire")
arrows(t, p[1, ], t, p[2, ],
       code = 3, angle = 90, length = 0.05)

## External regressors
mar1s <- fit.mar1s(forest.fire, nesterov.index[, "mean"])

sim.mar1s(mar1s)
sim.mar1s(mar1s, n.sim = 6)

predict(mar1s)
predict(mar1s, xreg.absdata = 10000)
predict(mar1s, init.absdata = c(100, 1000))
}
\keyword{ models }
\keyword{ multivariate }
\keyword{ ts }
