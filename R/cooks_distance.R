# R/cooks_distance.R
#' Custom Cook's Distance Measure
#'
#' This function calculates Cook's Distance for a linear model object without using the built-in cooks.distance function.
#'
#'
#' @param model A linear model object of class 'lm'.
#' @return A numeric vector of Cook's Distance values for each observation in the model.
#' @importFrom stats coef df.residual model.matrix model.response model.frame residuals
#' @examples
#' model <- lm(mpg ~ wt + hp, data = mtcars)
#' cooksD <- cooks_distance(model)
#' print(cooksD)
#' @export
#--------------------------
cooks_distance <- function(model) {
  if (!inherits(model, "lm")) {
    stop("The input model must be of class 'lm'.")
  }

  # Extract model components
  X <- model.matrix(model)
  y <- model.response(model.frame(model))
  n <- nrow(X)
  p <- length(coef(model))

  # Calculate the hat matrix H
  H <- X %*% solve(t(X) %*% X) %*% t(X)
  h <- diag(H)  # Leverage values

  # Calculate residuals
  e <- residuals(model)

  # Calculate the mean squared error (MSE)
  mse <- sum(e^2) / df.residual(model)

  # Calculate Cook's Distance
  cooksD <- (e^2 / (p * mse)) * (h / (1 - h)^2)

  return(cooksD)
}
