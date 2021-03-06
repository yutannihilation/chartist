#' SVG animation
#' 
#' @param target   name of element to animate ("label", "grid", "point", "line", "bar", "slice")
#' @param style    name of style to animate ("x", "x1", "x2", "y", "y1", "y2", "opacity")
#' @param easing   name of an easing function in Chartist.Svg.Easing or an array with four numbers
#'                 specifying a cubic (e.g. \code{"easeInOutBack"} or \code{c(0, 0.1, 1.1, 1)})
#' @param delay    delay between when one element animated and when the next element will animate (unit: ms)
#' @param dur      duration of animation (unit: ms)
#' @param interval interval of animation (unit: ms)
#' @param offset   offset from the original value
#' @param relative if the offset value is relative to each element's original value or absolute
#' 
#' @examples
#' \dontrun{
#' set.seed(324)
#' data <- data.frame(
#'   day = paste0("day", 1:20),
#'   A   = runif(10, 0, 20),
#'   B   = runif(10, 0, 20),
#'   C   = runif(10, 0, 20),
#'   D   = runif(10, 0, 20),
#'   E   = runif(10, 0, 20),
#'   stringsAsFactors = FALSE
#' )
#' 
#' # a simple example
#' chartist(data, day) + Point() +
#'   SVG_animate(target = "point", offset = -30, style = "x1")
#'   
#' # `offset` is used as the absolute value when
#' #   1) relative = FALSE
#' #   2) style = "opacity"
#' chartist(data, day) +
#'   SVG_animate(target = "line", offset = 0, style = "opacity")
#' 
#' # If you want to animate things sequentially, you can use `delay` parameter.
#' chartist(data, day) +
#'   SVG_animate(target = "line", style = "opacity", offset = 0, delay = 300)
#' 
#' # You can even overlay animations.
#' chartist(data, day) + 
#' Point() +
#'   SVG_animate(target = "point", style = "x1", offset = -100, delay = 5) +
#'   SVG_animate(target = "point", style = "y1", offset = 100, delay = 3) +
#'   SVG_animate(target = "point", style = "opacity", offset = 0, delay = 5)
#' }
#' 
#' @seealso \url{http://gionkunz.github.io/chartist-js/api-documentation.html#chartistsvg-function-animate}
#' 
#' 
#' @export
SVG_animate <- function(target = NULL, style = "opacity", easing = "easeOutQuart",
                        delay = NULL, dur = 1000, interval = 5000,
                        offset = 0, relative = TRUE) {
  animate_params <- list()
  animate_params$target   <- target
  animate_params$style    <- style
  animate_params$easing   <- easing
  animate_params$delay    <- delay
  animate_params$dur      <- dur
  animate_params$interval <- interval
  animate_params$offset   <- offset
  animate_params$relative <- relative
  
  animate_style <- list()
  animate_style[[style]] <- animate_params
  
  animate_target <- list()
  animate_target[[target]] <- animate_style
  
  structure(list(svg_animate = animate_target), class = "chartist_options")
}