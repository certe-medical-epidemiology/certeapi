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

#' Start API
#' 
#' This function starts the API server.
#' @param port port number
#' @details For cron on UNIX (Linux/macOS), use the following command:
#' 
#' `Rscript -e "certeapi::startup()" &>> /path/api.log &`
#' 
#' Use `Rscript --vanilla -e` to *not* load any user settings such as `.Rprofile`. The trailing `&` will make the script run in the background.
#' @importFrom plumber pr_set_docs pr_run pr
#' @importFrom rapidoc rapidoc_index
#' @importFrom certestyle colourpicker
#' @export
startup <- function(port = read_secret("api.port")) {
  
  port <- as.integer(port)[1L]
  if (is.na(port) || port == 0) {
    port <- NULL
  }

  file_path <- get_api_file()
  
  if (file.exists(file_path)) {
    
    message()
    message(Sys.time())
    message("Starting API from file '", file_path, "'...")
    message("This R session has process ID (pid) ", Sys.getpid())
    
    loadNamespace("rapidoc")
    
    file_path |> 
      pr() |> 
      pr_set_docs("rapidoc",
                  show_header = FALSE,
                  primary_color = colourpicker("certeblauw"),
                  bg_color = colourpicker("white"),
                  text_color = colourpicker("black")) |> 
      pr_run(port = port, quiet = FALSE)
    
  } else {
    
    stop("API file not found")
    
  }
}

#' Overview of API Endpoints
#' 
#' This page provides an overview of all available API endpoints and their arguments.
#' @section Overview of endpoints: `r api2rd()`
#' @rdname endpoints
#' @name endpoints
NULL
