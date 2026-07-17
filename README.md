# Brazilian E-Commerce Public Dataset by Olist


# About the data 

*The  Brazilian ecommerce public dataset of orders made at Olist Store. The dataset has information of 100k orders from 2016 to 2018 made
at multiple marketplaces in Brazil. Its features allows viewing an order from multiple dimensions: from order status, price, payment and 
freight performance to customer location, product attributes and finally
reviews written by customers. We also released a geolocation dataset that relates Brazilian zip codes to lat/lng coordinates.*

## Dataset's relationship scheme 

<img width="4628" height="2632" alt="Untitled Diagram_2026-07-09T05_23_12 022Z" src="https://github.com/user-attachments/assets/820bfe74-0802-4044-a6c5-48805687bd6c" />


## Database Relationships

The database schema follows the relational structure of the Olist Brazilian E-commerce dataset. Foreign key constraints were added to maintain referential integrity between related tables.

### Relationships

| Parent Table | Child Table | Relationship |
|--------------|------------|--------------|
| Customers | Orders | One customer can place many orders (1:N) |
| Orders | Order_Items | One order can contain multiple products (1:N) |
| Products | Order_Items | One product can appear in many order items (1:N) |
| Seller | Order_Items | One seller can sell many order items (1:N) |
| Orders | Order_Payment | One order can have multiple payment records (1:N) |
| Orders | Order_Reviews | One order can have one or more reviews (1:N) |

---

### Primary Keys

The following primary keys were implemented:

| Table | Primary Key |
|--------|-------------|
| Customers | `customer_id` |
| Orders | `order_id` |
| Products | `product_id` |
| Seller | `seller_id` |
| Order_Reviews | `review_id` |
| Order_Items | (`order_id`, `order_item_id`) |
| Order_Payment | (`order_id`, `payment_sequence`) |

Composite primary keys were used where a single column was not sufficient to uniquely identify each record.

---

### Foreign Keys

| Table | Foreign Key | References |
|--------|-------------|------------|
| Orders | `customer_id` | Customers(`customer_id`) |
| Order_Items | `order_id` | Orders(`order_id`) |
| Order_Items | `product_id` | Products(`product_id`) |
| Order_Items | `seller_id` | Seller(`seller_id`) |
| Order_Payment | `order_id` | Orders(`order_id`) |
| Order_Reviews | `order_id` | Orders(`order_id`) |

---

### Check Constraints

To improve data integrity, several `CHECK` constraints were added.

### Monetary Values

- `price >= 0`
- `freight_value >= 0`
- `payment_value >= 0`

### Product Information

- `product_weight_g >= 0`
- `product_length_cm >= 0`
- `product_width_cm >= 0`
- `product_height_cm >= 0`
- `product_name_length >= 0`
- `product_description_length >= 0`
- `product_photos_qty >= 0`

### Payments

- `payment_installments >= 1`

### Reviews

- `review_score BETWEEN 1 AND 5`

These constraints prevent invalid values from being inserted into the database and help maintain data consistency.
indices were added to optimize the queries 

# Exploratory Data Analysis



<img width="2000" height="1333" alt="work-office-computer-man-woman-business-character-marketing-online-employee-technology-business-man-cartoon-co-working-flat-design-freelance" src="https://github.com/user-attachments/assets/c329f00f-4f4b-49d7-a1dd-6c4cab8adcc9" />


>The exploratory data analysis (EDA) phase was conducted to gain a comprehensive understanding of the Olist Brazilian E-Commerce dataset and uncover meaningful business insights before moving to advanced analysis. Beyond examining the structure and quality of the data, this analysis focuses on identifying patterns in customer behavior, sales performance, logistics efficiency, freight costs, delivery reliability, and customer satisfaction.

>The dataset was first cleaned and transformed by handling missing values, converting date columns to appropriate datetime formats, creating categorical variables, engineering new business metrics, and integrating multiple tables into a relational analytical model. These transformations enabled more detailed temporal, geographical, and operational analyses.

>Throughout the analysis, interactive dashboards and visualizations were developed to answer key business questions, including:

* Sales performance and revenue trends over time
* Geographic distributions of revenue , delivery costs accross the states
* Logistics performance, delivery times, and late delivery analysis
* Freight cost efficiency and freight-to-product value ratios
* Customer review sentiment analysis using Natural Language Processing (NLP)
* Product category performance and purchasing behavior
* Seasonal trends, including the impact of Black Friday on order volume and delivery performance

## Order fulfillment reliability.
*What percentage of customer orders are successfully completed versus interrupted by cancellations or operational issues?

<img width="989" height="590" alt="image1" src="https://github.com/user-attachments/assets/287ed2a2-f263-4b1a-9800-943a47f305dc" />

>Business Impact: The high delivery completion rate demonstrates strong operational performance and customer fulfillment reliability. Since failed or canceled orders represent only a small percentage of transactions, subsequent analyses can focus on optimizing delivery speed, freight efficiency, and customer satisfaction rather than addressing widespread fulfillment failures.


* When do customers place the highest number of orders, and are there any temporal purchasing patterns that can help optimize business operations?

<img width="1277" height="989" alt="image2" src="https://github.com/user-attachments/assets/a8eab93e-7c46-4799-a6b9-be30568fc64e" />

>Key Insights
> Monthly order volume grew steadily throughout 2017, reflecting the rapid expansion of the Olist marketplace.
> November 2017 recorded the highest number of orders, aligning with Brazil's Black Friday shopping season.
> Following the Black Friday surge, monthly orders stabilized at approximately 6,000–7,000 orders, indicating consistent customer demand.
> Purchasing activity was concentrated on weekdays, with Monday (16.3%) and Tuesday (16.1%) recording the highest order volumes, while Saturday (10.9%) showed the lowest activity.
> Customers preferred shopping during the Afternoon (38.3%), followed by Night (28.5%) and Morning (27.9%), whereas Dawn accounted for only 5.3% of purchases.
> The sharp decline observed at the end of the timeline reflects incomplete data collection rather than an actual drop in customer demand.
>
 * Business Impact
>Seasonal events, particularly Black Friday, have a significant impact on demand and require additional inventory, staffing, and logistics capacity.
Customer purchasing behavior is highly concentrated during weekday afternoons, providing an ideal window for targeted marketing campaigns and promotional activities.

>Understanding peak purchasing periods enables better workforce planning, ensuring customer support and fulfillment teams are adequately staffed during busy hours.
Recognizing low-demand periods, such as weekends and dawn hours, creates opportunities to optimize operational costs through smarter resource allocation.
Temporal purchasing patterns provide valuable insights for inventory planning, helping businesses anticipate demand fluctuations and improve service quality.


* When are customers most likely to place orders, and how can these purchasing patterns help optimize staffing, marketing campaigns, and operational planning?
<img width="1333" height="1071" alt="image3" src="https://github.com/user-attachments/assets/45752f44-f41e-47b5-bbf1-c3ea63bdafcf" />

### Key Insights
>Order activity is concentrated during weekday business hours, with Monday recording the highest order volume, followed closely by Tuesday and Wednesday.
>
>Purchasing behavior follows a clear daily pattern, with demand increasing rapidly after 8 AM, peaking between 10 AM and 4 PM, and remaining relatively high until late evening.
>
> Overnight activity (2–6 AM) is minimal, indicating that customers rarely purchase during these hours.
>
>The Day × Hour heatmap highlights a consistent "Golden Purchase Window" between 10 AM and 9 PM on weekdays, where order volume is highest.
>
>Weekend purchasing activity decreases noticeably, particularly on Saturdays, although evening demand remains relatively stable.
>
### Business Impact

> Schedule marketing campaigns, promotional emails, and push notifications during the **10 AM–4 PM** window to maximize customer engagement.

> Allocate customer support and warehouse resources according to peak purchasing hours, improving operational efficiency during high-demand periods.

> Plan flash sales and promotional events during weekday afternoons when customer activity is naturally highest.

> Reduce staffing requirements during overnight hours, where customer demand is consistently low.

> Use purchasing patterns to improve forecasting models and workforce scheduling, ensuring resources are aligned with expected order volumes.
>

## Sales Growth & Seasonality Performance Dashboard


> **How has order demand evolved over time, what seasonal purchasing patterns exist, and which periods consistently generate the highest sales volume?**
<img width="1324" height="1071" alt="image4" src="https://github.com/user-attachments/assets/fdbaa247-3e9c-4ed3-bad0-f35ef0448bf2" />




### Key Insights

> The business experienced strong and consistent order growth throughout 2017, reaching its highest monthly order volume in **November 2017**, indicating rapid marketplace expansion.

> Monthly seasonality reveals that **May, July, August, and November** are the strongest-performing months, suggesting recurring periods of elevated customer demand.

> September consistently records one of the lowest order volumes, indicating a seasonal slowdown before demand increases again toward the holiday shopping period.

> The Year-over-Year comparison demonstrates substantial growth between 2017 and 2018, with monthly order volumes remaining significantly higher across nearly every comparable month.

> The sharp decline observed during the final months of 2018 is caused by the dataset ending before the year was complete and should not be interpreted as a real decline in business performance.

### Business Impact

> Anticipate higher inventory requirements and warehouse capacity during peak demand months to reduce stock shortages and delivery delays.

> Launch major promotional campaigns during historically strong purchasing periods such as **May, August, and November** to maximize revenue potential.

> Use lower-demand months, particularly September, for inventory replenishment, operational improvements, and customer retention campaigns.

> Allocate additional customer support and logistics resources ahead of seasonal demand spikes to maintain service quality during peak periods.

> Incorporate seasonal demand patterns into forecasting models to improve inventory planning, staffing decisions, and supply chain efficiency.


## Delivery Performance & Fulfillment Operations Dashboard
> **How efficiently are orders progressing through the fulfillment pipeline, from customer purchase to carrier dispatch, and where do operational bottlenecks occur?**


<img width="1380" height="1104" alt="image5" src="https://github.com/user-attachments/assets/af3fc528-2310-4ff9-8433-5eca11d95095" />


### Key Insights

> Most orders are approved within the **first few hours after purchase**, indicating that the payment verification process is generally efficient.

> A small number of orders experience significantly longer approval times, suggesting occasional operational or payment-processing exceptions.

> Warehouse-to-carrier handoff is highly concentrated within the **first 1–3 days**, with dispatch frequency declining steadily for longer processing times.

> Monthly operational trends show that both approval latency and carrier dispatch time improved over the observation period, indicating increased fulfillment efficiency.

> The unusually high values observed during the earliest months are caused by limited historical data and should not be interpreted as representative of normal operational performance.

### Business Impact

> Maintain rapid payment approval processes, as minimizing approval delays shortens the overall order fulfillment cycle.

> Investigate the small percentage of orders with exceptionally long approval times to identify payment failures, fraud reviews, or system bottlenecks.

> Continue optimizing warehouse operations to maximize same-day or next-day carrier dispatch, improving delivery speed and customer satisfaction.

> Use operational KPIs such as approval latency and carrier handoff time to monitor fulfillment performance and identify process inefficiencies before they affect customers.

> Incorporate fulfillment efficiency metrics into operational dashboards to support workforce planning, warehouse capacity management, and continuous process improvement.








