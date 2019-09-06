#' @title Combine data to be used in the applet into a single .RData file.
#' @description Produces a sunburst plot and data table, and stores them
#' with *file_names* in an .RData file called full_data.R. This .RData
#' file is saved in the shiny output folder, and is directly used by the
#' applet.
#' @param shiny_setup (required) The shiny_setup variable produced 
#' during the [shiny_setup()] function.
#' @param file_names (required) The file_names variable produced
#' during the [file_names()] function.
#' @param dataset (required) Whole brain dataset returned as an output of 
#' the [forward_warp()] function.
#' @details The new .RData file is automatically created in the shiny
#' output folder.
#' @export
#' @md

combine_datasets <- function(shiny_setup, file_names, dataset){
  
  sunburst_object <- SMART::get_sunburst(dataset)
  data_table <- SMART::get_table(dataset)
  
  forward_warp_files <- file_names$forward_warp_files
  plate_numbers <- file_names$plate_numbers
  registration_files <- file_names$registration_files
  segmentation_files <- file_names$segmentation_files
  
  save(sunburst_object, data_table, forward_warp_files, plate_numbers, registration_files, segmentation_files, file = paste0(shiny_setup$output_folder, "/full_data.RData"))
}





