/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

create or alter procedure bronze.load_bronze as 
Begin
    Declare @start_time Datetime , @end_time Datetime , @start_batch_time Datetime , @end_batch_time Datetime;
    Begin try
        print '===============================================================';
        print 'Loading Bronze Layer';
        print '===============================================================';
        
        
        print '---------------------------------------------------------------';
        print 'Loading CRM Tables';
        print '---------------------------------------------------------------';
        
        set @start_batch_time = GETDATE();

        set @start_time = GETDATE();
        print '<< Truncating Table: bronze.crp_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        
        print '<< Inserting Data into: bronze.crp_cust_info';
        BULK INSERT bronze.crm_cust_info
        from 'C:\Users\dilan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        with(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = GETDATE();
        print '>> Load Duration: ' + cast(datediff(second , @start_time , @end_time) as NVARCHAR) + ' Seconds ';
        print '------------------------------------';

        set @start_time = GETDATE();
        print '<< Truncating Table: bronze.crp_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        
        print '<< Inserting Data into: bronze.crp_prd_info';
        BULK INSERT bronze.crm_prd_info
        from 'C:\Users\dilan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        with(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = GETDATE();
        print '>> Load Duration: ' + cast(datediff(second , @start_time , @end_time) as NVARCHAR) + ' Seconds ';
        print '------------------------------------';


        set @start_time = GETDATE();
        print '<< Truncating Table: bronze.crp_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        
        print '<< Inserting Data into: bronze.crp_sales_details';
        BULK INSERT bronze.crm_sales_details
        from 'C:\Users\dilan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        with(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = GETDATE();
        print '>> Load Duration: ' + cast(datediff(second , @start_time , @end_time) as NVARCHAR) + ' Seconds ';
        print '------------------------------------';


        set @start_time = GETDATE();
        print '---------------------------------------------------------------';
        print 'Loading ERP Tables';
        print '---------------------------------------------------------------';
        
        print '>> Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        
        print '>> Inserting Data into: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        from 'C:\Users\dilan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        with(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = GETDATE();
        print '>> Load Duration: ' + cast(datediff(second , @start_time , @end_time) as NVARCHAR) + ' Seconds ';
        print '------------------------------------';


        set @start_time = GETDATE();
        print '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        
        print '>> Inserting Data into: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        from 'C:\Users\dilan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        with(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = GETDATE();
        print '>> Load Duration: ' + cast(datediff(second , @start_time , @end_time) as NVARCHAR) + ' Seconds ';
        print '------------------------------------';


        set @start_time = GETDATE();
        print '>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        
        print '>> Inserting Data into: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        from 'C:\Users\dilan\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        with(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = GETDATE();
        print '>> Load Duration: ' + cast(datediff(second , @start_time , @end_time) as NVARCHAR) + ' Seconds ';
        print '------------------------------------';


        set @end_batch_time = GETDATE();
        print '==================================================================';
        print 'Loading Bronze layer is completed';
        print 'Total Load Duration: ' + cast(datediff(second , @start_batch_time , @end_batch_time) as NVARCHAR) + ' Seconds ';
        print '=================================================================='


    end try
    begin catch
        print '========================================================================';
        print 'Error occured during loading bronze layer';
        print 'Error Message' + Error_message();
        print 'Error Message' + cast(Error_Number() as NVARCHAR);
        print 'Error Message' + cast(error_state() as NVARCHAR);
        print '========================================================================';
    end catch
end
