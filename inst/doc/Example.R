## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(metacore)
library(xml2)

## -----------------------------------------------------------------------------
doc <- read_xml(metacore_example("SDTM_define.xml"))
xml_ns_strip(doc)

## -----------------------------------------------------------------------------
ds_spec2 <- xml_to_ds_spec(doc)
ds_vars <- xml_to_ds_vars(doc)
var_spec <- xml_to_var_spec(doc)
value_spec <- xml_to_value_spec(doc)
code_list <- xml_to_codelist(doc)
derivations <- xml_to_derivations(doc)

## -----------------------------------------------------------------------------
test <- metacore(ds_spec2, ds_vars, var_spec, value_spec, derivations, code_list)

## -----------------------------------------------------------------------------
# a metacore object with all your dataframes
subset <- test %>% select_dataset("DM")
subset$ds_spec

# a simplified dataframe 
subset_t <- test %>% select_dataset("DM", simplify = TRUE)

## -----------------------------------------------------------------------------
subset_t

