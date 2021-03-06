% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stat_weighted_mean.R
\docType{data}
\name{stat_weighted_mean}
\alias{stat_weighted_mean}
\alias{StatWeightedMean}
\title{Compute weighted y mean}
\usage{
stat_weighted_mean(
  mapping = NULL,
  data = NULL,
  geom = "point",
  position = "identity",
  ...,
  na.rm = FALSE,
  orientation = NA,
  show.legend = NA,
  inherit.aes = TRUE
)
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link[ggplot2:aes]{aes()}} or
\code{\link[ggplot2:aes_]{aes_()}}. If specified and \code{inherit.aes = TRUE} (the
default), it is combined with the default mapping at the top level of the
plot. You must supply \code{mapping} if there is no plot mapping.}

\item{data}{The data to be displayed in this layer. There are three
options:

If \code{NULL}, the default, the data is inherited from the plot
data as specified in the call to \code{\link[ggplot2:ggplot]{ggplot()}}.

A \code{data.frame}, or other object, will override the plot
data. All objects will be fortified to produce a data frame. See
\code{\link[ggplot2:fortify]{fortify()}} for which variables will be created.

A \code{function} will be called with a single argument,
the plot data. The return value must be a \code{data.frame}, and
will be used as the layer data. A \code{function} can be created
from a \code{formula} (e.g. \code{~ head(.x, 10)}).}

\item{geom}{Use to override the default connection between
\code{geom_histogram()}/\code{geom_freqpoly()} and \code{stat_bin()}.}

\item{position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{...}{Other arguments passed on to \code{\link[ggplot2:layer]{layer()}}. These are
often aesthetics, used to set an aesthetic to a fixed value, like
\code{colour = "red"} or \code{size = 3}. They may also be parameters
to the paired geom/stat.}

\item{na.rm}{If \code{FALSE}, the default, missing values are removed with
a warning. If \code{TRUE}, missing values are silently removed.}

\item{orientation}{The orientation of the layer. The default (\code{NA})
automatically determines the orientation from the aesthetic mapping. In the
rare event that this fails it can be given explicitly by setting \code{orientation}
to either \code{"x"} or \code{"y"}. See the \emph{Orientation} section for more detail.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.
It can also be a named logical vector to finely select the aesthetics to
display.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link[ggplot2:borders]{borders()}}.}
}
\description{
This statistic will compute the mean of \strong{y} aesthetic for
each unique value of \strong{x}, taking into account \strong{weight}
aesthetic if provided.
}
\section{Computed variables}{

\describe{
\item{y}{weighted y (numerator / denominator)}
\item{numerator}{numerator}
\item{denominator}{denominator}
}
}

\examples{
# Small function to display plots only if it's interactive
p_ <- GGally::print_if_interactive

data(tips, package = "reshape")

p_(ggplot(tips) +
  aes(x = day, y = total_bill) +
  geom_point())

p_(ggplot(tips) +
  aes(x = day, y = total_bill) +
  stat_weighted_mean())

p_(ggplot(tips) +
  aes(x = day, y = total_bill, group = 1) +
  stat_weighted_mean(geom = "line"))

p_(ggplot(tips) +
  aes(x = day, y = total_bill, colour = sex, group = sex) +
  stat_weighted_mean(geom = "line"))

p_(ggplot(tips) +
  aes(x = day, y = total_bill, fill = sex) +
  stat_weighted_mean(geom = "bar", position = "dodge"))

# computing a proportion on the fly
p_(ggplot(tips) +
  aes(x = day, y = as.integer(smoker == "Yes"), fill = sex) +
  stat_weighted_mean(geom = "bar", position = "dodge") +
  scale_y_continuous(labels = scales::percent))

# taking into account some weights
d <- as.data.frame(Titanic)
p_(ggplot(d) +
  aes(x = Class, y = as.integer(Survived == "Yes"), weight = Freq, fill = Sex) +
  geom_bar(stat = "weighted_mean", position = "dodge") +
  scale_y_continuous(labels = scales::percent) +
  labs(y = "Survived"))


\dontrun{
cuse <- read.table("https://data.princeton.edu/wws509/datasets/cuse.dat", header = TRUE)
cuse$n <- cuse$notUsing + cuse$using
cuse$prop <- cuse$using / cuse$n

ggplot(cuse) +
  aes(x = education, y = prop, weight = n) +
  stat_weighted_mean()

ggplot(cuse) +
  aes(x = age, y = prop, weight = n, color = education) +
  stat_weighted_mean()

ggplot(cuse) +
  aes(x = education, y = prop, weight = n) +
  stat_weighted_mean(geom = "bar")

# add percentages above each bar
ggplot(cuse) +
  aes(x = age, y = prop, weight = n, fill = education) +
  stat_weighted_mean(geom = "bar") +
  geom_text(aes(label = scales::percent(after_stat(y))), stat = "weighted_mean", vjust = 0) +
  facet_grid(~ education)
}
}
\keyword{datasets}
