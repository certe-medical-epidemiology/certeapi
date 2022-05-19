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

#* @apiTitle certeapi
#* @apiVersion 0.0.1
#* @apiDescription This is the Certe Medical Epidemiology API for R.
#* @apiLicense list(name = "GNU GPL v2.0", url = "https://github.com/certe-medical-epidemiology/certeapi/blob/main/LICENSE.md")


#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @serializer png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}

#* Return the mean of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /mean
function(a, b) {
  mean(c(as.numeric(a), as.numeric(b)))
}

#* Test sum 2
#* @param a getal 1
#* @param b getal 2
#* @get /sum
function(a = 0, b = 0) {
  as.numeric(a) + as.numeric(b)
}
