% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_functions.R
\name{add_ghql_query_from_text_file}
\alias{add_ghql_query_from_text_file}
\title{Add ghql Query From Text File}
\usage{
add_ghql_query_from_text_file(
  query_name,
  text_file_path,
  query_object = .GlobalEnv$ghql_query_object
)
}
\arguments{
\item{query_name}{A string, that will be the name of the query}

\item{text_file_path}{A string that is the path to the query file}

\item{query_object}{A ghql::Query$new object}
}
\description{
Add ghql Query From Text File
}
