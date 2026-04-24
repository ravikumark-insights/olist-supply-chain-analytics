# Olist Supply Chain Analytics — Business Analyst Project

**SQL + Python + Power BI | End-to-End Supply Chain Analysis**

## Overview

This project analyzes e-commerce supply chain data to evaluate delivery performance, operational efficiency, and customer experience.

The goal is to identify delivery delays, measure on-time delivery performance, and provide business recommendations to improve logistics efficiency.

## Problem Statement

In e-commerce supply chains, customer satisfaction depends heavily on delivery performance. Delayed deliveries, regional inefficiencies, and poor visibility into fulfillment performance can negatively impact customer experience and operational cost.

This project answers the key question:

How can delivery performance be measured and improved using data?

## Objectives

- Analyze delivery performance across regions
- Measure on-time delivery performance
- Identify delayed orders
- Analyze delivery trends over time
- Identify operational bottlenecks
- Provide actionable business recommendations

## Data Overview

The project uses Olist e-commerce order data, including:

- Orders
- Customers
- Sellers
- Order items
- Payments
- Delivery timestamps
- Customer and seller location data

## Key Metrics

- On-Time Delivery Rate
- Delay Rate
- Average Delivery Time
- Average Delay Days
- Orders by State
- Monthly Delivery Trend
- Regional Delivery Performance

## Analytical Approach

### 1. Data Preparation

- Loaded multiple datasets
- Cleaned missing and inconsistent values
- Standardized date and timestamp fields
- Merged order, customer, seller, and delivery data
- Created calculated columns for delivery time and delay days

### 2. KPI Development

Created business KPIs to measure supply chain performance:

- On-time vs delayed orders
- Delivery time in days
- Delay days compared to estimated delivery date
- Monthly order volume
- State-level delivery performance

### 3. SQL Analysis

SQL was used to:

- Aggregate order performance
- Calculate delivery KPIs
- Identify high-delay states
- Analyze monthly trends
- Compare actual delivery dates against estimated delivery dates

### 4. Python Analysis

Python was used for:

- Data cleaning
- Exploratory data analysis
- Merging datasets
- Creating calculated fields
- Visualizing delivery performance trends

### 5. Dashboard Development

Power BI was used to create an interactive dashboard showing:

- Delivery performance summary
- On-time delivery trends
- Delay analysis
- State-level performance
- Operational bottlenecks

## Key Insights

### 1. Regional Delivery Variation

Some states showed higher delay rates compared to others.

**Business Implication:**  
Delivery performance is not consistent across regions.

**Recommendation:**  
Review logistics capacity, routing, and carrier performance in high-delay regions.

### 2. Delivery Delays Impact Customer Experience

Orders delivered after the estimated date can reduce customer trust and satisfaction.

**Business Implication:**  
Improving delivery accuracy can improve customer experience.

**Recommendation:**  
Track delay rate regularly and prioritize improvement in high-volume regions.

### 3. Bottlenecks Exist Across Fulfillment and Delivery

Delays can occur during order processing, shipping, or final delivery.

**Business Implication:**  
A single delivery metric is not enough; the process must be analyzed end-to-end.

**Recommendation:**  
Separate fulfillment delay from transportation delay to identify root causes.

## Business Impact

This project supports:

- Better supply chain visibility
- Improved on-time delivery tracking
- Identification of regional bottlenecks
- Data-driven logistics planning
- Improved customer experience
- Leadership-level performance reporting

## Dashboard

The Power BI dashboard provides:

- KPI summary
- On-time delivery rate
- Delay rate
- Average delivery time
- State-level performance
- Monthly delivery trends

## Tech Stack

- SQL
- Python
- Pandas
- Jupyter Notebook
- Power BI
- Excel

## Skills Demonstrated

- Supply chain analytics
- Data cleaning
- SQL analysis
- Python analysis
- KPI development
- Dashboard development
- Business insight generation
- Root cause analysis
- Data-driven recommendations

## Repository Structure

```text
olist-supply-chain-analytics/
│
├── data/
├── notebooks/
├── sql/
├── dashboard/
├── docs/
└── README.md
