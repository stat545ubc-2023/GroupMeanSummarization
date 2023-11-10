#' @title: Group Mean Summarization
#'
#' @description The function automates the calculation of arithmetic mean - operating and summarizing on the grouping chosen by the user
#'
#' @details This is a generic function that can group by one or multiple levels passed by the user.
#'          User can pass provide argument for grouping either by numerical index or column name because both ways are used in practice.
#'          Rows with N/A values are kept as it can still be valid grouping combinations. Thus N/A values are treated via omission in the calculation of mean.
#'
#' @param dataFrame dataframe_like_object accepts either dataframe or tibbular data & hence the chosen name to indicate the inclusion of both
#' @param group_by vector should be non-empty and can either be numerical or string thus the chosen name is kept generic
#'
#' @return tibble for the case where legal arguments are passed otherwise null along with an error message
#'
#' @examples
#' sample_data <- data.frame(Name = c("Vir", "Shreya", "Kabir", "Vir", "Kabir"), TransactionCity = c("Vancouver", "Vancouver", "California", "Seattle", "California"), TransactionCost = c(100, 50, 80, 100, 40), ItemsPurchased = c(4,1,4,6,2)) # Generating sample data
#' Group_mean_summarization(sample_data, "Name") #Providing arithmetic mean summary per person using column name
#' Group_mean_summarization(sample_data, c(2))   #Providing arithmetic mean summary per city using column index
#' Group_mean_summarization(sample_data, c(2,1)) #Providing arithmetic mean summary per city and name using column index
#'
#' @export
Group_mean_summarization = function(dataFrame, group_by){
  if (! (is.vector(group_by) && length(group_by) > 0)){
    stop('Group by column parameter is invalid')
  }

  # if numeric col_ind passed check they don't have matching names in the tibble
  # then convert to col_ind to col_names of the tibble
  if (is.numeric(group_by) && sum(group_by %in% names(dataFrame))==0 ){
    group_by = names(dataFrame)[group_by]
    if (sum(is.na(group_by)) > 0 || identical(group_by, character(0)) ) { # Ensuring no column index is out of bounds
      stop('Column indices not valid')
    }
  }

  else if (sum(group_by %in% names(dataFrame))==length(group_by)){   # if reached here then ensuring all input vector elements are legal column names
    invisible()
  }

  else {
    stop('Column name(s) not valid')
  }

  # now grouping the data, summarize by mean while omitting N/A values, and return
  dataFrame %>%
    dplyr::group_by_at(group_by) %>%
    dplyr::summarise(dplyr::across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>%
    return()
}
