-- Check for Null or Duplicates in Primary Key

select 
cst_id,
count(*)
from silver.crm_cust_info
group by cst_id
having count(*) > 1 or cst_id is null;


select 
prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null;


--- Chack for unwanted spaces

select cst_firstname
from silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)

select cst_lastname
from silver.crm_cust_info
where cst_lastname != TRIM(cst_lastname)


select prd_nm
from silver.crm_prd_info
where prd_nm != TRIM(prd_nm);

--- Data standardization and Consistency

select distinct cst_marital_status
from silver.crm_cust_info;

select distinct cst_gndr
from silver.crm_cust_info;


select distinct prd_line
from silver.crm_prd_info;



---Check for Nulls and Negative numbers

SELECT prd_cost
FROM silver.crm_prd_info
where prd_cost < 0 OR prd_cost IS NUll;


--Check for Invalid Date Orders

SELECT 
prd_start_dt,
prd_end_dt
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;