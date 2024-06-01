SELECT 
	quantity,
	product_category,
    SUM (total_amount) AS sum_total_amount,
	AVG (price_per_unit) AS avg_price_per_unit
FROM project_1
	WHERE product_category = 'Electronics'
GROUP BY quantity, product_category
ORDER BY quantity