\name{forest.fire}
\alias{forest.fire}
\docType{data}
\title{ Forest fire in Irkutsk region, USSR: historical data }
\description{
  Number of forest fire seats in Irkutsk region, USSR. Daily from April
  01 to October 31, 1969--1991 (total 4708 observations).
}
\usage{data(forest.fire)}
\format{
  A univariate time series.
}
\source{
  AviaLesoOkhrana (\url{http://www.nffc.aviales.ru/engl/main.sht}).
}
\examples{
data(forest.fire)
colnames(forest.fire)
plot(forest.fire)
}
\keyword{datasets}
