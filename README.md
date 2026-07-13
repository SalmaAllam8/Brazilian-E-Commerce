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


