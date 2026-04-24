-- ── LEVEL 1: Is there a problem? ─────────────────────────────
SELECT
    order_year,
    COUNT(*)                                              AS total_orders,
    ROUND(AVG(CAST(on_time_flag AS FLOAT)) * 100, 2)      AS otd_rate_pct,
    ROUND(AVG(CAST(on_time_flag AS FLOAT)) * 100, 2) - 92 AS gap_vs_92pct_target
FROM fact_orders
GROUP BY order_year
ORDER BY order_year;
GO

--aLEVEL 2: WHERE is the problem? ───────────────────────────
WITH natl_avg AS (
    SELECT ROUND(AVG(CAST(on_time_flag AS FLOAT)) * 100, 2) AS natl_otd
    FROM fact_orders
)
SELECT
    f.customer_state,
    COUNT(*)                                              AS total_orders,
    ROUND(AVG(CAST(f.on_time_flag AS FLOAT)) * 100, 2)    AS state_otd_pct,
    n.natl_otd                                            AS national_otd_pct,
    ROUND(AVG(CAST(f.on_time_flag AS FLOAT)) * 100, 2)
        - n.natl_otd                                      AS gap_vs_national,
    ROUND(AVG(CAST(f.delay_days  AS FLOAT)), 2)           AS avg_delay_days
FROM fact_orders f
CROSS JOIN natl_avg n
GROUP BY f.customer_state, n.natl_otd
HAVING COUNT(*) > 100
ORDER BY gap_vs_national ASC;
GO

-- Worst state x seller combinations
SELECT TOP 20
    f.customer_state,
    f.primary_seller_id,
    COUNT(*)                                              AS orders,
    ROUND(AVG(CAST(f.on_time_flag AS FLOAT)) * 100, 2)    AS otd_rate_pct,
    ROUND(AVG(CAST(f.delay_days  AS FLOAT)), 2)           AS avg_delay,
    ROUND(SUM(ISNULL(f.total_revenue, 0)), 2)             AS revenue_at_risk
FROM fact_orders f
WHERE f.is_late = 1
GROUP BY f.customer_state, f.primary_seller_id
HAVING COUNT(*) > 10
ORDER BY otd_rate_pct ASC, orders DESC;
GO

-- ── LEVEL 3: WHY is it happening? ────────────────────────────
WITH seller_stats AS (
    SELECT
        primary_seller_id,
        COUNT(*)                                           AS total_orders,
        ROUND(AVG(CAST(on_time_flag AS FLOAT))*100, 2)    AS otd_rate_pct,
        ROUND(AVG(CAST(delay_days  AS FLOAT)), 2)         AS avg_delay,
        ROUND(AVG(CAST(review_score AS FLOAT)), 2)        AS avg_review,
        ROUND(SUM(ISNULL(total_revenue,0)), 2)            AS total_revenue
    FROM fact_orders
    GROUP BY primary_seller_id
    HAVING COUNT(*) >= 20
)
SELECT
    primary_seller_id,
    total_orders,
    otd_rate_pct,
    avg_delay,
    avg_review,
    total_revenue,
    NTILE(4) OVER (ORDER BY otd_rate_pct DESC)            AS performance_quartile,
    CASE NTILE(4) OVER (ORDER BY otd_rate_pct DESC)
        WHEN 1 THEN 'Top Quartile'
        WHEN 2 THEN 'Above Avg'
        WHEN 3 THEN 'Below Avg'
        WHEN 4 THEN 'Bottom Quartile'
    END AS performance_tier
FROM seller_stats
ORDER BY otd_rate_pct ASC;
GO

-- Pareto: what % of late orders come from top sellers?
WITH seller_late AS (
    SELECT
        primary_seller_id,
        SUM(is_late)   AS late_count,
        COUNT(*)       AS total_orders
    FROM fact_orders
    GROUP BY primary_seller_id
    HAVING COUNT(*) >= 10
),
ranked AS (
    SELECT *,
        SUM(late_count) OVER (ORDER BY late_count DESC
                              ROWS UNBOUNDED PRECEDING) AS running_late,
        SUM(late_count) OVER ()                         AS total_late
    FROM seller_late
)
SELECT TOP 30
    primary_seller_id,
    late_count,
    total_orders,
    ROUND(CAST(late_count   AS FLOAT)/total_orders*100, 1) AS seller_late_rate,
    ROUND(CAST(running_late AS FLOAT)/total_late*100,   1) AS cumulative_pct_of_all_late
FROM ranked
ORDER BY late_count DESC;
GO