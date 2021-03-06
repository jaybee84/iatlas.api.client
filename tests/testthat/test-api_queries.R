query_dir  <- system.file("queries", package = "iatlas.api.client")

# datasets ------------------------------------------------------------------

test_that("query_datasets", {
  expected_names <- c("display", "name", "type")
  result1 <- query_datasets(query_dir = query_dir)
  expect_named(result1, expected_names)
  expect_true(nrow(result1) > 0)
  result2 <- query_datasets("non_dataset", query_dir = query_dir)
  expect_named(result2, expected_names)
  expect_equal(nrow(result2), 0)
})

test_that("query_dataset_samples", {
  result1 <- query_dataset_samples("PCAWG", query_dir = query_dir)
  expect_named(result1, c("name"))
  expect_true(nrow(result1) > 0)
  result2 <- query_dataset_samples("non_dataset", query_dir = query_dir)
  expect_named(result2, c("name"))
  expect_equal(nrow(result2), 0)
})

# features ------------------------------------------------------------------

test_that("query_features", {
  expected_columns <- c(
    "name",
    "display",
    "class",
    "order",
    "unit",
    "method_tag"
  )

  result1 <- query_features(
    datasets = "PCAWG",
    parent_tags = "Immune_Subtype",
    features = "Lymphocytes_Aggregate1",
    query_dir = query_dir
  )
  result2 <- query_features(
    datasets = "PCAWG",
    parent_tags ="Immune_Subtype",
    features = "not_a_feature",
    query_dir = query_dir
  )

  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)

  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})

test_that("query_feature_values", {
  expected_columns <- c(
    "sample",
    "feature_name",
    "feature_display",
    "feature_value",
    "feature_order",
    "feature_class"
  )

  result1 <- query_feature_values(
    datasets = "PCAWG",
    parent_tags = "Immune_Subtype",
    features = "Lymphocytes_Aggregate1",
    query_dir = query_dir
  )
  result2 <- query_feature_values(
    datasets = "PCAWG",
    parent_tags ="Immune_Subtype",
    features = "not_a_feature",
    query_dir = query_dir
  )

  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)

  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})

test_that("query_features_range", {
  expected_columns <- c("name", "display", "value_min", "value_max")
  result1 <- query_features_range(
    "PCAWG",
    features = "Lymphocytes_Aggregate1",
    query_dir = query_dir
  )
  result2 <- query_features_range(
    "PCAWG",
    features = "not_a_feature",
    query_dir = query_dir
  )
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)

  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})



# features_by_tag -----------------------------------------------------------

test_that("query_feature_values_by_tag", {
  expected_columns <- c(
    "tag_name",
    "tag_short_display",
    "tag_long_display",
    "tag_color",
    "tag_characteristics",
    "feature_display",
    "feature_name",
    "sample",
    "value"
  )

  result1 <- query_feature_values_by_tag(
    datasets = "PCAWG",
    parent_tags = "Immune_Subtype",
    features = "Lymphocytes_Aggregate1",
    query_dir = query_dir
  )
  result2 <- query_feature_values_by_tag(
    datasets = "PCAWG",
    parent_tags = "Immune_Subtype",
    features = "not_a_feature",
    query_dir = query_dir
  )
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)

  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})


# features_by_class ---------------------------------------------------------

test_that("query_features_by_class", {
  expected_columns <- c(
    "class",
    "display",
    "name",
    "order",
    "unit",
    "method_tag"
  )
  result1 <- query_features_by_class(query_dir = query_dir)
  result2 <- query_features_by_class(
    feature_classes = "not_a_class", query_dir = query_dir
  )
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)

  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})

# genes expression by tag -----------------------------------------------------

#TODO fix query
# test_that("query_genes_expression_by_tag", {
#   expected_columns <- c(
#     "tag_name",
#     "tag_long_display",
#     "tag_short_display",
#     "tag_color",
#     "tag_characteristics",
#     "entrez",
#     "hgnc",
#     "sample",
#     "rna_seq_expr"
#   )
#
#   result1 <- query_genes_expression_by_tag(
#     "PCAWG",
#     "Immune_Subtype",
#     tags = "C1",
#     entrez = c(1:2),
#     query_dir = query_dir
#   ) %>% print()
#   expect_named(result1, expected_columns)
#   expect_true(nrow(result1) > 0)
#
#   result2 <- query_genes_expression_by_tag(
#     "not_a_dataset",
#     "Immune_Subtype",
#     tags = "C1",
#     entrez = 1,
#     query_dir = query_dir
#   )
#   expect_named(result2, expected_columns)
#   expect_equal(nrow(result2), 0)
# })

# gene types ------------------------------------------------------------------

test_that("query_gene_types", {
  expected_columns <- c("display", "name")

  result1 <- query_gene_types(query_dir = query_dir)
  result2 <- query_gene_types("not_a_type", query_dir = query_dir)
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)
  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})

test_that("query_genes_by_gene_types", {
  expected_columns <- c("entrez", "hgnc", "gene_type_name", "gene_type_display")

  result1 <- query_genes_by_gene_types(query_dir = query_dir)
  result2 <- query_genes_by_gene_types("not_a_type", query_dir = query_dir)
  expect_named(result1, expected_columns)
  expect_named(result2, expected_columns)
  expect_true(nrow(result1) > 0)
  expect_equal(nrow(result2), 0)
})
