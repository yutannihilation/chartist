context("get_label_offset")

test_that("single numeric", {
  expect_equal(get_label_offset(1), list(x = 1, y = 1))
})

test_that("a numeric vector of length two", {
  expect_equal(get_label_offset(c(1, 2)), list(x = 1, y = 2))
})

test_that("a list", {
  expect_equal(get_label_offset(list(x = 1, y = 2)), list(x = 1, y = 2))
})

test_that("invalid length of vector and list", {
  expect_null(get_label_offset(c(1, 2, 3)))
  expect_null(get_label_offset(list(x = 1, y = 2, z = 3)))
})

test_that("invalid type of vector and list", {
  expect_null(get_label_offset("foo"))
  expect_null(get_label_offset(list(x = "foo", y = "bar")))
})