WITH seller_metrics AS (
    SELECT
        f.primary_seller_id,
        s.seller_state,
        COUNT(f.order_id)                                  AS total_orders,
        ROUND(AVG(CAST(f.on_time_flag AS FLOAT))*100, 2)   AS otd_rate_pct,
        ROUND(AVG(CAST(f.is_late     AS FLOAT))*100, 2)    AS late_rate_pct,
        ROUND(AVG(CAST(f.delay_days  AS FLOAT)), 2)        AS avg_delay_days,
        ROUND(AVG(CAST(f.review_score AS FLOAT)), 2)       AS avg_review_score,
        ROUND(SUM(ISNULL(f.total_revenue,0)), 2)           AS total_revenue,
        ROUND(AVG(ISNULL(f.total_revenue,0)), 2)           AS avg_order_value,
        SUM(CASE WHEN f.review_score = 1 THEN 1 ELSE 0 END)AS one_star_count
    FROM fact_orders f
    LEFT JOIN dim_sellers s ON f.primary_seller_id = s.seller_id
    GROUP BY f.primary_seller_id, s.seller_state
    HAVING COUNT(f.order_id) >= 20
),
scored AS (
    SELECT *,
        -- OTD Score (0-40 pts)
        CASE WHEN otd_rate_pct >= 95 THEN 40
             WHEN otd_rate_pct >= 90 THEN 32
             WHEN otd_rate_pct >= 85 THEN 20
             WHEN otd_rate_pct >= 75 THEN 10
             ELSE 0 END                        AS otd_score,
        -- Review Score (0-30 pts)
        CASE WHEN avg_review_score >= 4.5 THEN 30
             WHEN avg_review_score >= 4.0 THEN 24
             WHEN avg_review_score >= 3.5 THEN 15
             WHEN avg_review_score >= 3.0 THEN 8
             ELSE 0 END                        AS review_score_pts,
        -- Volume Score (0-20 pts) 
        CASE WHEN total_orders >= 200 THEN 20
             WHEN total_orders >= 100 THEN 15
             WHEN total_orders >= 50  THEN 10
             ELSE 5 END                        AS volume_score,
        -- Revenue contribution (0-10 pts)
        CASE WHEN total_revenue >= 50000 THEN 10
             WHEN total_revenue >= 20000 THEN 7
             WHEN total_revenue >= 5000  THEN 4
             ELSE 2 END                        AS revenue_score
    FROM seller_metrics
)
SELECT
    primary_seller_id,
    seller_state,
    total_orders,
    otd_rate_pct,
    late_rate_pct,
    avg_delay_days,
    avg_review_score,
    total_revenue,
    otd_score + review_score_pts + volume_score + revenue_score  AS composite_score,
    CASE
        WHEN otd_score + review_score_pts + volume_score + revenue_score >= 80 
            THEN 'Preferred Seller'
        WHEN otd_score + review_score_pts + volume_score + revenue_score >= 60 
            THEN 'Approved Seller'
        WHEN otd_score + review_score_pts + volume_score + revenue_score >= 40 
            THEN 'Monitor'
        ELSE 'At Risk'
    END AS seller_tier,
    RANK() OVER (ORDER BY otd_score + review_score_pts + volume_score + revenue_score DESC) 
        AS overall_rank
FROM scored
ORDER BY composite_score DESC;
GO