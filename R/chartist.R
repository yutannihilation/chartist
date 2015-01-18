#' Draw a Chartist.js chart
#'
#' Draw a Chartist.js chart. \code{chartist} is NSE version and \code{chartist_} is SE version. 
#' You can specify column the same way as \code{dplyr}'s \code{select} does (The trick is very simple;
#' actually \code{select} is used inside).
#' 
#' @param data     data.frame containing x-axis label and data series
#' @param x_labels x-axis labels, or the column name which contains x-axis labels
#' @param select_cols column name(s) of data
#' @param ...      column name(s) of data. If not specified, use all column except for \code{label_colname}
#'
#' @name chartist
#' 
#' @examples
#' set.seed(324)
#' data <- data.frame(
#'   day = paste0("day", 1:10),
#'   A   = runif(10, 0, 10),
#'   B   = runif(10, 0, 10),
#'   C   = runif(10, 0, 10)
#' )
#' 
#' # NSE version
#' chartist(data, day)
#' 
#' # These are the same
#' chartist(data, day, A, B)
#' chartist(data, day, A:B)
#' chartist(data, day, -C)
#' 
#' # SE version
#' chartist_(data, "day", c("A", "B"))
#' 
#' # SE version is usuful when you use variables
#' lab <- "day"
#' col <- c("A", "B")
#' chartist_(data, lab, col)
#' 
#' # With using SE version, labels can be specified directly
#' chartist_(data, rep(c("Odd", "Even"), 5), "A")
#' 
#' @seealso \url{http://gionkunz.github.io/}
#' @importFrom dplyr select_
#' @export
chartist_ <- function(data, x_labels, select_cols) {
  
  x_labels_len <- length(x_labels)
  if(x_labels_len == 1) {
    
    # if x_labels is a column name, get the column values
    x_labels_colname <- x_labels
    x_labels <- unname(unlist(
      dplyr::select_(data, x_labels_colname)
      ))
    
    # exclude the column from data
    data <- dplyr::select_(data, sprintf("-%s", x_labels_colname))
    
  } else if(x_labels_len != nrow(data)) {
    stop("Length of x-axis labels and data must be the same.")
  }

  series_cols <- dplyr::select_(data, .dots = select_cols)
  
  series <- unname(as.list(series_cols))

  x <- list()
  
  x$data <- list(
    labels = x_labels,
    series = series
  )
  
  # line chart is defaultly drawn
  x$type <- "Line"

  # create widget
  htmlwidgets::createWidget(
    name = 'chartist',
    x,
    package = 'chartist'
  )
}

#' NSE Version of function to create chartist plot
#' 
#' @rdname chartist
#' @importFrom dplyr select_vars
#' @export
chartist <- function(data, x_label_colname, ...) {
  x_label_colname <- as.character(substitute(x_label_colname))
  other_colname <- setdiff(names(data), x_label_colname)
  
  n_dots <- function(...) nargs()
  if (n_dots(...) > 0) {
    select_cols <- unname(dplyr::select_vars(other_colname, ...))
  } else {
    select_cols <- other_colname
  }
  
  chartist_(data, x_label_colname, select_cols)
}

#' Widget output function for use in Shiny
#'
#' @export
chartistOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'chartist', width, height, package = 'chartist')
}

#' Widget render function for use in Shiny
#'
#' @export
renderChartist <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, chartistOutput, env, quoted = TRUE)
}

chartist_html <- function(id, style, class, ...) {
  tags$div(class = paste(class, "ct-chart", "ct-perfect-fourth"),
           id = id, style=style)
}