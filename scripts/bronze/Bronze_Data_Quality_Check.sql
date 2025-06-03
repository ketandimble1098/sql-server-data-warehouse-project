-- Check for Null or Duplicates in Primary Key

select 
cst_id,
count(*)
from bronze.crm_cust_info
group by cst_id
having count(*) > 1 or cst_id is null;

select 
prd_id,
count(*)
from bronze.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null;


--- Chack for unwanted spaces

select cst_firstname
from bronze.crm_cust_info
where cst_firstname != TRIM(cst_firstname);


select cst_firstname
from bronze.crm_cust_info
where cst_firstname != TRIM(cst_firstname);


select prd_nm
from bronze.crm_prd_info
where prd_nm != TRIM(prd_nm);

select sls_ord_num
from bronze.crm_sales_details
where sls_ord_num != TRIM(sls_ord_num);

SELECT * FROM bronze.erp_px_cat_g1v2
where cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance)


--- Data standardization and Consistency

select distinct cst_marital_status
from bronze.crm_cust_info;

select distinct cst_gndr
from bronze.crm_cust_info;


select distinct prd_line
from bronze.crm_prd_info;

SELECT DISTINCT
gen
FROM bronze.erp_cust_az12


SELECT DISTINCT
 subcat 
FROM bronze.erp_px_cat_g1v2



---Check for Nulls and Negative numbers

SELECT prd_cost
FROM bronze.crm_prd_info
where prd_cost < 0 OR prd_cost IS NUll;


--Check for Invalid Date Orders

SELECT 
prd_start_dt,
prd_end_dt
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;




SELECT * FROM bronze.crm_sales_details
where sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info)


-- Check for Invalid Dates

SELECT sls_order_dt 
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 
OR LEN(sls_order_dt) !=8  
OR sls_order_dt > 20500101
OR sls_order_dt < 1900101


SELECT sls_ship_dt 
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0 
OR LEN(sls_ship_dt) !=8  
OR sls_ship_dt > 20500101
OR sls_ship_dt < 1900101


--- Check for Invalid Date Orders

SELECT *
FROM bronze.crm_sales_details
where sls_order_dt > sls_ship_dt OR sls_order_dt > sls_ship_dt


-- Check data consistency betwwen sales, quantity and price

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
where sls_sales != sls_quantity*sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <=0  OR sls_price <= 0
ORDER BY sls_sales,sls_quantity,sls_price



---Identify Out-Of-Range Dates

SELECT DISTINCT
bdate
from bronze.erp_cust_az12
where bdate < '1924-01-01' OR  bdate > GETDATE()


