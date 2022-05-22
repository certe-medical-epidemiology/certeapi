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

pkg_env <- new.env(hash = FALSE)

`%||%` <- function(x, y) if (is.null(x)) y else x

api2rd <- function() {
  lines <- readLines(get_api_file())
  lines <- lines[lines %like% "^#\\* " & lines %unlike% "@api"]
  
  lines <- gsub("#\\* @get (.*)", "\n## `\\1` (method `GET`):", lines)
  lines <- gsub("#\\* @post (.*)", "\n## `\\1` (method `POST`):", lines)
  lines <- gsub("#\\* @delete (.*)", "\n## `\\1` (method `DELETE`):", lines)
  
  lines <- gsub("#\\* @serializer (.*)", "\n\nSerializer: `\\1`\n\n", lines)
  
  lines <- gsub("#\\* @param ([a-zA-Z0-9_.]+)(.*)", "* `\\1` \\2", lines)
  lines <- gsub("#\\* (.*)", "\n\nDescription: \\1\n\nArguments:\n\n", lines)
  paste(lines, collapse = "\n")
}
