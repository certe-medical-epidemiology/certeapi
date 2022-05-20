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


#* @get /echo
#* Echo back the input
#* @param msg The message to echo
function(msg = "") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* @get /plot
#* Plot a histogram
#* @serializer png
function() {
  rand <- rnorm(100)
  hist(rand)
}

#* @post /mean
#* Return the mean of two numbers
#* @param a The first number to add
#* @param b The second number to add
function(a, b) {
  mean(c(as.numeric(a), as.numeric(b)))
}

#* @get /sum
#* Test sum 2
#* @param a getal 1
#* @param b getal 2
function(a = 0, b = 0) {
  as.numeric(a) + as.numeric(b)
}

#* @get /esbl_prediction
#* Retrieve an ESBL ETEST prediction and reliability for a vector of MIC values.
#* @param mo microorganism, a code or a name
function(mo) {
  list(mo = AMR::mo_name(mo),
       value = sample(c(TRUE, FALSE), 1),
       reliability = runif(1, 0.5, 1))
}
