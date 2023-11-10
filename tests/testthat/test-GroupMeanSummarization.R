test_that("Invalid data type error", {
  expect_error(Group_mean_summarization(list(1,2),c(1)))
})

test_that("Invalid group by index error", {
  expect_error(Group_mean_summarization(tibble::tibble(1,2),c(0)))
})

test_that("Empty group by index error", {
  expect_error(Group_mean_summarization(tibble::tibble(1,2),c()))
})

test_that("Expect the mean to equal 3 for all data vales = 3 grouped by first index", {
  expect_equal(Group_mean_summarization(tibble::tibble(c(1,1),3),c(1)), tibble::tibble(c(1),c(3)), ignore_attr=TRUE)
})

test_that("Test mean removes NA values in summarized column ", {
  expect_equal(Group_mean_summarization(tibble::tibble(c(1,1,2),c(3,NA,5)),c(1)), tibble::tibble(c(1,2),c(3,5)), ignore_attr=TRUE)
})
