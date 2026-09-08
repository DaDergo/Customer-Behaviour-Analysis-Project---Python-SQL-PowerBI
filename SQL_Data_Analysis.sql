SELECT *
FROM customer
-- Revenue by gender
SELECT gender, SUM(purchase_amount)
FROM customer
Group BY gender

-- Customers that used a discounts and spent more than avg
Select customer_id, purchase_amount
FROM customer
WHERE discount_applied = 'Yes' AND (SELECT AVG(purchase_amount) FROM customer) < purchase_amount

-- Top 5 products by AVG review rating

SELECT item_purchased, ROUND(AVG(review_rating::numeric), 2) 
FROM customer
GROUP BY item_purchased 
ORDER BY avg(review_rating) Desc
LIMIT 5

-- Standard vs Express shipping avg purchase amounts
SELECT shipping_type, Round(AVG(purchase_amount::numeric),2)
FROM customer
WHERE shipping_type in ('Express', 'Standard')
Group by shipping_type

-- Subscribers vs non-subscriber spending
SELECT subscription_status, 
ROUND(AVG(purchase_amount)::numeric, 2) as avg_spend, 
ROUND(SUM(purchase_amount)::numeric, 2) as total_rev
FROM customer
Group BY subscription_status

-- Which 5 products have highest percentage of purchases with discounts?
SELECT item_purchased, Round(100*SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/Count(*), 2) as percent_disc
FROM customer
group by item_purchased
Order by percent_disc DESC
LIMIT 5

-- Segment customers into New, Returning, and Loyal based on their total
-- number of previous purchases, and show the count of each segment

with customer_type as (
Select customer_id, previous_purchases,
CASE WHEN previous_purchases= 1 THEN 'New'
WHEN previous_purchases BETWEEN 2 and 10 THEN 'Returning'
ELSE 'loyal'
)

Select SUM(CASE WHEN previous_purchases > 10 THEN 1 ELSE 0 END) as Loyal_customers
SUM(CASE WHEN previous_purchases > 0 THEN 1 ELSE 0 END) as Returning_customers
SUM(CASE WHEN previous_purchase= 1 THEN 'New' ELSE 0 END) as New_customers

From customer
group by Loyal_customers
