#' Custom Hadi's Influence Measure
#'
#' This function calculates Hadi's Influence Measure for each observation in a linear model.
#'
#' @param model A linear model object of class 'lm'.
#' @return A numeric vector of Hadi's Influence Measure values for each observation.
#' @importFrom stats coef df.residual model.matrix model.response model.frame residuals
#' @importFrom graphics lines legend
#' @examples
#' model <- lm(mpg ~ wt + hp, data = mtcars)
#' hadi_influence_values <- hadis_influence_measure(model)
#' print(hadi_influence_values)
#' @export
hadis_influence_measure <- function(model) {
  # Check if the input is a linear model
  if (!inherits(model, "lm")) {
    stop("The input model must be of class 'lm'.")
  }

  # Extract model components
  X <- model.matrix(model)
  y <- model.response(model.frame(model))
  n <- nrow(X)
  p <- length(coef(model))  # Number of predictors

  # Calculate the hat matrix H = X(X'X)^(-1)X'
  H <- X %*% solve(t(X) %*% X) %*% t(X)
  h <- diag(H)  # Leverage values

  # Calculate residuals
  e <- residuals(model)

  # Mean Squared Error (MSE) of the residuals
  mse <- sum(e^2) / df.residual(model)

  # Calculate the total sum of squared residuals
  # eTe <- sum(e^2)

  eTe <- diag(t(e) %*% e)

  # Calculate the first term of Hadi's Influence Measure
  first_term <- ((p + 1) * e^2) / ((1 - h) * (eTe - e^2))

  # Calculate the second term of Hadi's Influence Measure
  second_term <- h / (1 - h)

  # Calculate Hadi's Influence Measure
  hadi_influence <- first_term + second_term

  return(hadi_influence)
}

