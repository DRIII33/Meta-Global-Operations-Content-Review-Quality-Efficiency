-- =====================================================================
-- Phase 2: SQL Data Manipulation and View Creation in Google BigQuery
-- Project ID: driiiportfolio
-- Dataset: meta_go_operations
-- =====================================================================

-- 1. Base Table
-- ---------------------------------------------------------------------
-- Assume 'raw_content_reviews' is created by uploading the CSV
-- (content_review_data.csv) into the BigQuery dataset 'meta_go_operations'.
-- Schema is inferred from the Python script's output.

-- Example (manual upload or scripted):
-- bq load --source_format=CSV \
--   driiiportfolio:meta_go_operations.raw_content_reviews \
--   ./content_review_data.csv

-- ---------------------------------------------------------------------
-- 2. Create a Materialized (Analyst-Ready) View
-- ---------------------------------------------------------------------
-- This view performs:
--   - Key transformations
--   - Reviewer-level daily aggregations
--   - Demonstration of advanced SQL & pipeline building

CREATE OR REPLACE VIEW `driiiportfolio.meta_go_operations.reviewer_performance_view` AS
SELECT
    -- =============================
    -- Dimensions
    -- =============================
    FORMAT_DATE('%Y-%m-%d', review_date_time) AS review_date,  -- Convert DATETIME → DATE
    reviewer_id,
    region,
    team_level,

    -- =============================
    -- Reviewer-Level Metrics
    -- =============================
    COUNT(review_id) AS total_reviews_day,  -- Operational throughput

    -- Quality Metrics
    SUM(CASE WHEN decision_accuracy_rate < 0.90 THEN 1 ELSE 0 END) AS count_low_accuracy_reviews,  -- Count <90% accuracy
    AVG(decision_error_rate) AS average_daily_error_rate,  -- Overall daily error rate

    -- Efficiency Metrics
    AVG(review_time_seconds) AS average_review_time_sec,   -- Avg review duration
    AVG(reviews_per_minute) AS average_reviews_per_minute, -- Avg efficiency

    -- Complexity & AI Metrics
    AVG(content_complexity_score) AS average_complexity_score_day,
    SUM(CASE WHEN ai_triage_used = TRUE THEN 1 ELSE 0 END) AS ai_triage_usage_count,  -- AI adoption

    -- Correlation Metrics: AI vs. Performance
    AVG(CASE WHEN ai_triage_used = TRUE  THEN review_time_seconds END) AS avg_time_with_ai,
    AVG(CASE WHEN ai_triage_used = FALSE THEN review_time_seconds END) AS avg_time_without_ai,
    AVG(CASE WHEN ai_triage_used = TRUE  THEN decision_error_rate END) AS avg_error_with_ai,

    -- Contextual Metrics
    APPROX_COUNT_DISTINCT(policy_area) AS distinct_policy_areas_reviewed -- Complexity proxy

FROM
    `driiiportfolio.meta_go_operations.raw_content_reviews`
GROUP BY
    review_date, reviewer_id, region, team_level
ORDER BY
    review_date, reviewer_id;

-- ---------------------------------------------------------------------
-- 3. Verification Query
-- ---------------------------------------------------------------------

SELECT *
FROM `driiiportfolio.meta_go_operations.reviewer_performance_view`
LIMIT 10;
