-- SELECT 
--    CASE
-- 	  WHEN date BETWEEN '2023-01-01' AND '2023-03-31' THEN 'Q1'
-- 	  WHEN date BETWEEN '2023-04-01' AND '2023-06-30' THEN 'Q2'
-- 	  WHEN date BETWEEN '2023-07-01' AND '2023-09-30' THEN 'Q3'
-- 	  WHEN date BETWEEN '2023-10-01' AND '2024-01-01' THEN 'Q4'
--     END AS date_group,
-- 	       gender, 
-- 	       age, 
-- 	       product_category,
-- 	       total_amount 	
-- FROM project_1
-- GROUP BY date_group,gender,age,product_category,total_amount
-- ORDER BY date_group, age, total_amount

SELECT 
   CASE
	  WHEN date BETWEEN '2023-01-01' AND '2023-03-31' THEN 'Q1'
	  WHEN date BETWEEN '2023-04-01' AND '2023-06-30' THEN 'Q2'
	  WHEN date BETWEEN '2023-07-01' AND '2023-09-30' THEN 'Q3'
	  WHEN date BETWEEN '2023-10-01' AND '2024-01-01' THEN 'Q4'
    END AS date_group,
SUM(total_amount) AS sum_total
FROM project_1
GROUP BY date_group
ORDER BY date_group

