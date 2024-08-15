library(testthat)

test_that("calculate_influence_measures handles different inputs", {

  # Scenario 1: Valid inputs, correct measure name
  model <- lm(mpg ~ wt + hp, data = mtcars)
  influence_values <- calculate_influence_measures(mtcars, model, measure = "cooks")
  expect_type(influence_values, "double")

  # Scenario 2: Invalid measure name
  expect_error(
    calculate_influence_measures(mtcars, model, measure = "cookies"),
    "Invalid measure. Choose from 'cooks', 'dffits', or 'hadi'."
  )

  # Scenario 3: Data contains NA values
  mtcars_na <- mtcars
  mtcars_na[1, 1] <- NA
  expect_error(
    calculate_influence_measures(mtcars_na, model, measure = "cooks"),
    "Data contains NA values."
  )

  # Scenario 4: Data contains infinite values
  mtcars_inf <- mtcars
  mtcars_inf[1, 1] <- Inf
  expect_error(
    calculate_influence_measures(mtcars_inf, model, measure = "cooks"),
    "Data contains infinite values."
  )

})
