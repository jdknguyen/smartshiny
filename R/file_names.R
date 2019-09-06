#' @title Generate a list of file names for images output by SMART.
#' @description Generates list of length 4 to store file names of
#' registration, segmentation, and forward warp images. These names
#' will be accessed downstream in the pipeline, including by future
#' functions and by the applet itself. This function requires that
#' the user has not modified the names of image files output by SMART.
#' @param shiny_setup (required) The shiny_setup variable produced 
#' during the [shiny_setup()] function.
#' @return Returns *file_names*, a list of length 4 containing 
#' the following information: registration filenames, segmentation
#' filenames, forward warp filenames, and plate numbers.
#' @export
#' @md

file_names <- function(shiny_setup){
  
  registration_files_fullname <- list.files(path = shiny_setup$setup$savepaths$out_auto_registration, pattern = ".tif", all.files = T, full.names = T)
  segmentation_files_fullname_initial <- list.files(path = shiny_setup$setup$savepaths$out_segmentation_schem, pattern = ".tif", all.files = T, full.names = T)
  forward_warp_files_fullname_initial <- list.files(path = shiny_setup$setup$savepaths$out_segmentation_warps, pattern = ".tif", all.files = T, full.names = T)
  
  registration_files_fullname_sorted <- gtools::mixedsort(registration_files_fullname, decreasing = FALSE)

  registration_files <- c()
  
  for(i in 1:length(registration_files_fullname_sorted)){
    temp_name <- strsplit(registration_files_fullname_sorted[i], split = "/", fixed = FALSE, perl = FALSE, useBytes = FALSE)
    registration_files[i] <- temp_name[[1]][length(temp_name[[1]])]
  }
  
  registration_files_no_extension <- c()
  
  for(i in 1:length(registration_files)){
    temp_name <- strsplit(registration_files[i], split = ".tif", fixed = FALSE, perl = FALSE, useBytes = FALSE)
    registration_files_no_extension <- c(registration_files_no_extension, temp_name[[1]][1])
  }
  
  registration_files <- registration_files_no_extension

  segmentation_files_fullname_sorted_initial <- gtools::mixedsort(segmentation_files_fullname_initial, decreasing = FALSE)

  segmentation_files_fullname_sorted <- c()
  
  plate_number <- "0"
  
  plate_numbers <- c()
  
  for(i in 1:length(segmentation_files_fullname_sorted_initial)){
    temp_name_init <- strsplit(segmentation_files_fullname_sorted_initial[i], split = "_", fixed = FALSE, perl = FALSE, useBytes = FALSE)
    temp_name <- stringr::str_sub(temp_name_init[[1]][length(temp_name_init[[1]])], 1, nchar(temp_name_init[[1]][length(temp_name_init[[1]])]) - 4)
    if(plate_number != temp_name){
      plate_number <- temp_name
      segmentation_files_fullname_sorted <- c(segmentation_files_fullname_sorted, segmentation_files_fullname_sorted_initial[i])
      plate_numbers <- c(plate_numbers, temp_name)
    }
  }
  
  segmentation_files <- c()
  
  for(i in 1:length(segmentation_files_fullname_sorted)){
    temp_name <- strsplit(segmentation_files_fullname_sorted[i], split = "/", fixed = FALSE, perl = FALSE, useBytes = FALSE)
    segmentation_files[i] <- temp_name[[1]][length(temp_name[[1]])]
  }
  
  segmentation_files_no_extension <- c()
  
  for(i in 1:length(segmentation_files)){
    temp_name <- strsplit(segmentation_files[i], split = ".tif", fixed = FALSE, perl = FALSE, useBytes = FALSE)
    segmentation_files_no_extension <- c(segmentation_files_no_extension, temp_name[[1]][1])
  }
  
  segmentation_files <- segmentation_files_no_extension
  
  forward_warp_files_fullname_sorted_initial <- gtools::mixedsort(forward_warp_files_fullname_initial, decreasing = FALSE)

  forward_warp_files_fullname_sorted <- c()
  
  plate_number <- "0"
  
  for(i in 1:length(forward_warp_files_fullname_sorted_initial)){
    temp_name_init <- strsplit(forward_warp_files_fullname_sorted_initial[i], split = "_", fixed = FALSE, perl = FALSE, useBytes = FALSE)
    temp_name <- stringr::str_sub(temp_name_init[[1]][length(temp_name_init[[1]])], 1, nchar(temp_name_init[[1]][length(temp_name_init[[1]])]) - 4)
    if(plate_number != temp_name){
      plate_number <- temp_name
      forward_warp_files_fullname_sorted <- c(forward_warp_files_fullname_sorted, forward_warp_files_fullname_sorted_initial[i])
    }
  }

  forward_warp_files <- c()
  
  for(i in 1:length(forward_warp_files_fullname_sorted)){
    temp_name <- strsplit(forward_warp_files_fullname_sorted[i], split = "/", fixed = FALSE, perl = FALSE, useBytes = FALSE)
    forward_warp_files[i] <- temp_name[[1]][length(temp_name[[1]])]
  }
  
  forward_warp_files_no_extension <- c()
  
  for(i in 1:length(forward_warp_files)){
    temp_name <- strsplit(forward_warp_files[i], split = ".tif", fixed = FALSE, perl = FALSE, useBytes = FALSE)
    forward_warp_files_no_extension <- c(forward_warp_files_no_extension, temp_name[[1]][1])
  }
  
  forward_warp_files <- forward_warp_files_no_extension
  
  file_names <- list(registration_files = registration_files, segmentation_files = segmentation_files, forward_warp_files = forward_warp_files, plate_numbers = plate_numbers)
  return(file_names)
}


