WITH customer_cohort AS (
    SELECT
        c.customer_unique_id,
        MIN(DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m-01')) AS cohort_month
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),

cohort_data AS (
    SELECT
        cc.customer_unique_id,
        cc.cohort_month,
        TIMESTAMPDIFF(
            MONTH,
            cc.cohort_month,
            DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m-01')
        ) AS cohort_index
    FROM customer_cohort cc
    JOIN olist_customers_dataset c
        ON cc.customer_unique_id = c.customer_unique_id
    JOIN olist_orders_dataset o
        ON c.customer_id = o.customer_id
),

cohort_counts AS (
    SELECT
        cohort_month,
        cohort_index,
        COUNT(DISTINCT customer_unique_id) AS customers
    FROM cohort_data
    GROUP BY cohort_month, cohort_index
)

SELECT
    cohort_month,
    cohort_index,
    customers,
    FIRST_VALUE(customers) OVER (
        PARTITION BY cohort_month
        ORDER BY cohort_index
    ) AS cohort_size,
    ROUND(
        customers * 100.0 /
        FIRST_VALUE(customers) OVER (
            PARTITION BY cohort_month
            ORDER BY cohort_index
        ),
        2
    ) AS retention_rate
FROM cohort_counts
ORDER BY cohort_month, cohort_index;