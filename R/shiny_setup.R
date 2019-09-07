#' @title Generate a list of parameters and file directory for the
#' applet and related files.
#' @description Generates setup list of length 3 to store
#' parameters for building an RShiny applet, and produces subfolders
#' within the user-specified output folder to store applet content.
#' To change any user-specified parameters, run [shiny_setup()]
#' again with updated parameters. Output subfolders created by
#' prior uses of the function will not be modified or deleted.
#' @param setup (required) The setup variable produced during the
#' [setup_pl()] function.
#' @param output_folder (required) The output folder that will
#' contain all files required for the applet. The function
#' will create subfolders within *output_folder*.
#' @return Returns *shiny_setup*, a list containing the following
#' information: setup variable, output folder, and output subfolders.
#' @details Output directories are automatically created in the
#' output folder.
#' @export
#' @md

shiny_setup <- function(setup, output_folder){

  output_segmentation_schem <- file.path(output_folder, "www/Segmentation_schematics/")
  output_segmentation_schem_temp <- file.path(output_folder, "www/Segmentation_schematics_temp/")
  output_segmentation_warps <- file.path(output_folder, "www/Segmentation_warpimages/")
  output_segmentation_warps_temp <- file.path(output_folder, "www/Segmentation_warpimages_temp/")
  output_registrations <- file.path(output_folder, "www/Registrations/")

  if(file.exists(output_folder) == FALSE){
    dir.create(output_folder)
  }

  dir.create(file.path(output_folder, "www"))
  dir.create(output_segmentation_schem)
  dir.create(output_segmentation_schem_temp)
  dir.create(output_segmentation_warps)
  dir.create(output_segmentation_warps_temp)
  dir.create(output_registrations)

  output_folders <- list(output_segmentation_schem = output_segmentation_schem,
                         output_segmentation_schem_temp = output_segmentation_schem_temp,
                         output_segmentation_warps = output_segmentation_warps,
                         output_segmentation_warps_temp = output_segmentation_warps_temp,
                         output_registrations = output_registrations)

  shiny_setup <- list(setup = setup, output_folder = output_folder, output_folders = output_folders)
  return(shiny_setup)
}
