SELECT
(
    SUM((price - avg_price) * (freight_value - avg_freight))
) /
(
    SQRT(
        SUM(POWER(price - avg_price, 2)) *
        SUM(POWER(freight_value - avg_freight, 2))
    )
) AS pearson_correlation
FROM (
    SELECT
        price,
        freight_value,
        AVG(price) OVER () AS avg_price,
        AVG(freight_value) OVER () AS avg_freight
    FROM olist_order_items_dataset
) t;

#result 0.4
SELECT
(
    SUM((product_weight_g - avg_weight) * (freight_value - avg_freight))
) /
(
    SQRT(
        SUM(POWER(product_weight_g - avg_weight,2)) *
        SUM(POWER(freight_value - avg_freight,2))
    )
) AS pearson_correlation
FROM (
    SELECT
        p.product_weight_g,
        oi.freight_value,
        AVG(p.product_weight_g) OVER() AS avg_weight,
        AVG(oi.freight_value) OVER() AS avg_freight
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p
        ON oi.product_id = p.product_id
    WHERE p.product_weight_g IS NOT NULL
) t;

# result 0.6 


SELECT
(
    SUM((delivery_days - avg_delivery) * (review_score - avg_score))
) /
(
    SQRT(
        SUM(POWER(delivery_days - avg_delivery,2)) *
        SUM(POWER(review_score - avg_score,2))
    )
) AS pearson_correlation
FROM (
    SELECT
        DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp
        ) AS delivery_days,

        r.review_score,

        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ) OVER() AS avg_delivery,

        AVG(r.review_score) OVER() AS avg_score

    FROM olist_orders_dataset o

    JOIN olist_order_reviews_dataset r
        ON o.order_id = r.order_id

    WHERE
        o.order_delivered_customer_date IS NOT NULL
) t;


# result -0.3


SELECT
(
    SUM((product_photos_qty - avg_photos) * (sales_count - avg_sales))
) /
(
    SQRT(
        SUM(POWER(product_photos_qty - avg_photos,2)) *
        SUM(POWER(sales_count - avg_sales,2))
    )
) AS pearson_correlation
FROM (

    SELECT

        p.product_photos_qty,

        COUNT(oi.order_id) AS sales_count,

        AVG(p.product_photos_qty) OVER() AS avg_photos,

        AVG(COUNT(oi.order_id)) OVER() AS avg_sales

    FROM olist_products_dataset p

    JOIN olist_order_items_dataset oi
        ON p.product_id = oi.product_id

    WHERE p.product_photos_qty IS NOT NULL

    GROUP BY
        p.product_id,
        p.product_photos_qty

) t;

# results 0.005
