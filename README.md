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
