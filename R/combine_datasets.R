#' @title Combine data to be used in the applet into a single .RData file.
#' @description Produces a sunburst plot and data table, and stores them
#' with *file_names* in an .RData file called full_data.R. This .RData
#' file is saved in the shiny output folder, and it is directly used by
#' the applet.
#' @param shiny_setup (required) The shiny_setup variable produced
#' during the [shiny_setup()] function.
#' @param file_names (required) The file_names variable produced
#' during the [file_names()] function.
#' @param dataset (required) Whole brain dataset returned as an output of
#' the [forward_warp()] function.
#' @details The new .RData file is automatically created in the RShiny
#' output folder.
#' @export
#' @md

combine_datasets <- function(shiny_setup, file_names, dataset){

  paxTOallen <- function(paxinos){
    round(214+(20-(paxinos*1000))/25)
  }

  get_roi <- function(dataset, roi = c('MO', 'TH')){
    out <- unlist(lapply(roi, function(x)sum(dataset$acronym %in% get.sub.structure(x)) ) )
    roi.data<-data.frame(acronym = roi, cell.count = out)
    return(roi.data)
  }

  init_rois <- c("CH", "BS")

  rois <- init_rois

  for(i in 1:length(init_rois))
  {
    new_parent_addition <- get.acronym.parent(init_rois[i])
    while(new_parent_addition != "grey")
    {
      rois <- c(rois, new_parent_addition)
      new_parent_addition <- get.acronym.parent(new_parent_addition)
    }
    new_child_additions <- get.acronym.child(init_rois[i])
    next_level_additions <- c()
    while(length(new_child_additions) > 0)
    {
      for(j in 1:length(new_child_additions))
      {
        next_level_additions <- c(next_level_additions, get.acronym.child(new_child_additions[j]))
      }
      rois <- c(rois, new_child_additions)
      new_child_additions <- next_level_additions
      next_level_additions <- c()
      new_child_additions <- new_child_additions[is.na(new_child_additions) == FALSE]
    }
  }
  rois <- unique(c(rois, "grey"))
  rois <- rois[is.na(rois) == FALSE]

  paths <- c()
  for(i in 1:length(rois))
  {
    most_recent <- get.acronym.parent(rois[i])
    most_recent_path <- rois[i]
    if(grepl("-", most_recent_path)){
      most_recent_path <- gsub("-", "_", most_recent_path)
    }
    if(rois[i] != "grey")
    {
      while(most_recent != "grey" & most_recent_path != "grey")
      {
        next_path <- get.acronym.parent(most_recent)
        if(grepl("-", most_recent)){
          most_recent <- gsub("-", "_", most_recent)
        }
        most_recent_path <- paste0(most_recent, "-", most_recent_path)
        most_recent <- next_path
      }
      most_recent_path <- paste0("grey-", most_recent_path)
      paths <- c(paths, most_recent_path)
    }
    if(rois[i] == "grey")
    {
      paths <- c(paths, "grey-end")
    }
  }

  counts <- c()
  initial_counts <- get_roi(dataset, roi=rois)
  for(i in 1:length(rois))
  {
    if(is.na(get.acronym.child(rois[i])))
    {
      new_count <- initial_counts$cell.count[i]
    }
    else
    {
      subregion_list_with_counts <- get_roi(dataset, roi=c(get.acronym.child(rois[i])))
      subregion_count <- 0
      for (j in 1:length(subregion_list_with_counts$cell.count))
      {
        if(subregion_list_with_counts$acronym[j] %in% rois)
        {
          subregion_count <- subregion_count + subregion_list_with_counts$cell.count[j]
        }
        new_count <- initial_counts$cell.count[i] - subregion_count
      }
    }
    counts <- c(counts, new_count)
  }

  colorv <- c()
  for(i in 1:length(rois))
  {
    newcolor <- color.from.acronym(rois[i])
    colorv <- c(colorv, newcolor)
  }
  rois2 <- rois
  for(i in 1:length(rois2)){
    if(grepl("-", rois2[i])){
      rois2[i] <- gsub("-", "_", rois2[i])
    }}

  sunburst_wholebrain <- structure(list(paths, counts), Names = c("paths", "counts"), class = "data.frame", row.names = c(NA, -25L))
  sunburst_object <- sunburstR::sunburst(sunburst_wholebrain, count = TRUE, percent = TRUE, colors = list(range = colorv, domain = rois2), legend = FALSE, breadcrumb = list(w = 75, h = 30, r = 100, s = 0))

  data_table <- SMART::get_table(dataset)

  forward_warp_files <- file_names$forward_warp_files
  plate_numbers <- file_names$plate_numbers
  registration_files <- file_names$registration_files
  segmentation_files <- file_names$segmentation_files

  save(sunburst_object, data_table, forward_warp_files, plate_numbers, registration_files, segmentation_files, file = paste0(shiny_setup$output_folder, "/full_data.RData"))
}





