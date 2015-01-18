context("create_labelInterporationFnc")

test_that("invalid interval", {
  expect_error(create_labelInterporationFnc(interval = "foo"))
  expect_error(create_labelInterporationFnc(interval = c(1,2)))
})

test_that("invalid offset", {
  expect_error(create_labelInterporationFnc(offset = "foo"))
  expect_error(create_labelInterporationFnc(offset = c(1,2)))
})