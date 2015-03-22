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
#' @param responsiveQuery if specified, the options are used only when the query matches.
#' 
#' @examples
#' \dontrun{
#' set.seed(324)
#' data <- data.frame(
#'   day = 1:10,
#'   A   = runif(10, 0, 10),
#'   B   = runif(10, 0, 10),
#'   C   = runif(10, 0, 10),
#'   D   = runif(10, 0, 10)
#' )
#' 
#' chartist(data[1:6, ], day) + Bar()
#' 
#' chartist(data, day) + Bar(stackBars = TRUE)
#' 
#' # responsive chart
#' chartist(data, day) +
#'   # By default, draw a normal bar chart
#'   Bar(stackBars = FALSE) +
#'   # For smaller screens, draw a stacked bar chart
#'   Bar(stackBars = TRUE, responsiveQuery = "screen and (max-width: 600px)")
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
                centerBars = NULL, stackBars = NULL, classNames = NULL, responsiveQuery = NULL) {
  options <- list()
  
  options$axisX <- axis_options(x_offset, x_labelOffset, x_showLabel, x_showGrid,
                                x_labelInterpolationFnc)
  
  options$axisY <- axis_options(y_offset, y_labelOffset, y_showLabel, y_showGrid,
                                y_labelInterpolationFnc, y_scaleMinSpace)
  
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
  
  if(is.null(responsiveQuery)) {
    structure(list(options = options,
                   responsiveOptions = NULL,
                   type = "Bar"),
              class = "chartist_options")
  } else {
    structure(list(options = NULL,
                   responsiveOptions = list(list(responsiveQuery, options)),
                   type = "Bar"),
              class = "chartist_options")
  }
}
