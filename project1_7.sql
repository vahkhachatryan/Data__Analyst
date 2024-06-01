SELECT
   product_category,
   price_per_unit,
   quantity,
   total_amount
FROM project_1
WHERE quantity = 1
GROUP BY product_category,price_per_unit
ORDER BY product_category,price_per_unit DESC






