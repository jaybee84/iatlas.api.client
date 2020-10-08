
# mutations -------------------------------------------------------------------

#' query_mutations
#'
#' @param ids A vector of integers
#' @param entrez A vector of integers
#' @param codes A vector of strings
#' @param types A vector of strings
#' @param samples A vector of strings
#' @param status A string
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_mutations <- function(
  ids = NA,
  entrez = NA,
  codes = NA,
  types = NA,
  samples = NA,
  status = NA,
  ...
  ){
  tbl <- create_result_from_api_query(
    query_args =  list(
      "mutationId" = ids,
      "entrez" = entrez,
      "mutationCode" = codes,
      "mutationType" = types,
      "sample" = samples,
      "status" = status
    ),
    query_file = "mutations.txt",
    default_tbl = dplyr::tibble(
      "id" = character(),
      "entrez" = integer(),
      "hgnc" = character(),
      "code" =  character(),
      "mutation_type_name" = character(),
      "mutation_type_display" = character(),
      "mutation_name" = character()
    ),
    select_cols = c(
      "id",
      "entrez" = "gene.entrez",
      "hgnc" = "gene.hgnc",
      "code" = "mutationCode",
      "mutation_type_name" = "mutationType.name",
      "mutation_type_display" = "mutationType.display"
    ),
    ...
  ) %>%
    dplyr::mutate("mutation_name" = stringr::str_c(.data$hgnc, ":", .data$code))
}

# mutations by samples --------------------------------------------------------

#' Query Mutations BY Samples
#'
#' @param entrez A vector of integers
#' @param samples A vector of strings
#' @param mutation_codes A vector of strings
#' @param mutation_types A vector of strings
#' @param mutation_ids A string
#' @param mutation_status An integer
#' @param page An integer
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_mutations_by_samples <- function(
  entrez = NA,
  mutation_codes = NA,
  mutation_types = NA,
  mutation_ids = NA,
  mutation_status = NA,
  samples = NA,
  page = NA,
  ...
){
  tbl <- create_result_from_paginated_api_query(
    query_args =  list(
      entrez = entrez,
      mutationCode = mutation_codes,
      mutationType = mutation_types,
      mutationId = mutation_ids,
      status = mutation_status,
      sample = samples,
      page = page
    ),
    query_file = "mutations_by_samples.txt",
    default_tbl = dplyr::tibble(
      "sample" = character(),
      "mutation_id" = integer(),
      "entrez" = integer(),
      "hgnc" = character(),
      "code" = character(),
      "mutation_type_name"  = character(),
      "mutation_type_display" = character(),
      "status" = character(),
      "mutation_name" = character()
    ),
    unnest_cols = "mutations",
    select_cols = c(
      "sample" = "name",
      "mutation_id" = "id",
      "entrez" = "gene.entrez",
      "hgnc" = "gene.hgnc",
      "code" = "mutationCode",
      "mutation_type_name" = "mutationType.name",
      "mutation_type_display" = "mutationType.display",
      "status"
    ),
    ...
  ) %>%
    dplyr::mutate("mutation_name" = stringr::str_c(.data$hgnc, ":", .data$code))
}

# patients --------------------------------------------------------------------

#' Query Patients
#'
#' @param patients A list of strings
#' @param datasets A vector of strings
#' @param ethnicities A vector of strings
#' @param genders A vector of strings
#' @param races A vector of strings
#' @param samples A vector of strings
#' @param slides A vector of strings
#' @param max_age_at_diagnosis An integer
#' @param max_height A float
#' @param max_weight A float
#' @param min_age_at_diagnosis An integer
#' @param min_height A float
#' @param min_weight A float
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_patients <- function(
  patients = NA,
  datasets = NA,
  ethnicities  = NA,
  genders  = NA,
  races  = NA,
  samples  = NA,
  slides  = NA,
  max_age_at_diagnosis  = NA,
  max_height = NA,
  max_weight  = NA,
  min_age_at_diagnosis  = NA,
  min_height  = NA,
  min_weight = NA,
  ...
){
  tbl <- create_result_from_api_query(
    query_args =  list(
      "barcode" = patients,
      "dataSet" = datasets,
      "ethnicity" = ethnicities,
      "gender" = genders,
      "race" = races,
      "sample" = samples,
      "slide" = slides,
      "maxAgeAtDiagnosis" = max_age_at_diagnosis,
      "maxHeight" = max_height,
      "maxWeight" = max_weight,
      "minAgeAtDiagnosis" = min_age_at_diagnosis,
      "minHeight" = min_height,
      "minWeight" = min_weight
    ),
    query_file = "patients.txt",
    default_tbl = dplyr::tibble(
      "age_at_diagnosis" = numeric(),
      "patient" = character(),
      "ethnicity" = character(),
      "gender" = character(),
      "height" = numeric(),
      "race" = character(),
      "weight" = numeric()
    ),
    select_cols = c(
      "age_at_diagnosis" = "ageAtDiagnosis",
      "patient" = "barcode",
      "ethnicity",
      "gender",
      "height",
      "race",
      "weight"
    ),
    ...
  )
}

#' Query Patient Slides
#'
#' @param patients A list of strings
#' @param datasets A vector of strings
#' @param ethnicities A vector of strings
#' @param genders A vector of strings
#' @param races A vector of strings
#' @param samples A vector of strings
#' @param slides A vector of strings
#' @param max_age_at_diagnosis An integer
#' @param max_height A float
#' @param max_weight A float
#' @param min_age_at_diagnosis An integer
#' @param min_height A float
#' @param min_weight A float
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_patient_slides <- function(
  patients = NA,
  datasets = NA,
  ethnicities  = NA,
  genders  = NA,
  races  = NA,
  samples  = NA,
  slides  = NA,
  max_age_at_diagnosis  = NA,
  max_height = NA,
  max_weight  = NA,
  min_age_at_diagnosis  = NA,
  min_height  = NA,
  min_weight = NA,
  ...
){
  tbl <- create_result_from_api_query(
    query_args =  list(
      "barcode" = patients,
      "dataSet" = datasets,
      "ethnicity" = ethnicities,
      "gender" = genders,
      "race" = races,
      "sample" = samples,
      "slide" = slides,
      "maxAgeAtDiagnosis" = max_age_at_diagnosis,
      "maxHeight" = max_height,
      "maxWeight" = max_weight,
      "minAgeAtDiagnosis" = min_age_at_diagnosis,
      "minHeight" = min_height,
      "minWeight" = min_weight
    ),
    query_file = "patient_slides.txt",
    default_tbl = dplyr::tibble(
      "patient" = character(),
      "slide" = character(),
      "slide_description" = character()
    ),
    unnest_cols = "slides",
    select_cols = c(
      "patient" = "barcode",
      "slide" = "name",
      "slide_description" = "description"
    ),
    ...
  )
}

# related ---------------------------------------------------------------------

#' Query Dataset Tags
#'
#' @param dataset A string
#' @param ... Arguments to create_result_from_api_query
#' @export
#' @importFrom magrittr %>%
query_dataset_tags <- function(dataset, ...){
  tbl <- create_result_from_api_query(
    query_args =  list("dataSet" = dataset, "related" = NA),
    query_file = "dataset_tags.txt",
    default_tbl = dplyr::tibble(
      "long_display" = character(),
      "name" = character(),
      "short_display" = character()
    ),
    select_cols = c("related"),
    ...
  )
  if(nrow(tbl) == 0) return(tbl)
  else {
    tbl %>%
      tidyr::unnest(cols = c("related"), keep_empty = T) %>%
      dplyr::rename(
        "long_display" = "longDisplay",
        "short_display" = "shortDisplay"
      )
  }
}

# samples ---------------------------------------------------------------------

#' Query Samples
#'
#' @param samples A vector of strings
#' @param patients A list of strings
#' @param ethnicities A vector of strings
#' @param genders A vector of strings
#' @param races A vector of strings
#' @param max_age_at_diagnosis An integer
#' @param max_height A float
#' @param max_weight A float
#' @param min_age_at_diagnosis An integer
#' @param min_height A float
#' @param min_weight A float
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_samples <- function(
  samples = NA,
  patients = NA,
  ethnicities  = NA,
  genders  = NA,
  races  = NA,
  max_age_at_diagnosis  = NA,
  max_height = NA,
  max_weight  = NA,
  min_age_at_diagnosis  = NA,
  min_height  = NA,
  min_weight = NA,
  ...
){
  tbl <- create_result_from_api_query(
    query_args =  list(
      "name" = samples,
      "patient" = patients,
      "ethnicity" = ethnicities,
      "gender" = genders,
      "race" = races,
      "maxAgeAtDiagnosis" = max_age_at_diagnosis,
      "maxHeight" = max_height,
      "maxWeight" = max_weight,
      "minAgeAtDiagnosis" = min_age_at_diagnosis,
      "minHeight" = min_height,
      "minWeight" = min_weight
    ),
    query_file = "samples.txt",
    default_tbl = dplyr::tibble("sample" = character()),
    select_cols = c("sample" = "name"),
    ...
  )
}

#' Query Sample Patients
#'
#' @param samples A vector of strings
#' @param patients A list of strings
#' @param ethnicities A vector of strings
#' @param genders A vector of strings
#' @param races A vector of strings
#' @param max_age_at_diagnosis An integer
#' @param max_height A float
#' @param max_weight A float
#' @param min_age_at_diagnosis An integer
#' @param min_height A float
#' @param min_weight A float
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_sample_patients <- function(
  samples = NA,
  patients = NA,
  ethnicities  = NA,
  genders  = NA,
  races  = NA,
  max_age_at_diagnosis  = NA,
  max_height = NA,
  max_weight  = NA,
  min_age_at_diagnosis  = NA,
  min_height  = NA,
  min_weight = NA,
  ...
){
  tbl <- create_result_from_api_query(
    query_args =  list(
      "name" = samples,
      "patient" = patients,
      "ethnicity" = ethnicities,
      "gender" = genders,
      "race" = races,
      "maxAgeAtDiagnosis" = max_age_at_diagnosis,
      "maxHeight" = max_height,
      "maxWeight" = max_weight,
      "minAgeAtDiagnosis" = min_age_at_diagnosis,
      "minHeight" = min_height,
      "minWeight" = min_weight
    ),
    query_file = "sample_patients.txt",
    default_tbl = dplyr::tibble(
      "sample" = character(),
      "patient" = character(),
      "age_at_diagnosis" = numeric(),
      "ethnicity" = character(),
      "gender" = character(),
      "height" = numeric(),
      "race" = character(),
      "weight" = numeric()
    ),
    select_cols = c(
      "sample" = "name",
      "patient" = "patient.barcode",
      "age_at_diagnosis" = "patient.ageAtDiagnosis",
      "ethnicity" = "patient.ethnicity",
      "gender" = "patient.gender",
      "height" = "patient.height",
      "race" = "patient.race",
      "weight" = "patient.weight"
    ),
    ...
  )
}

# samples by mutation status --------------------------------------------------

#' query_samples_by_mutation_status
#'
#' @param ids A vector of integers
#' @param status A string, either "Wt" or "Mut"
#' @param samples A vector of strings
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_samples_by_mutation_status <- function(
  ids = NA,
  status = NA,
  samples = NA,
  ...
){
  tbl <- create_result_from_api_query(
    query_args =  list(
      "mutationId" = ids,
      "mutationStatus"= status,
      "sample" = samples
    ),
    query_file = "samples_by_mutation_status.txt",
    default_tbl = dplyr::tibble("sample" = character(), "status" = character()),
    select_cols = c("status", "samples"),
    ...
  )
  if(nrow(tbl) == 0) return(tbl)
  else {
    tbl %>%
      tidyr::unnest("samples") %>%
      dplyr::select("sample" = "name", "status")
  }
}

# samples by tag --------------------------------------------------------------

#' Query Samples By Tag
#'
#' @param datasets A vector of strings
#' @param parent_tags A vector of strings
#' @param tags A vector of strings
#' @param features A vector of strings
#' @param feature_classes A vector of strings
#' @param samples A vector of strings
#' @param patients A vector of strings
#' @param max_age_at_diagnosis An integer
#' @param max_height A float
#' @param max_weight A float
#' @param min_age_at_diagnosis An integer
#' @param min_height A float
#' @param min_weight A float
#' @param ethnicities A vector of strings
#' @param genders A vector of strings
#' @param races A vector of strings
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_samples_by_tag <- function(
  datasets = NA,
  ethnicities  = NA,
  features = NA,
  feature_classes = NA,
  genders  = NA,
  max_age_at_diagnosis  = NA,
  max_height = NA,
  max_weight  = NA,
  min_age_at_diagnosis  = NA,
  min_height  = NA,
  min_weight = NA,
  samples = NA,
  patients = NA,
  races  = NA,
  parent_tags = NA,
  tags = NA,
  ...
){
  tbl <- create_result_from_api_query(
    query_args =  list(
      "dataSet" = datasets,
      "ethnicity" = ethnicities,
      "feature" = features,
      "featureClass" = feature_classes,
      "gender" = genders,
      "maxAgeAtDiagnosis" = max_age_at_diagnosis,
      "maxHeight" = max_height,
      "maxWeight" = max_weight,
      "minAgeAtDiagnosis" = min_age_at_diagnosis,
      "minHeight" = min_height,
      "minWeight" = min_weight,
      "name" = samples,
      "patient" = patients,
      "race" = races,
      "related" = parent_tags,
      "tag" = tags
    ),
    query_file = "samples_by_tag.txt",
    default_tbl = dplyr::tibble(
      "tag_name" = character(),
      "tag_long_display" = character(),
      "tag_short_display" = character(),
      "tag_characteristics" = character(),
      "tag_color" = character(),
      "sample" = character()
    ),
    select_cols = c(
      "tag_name" = "tag",
      "tag_long_display" = "longDisplay",
      "tag_short_display" = "shortDisplay",
      "tag_characteristics" = "characteristics",
      "tag_color" = "color",
      "samples"
    ),
    ...
  )
  if(nrow(tbl) == 0) return(tbl)
  else {
    tbl %>%
      tidyr::unnest("samples") %>%
      dplyr::rename("sample" = "name")
  }
}

#' Query Tag Samples
#'
#' @param datasets A vector of strings
#' @param parent_tags A vector of strings
#' @param tags A vector of strings
#' @param features A vector of strings
#' @param feature_classes A vector of strings
#' @param samples A vector of strings
#' @param patients A vector of strings
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_tag_samples <- function(
  datasets = NA,
  parent_tags = NA,
  tags = NA,
  features = NA,
  feature_classes = NA,
  samples = NA,
  patients = NA,
  ...
){
  tbl <- create_result_from_api_query(
    query_args =  list(
      "dataSet" = datasets,
      "related" = parent_tags,
      "tag" = tags,
      "feature" = features,
      "featureClass" = feature_classes,
      "name" = samples,
      "patient" = patients
    ),
    query_file = "tag_samples.txt",
    default_tbl = dplyr::tibble("sample" = character()),
    select_cols = c("samples"),
    ...
  )
  if(nrow(tbl) == 0) return(tbl)
  else {
    tbl %>%
      tidyr::unnest("samples") %>%
      dplyr::select("sample" = "name")
  }
}

# slides ----------------------------------------------------------------------

#' query_slides
#'
#' @param slides A vector of strings
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_slides <- function(slides = NA, ...){
  tbl <- create_result_from_api_query(
    query_args =  list("name" = slides),
    query_file = "slides.txt",
    default_tbl = dplyr::tibble(
      "slide" = character(),
      "description" = character(),
      "patient" = character()
    ),
    select_cols = c(
      "slide" = "name",
      "description",
      "patient" = "patient.barcode"
    ),
    ...
  )
}

# tags ------------------------------------------------------------------------

#' Query Tags
#'
#' @param datasets A vector of strings
#' @param parent_tags A vector of strings
#' @param tags A vector of strings
#' @param features A vector of strings
#' @param feature_classes A vector of strings
#' @param samples A vector of strings
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_tags <- function(
  datasets = NA,
  parent_tags = NA,
  tags = NA,
  features = NA,
  feature_classes = NA,
  samples = NA,
  ...
){
  create_result_from_api_query(
    query_args =  list(
      "dataSet" = datasets,
      "related" = parent_tags,
      "tag" = tags,
      "feature" = features,
      "featureClass" = feature_classes,
      "sample" = samples
    ),
    query_file = "tags.txt",
    default_tbl = dplyr::tibble(
      "name" = character(),
      "long_display" = character(),
      "short_display" = character(),
      "characteristics" = character(),
      "color" = character(),
      "sample_count" = integer()
    ),
    select_cols = c(
      "name",
      "long_display" = "longDisplay",
      "short_display" = "shortDisplay",
      "characteristics",
      "color",
      "sample_count" = "sampleCount"
    ),
    arrange_cols = "name",
    ...
  )
}

#' Query Tags to Tags
#'
#' @param datasets A vector of strings
#' @param parent_tags A vector of strings
#' @param tags A vector of strings
#' @param features A vector of strings
#' @param feature_classes A vector of strings
#' @param samples A vector of strings
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_tags_to_tags <- function(
  datasets = NA,
  parent_tags = NA,
  tags = NA,
  features = NA,
  feature_classes = NA,
  samples = NA,
  ...
){
  tbl <- create_result_from_api_query(
    query_args =  list(
      "dataSet" = datasets,
      "related" = parent_tags,
      "tag" = tags,
      "feature" = features,
      "featureClass" = feature_classes,
      "sample" = samples
    ),
    query_file = "tags_to_tags.txt",
    default_tbl = dplyr::tibble(
      "tag_name" = character(),
      "tag_long_display" = character(),
      "tag_short_display" = character(),
      "tag_characteristics" = character(),
      "tag_color" = character(),
      "parent_characteristics" = character(),
      "parent_color" = character(),
      "parent_long_display" = character(),
      "parent_name" = character(),
      "parent_short_display" = character()
    ),
    select_cols = c(
      "tag_name" = "name",
      "tag_long_display" =  "longDisplay",
      "tag_short_display" =  "shortDisplay",
      "tag_characteristics" = "characteristics",
      "tag_color" = "color",
      "related"
    ),
    arrange_cols = "tag_name",
    ...
  )
  if(nrow(tbl) > 0){
    tbl <- tbl %>%
      tidyr::unnest("related") %>%
      dplyr::rename(
        "parent_name" = "name",
        "parent_long_display" = "longDisplay",
        "parent_short_display" = "shortDisplay",
        "parent_characteristics" = "characteristics",
        "parent_color" = "color"
      )
  }
  return(tbl)


}

#' query_cohort_selector
#'
#'
#' @param datasets A vector of strings
#' @param parent_tags A vector of strings
#' @param tags A vector of strings
#' @param features A vector of strings
#' @param feature_classes A vector of strings
#' @param samples A vector of strings
#' @param ... Arguments to create_result_from_api_query
#'
#' @export
#' @importFrom magrittr %>%
query_cohort_selector <- function(
  datasets,
  parent_tags,
  tags = NA,
  features = NA,
  feature_classes = NA,
  samples = NA,
  ...
){
  create_result_from_api_query(
    query_args =  list(
      "dataSet" = datasets,
      "related" = parent_tags,
      "tag" = tags,
      "feature" = features,
      "featureClass" = feature_classes,
      "sample" = samples
    ),
    query_file = "cohort_selection.txt",
    default_tbl = dplyr::tibble(
      "name" = character(),
      "long_display" = character(),
      "short_display" = character(),
      "characteristics" = character(),
      "color" = character(),
      "size" = integer(),
      "samples" = list()
    ),
    select_cols = c(
      "name",
      "long_display" =  "longDisplay",
      "short_display" =  "shortDisplay",
      "characteristics",
      "color",
      "size" = "sampleCount",
      "samples"
    ),
    arrange_cols = "name",
    ...
  )
}