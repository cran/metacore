## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
   collapse = TRUE,
   comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(metacore)
library(dplyr)
library(purrr)
library(stringr)

## ----error=TRUE---------------------------------------------------------------
spec_to_metacore(metacore_example("mock_spec.xlsx"))

## -----------------------------------------------------------------------------
metacore:::spec_type(metacore_example("mock_spec.xlsx"))

## -----------------------------------------------------------------------------
doc <- read_all_sheets(metacore_example("mock_spec.xlsx"))
doc %>% map(head)


## ----error=TRUE---------------------------------------------------------------
spec_type_to_ds_spec(doc)

## -----------------------------------------------------------------------------
doc$Domains %>% names()

## -----------------------------------------------------------------------------
ds_spec <- spec_type_to_ds_spec(doc, 
                                cols = c("dataset" = "Name", 
                                         "structure" = "Data Structure",  
                                         "label" = "Label"))
head(ds_spec)

## ----error=TRUE---------------------------------------------------------------
spec_type_to_ds_vars(doc)

## -----------------------------------------------------------------------------
doc$Variables %>% head()

ds_vars<- spec_type_to_ds_vars(doc, cols = c("dataset" = "Domain",
                                             "variable" = "[V|v]ariable [N|n]ame",
                                             "order" = "[V|v]ariable [O|o]rder",
                                             "keep" = "[M|m]andatory"),
                               key_seq_cols = c("dataset" = "Domain Name",
                                                "key_seq" = "Key"),
                               sheet = "[V|v]ar|Domains") 

head(ds_vars)

## -----------------------------------------------------------------------------
var_spec <- spec_type_to_var_spec(doc, cols = c("variable" = "Variable Name",
                                                "length" = "[L|l]ength",
                                                "label" = "[L|l]abel",
                                                "type" = "[T|t]ype",
                                                "dataset" = "[D|d]ataset|[D|d]omain",
                                                "format" = "Format"))
head(var_spec)

## -----------------------------------------------------------------------------
var_spec <- var_spec %>% 
   mutate(format = if_else(str_detect(format, "\\."), format, ""))

## -----------------------------------------------------------------------------
value_spec <- spec_type_to_value_spec(doc, cols = c("dataset" = "VLM Name|Domain",
                                                    "variable" = "VLM Name|Variable Name",
                                                    "origin" = "[O|o]rigin",
                                                    "type" = "[T|t]ype",
                                                    "code_id" = "Controlled Term",
                                                    "where" = "Parameter Code",
                                                    "derivation_id" = "Method",
                                                    "predecessor" = "Method"),
                                      where_sep_sheet = FALSE)
head(value_spec)

## -----------------------------------------------------------------------------
derivation <- spec_type_to_derivations(doc, cols = c("derivation_id" = "Name",
                                                     "derivation" = "[D|d]efinition|[D|d]escription"), 
                                       var_cols = c("dataset" = "Domain Name",
                                                    "variable" = "Variable Name|VLM",
                                                    "origin" = "[O|o]rigin",
                                                    "predecessor" = "Comment",
                                                    "comment" = "Comment")) 
head(derivation)

## -----------------------------------------------------------------------------
codelist <- spec_type_to_codelist(doc, codelist_cols = c("code_id" = "Codelist Code",
                                                         "name" = "Codelist Name",
                                                         "code" = "Coded Value",
                                                         "decode" = "Decoded Value"),
                                  simplify = TRUE,
                                  dict_cols = NULL)
head(codelist)

## -----------------------------------------------------------------------------
metacore(ds_spec, ds_vars, var_spec, value_spec,
         derivation, codelist)

