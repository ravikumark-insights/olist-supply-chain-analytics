--Overall OTD Rate
SELECT
    COUNT(*)                                          AS total_orders,
    SUM(on_time_flag)                                 AS on_time_orders,
    SUM(is_late)                                      AS late_orders,
    ROUND(AVG(CAST(on_time_flag AS FLOAT)) * 100, 2)  AS otd_rate_pct,
    ROUND(AVG(CAST(is_late     AS FLOAT)) * 100, 2)   AS late_rate_pct,
    ROUND(AVG(CAST(delay_days  AS FLOAT)), 2)          AS avg_delay_all_orders,
    ROUND(AVG(CASE WHEN is_late = 1 THEN CAST(delay_days AS FLOAT) END), 2) 
                                                      AS avg_delay_late_only
FROM fact_orders;
GO

-- OTD Rate by State (worst first)
SELECT
    customer_state,
    COUNT(*)                                              AS total_orders,
    SUM(on_time_flag)                                     AS on_time,
    SUM(is_late)                                          AS late,
    ROUND(AVG(CAST(on_time_flag AS FLOAT)) * 100, 2)      AS otd_rate_pct,
    ROUND(AVG(CAST(delay_days  AS FLOAT)), 2)             AS avg_delay_days,
    ROUND(AVG(CAST(is_late     AS FLOAT)) * 100, 2) 
        - ROUND(AVG(CAST(on_time_flag AS FLOAT)) * 100, 2) -- gap vs national
                                                          AS gap_vs_national
FROM fact_orders
GROUP BY customer_state
ORDER BY otd_rate_pct ASC;
GO

-- Monthly OTD Trend
SELECT
    order_month_str,
    order_year,
    order_month,
    COUNT(*)                                            AS total_orders,
    ROUND(AVG(CAST(on_time_flag AS FLOAT)) * 100, 2)    AS otd_rate_pct,
    ROUND(AVG(CAST(delay_days  AS FLOAT)), 2)           AS avg_delay_days,
    SUM(ISNULL(total_revenue, 0))                       AS monthly_revenue
FROM fact_orders
GROUP BY order_month_str, order_year, order_month
ORDER BY order_month_str;
GO

-- Review Score vs Delivery Performance (KEY INSIGHT)
SELECT
    CASE WHEN on_time_flag = 1 THEN 'On Time' ELSE 'Late' END  AS delivery_status,
    COUNT(*)                                                    AS total_orders,
    ROUND(AVG(CAST(review_score AS FLOAT)), 3)                  AS avg_review_score,
    ROUND(SUM(CASE WHEN review_score = 1 THEN 1.0 ELSE 0 END)
          / COUNT(*) * 100, 2)                                  AS one_star_rate_pct,
    ROUND(SUM(CASE WHEN review_score = 5 THEN 1.0 ELSE 0 END)
          / COUNT(*) * 100, 2)                                  AS five_star_rate_pct
FROM fact_orders
WHERE review_score IS NOT NULL
GROUP BY on_time_flag;
GO

-- Revenue Summary
SELECT
    order_year,
    COUNT(*)                                  AS total_orders,
    ROUND(SUM(ISNULL(total_revenue,0)), 2)    AS total_revenue,
    ROUND(AVG(ISNULL(total_revenue,0)), 2)    AS avg_order_value,
    ROUND(SUM(ISNULL(total_freight,0)), 2)    AS total_freight_cost
FROM fact_orders
GROUP BY order_year
ORDER BY order_year;
GO