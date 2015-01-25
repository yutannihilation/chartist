#' SVG animation
#' 
#' @export
SVG_animate <- function(target = NULL, style = "opacity", easing = "easeOutQuart",
                        delay = NULL, dur = 1000, interval = 5000,
                        offset = NULL, relative = TRUE) {
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