\name{nesterov.index}
\alias{nesterov.index}
\docType{data}
\title{ Nesterov index in Irkutsk region, USSR: historical data }
\description{
  Values of Nesterov index in 6 distincts of Irkutsk region, USSR +
  region averaged. Daily from April 01 to October 31, 1969--1991 (total
  4708 observations).
}
\usage{data(nesterov.index)}
\format{
  A multivariate time series.
}
\details{
  The Nesterov index is the official Russian fire-danger rating
  specified by standard GOST R 22.1.09--99. It is calculated using the
  ignition index, the temperature, the dew-point temperature and the
  number of days since last significant (\eqn{\ge 3 mm}) precipitation.

  The dataset consists of daily values 1969--1991.
}
\source{
  Russian Institute of Hydrometeorogical Information--World Data Center
  (\url{http://meteo.ru/english/}).
}
\examples{
data(nesterov.index)
colnames(nesterov.index)
plot(nesterov.index)
}
\keyword{datasets}
