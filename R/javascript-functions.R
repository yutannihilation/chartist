# Helper Functions to Generate Javascript Functions

#' A Helper Function To Create JS Functions For labelInterporationFnc
#' 
#' @name JS_interp
#' 
#' @param interval interval between labels
#' @param offset   offset to the first label
#' @param prefix   prefix of labels (e.g. $)
#' @param suffix   suffix of labels (e.g. kB)
#' 
#' @examples
#' \dontrun{
#' #' set.seed(324)
#' data <- data.frame(
#'   day = 1:20,
#'   A   = runif(20, 0, 10),
#'   B   = runif(20, 0, 10),
#'   C   = runif(20, 0, 10),
#'   D   = runif(20, 0, 10)
#'   )
#' 
#' chartist(data, day) + Line(x_labelInterpolationFnc = JS_interp(4, offset = 2))
#' 
#' chartist(data, day) + Line(x_labelInterpolationFnc = JS_interp(4, prefix = "day "))
#' }
#' 
#' @export
JS_interp <- function(interval = 1, offset = 0, prefix = NULL, suffix = NULL) {
  if(is.numeric(interval) && length(interval) != 1) stop("interval must be single numeric value")
  if(is.numeric(offset) && length(offset) != 1)     stop("offset must be single numeric value")
  
  # NULL is automatically removed by c()
  values <- c(sprintf('"%s"', prefix), "value", sprintf('"%s"', suffix))
  htmlwidgets::JS(sprintf("function(value, index) {return (index - %d) %% %d === 0 ? %s : null;}",
                          offset, interval, paste(values, collapse = " + ")))
}