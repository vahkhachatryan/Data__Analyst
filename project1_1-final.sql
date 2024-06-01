SELECT 
    CASE
		WHEN age BETWEEN 18 AND 24 THEN '18-24' 
		WHEN age BETWEEN 25 AND 34 THEN '25-34'
	    WHEN age BETWEEN 35 AND 44 THEN '35-44'
	    WHEN age BETWEEN 45 AND 54 THEN '45-54'
		WHEN age BETWEEN 55 AND 64 THEN '55-64'
    END AS age_group,
	gender,
	product_category,
	SUM(quantity) AS sum_quantity
FROM project_1
GROUP BY age_group,product_category,gender
ORDER BY age_group