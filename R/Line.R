#' Line chart
#' 
#' The Chartist line chart can be used to draw Line or Scatter charts.
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
#' @param showLine       if the line should be drawn or not
#' @param showPoint      if dots should be drawn or not
#' @param showArea       if the line chart should draw an area
#' @param areaBase       base for the area chart that will be used to close the area shape
#'                       (is normally 0)
#' @param lineSmooth     if the lines should be smoothed (Catmull-Rom-Splines will be used)
#' @param low            lower limit of value
#' @param high           higher limit of value
#' @param chartPadding   padding of the chart drawing area to the container element and labels
#' @param fullWidth      When set to true, the last grid line on the x-axis is not drawn and the 
#'                       chart elements will expand to the full available width of the chart. For 
#'                       the last label to be drawn correctly you might need to add chart padding
#'                       or offset the last label with a draw event handler.
#' @param classNames     Override the class names that get used to generate the SVG structure of the chart
#' @param responsiveQuery if specified, the options are used only when the query matches.
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
#' chartist(data, day) + Line(showArea = TRUE, showPoint = FALSE)
#' 
#' # use JS function to generate axis labels
#' interp <- JS_interp(interval = 4, prefix = " day")
#' chartist(data, day) + Line(x_labelInterpolationFnc = interp)
#' 
#' # Of cource you can create your own JS function
#' interp2 <- htmlwidgets::JS("function(value, index) {
#'                              return index % 7 === 0 ? 'week ' + (index / 7) : null;}")
#' chartist(data, day) + Line(x_labelInterpolationFnc = interp2)
#' 
#' # these are the same
#' chartist(data, day) + Point()
#' chartist(data, day) + Line(showLine = FALSE)
#' 
#' # responsive chart
#' set.seed(324)
#' data <- data.frame(
#'   day = 1:10,
#'   A   = runif(10, 0, 10),
#'   B   = runif(10, 0, 10),
#'   C   = runif(10, 0, 10)
#' )
#' 
#' chartist(data, day) +
#'   # By default, the axis labels are day-bases
#'   Line(x_labelInterpolationFnc = JS_interp(interval = 1, prefix = "day")) +
#'   # For small screens, they are week-bases
#'   Line(x_labelInterpolationFnc = JS_interp(interval = 7, prefix = "week"),
#'        showPoint = FALSE,
#'        responsiveQuery = "screen and (max-width: 600px)")
#' }
#' 
#' @seealso \url{http://gionkunz.github.io/chartist-js/api-documentation.html#chartistline-function-line}
#' 
#' @export
Line <- function(x_offset = NULL, x_labelOffset = NULL, x_showLabel = NULL, x_showGrid = NULL,
                 x_labelInterpolationFnc = NULL,
                 y_offset = NULL, y_labelOffset = NULL, y_showLabel = NULL, y_showGrid = NULL,
                 y_labelInterpolationFnc = NULL, y_scaleMinSpace = NULL,
                 width = NULL, height = NULL, showLine = NULL, showPoint = NULL, showArea = NULL,
                 areaBase = NULL, lineSmooth = NULL, low = NULL, high = NULL, chartPadding = NULL,
                 fullWidth = NULL, classNames = NULL, responsiveQuery = NULL) {
  options <- list()
  
  options$axisX <- axis_options(x_offset, x_labelOffset, x_showLabel, x_showGrid,
                                x_labelInterpolationFnc)
  
  options$axisY <- axis_options(y_offset, y_labelOffset, y_showLabel, y_showGrid,
                                y_labelInterpolationFnc, y_scaleMinSpace)
  
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
  
  if(is.null(responsiveQuery)) {
    structure(list(options = options,
                   responsiveOptions = NULL,
                   type = "Line"),
              class = "chartist_options")
  } else {
    structure(list(options = NULL,
                   responsiveOptions = list(list(responsiveQuery, options)),
                   type = "Line"),
              class = "chartist_options")
  }
}

#' Scatter Plot
#' 
#' A short cut for Line() with showLine = FALSE
#' 
#' @param ... arguments passed to Line()
#' @export
Point <- function(...) {
  Line(showLine = FALSE, ...)
}