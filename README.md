# Customer-Behaviour-Analysis-Project---Python-SQL-PowerBI
A personal project going over a dataset of customer purchasing history, and using Python, SQL and PowerBI to analyze and present findings from a dataset. 

1. **Data Cleaning & Preprocessing (Python):** Missing value imputation, snake_case normalization, feature engineering (age bins, purchase frequency days), and redundant feature removal.
2. **Database Integration & Advanced Querying (PostgreSQL):** Direct Pandas-to-PostgreSQL pipeline using `SQLAlchemy` and `psycopg2`. Ran SQL queries involving CTEs, window functions (`ROW_NUMBER()`), and conditional aggregation.
3. **Interactive BI Dashboard (Power BI):** Developed a dynamic dashboard featuring multi-KPI metric cards, custom slicers, category sales breakdowns, and demographic revenue distributions.
4. **Stakeholder Deliverables:** Executive summary documentation and an AI-assisted presentation deck for client and management reviews.

---

## Tech Stack & Tools Used
* **Programming & Libraries:** Python (`pandas`, `numpy`, `sqlalchemy`, `psycopg2`)
* **Database Management:** PostgreSQL / pgAdmin 4
* **Business Intelligence:** Power BI (DAX Measures, Custom Cards, Slicers, Interactions)
* **Documentation & Presentation:** Markdown, Gamma AI
* **Version Control:** Git & GitHub

---

## Data Preprocessing & Feature Engineering (Python)

Key preprocessing steps performed in Jupyter Notebook:
* **Category-Aware Imputation:** Replaced missing values in `review_rating` using category-specific medians rather than a global median to preserve domain variance across product types.
* **Standardization:** Converted column names into standard `snake_case` format for seamless SQL integration.
* **Feature Engineering:**
  * Created `age_group` bins using `pd.qcut` (`Young Adult`, `Adult`, `Middle-Aged`, `Senior`).
  * Mapped textual purchase frequencies (`Weekly`, `Monthly`, `Fortnightly`) to numeric integer days (`purchase_frequency_days`).
* **Deduplication:** Dropped the redundant `promo_code_used` column after establishing 100% correlation with `discount_applied`.

---

## Key Business Insights & SQL Findings

Below are key business queries evaluated in PostgreSQL:

### 1. Subscription Revenue vs. Spend Behavior
* **Finding:** Non-subscribed customers generated significantly higher total revenue due to a larger customer base, while average order spend between subscribers and non-subscribers remained virtually identical.
* **Action:** Review the value proposition of the subscription program—current loyal repeat buyers show low conversion rates to paid subscriptions.

### 2. High Discount Dependency
* **Finding:** Computed product-level discount reliance rates using conditional aggregation (`SUM(CASE WHEN...) / COUNT(*)`). Certain items heavily rely on promotions to drive order volume.
* **Action:** Adjust pricing strategies on high-discount items to protect gross margins.

### 3. Shipping Channel Performance
* **Finding:** Customers utilizing **Express Shipping** exhibited a noticeably higher average order value (AOV) compared to Standard Shipping users.
* **Action:** Expand expedited shipping choices and cross-sell premium products during express checkout.

### 4. Category Leaders (Window Functions)
* **Finding:** Used `ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_orders DESC)` to isolate the top 3 best-selling items per product category.

---

## Power BI Interactive Dashboard

The Power BI report (`Customer_Behavior_Dashboard.pbix`) provides interactive visual exploration:

* **KPI Cards:** Total Customers, Average Purchase Amount (USD), and Average Review Rating.
* **Revenue & Sales Breakdown:** Clustered bar charts breaking down revenue and volume by `Category` and `Age Group`.
* **Segmentation & Distribution:** Donut charts for subscription status and dynamic multi-slicers (`Gender`, `Shipping Type`, `Category`).
