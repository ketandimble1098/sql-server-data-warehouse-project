CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME  ;
	SET @batch_start_time = GETDATE();
	BEGIN TRY
		PRINT '=====================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=====================================';
		
		PRINT '-------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		from 'C:\Projects\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------------------';
		

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Into: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		from 'C:\Projects\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------------------';
				
		
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		from 'C:\Projects\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------------------';

		
		PRINT '-------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------';
		
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		from 'C:\Projects\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------------------';		

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		from 'C:\Projects\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------------------';
		
				
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		from 'C:\Projects\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------------------';



		SET @batch_end_time = GETDATE();
		PRINT '===========================================';
		PRINT 'Loading Bronze Layer is Completed'
		PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '===========================================';
	END TRY
	BEGIN CATCH
		PRINT '===========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZ LAVERY';
		PRINT 'Error Message' + ERROR_NUMBER();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '===========================================';
	END CATCH
END