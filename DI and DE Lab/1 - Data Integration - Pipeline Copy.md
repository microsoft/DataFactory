# Data Integration: Create your First Pipeline in Data Factory

You will complete this module in 10 minutes by ingesting raw data from the source store into the bronze table of the data Lakehouse by Copy activity in Pipeline.

The major steps in module 1 are as follows:
* Create a data Pipeline
* Use Copy Activity in the Pipeline to load sample data into the Lakehouse

## Create a data Pipeline

1.	Choose your **existing workspace with premium capacity enabled** or **create a new workspace enabling Premium capacity** with other options as default.

![Create a workspace screen](/DI in an Hour/media/module-1-workspace-creation.png)

2. Click on the default Power BI icon at the bottom left of the screen and switch to **Data Factory** workload. 

![Workload picker menu to choose the Data Factory workload](instructions230216/module-1-workload-picker.png)

3. Select **Data pipeline** and input your Pipeline Name, we will use First Pipeline as name in this module. Then click Create.

![Artifacts creation screen for the Data Factory workload where the Data pipeline artifact is available](instructions230216/module-1-create-data-pipeline.png)

![Dialog to enter the name of the New pipeline](instructions230216/module-1-new-pipeline.png)

## Use Pipeline Activity to load sample data to Lakehouse

IN this section you will create a copy activity to load data directly into the lakehouse. This process will be divided into four sections:

1. Create Copy data pipeline
2. Configure your source setting in copy activity
3. Configure your destination setting in your copy activity
4. Run and view results of your copy activity

### Create Copy data piepline

1.	Click on **Add pipeline activity** and then select **Copy data**  to get started.

![Create a copy data activity inside the pipeline](instructions230216/module-1-create-data-pipeline.png)

### Configure your source setting in copy activity

1. In **Choose data source**, select **Source** tab, and then click **New**.

![Adding a new source and creating a new connection inside the Copy activiy of Data pipelines](instructions230216/module-1-new-copy-source.png)

2.	From the **New connection** dialog, Select **Azure Blob Storage**, and then click **Continue**.

![New connection dialog displaying the connectors available and the Azure Blob Storage connector is selected](instructions230216/module-1-copy-data-connector-picker.png)

3.	In connection settings, input the URL to the **Account name or URL**, and choose **Create a new connection**, then input **Connection name** and use **anonymous** authentication. Then click **Create**.

* **Account name or URL**: 	https://nyctaxisample.blob.core.windows.net/sample
* **Connections name**: Input the name for your new connection, like NYC_Taxi_yourusername

![New connection dialog for the Azure Blob Storage](instructions230216/module-1-source-connection-dialog.png)

4. In the **Source** tab, for File path, specify *sample* in the container text box then expand the dropdown and select **From specified path**.

![Source tab where the filepath has been defined as sample and the selection from specific path has been clicked](instructions230216/module-1-file-path-for-taxi.png)

5.From the **Browse** dialog, choose the file **NYC-Taxi-Green-2015-01.parquet** and then click **OK**.

![Browse dialog for the files inside of the Azure Blob Storage where the NYC-Taxi-Green-2015-01.parquet file is stored](instructions230216/module-1-browse-parquet-file.png)

6. Select **Parquet** in **File format** dropdown then select **Preview data**.

![In the Source taba, the File format has been selected as Parquet and then the Preview data button has been clicked](instructions230216/module-1-parquet-data-preview.png)

![Screenshot of the data preview for the sample parquet file](instructions230216/module-1-parquet-data-preview-dialog.png)

### Configure your destination setting in your copy activity

1. In the **destination** tab, select **+New** to create a new Lakehouse and name it **Bronze**. 

![Destination tab for the copy activity where the Workspace has been selected and the destination is the Lakehouse and clicking the New button to create a new Lakehouse](instructions230216/module-1-copy-destination-tab.png)

![Create new Lakehouse dialog where you can enter the name of the new Lakehouse](instructions230216/module-1-new-lakehouse.png)

2. In the **Table name**, click **Edit** to create a new Lakehouse table to load data to. With the name *NYC_Taxi_{UserName}*.

![Entering the new name of the table for the Lakehouse created after clicking the Edit radio box](instructions230216/module-1-enter-table-name.png)

### Run and view results of your copy activity

1. In the ribbon, access the **Run tab** and click **Run** and then Save and run to run copy activity.

![Run activity button in the ribbon inside the Run tab](instructions230216/module-1-run-button.png)

![Save and run dialog after clicking the Run button to save the pipeline and run it](instructions230216/module-1-save-and-run.png)

2. You can monitor the running process and check the results on the **Output tab** below the pipeline canvas. Select the run details button (with the **glasses icon** highlighted) to view the run details.

![Output tab for the Copy activity inside the data pipeline showcasing the status of the run of the activity and with the details icon highlighted](instructions230216/module-1-output-tab.png)

3. The run details show 1,508,501 rows read and written.

![Copy data details dialog showcasing a total of 1508501 rows written to the lakehouse as well as the duration of the run](instructions230216/module-1-copy-data-details.png)

4. Expand the **Duration breakdown**, you can know the time duration of each stage in copy activity. After reviewing the copy details, click **Close**.

![Duration breakdown for the copy data activity showcasing total time spent for each process of the activity](instructions230216/module-1-duration-breakdown.png)
