
# mutations by samples --------------------------------------------------------

test_that("mutations_by_sample", {
  expected_columns <-  c(
    "sample",
    "mutation_id",
    "entrez",
    "hgnc",
    "code",
    "mutation_type_name",
    "mutation_type_display",
    "status",
    "mutation_name"

  )
  result1 <- query_mutations_by_sample(
    "samples"= c("TCGA-D1-A17U", "TCGA-ZX-AA5X"),
    "entrez" = 25,
    query_dir = query_dir
  )
  result2 <- query_mutations_by_sample(
    "samples"= "not_a_sample", query_dir = query_dir
  )
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)
  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})

# patients --------------------------------------------------------------------

test_that("query_patients", {
  expected_columns <- c(
    "age_at_diagnosis",
    "patient",
    "ethnicity",
    "gender",
    "height",
    "race",
    "weight"
  )
  result1 <- query_patients("TCGA-05-4244", query_dir = query_dir)
  expect_named(result1, expected_columns)
  expect_equal(nrow(result1), 1)

  result2 <- query_patients("not_a_patient", query_dir = query_dir)
  expect_named(result2, expected_columns)
  expect_equal(nrow(result2), 0)

  result3 <- query_patients(datasets = "PCAWG", query_dir = query_dir)
  expect_named(result3, expected_columns)
  expect_equal(nrow(result3), 455)
})

test_that("query_patient_slides", {
  expected_columns <- c(
    "patient",
    "slide",
    "slide_description"
  )
  result1 <- query_patient_slides("TCGA-05-4244", query_dir = query_dir)
  result2 <- query_patient_slides("not_a_patient", query_dir = query_dir)
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)
  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})

# related ---------------------------------------------------------------------

test_that("query_dataset_tags", {
  expected_columns <- c("long_display", "name",  "short_display")
  result1 <- query_dataset_tags("PCAWG", query_dir = query_dir)
  result2 <- query_dataset_tags("not_a_dataset", query_dir = query_dir)
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)
  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})

# samples ---------------------------------------------------------------------

test_that("query_samples", {
  expected_columns <- c("sample")
  result1 <- query_samples("TCGA-05-4244", query_dir = query_dir)
  result2 <- query_samples("not_a_sample", query_dir = query_dir)
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)
  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})

test_that("query_sample_patients", {
  expected_columns <- c(
    "sample",
    "patient",
    "age_at_diagnosis",
    "ethnicity",
    "gender",
    "height",
    "race",
    "weight"
  )
  result1 <- query_sample_patients("TCGA-05-4244", query_dir = query_dir)
  result2 <- query_sample_patients("not_a_sample", query_dir = query_dir)
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)
  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})

# samples by mutation status --------------------------------------------------

test_that("query_samples_by_mutation_status", {
  expected_names <- c("sample", "status")
  result1 <- query_samples_by_mutation_status(
    samples = "TCGA-2Z-A9J8", query_dir = query_dir)
  expect_named(result1, expected_names)
  expect_true(nrow(result1) > 0)

  result2 <- query_samples_by_mutation_status(
    samples = "TCGA-2Z-A9J8", mutation_ids = 777, query_dir = query_dir
  )
  expect_named(result2, expected_names)
  expect_true(nrow(result2) > 0)

  result3 <- query_samples_by_mutation_status(
    samples = "not_a_sample", query_dir = query_dir
  )
  expect_named(result3, expected_names)
  expect_equal(nrow(result3),  0)
})

# slides ----------------------------------------------------------------------

test_that("query_slides", {
  expected_names <- c("slide", "description", "patient")
  result1 <- query_slides(query_dir = query_dir)
  result2 <- query_slides("not_a_slide", query_dir = query_dir)
  expect_named(result1, expected_names)
  expect_named(result2, expected_names)
  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})
