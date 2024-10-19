# Nashville Airbnb Insights

The goal of this project is to analyze short-term rental trends in Nashville, TN, to uncover insights and strategies that can help a property management company optimize earnings.  
Nashville’s popularity as a tourist destination has been growing exponentially over several decades, creating a strong demand for short-term rentals. Airbnb represents a large portion of this short-term rental market. By understanding Airbnb dynamics, property managers can make informed decisions to improve earnings.

The data used is sourced from Inside Airbnb, a platform that provides publicly accessible data to help communities and researchers understand the impact of Airbnb on housing markets.

---

## Key Questions

- **What is the going rate for the top rental spots?**
- **How do availability and pricing fluctuate over time?**
- **Which neighborhoods earn the most and least?**
- **How can we optimize operations to maximize bookings?**
- **How much do the top earners make?**

---

## Code and Queries

- **[Python code for importing the dataset to MySQL](https://github.com/jonwpen/Nashville-Airbnb/tree/master/python%20scripts)**  
- **[SQL queries for data cleaning and preparation](https://github.com/jonwpen/Nashville-Airbnb/tree/master/cleaning%20SQL%20script)**  
- **[Targeted SQL queries answering various business questions](https://github.com/jonwpen/Nashville-Airbnb/tree/master/analysis%20SQL%20scripts)**  

---

## Dataset Structure

The dataset is composed of three main tables:  

- **Listings:** This table includes detailed information about individual properties, such as pricing, location, amenities, and host attributes.
- **Calendar:** Contains daily data for each listing, including availability status and pricing, which allows for analysis of trends in occupancy and seasonal fluctuations.
- **Reviews:** Provides user-generated feedback and ratings, offering insight into guest experiences and property popularity.

Additionally, a temporary table named `calculated_metrics` was created to store commonly used aggregated metrics for easier analysis.
![](https://github.com/jonwpen/Nashville-Airbnb/blob/master/images/airbnb_erd.png)

---

## Insight Summary

### Rental Rate and Supply Dynamics

Some districts exhibit high rental rates and occupancy but have low listing counts, indicating unmet demand.  
- **District 34:** $439 average rental rate and 42.7% occupancy suggest potential for more listings.  
- **District 19:** Shows market saturation with over 2,100 listings but a lower occupancy rate (34.6%), despite being the top-earning neighborhood.
![](https://github.com/jonwpen/Nashville-Airbnb/blob/master/images/question_1.png)

### Seasonal Trends and Property Type Insights

- **Entire Home/Apt:** While bookings remain high throughout the year, the dip in December's occupancy rate indicates potential overcapacity. This signals an opportunity for price optimization during winter months.
- **Shared Rooms:** Despite lower booking numbers, shared rooms maintain high occupancy, suggesting strong demand relative to supply. Increasing availability during peak months could capture additional market share.
![](https://github.com/jonwpen/Nashville-Airbnb/blob/master/images/question_2.png)

### Earnings by Neighborhood

- **District 19** leads in both monthly and annual earnings, while **District 32** lags with the lowest earnings and only five listings, indicating room for growth in underperforming areas.
![](https://github.com/jonwpen/Nashville-Airbnb/blob/master/images/question_3.png)

### Weekly and Seasonal Occupancy Patterns

- **Day of Week:** Occupancy peaks on Fridays and Saturdays (39%) but is lowest on Mondays and Tuesdays (32%).
- **Seasonal Trends:** Occupancy rates are highest in June (65%) but decline significantly from September to December, with lows in November (22%) and October (27%). **District 29** is unique for maintaining high occupancy year-round.
![](https://github.com/jonwpen/Nashville-Airbnb/blob/master/images/question_4.png)

### Top Earners’ Impact

- The top 10% of properties contribute nearly 30% of total earnings, with "Entire Home/Apt" accounting for 98% of top earners.
- **District 19's** top 10% alone generated $45.2 million over the year, followed by **District 17** at $37.8 million.
![](https://github.com/jonwpen/Nashville-Airbnb/blob/master/images/question_5.png)

---

## Recommendations

### **Granular Pricing Adjustments**

For neighborhoods with high listings and earnings but average occupancy, implement dynamic pricing strategies.  
- Adjust rates for last-minute stays, weekdays versus weekends, and promote shared rooms during off-peak times.
- Redistribute marketing efforts to support underperforming listings.

### **Seasonal Pricing for Entire Homes**

Address the occupancy drop in winter months (December and January) through dynamic pricing, offering lower rates to increase bookings.  
- This strategy helps align high booking numbers with better occupancy rates.

### **Expand Shared Room Supply**

With consistently high occupancy rates for shared rooms, increasing supply could meet demand.  
- Encourage hosts to list shared rooms or focus marketing efforts on this segment to boost revenue.

### **Targeted Marketing and Property Expansion**

Focus marketing efforts on high-earning districts like **19** while expanding property listings in low-earning areas such as **District 32**.  
- This could help balance earnings across regions.

### **Day and Seasonal Promotions**

Introduce special rates or discounts for lower-occupancy days (Mondays and Tuesdays).  
- Use seasonal pricing to capitalize on high-demand months (April-July) and offer deals during slower periods (September-December).  
- Use **District 29’s** high year-round occupancy as a model for other areas.

### **Enhance Top Earners' Offerings**

Concentrate on "entire home/apartment" listings for the top 10% earners, who significantly drive revenue.  
- Expand these listings in high-performing districts like **19, 17, and 2**, while improving guest experiences in lower-earning areas to boost their competitiveness.
