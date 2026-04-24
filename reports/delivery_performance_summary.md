# Delivery Performance — Findings & Recommendations
**Olist Supply Chain Analytics | Business Analyst Report**

---

## Executive Summary

Olist's current On-Time Delivery (OTD) rate sits approximately **5 percentage points below** the 92% internal target. This gap is not random — it is driven by a combination of geographic routing challenges and a concentrated group of underperforming sellers. Late deliveries have a measurable and severe impact on customer satisfaction: orders that arrive late are **4.5× more likely** to receive a 1-star review compared to on-time orders.

This report presents findings from a structured 3-level root cause analysis and recommends targeted interventions across operations, logistics partnerships, and seller management.

---

## 1. Is There a Problem? (Level 1)

The data confirms a consistent gap vs. target across the available period. Key headline metrics:

- **Overall OTD Rate:** ~87% (target: 92%)
- **Late Orders:** approximately 1 in 8 orders arrives after the estimated delivery date
- **Average delay (late orders only):** ~11 days — indicating that when delays occur, they are not marginal but substantial
- **1-star review rate — Late orders:** ~36% vs ~8% for on-time orders

The business impact is clear: every late delivery is a high-probability customer satisfaction event that costs Olist in reviews, repeat purchase rate, and marketplace reputation.

---

## 2. Where Is the Problem? (Level 2)

OTD performance is not uniform across Brazil. Analysis of state-level performance reveals a clear geographic pattern:

**Worst-performing states** (OTD rate well below national average):
- Northern states (Amazonas, Roraima, Amapá) — logistically isolated, limited carrier coverage
- Northeastern states (Maranhão, Piauí, Alagoas) — high delivery times, infrastructure gaps

**Best-performing states:**
- Southeast hub states (São Paulo, Rio de Janeiro) — proximity to distribution centers

**Key observation:** The worst state × seller combinations account for a disproportionate share of total revenue at risk. Late orders in underperforming corridors represent both a customer experience and a financial exposure issue.

---

## 3. Why Is It Happening? (Level 3)

Seller-level analysis using performance quartiles reveals:

- **Bottom quartile sellers** (worst OTD) are not just slightly worse — they operate with fundamentally different delivery profiles, averaging significantly higher delay days
- A **Pareto analysis** shows the top 30 highest-volume late sellers contribute a cumulative majority of all late order volume
- This is a **concentration problem**: a small number of sellers is disproportionately responsible for the overall OTD gap

This finding is operationally significant — it means targeted intervention with a small group of sellers could move the needle materially on the overall OTD metric.

---

## 4. Seller Scorecard & Tiering

A composite scoring model was developed to classify sellers across four dimensions:

| Dimension | Weight | Rationale |
|-----------|--------|-----------|
| OTD Rate | 40 pts | Primary operational KPI |
| Avg Review Score | 30 pts | Customer satisfaction proxy |
| Order Volume | 20 pts | Marketplace contribution |
| Revenue | 10 pts | Financial importance |

**Tier definitions:**

| Tier | Score | Action |
|------|-------|--------|
| 🟢 Preferred Seller | 80–100 | Priority placement, fast-track support |
| 🟡 Approved Seller | 60–79 | Standard operating conditions |
| 🟠 Monitor | 40–59 | Improvement plan required within 90 days |
| 🔴 At Risk | < 40 | Formal review; potential delisting if no improvement |

---

## 5. Recommendations

### Immediate Actions (0–30 days)

1. **Engage At-Risk sellers** — Pull the At Risk tier list and initiate performance review conversations. Share their individual scorecard data. Set 90-day improvement targets with defined consequences.

2. **Flag high-revenue Monitor sellers** — Sellers in the Monitor tier with high revenue scores represent a managed risk: they're commercially important but operationally concerning. Assign dedicated account management.

### Short-Term (30–90 days)

3. **Audit northern/northeastern shipping routes** — Partner with logistics team to review carrier SLAs for AM, RR, AP, MA states. Consider adding a regional carrier or adjusting estimated delivery dates to be more realistic for these regions.

4. **Review estimated delivery date accuracy** — If the EDD model is systematically underestimating delivery time for certain corridors, correcting the estimate would immediately reduce the measured "late" rate without changing actual delivery time. This is a customer expectation management lever.

### Medium-Term (90+ days)

5. **Build seller onboarding standards** — Require new sellers to demonstrate geographic coverage capability before listing. High-volume routes to underperforming states should have explicit SLA requirements.

6. **Automate scorecard monitoring** — The SQL-based seller scorecard can be scheduled monthly in the data pipeline. Connect it to Power BI for real-time tier visibility. Trigger automated alerts when sellers drop tiers.

---

## 6. Metrics to Track Post-Intervention

- Monthly OTD rate trend (target: reach 92% within 6 months)
- At-Risk seller count (target: reduce by 50% in 90 days)
- Average review score (overall and segmented by tier)
- Revenue at risk (orders from Monitor/At Risk sellers)
- Northern state OTD rate (separate tracking for hardest corridors)

---

*Report generated from SQL Server analysis of Olist e-commerce dataset. All metrics based on delivered orders with validated delivery timestamps.*
