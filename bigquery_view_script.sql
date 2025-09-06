-- Phase 2: SQL Data Manipulation and View Creation in Google BigQuery
-- Project ID: driiiportfolio
-- Dataset: meta_go_operations

-- 1. Create a Base Table (Assume 'raw_content_reviews' is the uploaded CSV)
-- The analyst would manually or programmatically upload the content_review_data.csv 
-- into the BigQuery dataset 'meta_go_operations' as table 'raw_content_reviews'.
-- Schema would be inferred from the Python script's output.

-- 2. Create a Materialized View for Analyst-Ready Data
-- This view performs key transformations and aggregates daily metrics, 
-- demonstrating advanced SQL capabilities and pipeline building.
CREATE OR REPLACE VIEW `driiiportfolio.meta_go_operations.reviewer_performance_view` AS
SELECT
    -- Dimensions
    FORMAT_DATE('%Y-%m-%d', review_date_time) AS review_date, -- Transform DATETIME to DATE
    reviewer_id,
    region,
    team_level,
    
    -- Reviewer-Level Aggregated Metrics (Daily)
    COUNT(review_id) AS total_reviews_day, -- Total operational throughput
    
    -- Quality Metrics
    -- Calculate weighted average error rate (Errors are 1-Accuracy)
    SUM(CASE WHEN decision_accuracy_rate < 0.90 THEN 1 ELSE 0 END) AS count_low_accuracy_reviews, -- Count of reviews below the 90% quality threshold
    AVG(decision_error_rate) AS average_daily_error_rate, -- Overall Quality (Error Rate)

    -- Efficiency Metrics
    AVG(review_time_seconds) AS average_review_time_sec, -- Average time per review
    AVG(reviews_per_minute) AS average_reviews_per_minute, -- Average efficiency (Reviews/Min)

    -- Complexity & AI Metrics
    AVG(content_complexity_score) AS average_complexity_score_day,
    SUM(CASE WHEN ai_triage_used = TRUE THEN 1 ELSE 0 END) AS ai_triage_usage_count, -- Measure AI adoption/usage
    
    -- Correlation Metrics: How does AI usage affect efficiency/quality?
    AVG(CASE WHEN ai_triage_used = TRUE THEN review_time_seconds END) AS avg_time_with_ai,
    AVG(CASE WHEN ai_triage_used = FALSE THEN review_time_seconds END) AS avg_time_without_ai,
    AVG(CASE WHEN ai_triage_used = TRUE THEN decision_error_rate END) AS avg_error_with_ai,
    
    -- Contextual Data from Sub-Aggregation (Optional but good practice)
    APPROX_COUNT_DISTINCT(policy_area) AS distinct_policy_areas_reviewed -- Complexity proxy

FROM
    `driiiportfolio.meta_go_operations.raw_content_reviews` -- Source table
GROUP BY
    1, 2, 3, 4
ORDER BY
    review_date, reviewer_id;

-- 3. Verify the View Creation
SELECT *
FROM `driiiportfolio.meta_go_operations.reviewer_performance_view`
LIMIT 10;
