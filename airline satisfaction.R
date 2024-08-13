
# This dataset is a dummy dataset for Airline Passenger Satisfaction and was downloaded from kaggle from this link: https://www.kaggle.com/datasets/deltasierra452/airline-pax-satisfaction-survey/data

# The overall goal was to do an overall approach to figure out which customer touchpoints were correlated with eachother as well as to understand which touchpoint was the highest predictor of whether or not a passenger would be satisfied with their airline.
# Conclusions:
## Based on the means calculated for the transactional customer touchpoints, Gate Location, Ease of online booking and inflight wifi service are on average unfavorable- meaning customers are dissatisfied with these touchpoints.
## The higher score touchpoints are inflight service, baggage handling and seat comfort.
## According to the correlation matrix, we see that Satisfaction with Cleanliness is highly correlated with 1)Inflight Entertainment, 2)Seat Comfort and 3)Food and Drink Satisfaction in that order. 
## A second pattern highlighted by the correlation matrix is the strong relationship between Ease of online booking and Inflight Wifi Service.
## Lastly, through our Logistic Regression here are some Key Coefficients and Interpretation:
    # Inflight_wifi_service: Positive significant impact on satisfaction (Estimate = 0.267091)
    # Online_boarding: Very high positive impact (Estimate = 0.847904)
    # Leg_room_service: Significant positive impact (Estimate = 0.369404)
    # Seat_comfort: Positive significant impact (Estimate = 0.139286)
    # Inflight_entertainment: High positive impact (Estimate = 0.343328)

    #The strongest predictor we have seen is satisfaction with online boarding. The interpretation would be with a 1-unit increase in the rating with this touchpoint, we will see a 0.8479 increased likelihood of being satisfied.

### The general recommendation would be to continue to maintain high satisfaction with the customer touchpoints the airline has so far. If they had to focus on any, the online boarding experience seems to be an efficient way to ensure the customer is satisfied. However, there are multipe ways that would go into predicting satisfaction that may be explored further using customer demographics and groups. This analysis focuses on examining the data at the overall satisfaction

##########################################################################################

### GOALS OF CODE

## 1. Descriptive Statistic
## 2. Means for Transaction Satisfaction Touch points
## 3. Correlation between Transactional Touch points
## 4. Logistic Regression for Overall Satisfaction

# Load Packages
install.packages("tidyverse")
library(tidyverse)


# Load dataset
originaldata<- read.csv("airline_customer_satisfaction_survey.csv")

# EXPLORE
## Taking a peek at column content and column names in dataset
head(originaldata)
names(originaldata)
summary(originaldata)

##########################################################################################

# CLEAN

## Recode overall satisfaction to be binary to prep for logistic regression
originaldata$satisfaction <- ifelse(originaldata$satisfaction == "satisfied", 1, 0)

## Add an "Age_group" column based on the Age column to see Age segments

### Define age intervals and labels
age_intervals <- c(0, 18, 25, 35, 45, 60, 100)
age_labels <- c("0-18", "19-25", "26-35", "36-45", "46-60", "60+")

### Use cut() to create age groups
originaldata$Age_Group <- cut(originaldata$Age, breaks = age_intervals, labels = age_labels, right = FALSE)

#### Convert the Age_Group factor to character
originaldata$Age_Group <- as.character(originaldata$Age_Group)

### Print the data frame to verify the changes
print(originaldata)


############################################################################################


# 1. DESCRIPTIVE STATISTICS

## GROUPING VARIABLE FREQUENCIES
# Identify character columns
char_columns <- sapply(originaldata, is.character)

# Generate frequency tables and calculate rounded proportions for all character columns
frequency_tables <- lapply(originaldata[, char_columns, drop = FALSE], function(column) {
  freq_table <- table(column)
  proportions <- prop.table(freq_table) * 100
  rounded_proportions <- round(proportions, digits = 2)  # Round proportions to 2 decimal places
  return(rounded_proportions)
})

# Print frequency tables with rounded proportions out of 100
for (col_name in names(frequency_tables)) {
  cat("Proportions table for", col_name, ":\n")
  print(frequency_tables[[col_name]])
  cat("\n")
}

print(frequency_tables)


######################################################################################################

# 2. MEANS for TRANSACTIONAL SATISFACTION SCALE ITEMS

## Create a separate dataframe for satisfaction items only
satisfaction_data <- originaldata %>%
    select(Inflight_wifi_service, Ease_of_Online_booking, Gate_location, Food_and_drink, Online_boarding, Seat_comfort, Inflight_entertainment, On.board_service, Leg_room_service, Baggage_handling, Checkin_service, Inflight_service, Cleanliness)
  
## Get means for each satisfaction item
satisfaction_means <- colMeans(satisfaction_data, na.rm = TRUE)
print(satisfaction_means)

## Replace 0 with NA where it indicates not applicable
satisfaction_data[satisfaction_data == 0] <- NA

## Calculate means excluding NA values
means_excluding_na <- colMeans(satisfaction_data, na.rm = TRUE)

## Round the means to 2 decimal places
rounded_means <- round(means_excluding_na, digits = 2)

## Create a dataframe with sorted means
sorted_means_df <- data.frame(
  Satisfaction_Item = names(rounded_means),  # Column A: Satisfaction_Item names
  Means = rounded_means                     # Column B: Rounded means
)

## Sort the dataframe by means in descending order
sorted_means_df <- sorted_means_df %>%
  arrange(desc(Means))

## Display the sorted means dataframe
print(sorted_means_df)

write.csv(sorted_means_df, file = "transactional_items_satisfaction_means.csv", row.names = FALSE)


######################################################################################################

# 3. CORRELATION- TRANSACTIONAL SATISFACTION ITEMS

# Convert numeric columns to numeric
satisfaction_data[] <- lapply(satisfaction_data, function(x) if(is.factor(x) | is.character(x)) as.numeric(as.character(x)) else x)

# Print the dataframe
print(satisfaction_data)

# Run the Correlation with Transactional Satisfaction Items
correlation_matrix <- cor(satisfaction_data, use = 'complete.obs')

# Print correlation matrix
print(correlation_matrix)


# Compute correlation matrix with p-values
correlation_matrix <- matrix(NA, ncol = ncol(satisfaction_data), nrow = ncol(satisfaction_data))
p_values_matrix <- matrix(NA, ncol = ncol(satisfaction_data), nrow = ncol(satisfaction_data))

# Loop through each pair of variables
for (i in 1:ncol(satisfaction_data)) {
  for (j in 1:ncol(satisfaction_data)) {
    if (i != j) {
      # Perform correlation test
      result <- cor.test(satisfaction_data[, i], satisfaction_data[, j], use = "complete.obs")
      
      # Store correlation coefficient
      correlation_matrix[i, j] <- result$estimate
      
      # Store p-value
      p_values_matrix[i, j] <- result$p.value
    }
  }
}

# Define row and column names
item_names <- c(
  "Inflight_wifi_service", "Ease_of_Online_booking", "Gate_location",
  "Food_and_drink", "Online_boarding", "Seat_comfort",
  "Inflight_entertainment", "On.board_service", "Leg_room_service",
  "Baggage_handling", "Checkin_service", "Inflight_service", "Cleanliness"
)

# Set dimnames for correlation and pvalue matrix
dimnames(correlation_matrix) <- list(item_names, item_names)
dimnames(p_values_matrix) <- list(item_names, item_names)


# Print the relabeled correlation and pvalue matrix
print("Correlation Matrix:")
print(correlation_matrix)

print("P-Values Matrix:")
print(p_values_matrix)

write.csv(correlation_matrix, file = "correlation_matrix.csv")

write.csv(p_values_matrix, file = "p_values_matrix.csv")

######################################################################################################

# 4. REGRESSION for Overall Satisfaction

# Identify numeric columns
numeric_cols <- sapply(originaldata, is.numeric)

# Define a function to replace 0 with NA for numeric columns
replace_zeros <- function(x) {
  if (is.numeric(x) && !all(names(x) %in% "satisfaction")) {
    replace(x, x == 0, NA)
  } else {
    x
  }
}

# Apply the function to each column
satisfaction_data_regression <- originaldata %>%
  mutate_if(numeric_cols, replace_zeros)

# Fit logistic regression model
satisfaction_model_all <- glm(satisfaction ~ Inflight_wifi_service + Ease_of_Online_booking + Gate_location + Food_and_drink + Online_boarding + Seat_comfort + Inflight_entertainment + On.board_service + Leg_room_service + Baggage_handling + Checkin_service + Inflight_service + Cleanliness, data = satisfaction_data_regression, family = binomial)

# Summarize the model
satisfaction_model_summary <- summary(satisfaction_model_all)
print(satisfaction_model_summary)

coefficients <- satisfaction_model_summary$coefficients
results_df <- as.data.frame(coefficients)

# Add row names as a column to the data frame
results_df$Predictor <- rownames(results_df)
rownames(results_df) <- NULL

# Reorder columns to have 'Predictor' as the first column
results_df <- results_df[, c("Predictor", "Estimate", "Std. Error", "z value", "Pr(>|z|)")]

# Save Satisfaction Model to a CSV
write.csv(results_df, file = "Logistic_Regression_Overall_Satisfaction_Predictors.csv")




