# Module 2: Create your First Dataflow in Data Factory

With the raw data loaded into your bronze Lakehouse table from the last module, now you can prepare that data and enrich it by combining it with another table that contains discounts for each vendor and their trips during a particular day. This final gold Lakehouse table will be loaded and ready for consumption. 

The major steps in Dataflow are as follows:

* Get raw data from Lakehouse moved by upstream Copy activity
* Transform the data imported from the Lakehouse
* Connect to CSV file containing the discounts data
* Transform the discounts data
* Combine trips and discounts data 
* Load the output query to a gold Lakehouse table

## Get data from Lakehouse

1.	From the sidebar, click Home to take you back to the Data Factory Home canvas. 

2.	Click **Create** and select and click on **Dataflow Gen2**.

![Create Dataflow Gen2 (Preview) screen in Data Factory](media/module-2-create-dataflow.png)

3.	Select the **Get Data** option from the ribbon, and click the *More…*

![Dataflows Home tab showing the Get Data button and its submenu to display the more option](media/module-2-get-data-more.png)

4. Search and select the **Lakehouse** connector.

![Choose data source dialog inside of dataflows filtered to only show the Lakehouse connector](media/module-2-lakehouse-connector.png)

5. In the Connection settings page, an automatic connection will be created for you based on the currently signed in user. Click **Next**.

![Connect to data source dialog for the Lakehouse connector](media/module-2-connect-to-data-source-lakehouse.png)

6. A navigator will be shown where you can see all the **Workspaces** available to you as well as their contents. 
To select the table that was created in Module 1, first select & expand your **Workspace Name**, select & expand your **Lakehouse Name**, and finally select your **table**.  

Click on the **Create** button on the bottom right corner.

![Choose data dilaog where the user has selected a specific workspace, lakehouse and table to connect to with the name NYC_Taxi](media/module-2-choose-data-navigator.png)

7. Once your canvas is populated with the data, you can set column profile information as this  will be useful for data profiling.  You can apply the right transformation and target the right data values based on it. (optional) 
To do this, select **Options** from the ribbon pane, then select the first 3 options under Column profile (see screen print below), then select **OK**.

![Enabling the column profile features inside the Options dialog in Dataflows](media/module-2-column-profiling.png)

## Transform the data imported from the Lakehouse

1. Select the icon in the column header of the second column **lpepPickupDatetime** to display a dropdown menu and select the data type from the menu to convert the column from the *datetime* type to *date* type.

![Changing the data type of the lpepPickupDatetime column to be of the type date ](media/module-2-change-data-type-to-date.png)

2. In the **Home** tab of the ribbon, select the **Choose columns** option from the Manage columns group. 

![Choose columns button in the Home tab of the ribbon](media/module-2-choose-columns-button.png)

3. Inside the **Choose columns** dialog, deselect the following columns, then click **OK**.

* lpepDropoffDatetime
* puLocationId
* doLocationId
* pickupLongitude
* pickupLatitude
* dropoffLongitude
* dropoffLatitude
* rateCodeID

![Choose columns dialog inside of dataflows with mentioned columns unselected](media/module-2-choose-columns-dialog.png)

4. Select the **storeAndFwdFlag** column drop down menu. 

```Note: If you get a message “List may be incomplete”, click Load more to see the value ‘Y’```

![Autofilter shown for the column storeAndFwdFlag displaying only the value N in the list and the option to Load more values](media/module-2-autofilter.png)

5. Choose **Y** as we want to filter to only contain the rows with the value **Y** as   the discount only applies to the rows where this is true.  Click **OK**.

![Autofilter menu showing only the value Y selected and the N value unselected](media/module-2-autofilter-y.png)

6. Select the **lpepPickupDatetime** column drop down menu, select **Date filters**, and select the **Between…** filter from the contextual filter.

![Contextual Date filters for the column lpepPickupDatetime with the option Between](media/module-2-contextual-date-filters.png)

7. In the filter rows dialog, select only the dates within the month of **January of the year 2015**, then click OK.

![Filter rows dialog for the dates between option](media/module-2-filter-dialog-dates.png)

