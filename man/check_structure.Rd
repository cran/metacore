% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{check_structure}
\alias{check_structure}
\title{Column Validation Function}
\usage{
check_structure(.data, col, func, any_na_acceptable, nm)
}
\arguments{
\item{.data}{the dataframe to check the column for}

\item{col}{the column to test}

\item{func}{the function to use to assert column structure}

\item{any_na_acceptable}{boolean, testing if the column can have missing}

\item{nm}{name of column to check (for warning and error clarification)}
}
\description{
Column Validation Function
}
