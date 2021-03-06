.dt_options_key <- "_options"

dt_options_get <- function(data) {

  dt__get(data, .dt_options_key)
}

dt_options_set <- function(data, options) {

  dt__set(data, .dt_options_key, options)
}

dt_options_init <- function(data) {

  dplyr::tribble(
    ~parameter,                          ~scss,  ~category,          ~type,     ~value,
    "empty",                             FALSE,  "empty",            "value",   list(),
    "container_width",                   FALSE,  "container",        "px",      "auto",
    "container_height",                  FALSE,  "container",        "px",      "auto",
    "container_overflow_x",              FALSE,  "container",        "overflow","auto",
    "container_overflow_y",              FALSE,  "container",        "overflow","auto",
    "font_color",                         TRUE,  "table",            "value",   "#333333",
    "font_color_light",                   TRUE,  "table",            "value",   "#FFFFFF",
    "table_id",                          FALSE,  "table",            "value",   NA_character_,
    "table_width",                        TRUE,  "table",            "px",      "auto",
    "table_font_size",                    TRUE,  "table",            "px",      "16px",
    "table_background_color",             TRUE,  "table",            "value",   "#FFFFFF",
    "table_margin_left",                  TRUE,  "table",            "px",      "auto",
    "table_margin_right",                 TRUE,  "table",            "px",      "auto",
    "table_border_top_style",             TRUE,  "table",            "value",   "solid",
    "table_border_top_width",             TRUE,  "table",            "px",      "2px",
    "table_border_top_color",             TRUE,  "table",            "value",   "#A8A8A8",
    "table_border_bottom_style",          TRUE,  "table",            "value",   "solid",
    "table_border_bottom_width",          TRUE,  "table",            "px",      "2px",
    "table_border_bottom_color",          TRUE,  "table",            "value",   "#A8A8A8",
    "heading_background_color",           TRUE,  "heading",          "value",   NA_character_,
    "heading_title_font_size",            TRUE,  "heading",          "px",      "125%",
    "heading_subtitle_font_size",         TRUE,  "heading",          "px",      "85%",
    "heading_border_bottom_style",        TRUE,  "heading",          "value",   "solid",
    "heading_border_bottom_width",        TRUE,  "heading",          "px",      "2px",
    "heading_border_bottom_color",        TRUE,  "heading",          "value",   "#D3D3D3",
    "column_labels_background_color",     TRUE,  "columns",          "value",   NA_character_,
    "column_labels_font_size",            TRUE,  "columns",          "px",      "16px",
    "column_labels_font_weight",          TRUE,  "columns",          "value",   "initial",
    "column_labels_hidden",              FALSE,  "columns",          "logical", FALSE,
    "columns_border_top_style",           TRUE,  "columns",          "value",   "solid",
    "columns_border_top_width",           TRUE,  "columns",          "px",      "2px",
    "columns_border_top_color",           TRUE,  "columns",          "value",   "#D3D3D3",
    "columns_border_bottom_style",        TRUE,  "columns",          "value",   "solid",
    "columns_border_bottom_width",        TRUE,  "columns",          "px",      "2px",
    "columns_border_bottom_color",        TRUE,  "columns",          "value",   "#D3D3D3",
    "row_group_padding",                  TRUE,  "row_group",        "px",      "8px",
    "row_group_background_color",         TRUE,  "row_group",        "value",   NA_character_,
    "row_group_font_size",                TRUE,  "row_group",        "px",      "16px",
    "row_group_font_weight",              TRUE,  "row_group",        "value",   "initial",
    "row_group_border_top_style",         TRUE,  "row_group",        "value",   "solid",
    "row_group_border_top_width",         TRUE,  "row_group",        "px",      "2px",
    "row_group_border_top_color",         TRUE,  "row_group",        "value",   "#D3D3D3",
    "row_group_border_bottom_style",      TRUE,  "row_group",        "value",   "solid",
    "row_group_border_bottom_width",      TRUE,  "row_group",        "px",      "2px",
    "row_group_border_bottom_color",      TRUE,  "row_group",        "value",   "#D3D3D3",
    "table_body_border_top_style",        TRUE,  "table_body",       "value",   "solid",
    "table_body_border_top_width",        TRUE,  "table_body",       "px",      "2px",
    "table_body_border_top_color",        TRUE,  "table_body",       "value",   "#D3D3D3",
    "table_body_border_bottom_style",     TRUE,  "table_body",       "value",   "solid",
    "table_body_border_bottom_width",     TRUE,  "table_body",       "px",      "2px",
    "table_body_border_bottom_color",     TRUE,  "table_body",       "value",   "#D3D3D3",
    "row_padding",                        TRUE,  "row",              "px",      "8px",
    "summary_row_padding",                TRUE,  "summary_row",      "px",      "8px",
    "summary_row_background_color",       TRUE,  "summary_row",      "value",   NA_character_,
    "summary_row_text_transform",         TRUE,  "summary_row",      "value",   "inherit",
    "grand_summary_row_padding",          TRUE,  "grand_summary_row","px",      "8px",
    "grand_summary_row_background_color", TRUE,  "grand_summary_row","value",   NA_character_,
    "grand_summary_row_text_transform",   TRUE,  "grand_summary_row","value",   "inherit",
    "footnote_padding",                   TRUE,  "footnote",         "px",      "4px",
    "footnote_margin",                    TRUE,  "footnote",         "px",      "0px",
    "footnotes_border_top_style",         TRUE,  "footnote",         "value",   "solid",
    "footnotes_border_top_width",         TRUE,  "footnote",         "px",      "2px",
    "footnotes_border_top_color",         TRUE,  "footnote",         "value",   "#D3D3D3",
    "footnote_sep",                      FALSE,  "footnote",         "value",   "<br />",
    "footnote_marks" ,                   FALSE,  "footnote",         "values",  "numbers",
    "footnote_font_size",                 TRUE,  "footnote",         "px",      "90%",
    "sourcenote_padding",                 TRUE,  "sourcenote",       "px",      "4px",
    "sourcenote_font_size",               TRUE,  "sourcenote",       "px",      "90%",
    "sourcenotes_border_top_style",       TRUE,  "sourcenote",       "value",   "solid",
    "sourcenotes_border_top_width",       TRUE,  "sourcenote",       "px",      "2px",
    "sourcenotes_border_top_color",       TRUE,  "sourcenote",       "value",   "#D3D3D3",
    "row_striping_background_color",      TRUE,  "row",              "value",   "#8080800D",
    "row_striping_include_stub",         FALSE,  "row",              "logical", FALSE,
    "row_striping_include_table_body",   FALSE,  "row",              "logical", TRUE,
  )[-1, ] %>%
    dt_options_set(options = ., data = data)
}

dt_options_set_value <- function(data, option, value) {

  dt_options <-
    data %>%
    dt_options_get()

  dt_options$value[[which(dt_options$parameter == option)]] <- value

  dt_options %>%
    dt_options_set(options = ., data = data)
}

dt_options_get_value <- function(data, option) {

  dt_options <-
    data %>%
    dt_options_get()

  dt_options$value[[which(dt_options$parameter == option)]]
}
