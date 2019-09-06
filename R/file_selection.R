#' @title Isolate one segmentation image and one forward warp image 
#' for each atlas plate.
#' @description Copies one segmentation image and one forward warp
#' image per atlas plate from the SMART output folder (indicated
#' by the *setup* variable) to the temporary directories in the
#' applet output folder. 
#' @param shiny_setup (required) The shiny_setup variable produced 
#' during the [shiny_setup()] function.
#' @param file_names (required) The file_names variable produced
#' during the [file_names()] function.
#' @details Files are automatically copied to the temporary
#' directories. The original image files are retained.
#' @export
#' @md
 
file_selection <- function(shiny_setup, file_names){
  
  for(i in 1:length(file_names$segmentation_files)){
    file_input <- paste0(setup$savepaths$out_segmentation_schem, "/", file_names$segmentation_files[i], ".tif")
    file_output <- paste0(shiny_setup$output_folders$output_segmentation_schem_temp, "/", file_names$segmentation_files[i], ".tif")
    file.copy(from = file_input, to = file_output)
  }
  
  for(i in 1:length(file_names$forward_warp_files)){
    file_input <- paste0(setup$savepaths$out_segmentation_warps, "/", file_names$forward_warp_files[i], ".tif")
    file_output <- paste0(shiny_setup$output_folders$output_segmentation_warps_temp, "/", file_names$forward_warp_files[i], ".tif")
    file.copy(from = file_input, to = file_output)
  }
}


