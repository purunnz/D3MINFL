% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cooks_distance.R
\name{cooks_distance}
\alias{cooks_distance}
\title{Custom Cook's Distance Measure}
\usage{
cooks_distance(model)
}
\arguments{
\item{model}{A linear model object of class 'lm'.}
}
\value{
A numeric vector of Cook's Distance values for each observation in the model.
}
\description{
This function calculates Cook's Distance for a linear model object without using the built-in cooks.distance function.
}
\examples{
model <- lm(mpg ~ wt + hp, data = mtcars)
cooksD <- cooks_distance(model)
print(cooksD)
}
