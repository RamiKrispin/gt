#' Modify the table output options
#'
#' Modify the options available in a table. These options are named by the
#' components, the subcomponents, and the element that can adjusted.
#' @inheritParams fmt_number
#' @param container.width,container.height The width and height of the table's
#'   container. Can be specified as a single-length character with units of
#'   pixels or as a percentage. If provided as a single-length numeric vector,
#'   it is assumed that the value is given in units of pixels. The [px()] and
#'   [pct()] helper functions can also be used to pass in numeric values and
#'   obtain values as pixel or percent units.
#' @param container.overflow.x,container.overflow.y Options to enable scrolling
#'   in the horizontal and vertical directions when the table content overflows
#'   the container dimensions. Using `TRUE` (the default for both) means that
#'   horizontal or vertical scrolling is enabled to view the entire table in
#'   those directions. With `FALSE`, the table may be clipped if the table width
#'   or height exceeds the `container.width` or `container.height`.
#' @param table.width The width of the table. Can be specified as a
#'   single-length character with units of pixels or as a percentage. If
#'   provided as a single-length numeric vector, it is assumed that the value is
#'   given in units of pixels. The [px()] and [pct()] helper functions can also
#'   be used to pass in numeric values and obtain values as pixel or percent
#'   units.
#' @param table.align The alignment of the table in its container. By default,
#'   this is `"center"`. Other options are `"left"` and `"right"`. This will
#'   automatically set `table.margin.left` and `table.margin.right` to the
#'   appropriate values.
#' @param table.margin.left,table.margin.right The size of the margins on the
#'   left and right of the table within the container. Can be specified as a
#'   single-length character with units of pixels or as a percentage. If
#'   provided as a single-length numeric vector, it is assumed that the value is
#'   given in units of pixels. The [px()] and [pct()] helper functions can also
#'   be used to pass in numeric values and obtain values as pixel or percent
#'   units. Using `table.margin.left` or `table.margin.right` will overwrite any
#'   values set by `table.align`.
#' @param table.font.size,heading.title.font.size,heading.subtitle.font.size,column_labels.font.size,row_group.font.size,footnote.font.size,sourcenote.font.size
#'   Font sizes for the parent text element `table` and the following child
#'   elements: `heading.title`, `heading.subtitle`, `columns`, `row_group`,
#'   `footnote`, and `sourcenote`. Can be specified as a single-length character
#'   vector with units of pixels (e.g., `12px`) or as a percentage (e.g.,
#'   `80\%`). If provided as a single-length numeric vector, it is assumed that
#'   the value is given in units of pixels. The [px()] and [pct()] helper
#'   functions can also be used to pass in numeric values and obtain values as
#'   pixel or percent units.
#' @param font.color The table font color, for text used throughout the table.
#' @param font.color.light The table font color when text is required to be
#'   light, due to darker background colors.
#' @param column_labels.font.weight,row_group.font.weight The font weight of
#'   the `columns` and `row_group` text element.
#' @param summary_row.text_transform,grand_summary_row.text_transform An option
#'   to apply text transformations to the label text in each summary row.
#' @param table.background.color,heading.background.color,column_labels.background.color,row_group.background.color,summary_row.background.color,grand_summary_row.background.color
#'   Background colors for the parent element `table` and the following child
#'   elements: `heading`, `columns`, `row_group`, `summary_row`, and
#'   `table_body`. A color name or a hexadecimal color code should be provided.
#' @param table.border.top.style,table.border.top.width,table.border.top.color
#'   The style, width, and color of the table's top border.
#' @param heading.border.bottom.style,heading.border.bottom.width,heading.border.bottom.color
#'   The style, width, and color of the heading's bottom border.
#' @param row_group.border.top.style,row_group.border.top.width,row_group.border.top.color
#'   The style, width, and color of the row group's top border.
#' @param row_group.border.bottom.style,row_group.border.bottom.width,row_group.border.bottom.color
#'   The style, width, and color of the row group's bottom border.
#' @param table_body.border.top.style,table_body.border.top.width,table_body.border.top.color
#'   The style, width, and color of the table body's top border.
#' @param table_body.border.bottom.style,table_body.border.bottom.width,table_body.border.bottom.color
#'   The style, width, and color of the table body's bottom border.
#' @param row.padding,row_group.padding,summary_row.padding,grand_summary_row.padding
#'   The amount of padding in each type of row.
#' @param footnote.sep The separating characters between adjacent footnotes in
#'   the footnotes section. The default value produces a linebreak.
#' @param footnote.marks The set of sequential marks used to reference and
#'   identify each of the footnotes (same input as the [opt_footnote_marks()]
#'   function. We can supply a vector that represents the series of footnote
#'   marks. This vector is recycled when its usage goes beyond the length of the
#'   set. At each cycle, the marks are simply combined (e.g., `*` -> `**` ->
#'   `***`). The option exists for providing keywords for certain types of
#'   footnote marks. The keyword `"numbers"` (the default, indicating that we
#'   want to use numeric marks). We can use lowercase `"letters"` or uppercase
#'   `"LETTERS"`. There is the option for using a traditional symbol set where
#'   `"standard"` provides four symbols, and, `"extended"` adds two more
#'   symbols, making six.
#' @param footnote.padding,sourcenote.padding The amount of padding to apply to
#'   the footnote and source note sections.
#' @param row.striping.background_color The background color for striped table
#'   body rows.
#' @param row.striping.include_stub An option for whether to include the stub
#'   when striping rows.
#' @param row.striping.include_table_body An option for whether to include the
#'   table body when striping rows.
#' @param column_labels.hidden An option to hide the column labels.
#' @return an object of class `gt_tbl`.
#' @examples
#' # Use `exibble` to create a gt table with
#' # all the main parts added; we can use this
#' # going forward to demo some `tab_options()`
#' tab_1 <-
#'   exibble %>%
#'   dplyr::select(
#'     -c(fctr, date, time, datetime)
#'   ) %>%
#'   gt(
#'     rowname_col = "row",
#'     groupname_col = "group"
#'   ) %>%
#'   tab_header(
#'     title = md("Data listing from **exibble**"),
#'     subtitle = md("`exibble` is an R dataset")
#'   ) %>%
#'   fmt_number(columns = vars(num)) %>%
#'   fmt_currency(columns = vars(currency)) %>%
#'   tab_footnote(
#'     footnote = "Using commas for separators.",
#'     locations = cells_data(
#'       columns = vars(num),
#'       rows = num > 1000)
#'   ) %>%
#'   tab_footnote(
#'     footnote = "Using commas for separators.",
#'     locations = cells_data(
#'       columns = vars(currency),
#'       rows = currency > 1000)
#'   ) %>%
#'   tab_footnote(
#'     footnote = "Alphabetical fruit.",
#'     locations = cells_column_labels(
#'       columns = vars(char))
#'   )
#'
#' # Modify the table width to 100% (which
#' # spans the entire content width area)
#' tab_2 <-
#'   tab_1 %>%
#'   tab_options(
#'     table.width = pct(100)
#'   )
#'
#' # Modify the table's background color
#' # to be "lightcyan"
#' tab_3 <-
#'   tab_1 %>%
#'   tab_options(
#'     table.background.color = "lightcyan"
#'   )
#'
#' # Use letters as the marks for footnote
#' # references; also, separate footnotes in
#' # the footer by spaces instead of newlines
#' tab_4 <-
#'   tab_1 %>%
#'   tab_options(
#'     footnote.sep = " ",
#'     footnote.marks = letters
#'   )
#'
#' # Change the padding of data rows to 5px
#' tab_5 <-
#'   tab_1 %>%
#'   tab_options(
#'     row.padding = px(5)
#'   )
#'
#' # Reduce the size of the title and the
#' # subtitle text
#' tab_6 <-
#'   tab_1 %>%
#'   tab_options(
#'     heading.title.font.size = "small",
#'     heading.subtitle.font.size = "small"
#'   )
#'
#' @section Figures:
#' \if{html}{\figure{man_tab_options_1.svg}{options: width=100\%}}
#'
#' \if{html}{\figure{man_tab_options_2.svg}{options: width=100\%}}
#'
#' \if{html}{\figure{man_tab_options_3.svg}{options: width=100\%}}
#'
#' \if{html}{\figure{man_tab_options_4.svg}{options: width=100\%}}
#'
#' \if{html}{\figure{man_tab_options_5.svg}{options: width=100\%}}
#'
#' \if{html}{\figure{man_tab_options_6.svg}{options: width=100\%}}
#'
#' @family table-part creation/modification functions
#' @export
tab_options <- function(data,
                        container.width = NULL,
                        container.height = NULL,
                        container.overflow.x = NULL,
                        container.overflow.y = NULL,
                        font.color = NULL,
                        font.color.light = NULL,
                        table.width = NULL,
                        table.align = NULL,
                        table.margin.left = NULL,
                        table.margin.right = NULL,
                        table.font.size = NULL,
                        table.background.color = NULL,
                        table.border.top.style = NULL,
                        table.border.top.width = NULL,
                        table.border.top.color = NULL,
                        heading.background.color = NULL,
                        heading.title.font.size = NULL,
                        heading.subtitle.font.size = NULL,
                        heading.border.bottom.style = NULL,
                        heading.border.bottom.width = NULL,
                        heading.border.bottom.color = NULL,
                        column_labels.background.color = NULL,
                        column_labels.font.size = NULL,
                        column_labels.font.weight = NULL,
                        column_labels.hidden = NULL,
                        row_group.padding = NULL,
                        row_group.background.color = NULL,
                        row_group.font.size = NULL,
                        row_group.font.weight = NULL,
                        row_group.border.top.style = NULL,
                        row_group.border.top.width = NULL,
                        row_group.border.top.color = NULL,
                        row_group.border.bottom.style = NULL,
                        row_group.border.bottom.width = NULL,
                        row_group.border.bottom.color = NULL,
                        table_body.border.top.style = NULL,
                        table_body.border.top.width = NULL,
                        table_body.border.top.color = NULL,
                        table_body.border.bottom.style = NULL,
                        table_body.border.bottom.width = NULL,
                        table_body.border.bottom.color = NULL,
                        row.padding = NULL,
                        summary_row.background.color = NULL,
                        summary_row.padding = NULL,
                        summary_row.text_transform = NULL,
                        grand_summary_row.background.color = NULL,
                        grand_summary_row.padding = NULL,
                        grand_summary_row.text_transform = NULL,
                        footnote.sep = NULL,
                        footnote.marks = NULL,
                        footnote.font.size = NULL,
                        footnote.padding = NULL,
                        sourcenote.font.size = NULL,
                        sourcenote.padding = NULL,
                        row.striping.background_color = NULL,
                        row.striping.include_stub = NULL,
                        row.striping.include_table_body = NULL) {

  # Extract the options table from `data`
  opts_df <- dt_options_get(data = data)

  arg_names <- formals(tab_options) %>% names() %>% base::setdiff("data")
  arg_vals <- mget(arg_names)
  arg_vals <- arg_vals[!vapply(arg_vals, FUN = is.null, FUN.VALUE = logical(1))]
  arg_vals <- arg_vals %>% set_super_options()

  new_df <-
    dplyr::tibble(
      parameter = names(arg_vals) %>% tidy_gsub(".", "_", fixed = TRUE),
      value = unname(arg_vals)) %>%
    dplyr::left_join(
      opts_df %>% dplyr::select(parameter, type),
      by = "parameter"
    ) %>%
    dplyr::mutate(
      value = mapply(
        preprocess_tab_option,
        option = value, var_name = parameter, type = type,
        SIMPLIFY = FALSE)
    ) %>%
    dplyr::select(-type)

  # This rearranges the rows in the `opts_df` table, but this
  # shouldn't be a problem
  opts_df <-
    dplyr::bind_rows(
      new_df %>%
        dplyr::inner_join(
          opts_df %>% dplyr::select(-value),
          by = "parameter"
        ),
      opts_df %>%
        dplyr::anti_join(new_df, by = "parameter")
    )

  # Write the modified options table back to `data`
  data <- dt_options_set(data = data, options = opts_df)

  data
}

#' Modify the set of footnote marks
#'
#' Alter the footnote marks for any footnotes that may be present in the table.
#' Either a vector of marks can be provided (including Unicode characters), or,
#' a specific keyword could be used to signify a preset sequence. This function
#' serves as a shortcut for using `tab_options(footnote.marks = {marks})`
#'
#' We can supply a vector of that will represent the series of marks.
#' The series of footnote marks is recycled when its usage goes beyond the
#' length of the set. At each cycle, the marks are simply doubled, tripled, and
#' so on (e.g., `*` -> `**` -> `***`). The option exists for providing keywords
#' for certain types of footnote marks. The keywords are:
#'
#' \itemize{
#' \item `"numbers"`: numeric marks, they begin from 1 and these marks are not
#' subject to recycling behavior
#' \item `"letters"`: miniscule alphabetic marks, internally uses the `letters`
#' vector
#' which contains 26 lowercase letters of the Roman alphabet
#' \item `"LETTERS"`: majuscule alphabetic marks, using the `LETTERS` vector
#' which has 26 uppercase letters of the Roman alphabet
#' \item `"standard"`: symbolic marks, four symbols in total
#' \item `"extended"`: symbolic marks, extends the standard set by adding two
#' more symbols, making six
#' }
#'
#' @inheritParams fmt_number
#' @param marks Either a vector (that will represent the series of marks) or a
#'   keyword that represents a preset sequence of marks. The valid keywords are:
#'   `"numbers"` (for numeric marks), `"letters"` and `"LETTERS"` (for lowercase
#'   and uppercase alphabetic marks), `"standard"` (for a traditional set of
#'   four symbol marks), and `"extended"` (which adds two more symbols to the
#'   standard set).
#'
#' @examples
#' # Use `sza` to create a gt table,
#' # adding three footnotes; call
#' # `opt_footnote_marks()` to specify
#' # which footnote marks to use
#' tab_1 <-
#'   sza %>%
#'   dplyr::group_by(latitude, tst) %>%
#'   dplyr::summarize(
#'     SZA.Max = max(sza),
#'     SZA.Min = min(sza, na.rm = TRUE)
#'   ) %>%
#'   dplyr::ungroup() %>%
#'   dplyr::filter(latitude == 30, !is.infinite(SZA.Min)) %>%
#'   dplyr::select(-latitude) %>%
#'   gt(rowname_col = "tst") %>%
#'   tab_spanner_delim(delim = ".") %>%
#'   fmt_missing(
#'     columns = everything(),
#'     missing_text = "90+"
#'   ) %>%
#'   tab_stubhead("TST") %>%
#'   tab_footnote(
#'     footnote = "True solar time.",
#'     locations = cells_stubhead()
#'   ) %>%
#'   tab_footnote(
#'     footnote = "Solar zenith angle.",
#'     locations = cells_column_spanners(spanners = "SZA")
#'   ) %>%
#'   tab_footnote(
#'     footnote = "The Lowest SZA.",
#'     locations = cells_stub(rows = "1200")
#'   ) %>%
#'   opt_footnote_marks(marks = "standard")
#'
#' @section Figures:
#' \if{html}{\figure{man_opt_footnote_marks_1.svg}{options: width=100\%}}
#'
#' @export
opt_footnote_marks <- function(data,
                               marks = NULL) {

  if (!is.null(marks)) {
    data <- data %>% tab_options(footnote.marks = marks)
  }

  data
}

preprocess_tab_option <- function(option, var_name, type) {

  # Perform pre-processing on the option depending on `type`
  option <-
    switch(type,
           overflow = {
             if (isTRUE(option)) {
               "auto"
             } else if (isFALSE(option)) {
               "hidden"
             } else {
               option
             }
           },
           px = {
             if (is.numeric(option)) {
               px(option)
             } else {
               option
             }
           },
           option
    )

  # Perform checkmate assertions by `type`
  switch(type,
         logical = checkmate::assert_logical(
           option, len = 1, any.missing = FALSE, .var.name = var_name),
         overflow =,
         px =,
         value = checkmate::assert_character(
           option, len = 1, any.missing = FALSE, .var.name = var_name),
         values = checkmate::assert_character(
           option, min.len = 1, any.missing = FALSE, .var.name = var_name)
  )

  option
}

set_super_options <- function(arg_vals) {

  if ("table.align" %in% names(arg_vals)) {

    table_align_val <- arg_vals$table.align

    arg_vals$table.align <- NULL

    if (!(table_align_val %in% c("left", "center", "right"))) {
      stop("The chosen option for `table.align` (`", table_align_val, "`) is invalid\n",
           " * We can use either of `left`, `center`, or `right`.",
           call. = FALSE)
    }

    arg_vals$table.margin.left <- arg_vals$table.margin.left %||%
      switch(table_align_val,
             center = "auto",
             left = "0",
             right = "auto")

    arg_vals$table.margin.right <- arg_vals$table.margin.right %||%
      switch(table_align_val,
             center = "auto",
             left = "auto",
             right = "0")
  }

  arg_vals
}
