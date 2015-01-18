context("axis_options")

test_that("no options", {
  expect_null(axis_options(NULL, NULL, NULL, NULL, NULL))
  expect_null(axis_options(NULL, NULL, NULL, NULL, NULL, NULL))
})

test_that("one option", {
  expect_equal(axis_options(1, c(1, 2), FALSE, TRUE, "Chartist.noop"),
               list(offset = 1, labelOffset = list(x = 1, y = 2), showLabel = FALSE, showGrid = TRUE,
                    labelInterpolationFnc = "Chartist.noop"))
})