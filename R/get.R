# ===================================================================== #
#  An R package by Certe:                                               #
#  https://github.com/certe-medical-epidemiology                        #
#                                                                       #
#  Licensed as GPL-v2.0.                                                #
#                                                                       #
#  Developed at non-profit organisation Certe Medical Diagnostics &     #
#  Advice, department of Medical Epidemiology.                          #
#                                                                       #
#  This R package is free software; you can freely use and distribute   #
#  it for both personal and commercial purposes under the terms of the  #
#  GNU General Public License version 2.0 (GNU GPL-2), as published by  #
#  the Free Software Foundation.                                        #
#                                                                       #
#  We created this package for both routine data analysis and academic  #
#  research and it was publicly released in the hope that it will be    #
#  useful, but it comes WITHOUT ANY WARRANTY OR LIABILITY.              #
# ===================================================================== #

#' Get File Locations
#' 
#' Use [get_model_path()] to retrieve the prediction model path, which should be an RDS file.
#' @name get
#' @rdname get
#' @export
get_api_file <- function() {
  system.file("api.R", package = "certeapi")
}

#' @rdname get
#' @param name (file)name of the model
#' @param path folder of where the models are stored
#' @export
get_model_path <- function(name, path = read_secret("api.modelpath")) {
  if (name %unlike% "[.]rds$") {
    name <- paste0(name, ".rds")
  }
  model_path <- paste0(path, "/", name)
  if (file.exists(model_path)) {
    return(model_path)
  } else {
    stop("Model not found: ", model_path)
  }
}

#' @rdname get
#' @export
read_model <- function(path) {
  readRDS(file = path)
}
