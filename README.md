# 🚚 Olist Supply Chain Analytics  
**Business Analyst Project | SQL, Python, Power BI**

---

## 📌 Executive Summary

This project delivers an end-to-end analysis of an e-commerce supply chain using the Olist dataset, focusing on delivery performance, operational efficiency, and customer experience.

The goal was to move beyond descriptive reporting and build a structured, decision-support framework that identifies inefficiencies, quantifies their impact, and translates insights into actionable business decisions.

The solution integrates SQL-based data transformation, Python-driven analysis, and a Power BI dashboard to enable continuous monitoring and data-driven decision-making.

---

## 🧩 Business Problem

Delivery performance is a critical driver of customer satisfaction in e-commerce. However, organizations often lack visibility into:

- Where delays occur in the fulfillment lifecycle  
- How delivery performance varies across regions  
- What drives late deliveries  
- How to prioritize operational improvements  

This leads to reactive decision-making and inefficient resource allocation.

---

## 🎯 Objective

- Measure delivery performance using standardized KPIs  
- Identify and quantify delivery delays  
- Analyze regional and temporal performance variation  
- Detect operational bottlenecks  
- Enable data-driven improvements in delivery efficiency  

---

## 🔄 Supply Chain Flow (Scope)

The analysis covers the **order-to-delivery lifecycle**:

**Order Purchase → Order Approval → Shipment → Delivery**

---

## 📊 Data & Modeling

The project uses the Olist dataset, including:

- Orders and timestamps  
- Customers and locations  
- Sellers and fulfillment data  
- Order items and payments  

### Data Preparation

- Merged datasets into a unified analytical model  
- Standardized timestamps  
- Created derived metrics:
  - Delivery Time  
  - Delay Days  
  - Delivery Status (On-Time / Delayed)  

---

## 📏 KPI Definitions

- **On-Time Delivery (OTD%)**  
  = Orders delivered on or before estimated date / Total orders  

- **Delay Rate (%)**  
  = Delayed orders / Total orders  

- **Average Delivery Time**  
  = Avg(Delivery Date - Purchase Date)  

- **Average Delay Duration**  
  = Avg(Delay Days for delayed orders)  

---

## ⚙️ Analytical Approach

### 1. Data Transformation (SQL)
- Aggregated order-level performance  
- Calculated KPIs  
- Identified high-delay regions  

### 2. Exploratory Analysis (Python)
- Data cleaning and validation  
- Trend analysis  
- Pattern identification  

### 3. Performance Analysis
- Regional delivery variation  
- Monthly trends  
- Delay severity  

### 4. Root Cause Analysis
- Identified fulfillment vs transportation delays  
- Detected geographic bottlenecks  

### 5. 📈 Visualization & Decision Layer
Power BI dashboard built to:
- Track KPIs  
- Compare regions  
- Monitor trends  
- Highlight performance gaps  

---

## 🔍 Key Insights

### 1. Regional Inefficiencies
Some regions consistently show higher delays.

**Action:** Optimize routing and logistics capacity  

---

### 2. Predictable Delay Patterns
Delays follow identifiable trends.

**Action:** Implement proactive monitoring  

---

### 3. Multi-Stage Bottlenecks
Delays occur in both processing and delivery stages.

**Action:** Analyze lifecycle stages separately  

---

## 💼 Business Impact

- 📊 Improved visibility into delivery performance  
- 📈 Data-driven decision-making  
- ⚙️ Targeted operational improvements  
- 😊 Better customer experience  

---

## 📊 Dashboard

Power BI dashboard includes:

- OTD% tracking  
- Delay rate  
- Delivery time trends  
- Regional performance  

---

## 🛠 Tech Stack

- SQL  
- Python (Pandas)  
- Power BI  
- Jupyter Notebook  

---

## 🚀 Skills Demonstrated

- Data Modeling  
- KPI Development  
- Supply Chain Analytics  
- Root Cause Analysis  
- Data Visualization  
- Business Insights  

---

## 📁 Repository Structure

```markdown

olist-supply-chain-analytics/
│
├── data/
│   └── README.md                          # Dataset source (Olist - Kaggle)
│
├── notebooks/
│   └── olist_analysis.ipynb               # Python analysis (EDA + transformations)
│
├── sql/
│   └── olist_analysis.sql                 # SQL queries for KPI analysis
│
├── dashboard/
│   └── olist_dashboard.pbix               # Power BI dashboard (or screenshots)
│
├── docs/
│   └── Olist_Supply_Chain_Analytics.pdf   # Project documentation
│
└── README.md                             # Project overview

## 🔮 Future Enhancements

- Predictive modeling for delivery delays  
- Real-time pipeline integration  
- Seller-level performance insights  
- Customer satisfaction correlation  

---

## 👤 Author

**Ravi Kumar**  
Business Analyst
