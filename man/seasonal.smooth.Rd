\name{seasonal.smooth}
\alias{seasonal.smooth}
\title{ Smooth Seasonal Component of Time Series }
\description{
  Extracts seasonal component of time series by fitting the data with a
  linear combination of smooth periodic functions.
}
\usage{
seasonal.smooth(x, basis = create.fourier.basis(nbasis = 3), lambda = 0, ...)
}
\arguments{
  \item{x}{
    A univariate time series.
  }
  \item{basis}{
    A functional basis object (see \code{\link[fda]{basisfd}}). By
    default, use a linear combination of \code{const},
    \code{sin((2*pi)*t)} and \code{cos((2*pi)*t)}.
  }  
  \item{lambda}{
    A nonnegative number specifying the amount of smoothing. By default,
    apply no additional smoothing.
  }  
  \item{\dots}{
    Not currently used.
  }
}
\details{
  Although it is possible to specify arbitrary functional basis object,
  the function will only work properly if the basis is periodical on the
  unit interval. It is recommended to use a Fourier basis with default
  period (\code{\link[fda]{create.fourier.basis}}).

  Positive values of \code{lambda} imply a restriction on roughness of
  the result. The more the value, the more smooth result is; see
  \code{\link[fda]{smooth.basis}} for more detailed description.
}
\value{
  A time series object with times from 0 to 1 and the same frequency as
  \code{x}. The smoothing functional data object is stored in attribute
  \code{fd}.
}
\seealso{
  \code{\link[fda]{smooth.basisPar}}, \code{\link[fda]{fd}} for
  functional data objects, \code{\link{seasonal.ave}} for alternative
  seasonal extraction method.
}
\examples{
set.seed(19860306)

## Artificial example
x <- ts(sin(2*pi*(3:97)/10) + 0.5*rnorm(length(3:97)),
	start = c(0, 3), frequency = 10)

fourier3 <- seasonal.smooth(x)
fourier9 <- seasonal.smooth(x, create.fourier.basis(nbasis = 9))
fourier9s<- seasonal.smooth(x, create.fourier.basis(nbasis = 9), 1E-6)

plot.default(time(x)\%\%1, x, xlab = "Phase")
points(fourier3, pch = 20,  col = "blue")
lines(attr(fourier3, "fd"), col = "blue")
points(fourier9, pch = 20,  col = "green")
lines(attr(fourier9, "fd"), col = "green")
points(fourier9s,pch = 20,  col = "red")
lines(attr(fourier9s, "fd"),col = "red")
legend("bottomleft",
       legend = c("Fourier-3 basis",
		  "Fourier-9 basis",
		  "Fourier-9 basis, smooth"),
       col = c("blue", "green", "red"),
       lty = "solid")

## Realistic example
data(nesterov.index, package = "mar1s")
x <- log(nesterov.index[, "mean"])
x[x < -10] <- -Inf

fourier3 <- seasonal.smooth(x)
fourier9 <- seasonal.smooth(x, create.fourier.basis(nbasis = 9))
fourier9s<- seasonal.smooth(x, create.fourier.basis(nbasis = 9), 2E-5)

plot.default(time(x)\%\%1, x, xlab = "Phase", pch = ".")
lines(attr(fourier3, "fd"), col = "blue")
lines(attr(fourier9, "fd"), col = "green")
lines(attr(fourier9s,"fd"), col = "red")
legend("topleft",
       legend = c("Fourier-3 basis",
		  "Fourier-9 basis",
		  "Fourier-9 basis, smooth"),
       col = c("blue", "green", "red"),
       lty = "solid")
}
\keyword{ ts }
