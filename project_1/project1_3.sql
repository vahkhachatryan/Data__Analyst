SELECT 
	product_category,
SUM (quantity) AS sum_quantity
FROM project_1
GROUP BY product_category
ORDER BY sum_quantity DESC