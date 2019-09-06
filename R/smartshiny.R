#' smartshiny: A package for building an RShiny app from SMART outut data
#'
#' @description The smartshiny package interfaces with the [SMART] package
#' by Michelle Jin, which is used in conjunction with the [wholebrain] package
#' by Daniel Furth to process whole brain imaging datasets. This package is
#' used to produce an RShiny app from the output data from the [SMART] package.
#' The applet production pipeline consists of four parts, as outlined in the
#' online tutorial. The first two parts contain new functions, as described
#' below.
#'
#' @section Part 1. Data collection:
#'
#' 1) [shiny_setup()] Generate a list of parameters and file directory for the applet and related files.
#'
#' @section Part 2. Data processing:
#'
#' 1) [file_names()] Generate a list of file names for images output by SMART.
#' 2) [file_selection()] Isolate one segmentation image and one forward warp image for each atlas plate.
#' 3) [image_conversion()] Convert .tif files to .png to conserve server space.
#' 4) [combine_data()] Combine data to be used in the applet into a single .RData file.
#'
#' @md
#' @docType package
#' @name smartshiny
NULL
