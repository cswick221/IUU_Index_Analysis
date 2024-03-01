# Get unique indicator_ids
unique_indicator_ids <- unique(dind_df_all$indicator_id)

# Initialize an empty vector to store DiD estimates
did_estimates <- numeric()

# Loop through each indicator_id
for (id in unique_indicator_ids) {
  
  # Subset data for the specific indicator_id
  subset_data <- dind_df_all %>%
    filter(indicator_id == id)
  
  # Group by skylight_treatment and pre_post_treatment
  grouped_data <- subset_data %>%
    group_by(skylight_treatment, pre_post_treatment) %>%
    summarize(mean_score = mean(score))
  
  # Calculate the DiD estimate
  did_estimate <- ((grouped_data$mean_score[4] - grouped_data$mean_score[3]) -
                     (grouped_data$mean_score[2] - grouped_data$mean_score[1]))
  
  # Append the DiD estimate to the vector
  did_estimates <- c(did_estimates, did_estimate)
}

# Combine indicator_ids and DiD estimates into a data frame
did_results <- data.frame(indicator_id = unique_indicator_ids, DiD_estimate = did_estimates)



