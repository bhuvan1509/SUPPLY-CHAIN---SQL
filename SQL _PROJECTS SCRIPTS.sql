-- supply chain analysis
-- EASY ,INTERMEDIAT,ADVANCED QUERIES

use sqlprojects ;

select * from supply_chain_data;

select count(*) from supply_chain_data;
SELECT COUNT(DISTINCT SKU) FROM supply_chain_data;
desc supply_chain_data;
 
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EASY LEVEL QUERIES

 -- 1.	Product Insights:
 
 -- o	Which products have the highest prices(top 5)?
		select * from supply_chain_data order by price desc LIMIT 5;

-- o	What are the top-selling products based on revenue?
		SELECT product_type , sum(revenue_generated) as totalrevenue  FROM supply_chain_data 
		GROUP BY Product_type
		order by totalrevenue desc;
-- o	Which products are currently in stock?
		SELECT product_type , availability 
		FROM supply_chain_data 
		where availability >= 1 
		ORDER BY availability desc ; 

-- o	Which products are currently stock levels are 0?
		SELECT product_type , availability ,stock_levels
		FROM supply_chain_data 
		where stock_levels = 0 ;


-- 2.	Inventory Management

-- o	How many units of each product are available in stock?
		SELECT Product_Type, SKU, sum(Stock_Levels) as "total stocks"
		FROM  supply_chain_data 
		GROUP BY Product_type , sku;

-- o	Are there any products with low stock levels?
		SELECT product_type ,  stock_levels 
		from supply_chain_data 
		order by stock_levels asc;

-- 3.	Supplier Analysis:

-- o	Who are the primary suppliers for your products?
		SELECT Supplier_name , sum(revenue_generated) as total_revenue
		from supply_chain_data
		group by Supplier_name 
		order by total_revenue desc;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INTERMEDIAT LEVEL

-- 1.	Lead Times and Manufacturing:

-- o	What is the average lead time for shipping products?
		SELECT Product_type , avg(lead_time) as AvgL_time
		from supply_chain_data
		group by product_type
		order by avgl_time desc;

-- o	How long does it take to manufacture each product?
		SELECT Product_type , sum(manufacturing_lead_time) as m_time
		from supply_chain_data
		group by product_type
		order by m_time desc;


-- 2.	Shipping Details:

-- o	Which shipping carriers are most cost-effective?
		SELECT `shipping carriers` , avg(`shipping costs`) as avg_shipping_cost
		from supply_chain_data
		group by `shipping carriers`
		order by avg_shipping_cost asc;

-- o	What are the average shipping costs for different product types?
		SELECT Product_type , avg(`shipping costs`) as avg_shipping_cost
		from supply_chain_data
		group by Product_type
		order by avg_shipping_cost desc;



-- 3.	Transportation Modes and Routes:

-- o	Which transportation modes (e.g., air, sea, road) are commonly used?
		SELECT `Transportation modes`,count(`Transportation modes`) as mode_count 
		from supply_chain_data
		GROUP BY `Transportation modes`
		ORDER BY mode_count desc;

-- o	What are the preferred routes for shipping?
		SELECT routes , count(*) as route_count
		from supply_chain_data
		GROUP BY routes
		ORDER BY route_count desc;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Advanced Level:

-- 1.	Customer Demographics and Revenue:
		SELECT `Customer demographics`, 
			   SUM(Revenue_generated) AS Total_Revenue,
			   AVG(Revenue_generated) AS Average_Revenue
		FROM supply_chain_data
		GROUP BY `Customer demographics`
		ORDER BY Total_Revenue DESC;


-- o	Can you segment customers based on demographics (e.g., age, location)?
		select `Customer demographics` , count(*) as cust_count
		from supply_chain_data
		GROUP BY `Customer demographics`
		order by cust_count desc;

-- o	How does customer demographic information relate to revenue?
-- by demographics
		select `Customer demographics` , avg(`Revenue_generated`) as avg_rev
		from supply_chain_data
		GROUP BY `Customer demographics`
		order by avg_rev desc;

-- by location
		select location , sum(`Revenue_generated`) as total_rev
		from supply_chain_data
		GROUP BY location
		order by total_rev desc;

-- 2.	Manufacturing Efficiency:
-- o	Are there bottlenecks in the production process?
		SELECT product_type,Manufacturing_lead_time, COUNT(*) AS Occurrences
		FROM supply_chain_data
		GROUP BY product_type,Manufacturing_lead_time
		ORDER BY Occurrences DESC;

-- o	How can manufacturing costs be optimized?
		SELECT Product_type, AVG(`Manufacturing costs`) AS Average_Cost
		FROM supply_chain_data
		GROUP BY Product_type
		ORDER BY Average_Cost DESC;


-- 3.	Quality Control and Defect Rates:
-- o	What are the most common defects?
		SELECT CASE 
				WHEN `Defect rates` < 0.05 THEN 'Low (0-5%)'
				WHEN `Defect rates` >= 0.05 AND `Defect rates` < 0.10 THEN 'Moderate (5-10%)'
				WHEN `Defect rates` >= 0.10 AND `Defect rates` < 0.20 THEN 'High (10-20%)'
				ELSE 'Very High (>20%)'
			END AS Defect_Category, avg(`Defect rates`) as avg_defect
		FROM supply_chain_data
		GROUP BY  Defect_Category
		ORDER BY avg_defect desc;
        
-- o	How do inspection results impact overall defect rates?
		SELECT `Inspection results` , avg(`Defect rates`) as avg_defect_rates 
		from supply_chain_data
		GROUP BY `Inspection results`
		order by avg_defect_rates desc;




-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------















