#' Bar chart
#' 
#' The Chartist bar chart can be used to draw unipolar or bipolar bar and grouped bar charts.
#' 
#' @param x_offset       offset of the X-axis
#' @param x_labelOffset  offset of the each X-axis label (e.g. 1, c(1,2), list(x=1, y=2))
#' @param x_showLabel    if X-axis labels should be shown or not
#' @param x_showGrid     if X-axis grid should be drawn or not
#' @param x_labelInterpolationFnc JS function to intercept the value from the X-axis label
#' @param y_offset       offset of the Y-axis labels to the chart area
#' @param y_labelOffset  offset of the X-axis labels (e.g. 1, c(1,2), list(x=1, y=2))
#' @param y_showLabel    if Y-axis labels should be shown or not
#' @param y_showGrid     if Y-axis grid should be drawn or not
#' @param y_labelInterpolationFnc JS function to intercept the value from the Y-axis label
#' @param y_scaleMinSpace minimum height in pixel of the scale steps
#' @param width          fixed width for the chart as a string (i.e. '100px' or '50\%')
#' @param height         fixed height for the chart as a string (i.e. '100px' or '50\%')
#' @param low            lower limit of value
#' @param high           higher limit of value
#' @param chartPadding   padding of the chart drawing area to the container element and labels
#' @param seriesBarDistance distance in pixel of bars in a group
#' @param fullWidth      When set to true, the last grid line on the x-axis is not drawn and the 
#'                       chart elements will expand to the full available width of the chart. For 
#'                       the last label to be drawn correctly you might need to add chart padding
#'                       or offset the last label with a draw event handler.
#' @param centerBars     if bars are drawn on the grid line rather than between two grid lines
#' @param stackBars      if series bars are stacked or not
#'                       (in stacked mode the seriesBarDistance property will have no effect).
#' @param classNames     Override the class names that get used to generate the SVG structure of the chart
#' 
#' @examples
#' \dontrun{
#' set.seed(324)
#' data <- data.frame(
#'   day = 1:20,
#'   A   = runif(20, 0, 10),
#'   B   = runif(20, 0, 10),
#'   C   = runif(20, 0, 10),
#'   D   = runif(20, 0, 10)
#'   )
#' 
#' chartist(data, day) + Bar()
#' 
#' chartist(data, day) + Bar(stackBars = TRUE)
#' }
#' 
#' @seealso \url{http://gionkunz.github.io/chartist-js/api-documentation.html#chartistbar-function-bar}
#' 
#' @export
Bar <- function(x_offset = NULL, x_labelOffset = NULL, x_showLabel = NULL, x_showGrid = NULL,
                x_labelInterpolationFnc = NULL,
                y_offset = NULL, y_labelOffset = NULL, y_showLabel = NULL, y_showGrid = NULL,
                y_labelInterpolationFnc = NULL, y_scaleMinSpace = NULL,
                width = NULL, height = NULL, low = NULL, high = NULL,
                chartPadding = NULL, seriesBarDistance = NULL, fullWidth = NULL,
                centerBars = NULL, stackBars = NULL, classNames = NULL) {
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
  options$low       <- low
  options$high      <- high
  options$chartPadding <- chartPadding
  options$seriesBarDistance <- seriesBarDistance
  options$fullWidth <- fullWidth
  options$centerBars <- centerBars
  options$stackBars <- stackBars
  options$classNames <- classNames
  
  structure(list(options = options, type = "Bar"), class = "chartist_options")
}
