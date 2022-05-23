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


##      PLEASE NOT THAT THIS FILE WILL NOT BE LOADED WITH THE PACKAGE!     ##
## This means that every non-base function has be called with the pkg name ##


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
  
  mdl_path <- certeapi::get_model_path("esbl_prediction")
  to_pred <- data.frame(AMC = as.double(AMR::as.mic(AMC)),
                        AMP = as.double(AMR::as.mic(AMP)),
                        TZP = as.double(AMR::as.mic(TZP)),
                        CXM = as.double(AMR::as.mic(CXM)),
                        FOX = as.double(AMR::as.mic(FOX)),
                        CTX = as.double(AMR::as.mic(CTX)),
                        CAZ = as.double(AMR::as.mic(CAZ)),
                        GEN = as.double(AMR::as.mic(GEN)),
                        TOB = as.double(AMR::as.mic(TOB)),
                        TMP = as.double(AMR::as.mic(TMP)),
                        NIT = as.double(AMR::as.mic(NIT)),
                        FOS = as.double(AMR::as.mic(FOS)),
                        CIP = as.double(AMR::as.mic(CIP)),
                        IPM = as.double(AMR::as.mic(IPM)),
                        MEM = as.double(AMR::as.mic(MEM)),
                        COL = as.double(AMR::as.mic(COL)))
  
  # remove columns with only NAs
  to_pred <- to_pred[, vapply(FUN.VALUE = logical(1), to_pred, function(col) !all(is.na(col))), drop = FALSE]
  
  lst <- list()
  lst$warn <- NULL
  lst$outcome <- NULL
  
  # call prediction function but write warning message to list as well
  withCallingHandlers({
    lst$outcome <- mdl_path |> 
      certeapi::read_model() |> 
      certestats::apply_model_to(to_pred)
  }, warning = function(w) {
    lst$warn <<- conditionMessage(w)
    invokeRestart("muffleWarning")
  })
  
  list(name = "ESBL prediction",
       outcome = lst$outcome$predicted,
       certainty = lst$outcome$certainty,
       haswarning = !is.null(lst$warn),
       warningtxt = as.character(lst$warn),
       model = list(modified = format(file.mtime(mdl_path), format = "%Y-%m-%d %H:%M:%S %Z"),
                    metrics = mdl_path |> 
                      certeapi::read_model() |> 
                      certestats::metrics()))
}
