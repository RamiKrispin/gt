#' Add summary rows using aggregation functions
#'
#' Add groupwise summary rows (with `summary_rows()`) to one or more row groups
#' by using the input data already provided in the [gt()] function alongside any
#' suitable aggregation functions. Or, add a grand summary (with
#' `grand_summary_rows()`) that incorporates all available data, regardless of
#' grouping. You choose how to format the values in the resulting summary cells
#' by use of a `formatter` function (e.g, `fmt_number`) and any relevant
#' options.
#'
#' Should we need to obtain the summary data for external purposes, the
#' [extract_summary()] function can be used with a `gt_tbl` object where summary
#' rows were added via `summary_rows()`.
#'
#' @param data A table object that is created using the [gt()] function.
#' @param groups The groups to consider for generation of groupwise summary
#'   rows. By default this is set to `NULL`, which results in the formation of
#'   grand summary rows (a grand summary operates on all table data). Providing
#'   the names of row groups in [c()] will create a groupwise summary and
#'   generate summary rows for the specified groups. Setting this to `TRUE`
#'   indicates that all available groups will receive groupwise summary rows.
#' @param columns The columns for which the summaries should be calculated.
#' @param fns Functions used for aggregations. This can include base functions
#'   like `mean`, `min`, `max`, `median`, `sd`, or `sum` or any other
#'   user-defined aggregation function. The function(s) should be supplied
#'   within a `list()`. Within that list, we can specify the functions by use of
#'   function names in quotes (e.g., `"sum"`), as bare functions (e.g., `sum`),
#'   or as one-sided R formulas using a leading `~`. In the formula
#'   representation, a `.` serves as the data to be summarized (e.g., `sum(.,
#'   na.rm = TRUE)`). The use of named arguments is recommended as the names
#'   will serve as summary row labels for the corresponding summary rows data
#'   (the labels can derived from the function names but only when not providing
#'   bare function names).
#' @param missing_text The text to be used in place of `NA` values in summary
#'   cells with no data outputs.
#' @param formatter A formatter function name. These can be any of the `fmt_*()`
#'   functions available in the package (e.g., [fmt_number()], [fmt_percent()],
#'   etc.), or a custom function using `fmt()`. The default function is
#'   [fmt_number()] and its options can be accessed through `...`.
#' @param ... Values passed to the `formatter` function, where the provided
#'   values are to be in the form of named vectors. For example, when using the
#'   default `formatter` function, [fmt_number()], options such as `decimals`,
#'   `use_seps`, and `locale` can be used.
#' @return An object of class `gt_tbl`.
#' @examples
#' # Use `sp500` to create a gt table with
#' # row groups; create summary rows (`min`,
#' # `max`, `avg`) by row group, where each
#' # each row group is a week number
#' tab_1 <-
#'   sp500 %>%
#'   dplyr::filter(
#'     date >= "2015-01-05" &
#'       date <="2015-01-16"
#'   ) %>%
#'   dplyr::arrange(date) %>%
#'   dplyr::mutate(
#'     week = paste0(
#'       "W", strftime(date, format = "%V"))
#'   ) %>%
#'   dplyr::select(-adj_close, -volume) %>%
#'   gt(
#'     rowname_col = "date",
#'     groupname_col = "week"
#'   ) %>%
#'   summary_rows(
#'     groups = TRUE,
#'     columns = vars(open, high, low, close),
#'     fns = list(
#'       min = ~min(.),
#'       max = ~max(.),
#'       avg = ~mean(.)),
#'     formatter = fmt_number,
#'     use_seps = FALSE
#'   )
#'
#' @section Figures:
#' \if{html}{\figure{man_summary_rows_1.svg}{options: width=100\%}}
#'
#' @family row addition functions
#' @rdname summary_rows
#' @export
summary_rows <- function(data,
                         groups = NULL,
                         columns = TRUE,
                         fns,
                         missing_text = "---",
                         formatter = fmt_number,
                         ...) {

  # Collect all provided formatter options in a list
  formatter_options <- list(...)

  # If `groups` is FALSE, then do nothing; just
  # return the `data` unchanged; having `groups`
  # as `NULL` signifies a grand summary, `TRUE`
  # is used for groupwise summaries across all
  # groups
  if (is_false(groups)) {
    return(data)
  }

  # Get the `stub_df` object from `data`
  stub_df <- dt_stub_df_get(data = data)

  stub_available <- dt_stub_df_exists(data = data)

  # Resolve the column names
  columns <- enquo(columns)
  columns <- resolve_vars(var_expr = !!columns, data = data)

  # If there isn't a stub available, create an
  # 'empty' stub (populated with empty strings);
  # the stub is necessary for summary row labels
  if (!stub_available && is.null(groups)) {

    # Place the `rowname` values into `stub_df$rowname`
    stub_df[["rowname"]] <- ""

    data <- dt_stub_df_set(data = data, stub_df = stub_df)
  }

  # Derive the summary labels
  summary_labels <-
    vapply(fns, derive_summary_label, FUN.VALUE = character(1))

  # If there are names, use those names
  # as the summary labels
  if (!is.null(names(summary_labels))) {
    summary_labels <- names(summary_labels)
  }

  summary_list <-
    list(
      groups = groups,
      columns = columns,
      fns = fns,
      summary_labels = summary_labels,
      missing_text = missing_text,
      formatter = formatter,
      formatter_options = formatter_options
    )

  data <- dt_summary_add(data = data, summary = summary_list)

  data
}

#' @rdname summary_rows
#' @export
grand_summary_rows <- function(data,
                               columns = TRUE,
                               fns,
                               missing_text = "---",
                               formatter = fmt_number,
                               ...) {

  summary_rows(
    data,
    groups = NULL,
    columns = columns,
    fns = fns,
    missing_text = missing_text,
    formatter = formatter,
    ...)
}
