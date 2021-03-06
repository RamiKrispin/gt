#' Upgrader function for `cells_*` objects
#'
#' Upgrade a `cells_*` object to a `list()` if only a single instance is
#' provided.
#' @param locations Any `cells_*` object.
#' @noRd
as_locations <- function(locations) {

  if (!inherits(locations, "location_cells")) {

    if (!is.list(locations) &&
        any(!vapply(locations, inherits, logical(1), "location_cells"))) {

      stop("The `locations` object should be a list of `cells_*()`.",
           .call = FALSE)
    }
  } else {
    locations <- list(locations)
  }

  locations
}

add_summary_location_row <- function(loc,
                                     data,
                                     style,
                                     df_type = "styles_df") {

  stub_df <- dt_stub_df_get(data = data)

  row_groups <-
    stub_df %>%
    dplyr::pull(groupname) %>%
    unique()

  summary_data <- dt_summary_get(data = data)

  summary_data_summaries <-
    vapply(
      seq(summary_data),
      function(x) !is.null(summary_data[[x]]$groups),
      logical(1)
    )

  summary_data <- summary_data[summary_data_summaries]

  groups <-
    row_groups[resolve_data_vals_idx(
      var_expr = !!loc$groups,
      data_tbl = NULL,
      vals = row_groups
    )]

  # Adding styles to intersections of group, row, and column; any
  # that are missing at render time will be ignored
  for (group in groups) {

    summary_labels <-
      lapply(
        summary_data,
        function(summary_data_item) {
          if (isTRUE(summary_data_item$groups)) {
            summary_data_item$summary_labels
          } else if (group %in% summary_data_item$groups){
            summary_data_item$summary_labels
          }
        }
      ) %>%
      unlist() %>%
      unique()

    col_idx <-
      resolve_data_vals_idx(
        var_expr = !!loc$columns,
        data_tbl = NULL,
        vals = dt_boxhead_get_vars_default(data = data)
      )

    columns <- dt_boxhead_get_vars_default(data = data)[col_idx]

    if (length(columns) == 0) {
      stop("The location requested could not be resolved:\n",
           " * Review the expression provided as `columns`",
           call. = FALSE)
    }

    rows <-
      resolve_data_vals_idx(
        var_expr = !!loc$rows,
        data_tbl = NULL,
        vals = summary_labels
      )

    if (length(rows) == 0) {
      stop("The location requested could not be resolved:\n",
           " * Review the expression provided as `rows`",
           call. = FALSE)
    }

    if (df_type == "footnotes_df") {

      data <-
        dt_footnotes_add(
          data = data,
          locname = "summary_cells",
          grpname = group,
          colname = columns,
          locnum = 5,
          rownum = rows,
          footnotes = style
        )

    } else {

      data <-
        dt_styles_add(
          data = data,
          locname = "summary_cells",
          grpname = group,
          colname = columns,
          locnum = 5,
          rownum = rows,
          styles = style
        )
    }
  }

  data
}

add_grand_summary_location_row <- function(loc,
                                           data,
                                           style,
                                           df_type = "styles_df") {

  summary_data <- dt_summary_get(data = data)

  grand_summary_labels <-
    lapply(summary_data, function(summary_data_item) {
      if (is.null(summary_data_item$groups)) {
        return(summary_data_item$summary_labels)
      }
      NULL
    }) %>%
    unlist() %>%
    unique()

  columns <-
    resolve_vars(
      var_expr = !!loc$columns,
      data = data
    )

  if (length(columns) == 0) {
    stop("The location requested could not be resolved:\n",
         " * Review the expression provided as `columns`",
         call. = FALSE)
  }

  rows <-
    resolve_data_vals_idx(
      var_expr = !!loc$rows,
      data_tbl = NULL,
      vals = grand_summary_labels
    )

  if (length(rows) == 0) {
    stop("The location requested could not be resolved:\n",
         " * Review the expression provided as `rows`",
         call. = FALSE)
  }

  if (df_type == "footnotes_df") {

    data <-
      dt_footnotes_add(
        data = data,
        locname = "grand_summary_cells",
        grpname = grand_summary_col,
        colname = columns,
        locnum = 6,
        rownum = rows,
        footnotes = style
      )

  } else {

    data <-
      dt_styles_add(
        data = data,
        locname = "grand_summary_cells",
        grpname = grand_summary_col,
        colname = columns,
        locnum = 6,
        rownum = rows,
        styles = style
      )
  }

  data
}

# Given a location (i.e. cells_*() function result), evaluate captured quosures
# in the context of `data` and return an object with the `resolved` class added
# to the front of the class list.
resolve_location <- function(loc, data) {
  UseMethod("resolve_location")
}

resolve_location.resolved <- function(loc, data) {
  # The object is already resolved
  loc
}

resolve_location.cells_data <- function(loc, data) {

  data_tbl <- dt_data_get(data = data)
  stub_df <- dt_stub_df_get(data = data)

  loc$colnames <-
    resolve_vars(
      var_expr = !!loc[["columns"]],
      data = data
    )

  loc$rows <-
    resolve_data_vals_idx(
      var_expr = !!loc[["rows"]],
      data_tbl = data_tbl,
      vals = stub_df$rowname
    )

  class(loc) <- c("resolved", class(loc))
  loc
}

resolve_location.cells_column_labels <- function(loc, data) {

  data_tbl <- dt_data_get(data = data)

  if (!is.null(loc$columns)) {

    loc$colnames <-
      resolve_vars(
        var_expr = !!loc$columns,
        data = data_tbl
      )
  }

  # TODO: for now, when groups is set to TRUE, the
  # behavior is not to select all groups; this
  # should be changed to select all group

  # TODO: implement a stop() if groups provided not
  # in the available set of groups
  class(loc) <- c("resolved", class(loc))

  loc
}

resolve_location.cells_stub <- function(loc, data) {

  resolved <- resolve_cells_stub(data = data, object = loc)

  loc$rows <- resolved$rows

  class(loc) <- c("resolved", class(loc))

  loc
}

# Given a location, reassign column/row numbers from data-relative to
# output-relative, and return an object with the `output_relative` class added.
to_output_location <- function(loc, data) {
  UseMethod("to_output_location")
}

to_output_location.default <- function(loc, data) {

  loc <- resolve_location(loc = loc, data = data)

  class(loc) <- c("output_relative", class(loc))
  loc
}

to_output_location.output_relative <- function(loc, data) {
  # The object is already output-relative
  loc
}

to_output_location.cells_data <- function(loc, data) {

  stub_df <- dt_stub_df_get(data = data)
  groups <- dt_stub_groups_get(data = data)

  loc <- resolve_location(loc = loc, data = data)

  rows_df <- get_row_reorder_df(groups = groups, stub_df = stub_df)

  # We shouldn't need to do this, but `body` doesn't match up exactly to
  # the colnum_final values due to groupnames/rownames
  #loc$colnames <- loc$colnames
  loc$rows <- rows_df$rownum_final[loc$rows]

  class(loc) <- c("output_relative", class(loc))
  loc
}

to_output_location.cells_stub <- function(loc, data) {

  stub_df <- dt_stub_df_get(data = data)
  groups <- dt_stub_groups_get(data = data)

  loc <- resolve_location(loc = loc, data = data)

  rows_df <- get_row_reorder_df(groups = groups, stub_df = stub_df)

  loc$rows <- rows_df$rownum_final[loc$rows]

  class(loc) <- c("output_relative", class(loc))
  loc
}
