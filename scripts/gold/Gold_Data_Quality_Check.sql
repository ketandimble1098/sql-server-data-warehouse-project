---check for duplicate values after joins

SELECT cst_id, COUNT(*) FROM(
SELECT
	ci.cst_id
FROM DataWarehouse.silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid)t group by cst_id having count (*) >1;


SELECT prd_key, COUNT(*) FROM
(SELECT
	pn.prd_key
FROM DataWarehouse.silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
where prd_end_dt is null)t group by prd_key having count (*) >1;




select distinct gender from gold.dim_customers;


--check if all dimensions tables can succesfully join the fact tables

SELECT
*
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE c.customer_key IS NULL;