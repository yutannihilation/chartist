#' Add options by + operand
#'
#' @name plus
#' @export
"+.chartist" <- function(e1, e2) {
  if(class(e2) == "chartist_options") {
    return(update_chartist_options(e1, e2))
  } else {
    stop("You cannot add ", e2, " to a Chartist plot")
  }
}

#' Update options of Chartist plot
#' 
#' @rdname plus
#' @export
update_chartist_options <- function(chartist_plot, chartist_options) {
  new_chartist_plot <- chartist_plot
  new_chartist_plot$x$options     <- defaults(chartist_options$options,     new_chartist_plot$x$options)
  new_chartist_plot$x$type        <- defaults(chartist_options$type,        new_chartist_plot$x$type)
  
  for(target in names(chartist_options$svg_animate)){
      new_chartist_plot$x$svg_animate[[target]] <- 
        defaults(chartist_options$svg_animate[[target]], new_chartist_plot$x$svg_animate[[target]])      
  }
  
  new_chartist_plot
}

#' The same function as plyr::defaults.
defaults <- function(x, y) {
  if(is.null(x)) return(y)
  
  c(x, y[setdiff(names(y), names(x))])
}