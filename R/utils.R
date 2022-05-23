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

api2rd <- function() {
  lines <- readLines(get_api_file())
  lines <- lines[lines %like% "^#\\* " & lines %unlike% "@api"]
  
  lines <- gsub("#\\* @get (.*)", "\n## `[GET] \\1`:", lines)
  lines <- gsub("#\\* @post (.*)", "\n## `[POST] \\1`:", lines)
  lines <- gsub("#\\* @delete (.*)", "\n## `[DELETE] \\1`:", lines)
  
  lines <- gsub("#\\* @serializer (.*)", "\n\nSerializer: `\\1`\n\n", lines)
  
  lines <- gsub("#\\* @param ([a-zA-Z0-9_.]+)(.*)", "* `\\1` \\2", lines)
  lines <- gsub("#\\* (.*)", "\n\nDescription: \\1\n\nArguments:\n\n", lines)
  paste(lines, collapse = "\n")
}
