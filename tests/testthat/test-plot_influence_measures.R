library(testthat)
library(ggplot2)

test_that("plot_influence_measures handles different scenarios", {
  # Scenario 1: Valid inputs with all three influence measures
  model <- lm(mpg ~ wt + hp, data = mtcars)

  # Suppress plot output for testing
  expect_silent(plot_influence_measures(mtcars, model, measures = c("cooks", "dffits", "hadi")))

  # Scenario 2: Plot only Cooks Distance
  expect_silent(plot_influence_measures(mtcars, model, measures = "cooks"))

  # Scenario 3: Plot only DFFITS
  expect_silent(plot_influence_measures(mtcars, model, measures = "dffits"))

  # Scenario 4: Plot only Hadis Influence Measure
  expect_silent(plot_influence_measures(mtcars, model, measures = "hadi"))

  # Scenario 5: Invalid measure input
  expect_error(
    plot_influence_measures(mtcars, model, measures = "cookies"),
    "Invalid measure. Choose from 'cooks', 'dffits', or 'hadi'."
  )

})
