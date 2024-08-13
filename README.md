# Airline Passenger Satisfaction Dataset

The start dataset (airline_customer_satisfaction_survey.csv) is a dummy dataset for Airline Passenger Satisfaction and was downloaded from Kaggle from this link: 
[Airline Passenger Satisfaction Survey Dataset](https://www.kaggle.com/datasets/deltasierra452/airline-pax-satisfaction-survey/data)

The project was ran on R. The code is provided as (airline satisfaction.R)

## Research Goal

- Explore correlations using R between customer touchpoints.
- Understand which touchpoint is the highest predictor of passenger satisfaction.

## Goals of Code

1. Descriptive Statistics
2. Means for Transactional Satisfaction Touchpoints
3. Correlation Between Transactional Touchpoints
4. Logistic Regression for Overall Satisfaction

## Conclusions

### Transactional Customer Touchpoints
- **Unfavorable Touchpoints:** Gate Location, Ease of Online Booking, and Inflight Wifi Service are on average unfavorable, indicating customer dissatisfaction.
- **Favorable Touchpoints:** Inflight Service, Baggage Handling, and Seat Comfort are rated higher.

### Correlation Insights
- **High Correlation:** Satisfaction with Cleanliness is highly correlated with:
  1. Inflight Entertainment
  2. Seat Comfort
  3. Food and Drink Satisfaction

- **Secondary Pattern:** There is a strong relationship between Ease of Online Booking and Inflight Wifi Service.

### Logistic Regression Key Coefficients and Interpretation
- **Inflight Wifi Service:** Positive significant impact on satisfaction (Estimate = 0.267091)
- **Online Boarding:** Very high positive impact (Estimate = 0.847904)
- **Leg Room Service:** Significant positive impact (Estimate = 0.369404)
- **Seat Comfort:** Positive significant impact (Estimate = 0.139286)
- **Inflight Entertainment:** High positive impact (Estimate = 0.343328)

The strongest predictor is satisfaction with online boarding. A 1-unit increase in the rating for this touchpoint results in a 0.8479 increased likelihood of being satisfied.

### Recommendations
- **Maintain High Satisfaction:** Continue to maintain high satisfaction with existing customer touchpoints.
- **Focus Area:** Online boarding experience is an efficient way to ensure customer satisfaction. Further exploration could include customer demographics and other predictive factors.

---


