# possible patterns:
#   1
#   c(1, 2)
#   list(x = 1, y = 2)
get_label_offset <- function(labelOffset) {
  if(is.null(labelOffset) || !is.numeric(unlist(labelOffset))) {
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

# scaleMinSpace is for Y axis only
axis_options <- function(offset, labelOffset, showLabel, showGrid,
                         labelInterpolationFnc, scaleMinSpace = NULL) {
  axis <- list()
  
  axis$offset        <- offset
  axis$labelOffset   <- get_label_offset(labelOffset)
  axis$showLabel     <- showLabel
  axis$showGrid      <- showGrid
  axis$labelInterpolationFnc <- labelInterpolationFnc
  axis$scaleMinSpace <- scaleMinSpace
  
  if(length(axis) == 0){
    axis <- NULL
  }
  
  axis
}