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

# -----------------------------------------------------------------------------

#* @get /esbl_prediction
#* Retrieve an ESBL ETEST prediction and reliability for a vector of MIC values.
#* @param AMC Amoxicillin/clavulanic acid, can be left blank
#* @param AMP Ampicillin, can be left blank
#* @param TZP Piperacillin/tazobactam, can be left blank
#* @param CXM Cefuroxime, can be left blank
#* @param FOX Cefoxitin, can be left blank
#* @param CTX Cefotaxime, can be left blank
#* @param CAZ Ceftazidime, can be left blank
#* @param GEN Gentamicin, can be left blank
#* @param TOB Tobramycin, can be left blank
#* @param TMP Trimethoprim, can be left blank
#* @param NIT Nitrofurantoin, can be left blank
#* @param FOS Fosfomycin, can be left blank
#* @param CIP Ciprofloxacin, can be left blank
#* @param IPM Imipenem, can be left blank
#* @param MEM Meropenem, can be left blank
#* @param COL Colistin, can be left blank
function(AMC = NA, AMP = NA, TZP = NA, CXM = NA,
         FOX = NA, CTX = NA, CAZ = NA, GEN = NA,
         TOB = NA, TMP = NA, NIT = NA, FOS = NA,
         CIP = NA, IPM = NA, MEM = NA, COL = NA) {
  
  mdl <- get_model("esbl_prediction")
  to_pred <- data.frame(AMC = as.double(AMR::as.mic(AMC %||% NA_real_)),
                        AMP = as.double(AMR::as.mic(AMP %||% NA_real_)),
                        TZP = as.double(AMR::as.mic(TZP %||% NA_real_)),
                        CXM = as.double(AMR::as.mic(CXM %||% NA_real_)),
                        FOX = as.double(AMR::as.mic(FOX %||% NA_real_)),
                        CTX = as.double(AMR::as.mic(CTX %||% NA_real_)),
                        CAZ = as.double(AMR::as.mic(CAZ %||% NA_real_)),
                        GEN = as.double(AMR::as.mic(GEN %||% NA_real_)),
                        TOB = as.double(AMR::as.mic(TOB %||% NA_real_)),
                        TMP = as.double(AMR::as.mic(TMP %||% NA_real_)),
                        NIT = as.double(AMR::as.mic(NIT %||% NA_real_)),
                        FOS = as.double(AMR::as.mic(FOS %||% NA_real_)),
                        CIP = as.double(AMR::as.mic(CIP %||% NA_real_)),
                        IPM = as.double(AMR::as.mic(IPM %||% NA_real_)),
                        MEM = as.double(AMR::as.mic(MEM %||% NA_real_)),
                        COL = as.double(AMR::as.mic(COL %||% NA_real_)))
  
  # remove columns with only NAs
  to_pred <- to_pred[, vapply(FUN.VALUE = logical(1), to_pred, function(col) !all(is.na(col)))]
  
  pkg_env$warn <- NULL
  tryCatch(pkg_env$outcome <- mdl |> 
             certestats::apply_model_to(to_pred),
           warning = function(w) pkg_env$warn <- w$message)
  
  list(outcome = pkg_env$outcome$predicted,
       certainty = pkg_env$outcome$certainty,
       haswarning = !is.null(pkg_env$warn),
       warning = as.character(pkg_env$warn))
}
