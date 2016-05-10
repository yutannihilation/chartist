#' Pie chart
#' 
#' The Chartist pie chart can be used to draw pie, donut or gauge charts.
#' 
#' @param width          fixed width for the chart as a string (i.e. '100px' or '50\%')
#' @param height         fixed height for the chart as a string (i.e. '100px' or '50\%')
#' @param chartPadding   padding of the chart drawing area to the container element and labels
#' @param classNames     Override the class names that get used to generate the SVG structure of the chart
#' @param startAngle     start angle of the pie chart in degrees where 0 points north
#' @param total          By specifying a total value, the sum of the values in the series must be this total
#'                       in order to draw a full pie. You can use this parameter to draw only parts of a pie
#'                       or gauge charts.
#' @param donut          if donut chart or not
#' @param donutWidth     donut stroke width
#' @param showLabel      if labels should be shown or not
#' @param labelOffset    offset of the each label (different from Line() and Bar(), labelOffset must be 
#'                       a single numeric value)
#' @param labelInterpolationFnc JS function to intercept the value from labels
#' @param labelDirection label direction. Possible values are 'neutral', 'explode' or 'implode'.
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
#' # Only first data series is used for Pie(). So, these two draw the same chart.
#' interp <- JS_interp(prefix = "Item ")
#' chartist(data, day) + Pie(labelInterpolationFnc = interp)
#' chartist(subset(data, , 1), day) + Pie(labelInterpolationFnc = interp)
#' 
#' # responsive chart
#' chartist(data[1:4, ], day) +
#'   # by default, draw a donut chart
#'   Pie(donut = TRUE, donutWidth = 100) +
#'   # for smaller screens, draw a normal pie chart
#'   Pie(donut = FALSE, showLabel = FALSE, responsiveQuery = "screen and (max-width: 600px)")
#' 
#' # By default, Chartist knows only four colours
#' # (c.f. https://github.com/gionkunz/chartist-js/issues/79)
#' # Corrently Pie() cannot work well with data whose length is more than four
#' chartist(data, day) + Pie()
#' }
#' 
#' @seealso \url{http://gionkunz.github.io/chartist-js/api-documentation.html#chartistpie-function-pie}
#' 
#' @export
Pie <- function(width = NULL, height = NULL, chartPadding = NULL, classNames = NULL,
                startAngle = NULL, total = NULL, donut = NULL, donutWidth = NULL,
                showLabel = NULL, labelOffset = NULL, labelInterpolationFnc = NULL, labelDirection = NULL,
                responsiveQuery = NULL) {
  options <- list()
    
  options$width      <- width
  options$height     <- height
  options$chartPadding <- chartPadding
  options$classNames <- classNames
  options$startAngle <- startAngle
  options$total      <- total
  options$donut      <- donut
  options$donutWidth <- donutWidth
  options$showLabel  <- showLabel
  options$labelOffset <- labelOffset
  options$labelInterpolationFnc <- labelInterpolationFnc
  options$labelDirection <- labelDirection
  
  if(is.null(responsiveQuery)) {
    structure(list(options = options,
                   responsiveOptions = NULL,
                   type = "Pie"),
              class = "chartist_options")
  } else {
    structure(list(options = NULL,
                   responsiveOptions = list(list(responsiveQuery, options)),
                   type = "Pie"),
              class = "chartist_options")
  }
}
