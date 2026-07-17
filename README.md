# Brazilian E-Commerce Public Dataset by Olist

## Introduction

E-commerce has become one of the fastest-growing sectors of the global economy, transforming the way consumers purchase products and services. Its adoption accelerated significantly after the COVID-19 pandemic as online shopping became an essential part of everyday life. This digital transformation has enabled businesses of all sizes to reach customers beyond geographical boundaries, making markets more accessible and competitive.

As the largest e-commerce market in Latin America, Brazil plays a pivotal role in the region's digital economy. With a population of over 215 million people, the country accounts for approximately **55% of all e-commerce sales in Latin America**, making it an ideal market for studying customer behavior, sales performance, logistics, and business operations. Additionally, e-commerce contributes approximately **13% of Brazil's GDP**, highlighting its significant economic impact.

This project performs an end-to-end exploratory data analysis (EDA) of the Brazilian Olist e-commerce dataset to uncover actionable business insights across customer behavior, sales trends, delivery performance, regional markets, logistics, freight costs, and customer satisfaction. The analysis aims to identify opportunities for operational improvement and support data-driven business decision-making.

## About the data 

*The  Brazilian ecommerce public dataset of orders made at Olist Store. The dataset has information of 100k orders from 2016 to 2018 made
at multiple marketplaces in Brazil. Its features allows viewing an order from multiple dimensions: from order status, price, payment and 
freight performance to customer location, product attributes and finally
reviews written by customers. We also released a geolocation dataset that relates Brazilian zip codes to lat/lng coordinates.*
data source : https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
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
These constraints prevent invalid values from being inserted into the database and help maintain data consistency. Additionally, indexes were created on frequently queried columns to improve query performance and reduce execution time.

# Exploratory Data Analysis & Business Analysis



<img width="2000" height="1333" alt="work-office-computer-man-woman-business-character-marketing-online-employee-technology-business-man-cartoon-co-working-flat-design-freelance" src="https://github.com/user-attachments/assets/c329f00f-4f4b-49d7-a1dd-6c4cab8adcc9" />


>The exploratory data analysis (EDA) phase was conducted to gain a comprehensive understanding of the Olist Brazilian E-Commerce dataset and uncover meaningful business insights before moving to advanced analysis. Beyond examining the structure and quality of the data, this analysis focuses on identifying patterns in customer behavior, sales performance, logistics efficiency, freight costs, delivery reliability, and customer satisfaction.

>The dataset was first cleaned and transformed by handling missing values, converting date columns to appropriate datetime formats, creating categorical variables, engineering new business metrics, and integrating multiple tables into a relational analytical model. These transformations enabled more detailed temporal, geographical, and operational analyses.

>Throughout the analysis, interactive dashboards and visualizations were developed to answer key business questions, including:

* Sales performance and revenue trends over time
* Geographic distributions of revenue , delivery costs across the states
* Logistics performance, delivery times, and late delivery analysis
* Freight cost efficiency and freight-to-product value ratios
* Customer review sentiment analysis using Natural Language Processing (NLP)
* Product category performance and purchasing behavior
* Seasonal trends, including the impact of Black Friday on order volume and delivery performance
___
## Order fulfillment reliability.
*What percentage of customer orders are successfully completed versus interrupted by cancellations or operational issues?*

<img width="989" height="590" alt="image1" src="https://github.com/user-attachments/assets/287ed2a2-f263-4b1a-9800-943a47f305dc" />

### key Insights 
>Approximately 97% of all orders were successfully delivered, indicating a highly reliable fulfillment process. Only a small fraction of orders were shipped, canceled, unavailable, or remained in intermediate processing states. This suggests that operational disruptions are relatively uncommon and that the logistics network successfully completes the vast majority of customer orders.
### Business Impact
>The high delivery completion rate demonstrates strong operational performance and customer fulfillment reliability. Since failed or canceled orders represent only a small percentage of transactions, subsequent analyses can focus on optimizing delivery speed, freight efficiency, and customer satisfaction rather than addressing widespread fulfillment failures.

___

## Order Demand Trends & Customer Purchase Behavior Dashboard
* When do customers place the highest number of orders, and are there any temporal purchasing patterns that can help optimize business operations?*

<img width="1277" height="989" alt="image2" src="https://github.com/user-attachments/assets/a8eab93e-7c46-4799-a6b9-be30568fc64e" />

### Key Insights
> Monthly order volume grew steadily throughout 2017, reflecting the rapid expansion of the Olist marketplace.
> November 2017 recorded the highest number of orders, aligning with Brazil's Black Friday shopping season.
> Following the Black Friday surge, monthly orders stabilized at approximately 6,000–7,000 orders, indicating consistent customer demand.
> Purchasing activity was concentrated on weekdays, with Monday (16.3%) and Tuesday (16.1%) recording the highest order volumes, while Saturday (10.9%) showed the lowest activity.
> Customers preferred shopping during the Afternoon (38.3%), followed by Night (28.5%) and Morning (27.9%), whereas Dawn accounted for only 5.3% of purchases.
> The sharp decline observed at the end of the timeline reflects incomplete data collection rather than an actual drop in customer demand.
>
### Business Impact
>Seasonal events, particularly Black Friday, have a significant impact on demand and require additional inventory, staffing, and logistics capacity.
Customer purchasing behavior is highly concentrated during weekday afternoons, providing an ideal window for targeted marketing campaigns and promotional activities.

>Understanding peak purchasing periods enables better workforce planning, ensuring customer support and fulfillment teams are adequately staffed during busy hours.
Recognizing low-demand periods, such as weekends and dawn hours, creates opportunities to optimize operational costs through smarter resource allocation.
Temporal purchasing patterns provide valuable insights for inventory planning, helping businesses anticipate demand fluctuations and improve service quality.

___

## Customer purchase Timing and behavior dashboard 
* When are customers most likely to place orders, and how can these purchasing patterns help optimize staffing, marketing campaigns, and operational planning?*
<img width="1333" height="1071" alt="image3" src="https://github.com/user-attachments/assets/45752f44-f41e-47b5-bbf1-c3ea63bdafcf" />

### Key Insights
>Order activity is concentrated during weekday business hours, with Monday recording the highest order volume, followed closely by Tuesday and Wednesday.
>Purchasing behavior follows a clear daily pattern, with demand increasing rapidly after 8 AM, peaking between 10 AM and 4 PM, and remaining relatively high until late evening.
> Overnight activity (2–6 AM) is minimal, indicating that customers rarely purchase during these hours.
>The Day × Hour heatmap highlights a consistent "Golden Purchase Window" between 10 AM and 9 PM on weekdays, where order volume is highest.
>Weekend purchasing activity decreases noticeably, particularly on Saturdays, although evening demand remains relatively stable.
### Business Impact

> Schedule marketing campaigns, promotional emails, and push notifications during the **10 AM–4 PM** window to maximize customer engagement.

> Allocate customer support and warehouse resources according to peak purchasing hours, improving operational efficiency during high-demand periods.

> Plan flash sales and promotional events during weekday afternoons when customer activity is naturally highest.

> Reduce staffing requirements during overnight hours, where customer demand is consistently low.

> Use purchasing patterns to improve forecasting models and workforce scheduling, ensuring resources are aligned with expected order volumes.
>
___
## Sales Growth & Seasonality Performance Dashboard

*How has order demand evolved over time, what seasonal purchasing patterns exist, and which periods consistently generate the highest sales volume?*
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

___
## Delivery Performance & Fulfillment Operations Dashboard
*How efficiently are orders progressing through the fulfillment pipeline, from customer purchase to carrier dispatch, and where do operational bottlenecks occur?*


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

___
## Year-over-Year Growth Performance Dashboard

*How did order volume change between 2017 and 2018, and what does the year-over-year comparison reveal about the marketplace's growth trajectory?*
<img width="1311" height="511" alt="image6" src="https://github.com/user-attachments/assets/8fce157b-f538-4c15-96c2-51e6b024920f" />


### Key Insights

> Between **January and August**, total orders increased from **22,968 in 2017** to **53,991 in 2018**, representing an impressive **143% Year-over-Year growth**.

> Every month in 2018 outperformed its corresponding month in 2017, demonstrating sustained marketplace expansion rather than isolated growth during a few peak periods.

> Monthly order volumes remained consistently above **6,000 orders** throughout the first eight months of 2018, indicating that customer demand had stabilized at a significantly higher level.

> The strongest relative improvements occurred during the first half of the year, suggesting successful customer acquisition and increased platform adoption.

> The absence of any major monthly declines indicates healthy business momentum and a scalable operational model capable of supporting continued growth.

### Business Impact

> The sustained YoY growth demonstrates strong market expansion and validates investments in customer acquisition and marketplace development.

> Forecasting models should account for the significantly higher demand observed in 2018 to improve inventory planning and logistics capacity.

> Continued investment in fulfillment operations and customer support is essential to maintain service quality as order volumes increase.

> Marketing strategies that contributed to the 2018 growth should be evaluated and replicated to sustain long-term business expansion.

> Infrastructure, warehouse capacity, and staffing plans should be scaled proactively to support continued increases in marketplace demand.


___

## Brazil Regional market share and performance analysis 
*How is revenue distributed across Brazil's macro-regions, and which regions generate the highest customer value through Average Order Value (AOV)?*
<img width="1466" height="719" alt="image7" src="https://github.com/user-attachments/assets/e36fda64-cc93-4a80-8814-4bd1e27d9ff0" />

### Insights

> The Southeast region dominates the Brazilian e-commerce market, contributing approximately **65.4% of total revenue**, making it the company's primary revenue driver.

> Although the **North region accounts for only 2.5% of total revenue**, it records the **highest Average Order Value (R$161.10)**, indicating customers in this region spend considerably more per purchase.

> The **Northeast region** also demonstrates strong purchasing behavior, with an average order value of **R$147.66**, well above the national average despite representing a relatively modest share of revenue (11.4%).

> In contrast, the **Southeast region has the lowest Average Order Value (R$113.96)**. Its market leadership is driven by very high order volume rather than high-value transactions.

> The **South (14.4%)** and **Central-West (6.4%)** occupy a middle position, contributing moderate revenue while maintaining healthy average order values.

### Business Impact

> The Southeast should remain the company's highest operational priority, as even small improvements in conversion, logistics, or customer retention can generate significant revenue gains due to its large customer base.

> Premium product assortments and targeted marketing campaigns should be explored in the North and Northeast, where customers demonstrate a higher willingness to spend per order.

> Regions with smaller market share but high Average Order Value present attractive expansion opportunities. Increasing customer acquisition in these markets could produce strong revenue growth without relying solely on higher purchase frequency.

> Marketing strategies should be region-specific rather than uniform across Brazil. High-volume regions require operational efficiency and customer retention initiatives, while high-value regions may benefit more from premium positioning and personalized offers.

> Combining market share analysis with Average Order Value helps distinguish between regions that generate revenue through **customer volume** and those that generate revenue through **higher customer spending**, enabling more effective allocation of marketing and operational resources.


___

## Regional Order Distribution & Market Insights Dashboard
 *How is customer demand distributed across Brazil's regions, states, and cities, and which geographic markets contribute the most to overall order volume?*

<img width="1511" height="1011" alt="image8" src="https://github.com/user-attachments/assets/56fa4c67-bd9f-4a62-a842-6dbf82225825" />


### Insights

> - The **Southeast (Sudeste)** consistently records the highest monthly order volume, establishing it as the company's largest regional market throughout the analysis period.

> - **São Paulo (SP)** accounts for **42.2% of all customer orders**, making it the dominant state in Brazil's e-commerce market.

> - **Rio de Janeiro (RJ)** and **Minas Gerais (MG)** are the second and third largest contributors, representing **12.9%** and **11.7%** of total orders, respectively.

> - At the city level, **São Paulo** leads by a significant margin with **17,843 orders**, more than double the order volume of **Rio de Janeiro**, the second-ranked city.

> - Customer demand is highly concentrated within a few key metropolitan areas, while many states contribute only a small percentage of total orders.

> - Regional demand remains relatively stable over time, with the Southeast consistently outperforming the South, Northeast, Central-West, and North regions.

### Business Impact

> - Prioritize inventory allocation, warehouse capacity, and logistics investments in the **Southeast**, particularly São Paulo, where customer demand is greatest.

> - Concentrate marketing campaigns and customer retention initiatives in high-volume states such as **São Paulo, Rio de Janeiro, and Minas Gerais** to maximize business impact.

> - Expand fulfillment infrastructure around major metropolitan areas to improve delivery efficiency and customer satisfaction.

> - Develop targeted acquisition strategies for lower-performing regions to diversify revenue sources and reduce dependence on a single geographic market.

> - Geographic demand analysis provides valuable guidance for regional expansion, warehouse placement, inventory planning, and localized marketing strategies.

___
## Evolution of E-commerce 
*How did total sales revenue, order volume, and freight costs evolve over time, and what do these trends reveal about business growth and operational performance?*

<img width="1490" height="1189" alt="image9" src="https://github.com/user-attachments/assets/410c2cb6-8438-4e02-ae13-2aeb51478204" />

### Insights

> - Total sales revenue increased substantially throughout the analysis period, reaching its highest value in **November 2017 (approximately R$1.01M)**, likely influenced by seasonal shopping events such as **Black Friday**.

> - Monthly order volume closely follows the revenue trend, indicating that revenue growth was primarily driven by an increase in customer purchases rather than isolated high-value transactions.

> - Comparing the same period (January–August), total sales increased from **R$3.11M in 2017** to **R$7.39M in 2018**, representing a **142.15% Year-over-Year revenue growth**.

> - Average freight cost remained relatively stable during 2017, fluctuating around **R$18–20 per order**, before increasing during mid-2018 to more than **R$22 per order**.

> - Despite significant growth in revenue and order volume, freight costs increased only gradually, suggesting that logistics expenses remained relatively controlled as the business expanded.

### Business Impact

> - The strong Year-over-Year revenue growth demonstrates successful business expansion and increasing customer demand, supporting continued investment in marketing and customer acquisition.

> - The November revenue peak highlights the importance of seasonal events, emphasizing the need for proactive inventory planning and logistics preparation during promotional periods.

> - Monitoring freight cost trends alongside revenue helps ensure that operational costs do not outpace sales growth as order volume increases.

> - The gradual rise in average freight cost during 2018 may indicate expanding delivery distances, higher carrier pricing, or changing customer purchasing patterns, warranting further logistics optimization.

> - Tracking revenue, order volume, and freight expenses together provides management with a comprehensive view of both commercial performance and operational efficiency, enabling more informed strategic planning.
___

## Delivery Performance and SLA compilance analysis 
 *How effectively does the company meet its delivery promises, and which states demonstrate the strongest and weakest delivery performance?*
<img width="1839" height="933" alt="output" src="https://github.com/user-attachments/assets/748029ec-d761-4c44-83ed-7e489c87b227" />


### Key Insights
>- **79.3%** of orders were delivered significantly earlier than the estimated delivery date, while only **6.6%** were delivered after the promised date.
>- The average delivery time is **12.0 days**, and orders arrive on average **13.7 days before** the estimated delivery date.
>- **Alagoas (20.9%)**, **Maranhão (18.2%)**, and **Sergipe (16.4%)** recorded the highest late-delivery rates, exceeding the national average (**9.1%**).
>- **Amazonas (3.1%)**, **Acre (3.3%)**, **Amapá (3.7%)**, **Paraná (3.9%)**, and **Rondônia (4.0%)** achieved the lowest late-delivery rates.

###  Business Impact
>- Strong early-delivery performance increases customer satisfaction and strengthens trust in the platform.
>- States with above-average late-delivery rates should be prioritized for logistics improvements and carrier optimization.
>- More accurate delivery estimates could improve customer expectations while maintaining high service quality.
>- Regional performance comparisons help identify logistics best practices that can be replicated across underperforming states.
___
## Freight Cost Efficiency Across Regions & Product Categories
 *Which product categories incur the highest freight costs relative to their product price across different Brazilian regions, and where are shipping costs disproportionately high?*
<img width="1599" height="590" alt="image10" src="https://github.com/user-attachments/assets/ed0eafe0-c3dd-467d-8fa6-f8151c40427b" />


###  Key Insights
> Electronics consistently exhibit the highest freight-to-product price ratio across all regions, reaching **100% in the North**, indicating that shipping can cost as much as the product itself.

> Telephony products also have relatively high freight ratios, particularly in the **North (0.83)** and **Northeast (0.63)**, suggesting logistics costs represent a significant share of the selling price.

> The **North** generally experiences the highest freight burden across most product categories, while the **Southeast** maintains the lowest freight-to-price ratios, reflecting a more efficient logistics network.

> Categories such as **Watches & Gifts**, **Cool Stuff**, and **Toys** maintain comparatively low freight ratios across nearly all regions, indicating lower transportation costs relative to product value.

> Large regional differences for the same product category highlight that geographic location has a major impact on shipping efficiency and overall logistics costs.

### Business Impact
> High freight ratios for **Electronics** and **Telephony** in northern regions suggest opportunities for regional warehouses, improved carrier partnerships, or optimized shipping routes.

> Region-specific pricing and shipping strategies can help maintain profitability in areas where logistics costs consume a large portion of product value.

> Optimizing fulfillment for freight-intensive categories can significantly improve margins while keeping products competitively priced.

> Monitoring freight-to-price ratios across regions enables more informed inventory allocation and logistics planning, reducing operational costs and improving customer satisfaction.
___
## Freight Cost Efficiency
*How efficient are shipping costs across states, regions, and product categories, and where are the biggest opportunities to reduce freight expenses while maintaining customer satisfaction?*
<img width="1797" height="1453" alt="output2" src="https://github.com/user-attachments/assets/3430f97d-a488-4f5f-8b8f-f0a29e2a1861" />

### Key insights
> The average freight cost represents **30.8% of the product price**, while the median is **23.1%**, indicating that a relatively small number of orders incur exceptionally high shipping costs.

> Approximately **36.3% of all orders** have a freight-to-product ratio above the average, highlighting a significant portion of shipments where logistics costs are disproportionately high.

> States such as **Roraima (RR), Rondônia (RO), Maranhão (MA), Amazonas (AM), and Tocantins (TO)** exhibit the highest average freight ratios, suggesting that geographic distance and logistical complexity substantially increase shipping costs.

> Product categories such as **Telephony** and **Utilities & Home** consistently show the highest freight ratios across multiple regions, while categories like **Watches & Gifts** and **Beauty & Health** remain comparatively inexpensive to ship.

> The freight ratio distribution is **highly right-skewed**, meaning that although most orders have moderate shipping costs, a small number of shipments experience exceptionally high logistics expenses that inflate the overall average.

### Business Impact
> Prioritize logistics optimization in high-cost states by improving warehouse placement, expanding carrier partnerships, or introducing regional fulfillment centers.

> Review pricing and shipping strategies for product categories with consistently high freight ratios to protect profit margins.

> Consider shipping subsidies, minimum order thresholds, or bundled purchases for regions where freight costs are disproportionately expensive.

> Investigate extreme freight outliers to identify operational inefficiencies, inaccurate shipping calculations, or opportunities for better carrier negotiations.

> Monitor freight ratio as a key logistics KPI to balance customer satisfaction, shipping costs, and overall profitability across different markets.


# Maps 
## *Answering business questions but using maps*

### Where does most revenue comes from?

<img width="996" height="747" alt="image" src="https://github.com/user-attachments/assets/810f492c-f17b-4237-86b8-2230c41a88e3" />
<img width="866" height="811" alt="image" src="https://github.com/user-attachments/assets/8cb0b20e-4277-48d0-aaef-8ec3abb5daaa" />


### Who pays more for transportation?
<img width="983" height="747" alt="image" src="https://github.com/user-attachments/assets/2e2a04c8-1130-4a87-9808-15226061b2f3" />
<img width="847" height="835" alt="image" src="https://github.com/user-attachments/assets/9e550e6b-6a15-4471-9f07-fe388c0fd699" />


### Average Delivery Time
<img width="982" height="747" alt="image" src="https://github.com/user-attachments/assets/e2124ec9-8550-49f5-b544-49502ebc06ce" />
<img width="853" height="820" alt="image" src="https://github.com/user-attachments/assets/0f202167-23f0-4c34-93c0-30949a037ada" />

### Delayed Orders
<img width="996" height="746" alt="image" src="https://github.com/user-attachments/assets/6805c2c7-c889-4859-917b-2c25533cc241" />
<img width="860" height="818" alt="image" src="https://github.com/user-attachments/assets/2462ed7f-cfc0-45b5-addf-17fef94f8c0e" />

### States with the most installments 
<img width="991" height="741" alt="image" src="https://github.com/user-attachments/assets/d6e22fe5-33a5-4c4a-a465-1eea29de51de" />
<img width="856" height="827" alt="image" src="https://github.com/user-attachments/assets/adb361d0-31e3-4cad-9c50-14da2bf0975e" />


## Customer Review Sentiment Analysis (NLP)

### Business Question
> What are customers saying about their shopping experience, and what is the overall sentiment of their reviews?

### Approach
> - Cleaned customer review comments.
> - Applied a pre-trained Hugging Face Transformer model for sentiment analysis.
> - Classified each review into sentiment categories.
> - Combined sentiment predictions with order information for further analysis.
> - Visualized sentiment distribution and the most common words in positive and negative reviews.

<img width="1582" height="812" alt="output3" src="https://github.com/user-attachments/assets/59972a5b-cc2e-4604-bdf4-afa876f56a91" />














