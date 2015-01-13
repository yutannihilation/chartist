#' Line plot
#' 
#' The Chartist line chart can be used to draw Line or Scatter charts.
#' 
#' @export
Line <- function(x_offset = NULL, x_labelOffset = NULL, x_showLabel = NULL, x_showGrid = NULL,
                 x_labelInterpolationFnc = NULL,
                 y_offset = NULL, y_labelOffset = NULL, y_showLabel = NULL, y_showGrid = NULL,
                 y_labelInterpolationFnc = NULL, y_scaleMinSpace = NULL,
                 width = NULL, height = NULL, showLine = NULL, showPoint = NULL, showArea = NULL,
                 areaBase = NULL, lineSmooth = NULL, low = NULL, high = NULL, chartPadding = NULL,
                 fullWidth = NULL, classNames = NULL) {
  options <- list()
  
  # Options for X axis
  axisX <- list()
  axisX$offset       <- x_offset
  axisX$labelOffset  <- get_label_offset(x_labelOffset)
  axisX$showLabel    <- x_showLabel
  axisX$showGrid     <- x_showGrid
  axisX$labelInterpolationFnc <- x_labelInterpolationFnc
  
  if(length(axisX) > 0){
    options$axisX <- axisX
  }
  
  # Options for Y axis
  axisY <- list()
  axisY$offset       <- y_offset
  axisY$labelOffset  <- get_label_offset(y_labelOffset)
  axisY$showLabel    <- y_showLabel
  axisY$showGrid     <- y_showGrid
  axisY$labelInterpolationFnc <- y_labelInterpolationFnc
  axisY$scaleMinSpace <- y_scaleMinSpace
  
  if(length(axisY) > 0){
    options$axisY <- axisY
  }
  
  options$width     <- width
  options$height    <- height
  options$showLine  <- showLine
  options$showPoint <- showPoint
  options$showArea  <- showArea
  options$areaBase  <- areaBase
  options$lineSmooth <- lineSmooth
  options$low       <- low
  options$high      <- high
  options$chartPadding <- chartPadding
  options$fullWidth <- fullWidth
  options$classNames <- classNames
  
  structure(list(options = options, type = "Line"), class = "chartist_options")
}

#' Scatter Plot
#' 
#' A short cut for Line()
#' 
#' @export
Point <- function(...) {
  Line(showLine = FALSE, ...)
}

#' possible patterns:
#'   1
#'   c(1, 2)
#'   list(x = 1, y = 2)
get_label_offset <- function(labelOffset) {
  if(is.null(labelOffset)) {
    return(NULL)
  } else if(length(labelOffset) == 1) {
    return(list(x = labelOffset,  y = labelOffset))
  } else if(length(labelOffset) == 2) {
    result        <- as.list(labelOffset)
    names(result) <- c("x", "y")
    return(result)
  }
  return(NULL)
}