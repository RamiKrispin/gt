% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/modify_columns.R
\name{cols_align}
\alias{cols_align}
\title{Set the alignment of columns}
\usage{
cols_align(data, align = c("auto", "left", "center", "right"),
  columns = TRUE)
}
\arguments{
\item{data}{A table object that is created using the \code{\link[=gt]{gt()}} function.}

\item{align}{The alignment type. This can be any of \code{"center"}, \code{"left"}, or
\code{"right"} for center-, left-, or center-alignment. Alternatively, the
\code{"auto"} option (the default), will automatically align values in columns
according to the data type (see the Details section for specifics on which
alignments are applied).}

\item{columns}{An optional vector of column names for which the alignment
should be applied. If nothing is supplied, or if \code{columns} is \code{TRUE}, then
the chosen alignment affects all columns.}
}
\value{
An object of class \code{gt_tbl}.
}
\description{
The individual alignments of columns (which includes the column labels and
all of their data cells) can be modified. We have the option to align text to
the \code{left}, the \code{center}, and the \code{right}. In a less explicit manner, we can
allow \pkg{gt} to automatically choose the alignment of each column based on
the data type (with the \code{auto} option).
}
\details{
When you create a \pkg{gt} table object using \code{\link[=gt]{gt()}}, automatic alignment of
column labels and their data cells is performed. By default, left-alignment
is applied to columns of class \code{character}, \code{Date}, or \code{POSIXct};
center-alignment is for columns of class \code{logical}, \code{factor}, or \code{list}; and
right-alignment is used for the \code{numeric} and \code{integer} columns.
}
\section{Figures}{

\if{html}{\figure{man_cols_align_1.svg}{options: width=100\%}}
}

\examples{
# Use `countrypops` to create a gt table;
# align the `population` column data to
# the left
tab_1 <-
  countrypops \%>\%
  dplyr::select(-contains("code")) \%>\%
  dplyr::filter(country_name == "Mongolia") \%>\%
  tail(5) \%>\%
  gt() \%>\%
  cols_align(
    align = "left",
    columns = vars(population)
  )

}
\seealso{
Other column modification functions: \code{\link{cols_hide}},
  \code{\link{cols_label}}, \code{\link{cols_merge_range}},
  \code{\link{cols_merge_uncert}},
  \code{\link{cols_merge}}, \code{\link{cols_move_to_end}},
  \code{\link{cols_move_to_start}},
  \code{\link{cols_move}}, \code{\link{cols_width}},
  \code{\link{tab_spanner_delim}}
}
\concept{column modification functions}
