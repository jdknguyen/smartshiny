#' @title Convert .tif files to .png files to conserve server space.
#' @description Converts registration, segmentation, and forward
#' warp images into .png files. One of each image type per atlas
#' plate is converted. The new .png files are stored in the shiny
#' output directories, and the temporary directories created by
#' [file_selection()] are deleted.
#' @param shiny_setup (required) The shiny_setup variable produced
#' during the [shiny_setup()] function.
#' @param file_names (required) The file_names variable produced
#' during the [file_names()] function.
#' @details Files are automatically copied to the temporary
#' directories. The original registration image files are
#' retained, but the .tif segmentation and forward warp images
#' are deleted along with their temporary directories. All
#' images in the SMART output folder are kept intact.
#' @export
#' @md

image_conversion <- function(shiny_setup, file_names){

  regi_first <- as.integer(file_names$plate_numbers[1])
  regi_last <- as.integer(file_names$plate_numbers[length(file_names$plate_numbers)])
  regi_length <- regi_last - regi_first + 1

  for(i in 1:regi_length) {
    image_path <- paste0(setup$savepaths$out_registration, "/", file_names$registration_files[i], ".tif")
    if(file.exists(image_path)){
      image <- magick::image_read(image_path)
    }
    if(file.exists(image_path) == FALSE){
      image <- magick::image_read(paste0(setup$savepaths$out_auto_registration, "/", file_names$registration_files[i], ".tif"))
    }
    newpath <- paste0(shiny_setup$output_folders$output_registrations, "/", file_names$registration_files[i], ".png")
    magick::image_write(image, path = newpath, format = "png")
  }

  for(i in 1:regi_length) {
    image <- magick::image_read(paste0(shiny_setup$output_folders$output_segmentation_schem_temp, "/", file_names$segmentation_files[i], ".tif"))
    newpath <- paste0(shiny_setup$output_folders$output_segmentation_schem, "/", file_names$segmentation_files[i], ".png")
    magick::image_write(image, path = newpath, format = "png")
  }

  for(i in 1:regi_length) {
    image <- magick::image_read(paste0(shiny_setup$output_folders$output_segmentation_warps_temp, "/", file_names$forward_warp_files[i], ".tif"))
    newpath <- paste0(shiny_setup$output_folders$output_segmentation_warps, "/", file_names$forward_warp_files[i], ".png")
    magick::image_write(image, path = newpath, format = "png")
  }

  magick::image_write(magick::image_read(paste0(setup$savepaths$out_RC_brain_morph, "/", list.files(setup$savepaths$out_RC_brain_morph)[1])), path = paste0(shiny_setup$output_folder, "/www/brain_morph.png"), format = "png")

  unlink(shiny_setup$output_folders$output_segmentation_schem_temp, recursive = TRUE)
  unlink(shiny_setup$output_folders$output_segmentation_warps_temp, recursive = TRUE)
}






