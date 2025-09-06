# End-to-End Data Analysis Portfolio Project: Meta Global Operations

# Project Title: Optimizing Content Review Quality and Efficiency

# Business Scenario
The mission of Global Operations (GO) at Meta is to minimize harm and ensure positive experiences for users and businesses. The Global Operations Quality team measures the effectiveness of content moderation processes. This project focuses on a core operational challenge: optimizing the manual content review workflow to improve both quality (accuracy) and efficiency (speed).

# Business Problem
Manual content review is a massive, costly, and complex operation. The business needs to identify the specific factors—such as content complexity, reviewer demographics, and AI tool usage—that are driving inefficiencies and errors. By understanding these drivers, we can inform strategic decisions to improve performance and scale operations effectively.

# Proposed Solution
This project develops an end-to-end data analysis workflow to provide data-driven insights. It begins with creating a synthetic dataset that simulates real-world content review metrics and follows with a complete analytical pipeline, including:

Data Generation: Creating a robust, realistic synthetic dataset.

Data Infrastructure: Setting up a data model in Google BigQuery.

Exploratory Analysis: Performing in-depth Exploratory Data Analysis (EDA) to find initial trends.

Advanced Analysis: Conducting statistical tests and deep dives into specific topics like content type and reviewer experience.

Visualization: Building a self-service dashboard to communicate key metrics.

Recommendation: Synthesizing findings into actionable business insights and strategic recommendations.

This project demonstrates proficiency across the full data analysis lifecycle, directly mapping to the skills required for a Data Analyst role at Meta.

# Tools and Technologies
Data Generation & Analysis: Google Colab, Python, Pandas, NumPy, Matplotlib, Seaborn

Data Infrastructure: Google BigQuery, SQL

Version Control: GitHub

Visualization: Looker Studio

Documentation: Google Sheets (for the Data Dictionary)

# Repository Structure
The repository is organized to reflect the project's phased approach, making it easy to navigate the workflow and deliverables.

data/

content_review_data.csv: The raw synthetic dataset generated in Phase 1.

data_dictionary.csv: A detailed description of the columns in the dataset.

notebooks/

phase1_data_generation.ipynb: Python notebook used to create the synthetic data.

phase3_eda_analysis.ipynb: Python notebook for initial Exploratory Data Analysis and statistical deep dives.

phase4_advanced_analysis.ipynb: Python notebook for advanced analysis of reviewer experience and specific content types.

sql/

bigquery_view_script.sql: SQL script used to create the transformed data view in Google BigQuery.

README.md: This file, providing a project overview and a link to the deliverables.

project_summary.md: A summary of the analysis findings, key insights, and business recommendations.

# Project Phases & Deliverables
Phase 1: Project Scoping and Data Modeling
Deliverables: data_dictionary.csv, phase1_data_generation.ipynb, content_review_data.csv

Description: Defined the project scope, created a data dictionary for documentation, and generated the synthetic dataset.

Phase 2: Data Infrastructure and ELT
Deliverables: bigquery_view_script.sql

Description: The raw data was loaded into a BigQuery table, and a series of SQL views were created to transform and aggregate the data for analysis. This showcases advanced SQL and data pipeline conceptualization.

Phase 3: Exploratory Data Analysis (EDA)
Deliverables: phase3_eda_analysis.ipynb

Description: Performed a detailed analysis using Python to uncover relationships between metrics. Key findings included the strong correlation between content complexity, review time, and error rates. The impact of AI on reviewer efficiency was also analyzed.

Phase 4: Advanced Analysis & Hypothesis Testing
Deliverables: phase4_advanced_analysis.ipynb

Description: Conducted deeper analysis on the relationships between reviewer experience (reviewer_monthly_volume) and performance. This phase also included an investigation into the impact of specific policy_area and content_type metrics, providing more granular, actionable insights.

Phase 5: Communication, Visualization, and Recommendations
Deliverables: Looker Studio Dashboard Link (not a file, but a key deliverable), project_summary.md

Description: Key metrics and insights were visualized in an interactive Looker Studio dashboard, designed for self-service consumption by business stakeholders. A comprehensive summary document (project_summary.md) was created to outline the analysis, key insights, and actionable recommendations for the business.

# Key Insights from Analysis
Complexity is the Primary Driver: Content complexity is a strong predictor of both increased review time and higher error rates.

AI Augmentation is Effective: AI-driven triage successfully reduced the average review time, proving its value in scaling operational efficiency.

Targeted Interventions are Needed: Error rates are not uniform; they are concentrated in high-complexity policy areas, suggesting a need for targeted training and specialized tooling.

# Recommendations
Based on the analysis, the following next steps are recommended:

Develop a Complexity-Based Routing Model: Use the content_complexity_score to build a model that automatically assigns high-complexity cases to expert reviewers.

Enhance AI Triage: Investigate the slight increase in error rates with AI triage to refine the model's performance on edge cases.

Implement a Self-Service Dashboard: Roll out the Looker Studio dashboard to operations managers to enable autonomous, data-driven decision-making.


